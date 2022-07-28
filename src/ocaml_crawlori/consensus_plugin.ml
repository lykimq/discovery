
open Pg
open Crp
open Consensus_ocaml_interface
open Proto
open Common
open Info

type txn = Pg.txn
type init_acc = Pg.init_acc
include E

let mic_type_storage_ftype =
  match Mtyped.parse_type Consensus_ocaml_interface.storage_micheline with
  | Ok ftype -> ftype
  | Error _ -> failwith "can't parse factory generated storage type"

let mic_type_storage_type = Mtyped.short mic_type_storage_ftype

let always = true
let name = "consensus"
let forward_end _config _level = rok ()

let insert_consensus_storage ?(forward=false) ~dbh ~contract ~op parameter =
match parameter with
  | None -> rerr @@ `generic ("node_error", "no storage")
  | Some storage ->
    let p = EzEncoding.construct micheline_enc.json storage in
    [%pgsql dbh "insert into consensus_storage(contract,transaction,block,index,level,tsp,main,storage_content) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$p)"]

let insert_consensus_deposit ?(forward=false) ~dbh ~contract ~op parameter =
let p = EzEncoding.construct micheline_enc.json parameter in
[%pgsql dbh "insert into consensus_deposit(contract,transaction,block,index,level,tsp,main,deposit_parameter) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$p)"]

let insert_consensus_update_root_hash ?(forward=false) ~dbh ~contract ~op parameter =
let p = EzEncoding.construct micheline_enc.json parameter in
[%pgsql dbh "insert into consensus_update_root_hash(contract,transaction,block,index,level,tsp,main,update_root_hash_parameter) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$p)"]

let insert_consensus_withdraw ?(forward=false) ~dbh ~contract ~op parameter =
let p = EzEncoding.construct micheline_enc.json parameter in
[%pgsql dbh "insert into consensus_withdraw(contract,transaction,block,index,level,tsp,main,withdraw_parameter) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$p)"]

let insert_bm_consensus_vault ?(forward=false) ~dbh ~contract ~op parameter =
iter (fun (k, v) ->
       let k = EzEncoding.construct micheline_enc.json k in
       let v = EzEncoding.construct micheline_enc.json v in
       [%pgsql dbh "insert into bm_consensus_vault(contract,transaction,block,index,level,tsp,main,key_vault_parameter,value_vault_parameter) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$k,$v)"]) parameter

let insert_bm_consensus_used_handles ?(forward=false) ~dbh ~contract ~op parameter =
iter (fun (k, v) ->
       let k = EzEncoding.construct micheline_enc.json k in
       let v = EzEncoding.construct micheline_enc.json v in
       [%pgsql dbh "insert into bm_consensus_used_handles(contract,transaction,block,index,level,tsp,main,key_used_handles_parameter,value_used_handles_parameter) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$k,$v)"]) parameter

let insert_bm_consensus_known_handles_hash ?(forward=false) ~dbh ~contract ~op parameter =
iter (fun (k, v) ->
       let k = EzEncoding.construct micheline_enc.json k in
       let v = EzEncoding.construct micheline_enc.json v in
       [%pgsql dbh "insert into bm_consensus_known_handles_hash(contract,transaction,block,index,level,tsp,main,key_known_handles_hash_parameter,value_known_handles_hash_parameter) values ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$k,$v)"]) parameter

let get_storage_bms_id ?(allocs=[]) ~fields ~storage_type storage_value =
    let$ bmid_consensus_vault_vault =
  match Bm_utils.find_opt_storage_field
    ~allocs ~fields ~storage_type ~storage_value "vault" with
| _, Some { bm_id ; _} -> Ok bm_id
| _ -> Error (`generic ("parse_error", "storage.vault")) in
let$ bmid_consensus_vault_used_handles =
  match Bm_utils.find_opt_storage_field
    ~allocs ~fields ~storage_type ~storage_value "used_handles" with
| _, Some { bm_id ; _} -> Ok bm_id
| _ -> Error (`generic ("parse_error", "storage.used_handles")) in
let$ bmid_consensus_vault_known_handles_hash =
  match Bm_utils.find_opt_storage_field
    ~allocs ~fields ~storage_type ~storage_value "known_handles_hash" with
| _, Some { bm_id ; _} -> Ok bm_id
| _ -> Error (`generic ("parse_error", "storage.known_handles_hash")) in
Ok(bmid_consensus_vault_vault,bmid_consensus_vault_used_handles,bmid_consensus_vault_known_handles_hash)

let get_storage_ori ~allocs script =
  try
    let storage = storage_decode script.storage in
    let$ fields = Bm_utils.get_storage_fields script in
    let storage_type = mic_type_storage_ftype in
    let$ storage_value =
      Mtyped.(parse_value mic_type_storage_type script.storage) in
  let$ (bmid_consensus_vault_vault,bmid_consensus_vault_used_handles,bmid_consensus_vault_known_handles_hash) =
    get_storage_bms_id ~allocs ~fields ~storage_type storage_value in
  Ok (storage,bmid_consensus_vault_vault,bmid_consensus_vault_used_handles,bmid_consensus_vault_known_handles_hash)
  with exn ->
    let s = Printf.sprintf "decode_storage: %s" @@ Printexc.to_string exn in
    Error (`generic ("parse_error", s))


let get_bmid_consensus_vault_vault_updates bm_id l =
  Bm_utils.get_bm_updates
    ~bm_id
    l

let get_bmid_consensus_vault_used_handles_updates bm_id l =
  Bm_utils.get_bm_updates
    ~bm_id
    l

let get_bmid_consensus_vault_known_handles_hash_updates bm_id l =
  Bm_utils.get_bm_updates
    ~bm_id
    l

let insert_origination ?dbh ?(forward = false) config op ori =
  let address = Tzfunc.Crypto.op_to_KT1 op.bo_hash in
  if op.bo_op.source = config.originator_address then
    begin
    match op.bo_meta with
      | None -> rerr @@ `generic ("node_error", "no metadata")
      | Some meta ->
        let allocs = Bm_utils.big_map_allocs meta.op_lazy_storage_diff in
        match get_storage_ori ~allocs ori.script with
        | Error e ->
          Format.eprintf "Error %s@." @@ Tzfunc.Rp.string_of_error e ;
          rok ()
        | Ok (s,bmid_consensus_vault_vault,bmid_consensus_vault_used_handles,bmid_consensus_vault_known_handles_hash) ->
          Format.printf "\027[0;93morigination %s\027[0m@." (short address) ;
          use dbh @@ fun dbh ->
          let storage = Some (storage_encode s) in
          let>? () = insert_consensus_storage ~dbh ~forward ~contract:address ~op storage in
          let>? () =
            Contracts.insert_all_operations
              ~forward ~dbh ~op ~contract:address "origination" in
          let bmid_consensus_vault_vault_updates = get_bmid_consensus_vault_vault_updates bmid_consensus_vault_vault meta.op_lazy_storage_diff in
let>? () = insert_bm_consensus_vault ~dbh ~forward ~op ~contract:address bmid_consensus_vault_vault_updates in
let bmid_consensus_vault_used_handles_updates = get_bmid_consensus_vault_used_handles_updates bmid_consensus_vault_used_handles meta.op_lazy_storage_diff in
let>? () = insert_bm_consensus_used_handles ~dbh ~forward ~op ~contract:address bmid_consensus_vault_used_handles_updates in
let bmid_consensus_vault_known_handles_hash_updates = get_bmid_consensus_vault_known_handles_hash_updates bmid_consensus_vault_known_handles_hash meta.op_lazy_storage_diff in
let>? () = insert_bm_consensus_known_handles_hash ~dbh ~forward ~op ~contract:address bmid_consensus_vault_known_handles_hash_updates in
          Contracts.consensus_register ~forward ~dbh config address "consensus" op bmid_consensus_vault_vault bmid_consensus_vault_used_handles bmid_consensus_vault_known_handles_hash
    end
  else rok ()

let register_block ?forward config dbh b =
  let>? _ =
    fold (fun index op ->
        fold (fun index c ->
            match c.man_metadata with
            | None -> Lwt.return_ok index
            | Some meta ->
              if meta.man_operation_result.op_status = `applied then
                let>? index = match c.man_info.kind with
                  | Origination ori ->
                    let op = {
                      bo_block = b.hash; bo_level = b.header.shell.level;
                      bo_tsp = b.header.shell.timestamp; bo_hash = op.op_hash;
                      bo_op = c.man_info; bo_index = index; bo_indexes = (0l, 0l, 0l);
                      bo_meta = Option.map (fun m -> m.man_operation_result) c.man_metadata;
                      bo_numbers = Some c.man_numbers; bo_nonce = None;
                      bo_counter = c.man_numbers.counter } in
                    let|>? () = insert_origination ?forward config ~dbh op ori in
                    Int32.succ index
                  | _ -> Lwt.return_ok index in
                fold (fun index iop ->
                    if iop.in_result.op_status = `applied then
                      match iop.in_content.kind with
                      | Origination ori ->
                        let bo_meta = Some {
                            iop.in_result with
                            op_lazy_storage_diff =
                              iop.in_result.op_lazy_storage_diff @
                              (Option.fold ~none:[] ~some:(fun m ->
                                   m.man_operation_result.op_lazy_storage_diff)
                                  c.man_metadata) } in
                        let op = {
                          bo_block = b.hash; bo_level = b.header.shell.level;
                          bo_tsp = b.header.shell.timestamp; bo_hash = op.op_hash;
                          bo_op = iop.in_content; bo_index = index; bo_indexes = (0l, 0l, 0l); bo_meta;
                          bo_numbers = Some c.man_numbers; bo_nonce = Some iop.in_nonce;
                          bo_counter = c.man_numbers.counter } in
                        let|>? () = insert_origination ?forward config ~dbh op ori in
                        Int32.succ index
                      | _ -> Lwt.return_ok index
                    else
                      Lwt.return_ok index
                  ) index meta.man_internal_operation_results
              else Lwt.return_ok index
          ) index op.op_contents
      ) 0l b.operations in
  [%pgsql dbh
      "insert into state (level, tsp, chain_id) \
       values (${b.header.shell.level}, ${b.header.shell.timestamp}, \
       ${b.chain_id})"]


  let insert_operation ?forward dbh ~op ~contract parameter =
  match parameter with
  | None -> rerr @@ `generic ("operation_error", "no parameter")
  | Some p ->
    match p.entrypoint with
    | EPnamed "deposit" ->
      let>? () = Contracts.insert_all_operations ?forward ~dbh ~op ~contract "consensus_deposit" in
      insert_consensus_deposit ?forward ~dbh ~contract ~op p.value
| EPnamed "update_root_hash" ->
      let>? () = Contracts.insert_all_operations ?forward ~dbh ~op ~contract "consensus_update_root_hash" in
      insert_consensus_update_root_hash ?forward ~dbh ~contract ~op p.value
| EPnamed "withdraw" ->
      let>? () = Contracts.insert_all_operations ?forward ~dbh ~op ~contract "consensus_withdraw" in
      insert_consensus_withdraw ?forward ~dbh ~contract ~op p.value
    | _ ->
      let str =
        Format.sprintf "unexpected entrypoint %S" @@
        EzEncoding.construct entrypoint_enc.json p.entrypoint in
      rerr @@ `generic ("operation_error", str)

  let register_operation ?forward info dbh op =
  match op.bo_op.kind, op.bo_meta with
  | (Delegation _ | Reveal _ | Origination _ | Constant _ | Deposits_limit _|
    Tx_rollup_origination _ | Tx_rollup_submit_batch _|Tx_rollup_commit _|
    Tx_rollup_return_bond _|Tx_rollup_finalize_commitment _|
    Tx_rollup_remove_commitment _|Tx_rollup_rejection _|
    Tx_rollup_dispatch_tickets _|Transfer_ticket _|Sc_rollup_originate _|
    Sc_rollup_add_messages _|Sc_rollup_cement _|Sc_rollup_publish _), _ ->
    rok ()
  | _, None -> rerr @@ `generic ("node_error", "no metadata")
  | Transaction {destination=contract; parameters ; _}, Some meta ->
    match List.find_opt (fun c -> c.ci_address = contract && c.ci_kind = "consensus") @@ CSet.elements info.contracts with
    | None -> rok ()
    | Some info ->
      Format.printf "\027[0;35m[%s] transaction %s %s\027[0m@."
        name
        (String.sub op.bo_hash 0 10)
        (Option.fold ~none:"" ~some:(fun p ->
             EzEncoding.construct entrypoint_enc.json p.entrypoint) parameters) ;
      let>? () = insert_operation ?forward dbh ~op ~contract parameters in
      let bmid_consensus_vault_vault_updates = get_bmid_consensus_vault_vault_updates (Option.get info.ci_bmid_consensus_vault_vault) meta.op_lazy_storage_diff in
let>? () = insert_bm_consensus_vault ~dbh ?forward ~op ~contract bmid_consensus_vault_vault_updates in
let bmid_consensus_vault_used_handles_updates = get_bmid_consensus_vault_used_handles_updates (Option.get info.ci_bmid_consensus_vault_used_handles) meta.op_lazy_storage_diff in
let>? () = insert_bm_consensus_used_handles ~dbh ?forward ~op ~contract bmid_consensus_vault_used_handles_updates in
let bmid_consensus_vault_known_handles_hash_updates = get_bmid_consensus_vault_known_handles_hash_updates (Option.get info.ci_bmid_consensus_vault_known_handles_hash) meta.op_lazy_storage_diff in
let>? () = insert_bm_consensus_known_handles_hash ~dbh ?forward ~op ~contract bmid_consensus_vault_known_handles_hash_updates in
      insert_consensus_storage ~dbh ?forward ~contract ~op meta.op_storage


let set_main ?(forward=false) _info _dbh _m =
  if not forward then
    rok @@ fun () -> rok ()
  else rok @@ fun () -> rok ()


let init _config acc =
let l = [ Consensus_tables.upgrade, Consensus_tables.downgrade ] in
rok (acc @ l)

