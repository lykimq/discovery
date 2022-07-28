open Consensus_code
open Factori_types
open Tzfunc.Proto

type handle = {ticketer : address;owner : address;id : nat;data : bytes;amount : nat}

let handle_encode arg = Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [(nat_encode arg.amount);(bytes_encode arg.data)];
annots=[]}
;(nat_encode arg.id);(address_encode arg.owner)];
annots=[]}
;(address_encode arg.ticketer)];
annots=[]}

let handle_decode (m : micheline) : handle =
let (((amount,data),id,owner),ticketer) = (tuple2_decode (tuple3_decode (tuple2_decode nat_decode bytes_decode) nat_decode address_decode) address_decode) m in
{ticketer : address;owner : address;id : nat;data : bytes;amount : nat}

let handle_micheline = Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [(nat_micheline);(bytes_micheline)];
annots=[]}
;(nat_micheline);(address_micheline)];
annots=[]}
;(address_micheline)];
annots=[]}

let handle_generator () = {ticketer = address_generator ();owner = address_generator ();id = nat_generator ();data = bytes_generator ();amount = nat_generator ()}


type withdraw = {proof : (bytes *
 bytes) list;handles_hash : bytes;handle : handle;callback : contract}

let withdraw_encode arg = Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [((contract_encode (EzEncoding.destruct micheline_enc.json {|{"prim":"ticket","args":[{"prim":"bytes"}]}|})) arg.callback);(handle_encode arg.handle)];
annots=[]}
;(bytes_encode arg.handles_hash);((list_encode (tuple2_encode bytes_encode
bytes_encode)) arg.proof)];
annots=[]}

let withdraw_decode (m : micheline) : withdraw =
let ((callback,handle),handles_hash,proof) = (tuple3_decode (tuple2_decode (contract_decode (EzEncoding.destruct micheline_enc.json {|{"prim":"ticket","args":[{"prim":"bytes"}]}|})) handle_decode) bytes_decode (list_decode (tuple2_decode bytes_decode
bytes_decode))) m in
{proof : (bytes *
 bytes) list;handles_hash : bytes;handle : handle;callback : contract}

let withdraw_micheline = Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [((contract_micheline (EzEncoding.destruct micheline_enc.json {|{"prim":"ticket","args":[{"prim":"bytes"}]}|})));(handle_micheline)];
annots=[]}
;(bytes_micheline);((list_micheline ((tuple2_micheline bytes_micheline
bytes_micheline))))];
annots=[]}

let withdraw_generator () = {proof = (list_generator (tuple2_generator bytes_generator
bytes_generator)) ();handles_hash = bytes_generator ();handle = handle_generator ();callback = contract_generator ()}

let call_withdraw ?(node = Blockchain.default_node) ?(debug=false) ?(amount=0L) ~from ~kt1 (param : withdraw) =
     let param =
     {
     entrypoint = EPnamed "withdraw";
     value = Micheline (withdraw_encode param);
     } in
     Blockchain.call_entrypoint ~debug ~node ~amount ~from ~dst:kt1 param


type update_root_hash = {validators : key_hash list;state_hash : bytes;signatures : signature option list;handles_hash : bytes;current_validator_keys : key option list;block_payload_hash : bytes;block_height : int_michelson}

let update_root_hash_encode arg = Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [(int_michelson_encode arg.block_height);(bytes_encode arg.block_payload_hash)];
annots=[]}
;((list_encode (option_encode key_encode)) arg.current_validator_keys);(bytes_encode arg.handles_hash)];
annots=[]}
;Mprim {prim = `Pair;
args = [((list_encode (option_encode signature_encode)) arg.signatures);(bytes_encode arg.state_hash)];
annots=[]}
;((list_encode key_hash_encode) arg.validators)];
annots=[]}

let update_root_hash_decode (m : micheline) : update_root_hash =
let (((block_height,block_payload_hash),current_validator_keys,handles_hash),(signatures,state_hash),validators) = (tuple3_decode (tuple3_decode (tuple2_decode int_michelson_decode bytes_decode) (list_decode (option_decode key_decode)) bytes_decode) (tuple2_decode (list_decode (option_decode signature_decode)) bytes_decode) (list_decode key_hash_decode)) m in
{validators : key_hash list;state_hash : bytes;signatures : signature option list;handles_hash : bytes;current_validator_keys : key option list;block_payload_hash : bytes;block_height : int_michelson}

let update_root_hash_micheline = Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [(int_michelson_micheline);(bytes_micheline)];
annots=[]}
;((list_micheline ((option_micheline (key_micheline)))));(bytes_micheline)];
annots=[]}
;Mprim {prim = `pair;
args = [((list_micheline ((option_micheline (signature_micheline)))));(bytes_micheline)];
annots=[]}
;((list_micheline (key_hash_micheline)))];
annots=[]}

let update_root_hash_generator () = {validators = (list_generator key_hash_generator) ();state_hash = bytes_generator ();signatures = (list_generator (option_generator signature_generator)) ();handles_hash = bytes_generator ();current_validator_keys = (list_generator (option_generator key_generator)) ();block_payload_hash = bytes_generator ();block_height = int_michelson_generator ()}

let call_update_root_hash ?(node = Blockchain.default_node) ?(debug=false) ?(amount=0L) ~from ~kt1 (param : update_root_hash) =
     let param =
     {
     entrypoint = EPnamed "update_root_hash";
     value = Micheline (update_root_hash_encode param);
     } in
     Blockchain.call_entrypoint ~debug ~node ~amount ~from ~dst:kt1 param


type deposit = {ticket : bytes ticket;address : address}

let deposit_encode arg = Mprim {prim = `Pair;
args = [(address_encode arg.address);((ticket_encode bytes_encode) arg.ticket)];
annots=[]}

let deposit_decode (m : micheline) : deposit =
let (address,ticket) = (tuple2_decode address_decode (ticket_decode bytes_decode)) m in
{ticket : bytes ticket;address : address}

let deposit_micheline = Mprim {prim = `pair;
args = [(address_micheline);((ticket_micheline (bytes_micheline)))];
annots=[]}

let deposit_generator () = {ticket = (ticket_generator bytes_generator) ();address = address_generator ()}

let call_deposit ?(node = Blockchain.default_node) ?(debug=false) ?(amount=0L) ~from ~kt1 (param : deposit) =
     let param =
     {
     entrypoint = EPnamed "deposit";
     value = Micheline (deposit_encode param);
     } in
     Blockchain.call_entrypoint ~debug ~node ~amount ~from ~dst:kt1 param


type vault = {vault : ((address *
 bytes),bytes ticket) big_map;used_handles : (nat,unit) big_map;known_handles_hash : (bytes,unit) big_map}

let vault_encode arg = Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [((big_map_encode bytes_encode unit_encode) arg.known_handles_hash);((big_map_encode nat_encode unit_encode) arg.used_handles)];
annots=[]}
;((big_map_encode (tuple2_encode address_encode
bytes_encode) (ticket_encode bytes_encode)) arg.vault)];
annots=[]}

let vault_decode (m : micheline) : vault =
let ((known_handles_hash,used_handles),vault) = (tuple2_decode (tuple2_decode (big_map_decode bytes_decode unit_decode) (big_map_decode nat_decode unit_decode)) (big_map_decode (tuple2_decode address_decode
bytes_decode) (ticket_decode bytes_decode))) m in
{vault : ((address *
 bytes),bytes ticket) big_map;used_handles : (nat,unit) big_map;known_handles_hash : (bytes,unit) big_map}

let vault_micheline = Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [((big_map_micheline bytes_micheline unit_micheline));((big_map_micheline nat_micheline unit_micheline))];
annots=[]}
;((big_map_micheline (tuple2_micheline address_micheline
bytes_micheline) (ticket_micheline (bytes_micheline))))];
annots=[]}

let vault_generator () = {vault = (big_map_generator (tuple2_generator address_generator
bytes_generator) (ticket_generator bytes_generator)) ();used_handles = (big_map_generator nat_generator unit_generator) ();known_handles_hash = (big_map_generator bytes_generator unit_generator) ()}


type root_hash = {current_validators : key_hash list;current_state_hash : bytes;current_handles_hash : bytes;current_block_height : int_michelson;current_block_hash : bytes}

let root_hash_encode arg = Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [Mprim {prim = `Pair;
args = [(bytes_encode arg.current_block_hash);(int_michelson_encode arg.current_block_height)];
annots=[]}
;(bytes_encode arg.current_handles_hash);(bytes_encode arg.current_state_hash)];
annots=[]}
;((list_encode key_hash_encode) arg.current_validators)];
annots=[]}

let root_hash_decode (m : micheline) : root_hash =
let (((current_block_hash,current_block_height),current_handles_hash,current_state_hash),current_validators) = (tuple2_decode (tuple3_decode (tuple2_decode bytes_decode int_michelson_decode) bytes_decode bytes_decode) (list_decode key_hash_decode)) m in
{current_validators : key_hash list;current_state_hash : bytes;current_handles_hash : bytes;current_block_height : int_michelson;current_block_hash : bytes}

let root_hash_micheline = Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [Mprim {prim = `pair;
args = [(bytes_micheline);(int_michelson_micheline)];
annots=[]}
;(bytes_micheline);(bytes_micheline)];
annots=[]}
;((list_micheline (key_hash_micheline)))];
annots=[]}

let root_hash_generator () = {current_validators = (list_generator key_hash_generator) ();current_state_hash = bytes_generator ();current_handles_hash = bytes_generator ();current_block_height = int_michelson_generator ();current_block_hash = bytes_generator ()}


type storage = {vault : vault;root_hash : root_hash}

let storage_encode arg = Mprim {prim = `Pair;
args = [(root_hash_encode arg.root_hash);(vault_encode arg.vault)];
annots=[]}

let storage_decode (m : micheline) : storage =
let (root_hash,vault) = (tuple2_decode root_hash_decode vault_decode) m in
{vault : vault;root_hash : root_hash}

let storage_micheline = Mprim {prim = `pair;
args = [(root_hash_micheline);(vault_micheline)];
annots=[]}

let storage_generator () = {vault = vault_generator ();root_hash = root_hash_generator ()}

let deploy ?(amount=0L) ?(node="https://tz.functori.com") ?(name="No name provided") ?(from=Blockchain.bootstrap1) storage =
               let storage = storage_encode storage in
               Blockchain.deploy ~amount ~node ~name ~from ~code (Micheline storage)

let test_storage_download ~kt1 ~base () =
     let open Tzfunc.Rp in
     let open Blockchain in
     Lwt_main.run @@
     let>? storage = get_storage ~base ~debug:(!Factori_types.debug > 0) kt1 storage_decode in
     let storage_reencoded = storage_encode storage in
     Lwt.return_ok @@ Factori_types.output_debug @@ Format.asprintf "Done downloading storage: %s."
     (Ezjsonm_interface.to_string
     (Json_encoding.construct
     micheline_enc.json
     storage_reencoded))