open Pg
open Crp
open Discovery_ocaml_interface
open Proto
open Common
open Info

type txn = Pg.txn

type init_acc = Pg.init_acc

include E

let mic_type_storage_ftype =
  match Mtyped.parse_type Discovery_ocaml_interface.storage_micheline with
  | Ok ftype -> ftype
  | Error _ -> failwith "can't parse factory generated storage type"

let mic_type_storage_type = Mtyped.short mic_type_storage_ftype

let always = true

let name = "discovery"

let forward_end _config _level = rok ()

let insert_discovery_storage ?(forward = false) ~dbh ~contract ~op parameter =
  match parameter with
  | None -> rerr @@ `generic ("node_error", "no storage")
  | Some storage ->
      let p = EzEncoding.construct micheline_enc.json storage in
      [%pgsql
        dbh
          "insert into \
           discovery_storage(contract,transaction,block,index,level,tsp,main,storage_content) \
           values \
           ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$p)"]

let insert_discovery__default ?(forward = false) ~dbh ~contract ~op parameter =
  let p = EzEncoding.construct micheline_enc.json parameter in
  [%pgsql
    dbh
      "insert into \
       discovery__default(contract,transaction,block,index,level,tsp,main,_default_parameter) \
       values \
       ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$p)"]

let insert_bm_discovery_ ?(forward = false) ~dbh ~contract ~op parameter =
  iter
    (fun (k, v) ->
      let k = EzEncoding.construct micheline_enc.json k in
      let v = EzEncoding.construct micheline_enc.json v in
      [%pgsql
        dbh
          "insert into \
           bm_discovery_(contract,transaction,block,index,level,tsp,main,key__parameter,value__parameter) \
           values \
           ($contract,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward,$k,$v)"])
    parameter

let get_storage_bms_id ?(allocs = []) ~fields ~storage_type storage_value =
  let$ bmid_discovery_ =
    match
      Bm_utils.find_opt_storage_field
        ~allocs
        ~fields
        ~storage_type
        ~storage_value
        ""
    with
    | _, Some {bm_id; _} -> Ok bm_id
    | _ -> Error (`generic ("parse_error", "storage."))
  in
  Ok bmid_discovery_

let get_storage_ori ~allocs script =
  try
    let storage = storage_decode script.storage in
    let$ fields = Bm_utils.get_storage_fields script in
    let storage_type = mic_type_storage_ftype in
    let$ storage_value =
      Mtyped.(parse_value mic_type_storage_type script.storage)
    in
    let$ bmid_discovery_ =
      get_storage_bms_id ~allocs ~fields ~storage_type storage_value
    in
    Ok (storage, bmid_discovery_)
  with exn ->
    let s = Printf.sprintf "decode_storage: %s" @@ Printexc.to_string exn in
    Error (`generic ("parse_error", s))

let get_bmid_discovery__updates bm_id l = Bm_utils.get_bm_updates ~bm_id l

let insert_origination ?dbh ?(forward = false) config op ori =
  let address = Tzfunc.Crypto.op_to_KT1 op.bo_hash in
  if op.bo_op.source = config.originator_address then
    match op.bo_meta with
    | None -> rerr @@ `generic ("node_error", "no metadata")
    | Some meta -> (
        let allocs = Bm_utils.big_map_allocs meta.op_lazy_storage_diff in
        match get_storage_ori ~allocs ori.script with
        | Error e ->
            Format.eprintf "Error %s@." @@ Tzfunc.Rp.string_of_error e ;
            rok ()
        | Ok (s, bmid_discovery_) ->
            Format.printf "\027[0;93morigination %s\027[0m@." (short address) ;
            use dbh @@ fun dbh ->
            let storage = Some (storage_encode s) in
            let>? () =
              insert_discovery_storage
                ~dbh
                ~forward
                ~contract:address
                ~op
                storage
            in
            let>? () =
              Contracts.insert_all_operations
                ~forward
                ~dbh
                ~op
                ~contract:address
                "origination"
            in
            let bmid_discovery__updates =
              get_bmid_discovery__updates
                bmid_discovery_
                meta.op_lazy_storage_diff
            in
            let>? () =
              insert_bm_discovery_
                ~dbh
                ~forward
                ~op
                ~contract:address
                bmid_discovery__updates
            in
            Contracts.discovery_register
              ~forward
              ~dbh
              config
              address
              "discovery"
              op
              bmid_discovery_)
  else rok ()

let register_block ?forward config dbh b =
  let>? _ =
    fold
      (fun index op ->
        fold
          (fun index c ->
            match c.man_metadata with
            | None -> Lwt.return_ok index
            | Some meta ->
                if meta.man_operation_result.op_status = `applied then
                  let>? index =
                    match c.man_info.kind with
                    | Origination ori ->
                        let op =
                          {
                            bo_block = b.hash;
                            bo_level = b.header.shell.level;
                            bo_tsp = b.header.shell.timestamp;
                            bo_hash = op.op_hash;
                            bo_op = c.man_info;
                            bo_index = index;
                            bo_indexes = (0l, 0l, 0l);
                            bo_meta =
                              Option.map
                                (fun m -> m.man_operation_result)
                                c.man_metadata;
                            bo_numbers = Some c.man_numbers;
                            bo_nonce = None;
                            bo_counter = c.man_numbers.counter;
                          }
                        in
                        let|>? () =
                          insert_origination ?forward config ~dbh op ori
                        in
                        Int32.succ index
                    | _ -> Lwt.return_ok index
                  in
                  fold
                    (fun index iop ->
                      if iop.in_result.op_status = `applied then
                        match iop.in_content.kind with
                        | Origination ori ->
                            let bo_meta =
                              Some
                                {
                                  iop.in_result with
                                  op_lazy_storage_diff =
                                    iop.in_result.op_lazy_storage_diff
                                    @ Option.fold
                                        ~none:[]
                                        ~some:(fun m ->
                                          m.man_operation_result
                                            .op_lazy_storage_diff)
                                        c.man_metadata;
                                }
                            in
                            let op =
                              {
                                bo_block = b.hash;
                                bo_level = b.header.shell.level;
                                bo_tsp = b.header.shell.timestamp;
                                bo_hash = op.op_hash;
                                bo_op = iop.in_content;
                                bo_index = index;
                                bo_indexes = (0l, 0l, 0l);
                                bo_meta;
                                bo_numbers = Some c.man_numbers;
                                bo_nonce = Some iop.in_nonce;
                                bo_counter = c.man_numbers.counter;
                              }
                            in
                            let|>? () =
                              insert_origination ?forward config ~dbh op ori
                            in
                            Int32.succ index
                        | _ -> Lwt.return_ok index
                      else Lwt.return_ok index)
                    index
                    meta.man_internal_operation_results
                else Lwt.return_ok index)
          index
          op.op_contents)
      0l
      b.operations
  in
  [%pgsql
    dbh
      "insert into state (level, tsp, chain_id) values \
       (${b.header.shell.level}, ${b.header.shell.timestamp}, ${b.chain_id})"]

let insert_operation ?forward dbh ~op ~contract parameter =
  match parameter with
  | None -> rerr @@ `generic ("operation_error", "no parameter")
  | Some p -> (
      match p.entrypoint with
      | EPnamed "_default" ->
          let>? () =
            Contracts.insert_all_operations
              ?forward
              ~dbh
              ~op
              ~contract
              "discovery__default"
          in
          insert_discovery__default ?forward ~dbh ~contract ~op p.value
      | _ ->
          let str =
            Format.sprintf "unexpected entrypoint %S"
            @@ EzEncoding.construct entrypoint_enc.json p.entrypoint
          in
          rerr @@ `generic ("operation_error", str))

let register_operation ?forward info dbh op =
  match (op.bo_op.kind, op.bo_meta) with
  | ( ( Delegation _ | Reveal _ | Origination _ | Constant _ | Deposits_limit _
      | Tx_rollup_origination _ | Tx_rollup_submit_batch _ | Tx_rollup_commit _
      | Tx_rollup_return_bond _ | Tx_rollup_finalize_commitment _
      | Tx_rollup_remove_commitment _ | Tx_rollup_rejection _
      | Tx_rollup_dispatch_tickets _ | Transfer_ticket _ | Sc_rollup_originate _
      | Sc_rollup_add_messages _ | Sc_rollup_cement _ | Sc_rollup_publish _ ),
      _ ) ->
      rok ()
  | _, None -> rerr @@ `generic ("node_error", "no metadata")
  | Transaction {destination = contract; parameters; _}, Some meta -> (
      match
        List.find_opt (fun c ->
            c.ci_address = contract && c.ci_kind = "discovery")
        @@ CSet.elements info.contracts
      with
      | None -> rok ()
      | Some info ->
          Format.printf
            "\027[0;35m[%s] transaction %s %s\027[0m@."
            name
            (String.sub op.bo_hash 0 10)
            (Option.fold
               ~none:""
               ~some:(fun p ->
                 EzEncoding.construct entrypoint_enc.json p.entrypoint)
               parameters) ;
          let>? () = insert_operation ?forward dbh ~op ~contract parameters in
          let bmid_discovery__updates =
            get_bmid_discovery__updates
              (Option.get info.ci_bmid_discovery_)
              meta.op_lazy_storage_diff
          in
          let>? () =
            insert_bm_discovery_
              ~dbh
              ?forward
              ~op
              ~contract
              bmid_discovery__updates
          in
          insert_discovery_storage ~dbh ?forward ~contract ~op meta.op_storage)

let set_main ?(forward = false) _info _dbh _m =
  if not forward then rok @@ fun () -> rok () else rok @@ fun () -> rok ()

let init _config acc =
  let l = [(Discovery_tables.upgrade, Discovery_tables.downgrade)] in
  rok (acc @ l)
