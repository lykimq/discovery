open Tzfunc.Proto
open Factori_types
(*Type definition for handle *)

type handle = {ticketer : address;owner : address;id : nat;data : bytes;amount : nat}

val handle_encode : handle -> micheline
val handle_decode : micheline -> handle
val handle_generator : unit -> handle
val handle_micheline : micheline


(*Type definition for withdraw *)

type withdraw = {proof : (bytes *
 bytes) list;handles_hash : bytes;handle : handle;callback : contract}

val withdraw_encode : withdraw -> micheline
val withdraw_decode : micheline -> withdraw
val withdraw_generator : unit -> withdraw
val withdraw_micheline : micheline


val call_withdraw :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                withdraw -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for update_root_hash *)

type update_root_hash = {validators : key_hash list;state_hash : bytes;signatures : signature option list;handles_hash : bytes;current_validator_keys : key option list;block_payload_hash : bytes;block_height : int_michelson}

val update_root_hash_encode : update_root_hash -> micheline
val update_root_hash_decode : micheline -> update_root_hash
val update_root_hash_generator : unit -> update_root_hash
val update_root_hash_micheline : micheline


val call_update_root_hash :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                update_root_hash -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for deposit *)

type deposit = {ticket : bytes ticket;address : address}

val deposit_encode : deposit -> micheline
val deposit_decode : micheline -> deposit
val deposit_generator : unit -> deposit
val deposit_micheline : micheline


val call_deposit :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                deposit -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for vault *)

type vault = {vault : ((address *
 bytes),bytes ticket) big_map;used_handles : (nat,unit) big_map;known_handles_hash : (bytes,unit) big_map}

val vault_encode : vault -> micheline
val vault_decode : micheline -> vault
val vault_generator : unit -> vault
val vault_micheline : micheline


(*Type definition for root_hash *)

type root_hash = {current_validators : key_hash list;current_state_hash : bytes;current_handles_hash : bytes;current_block_height : int_michelson;current_block_hash : bytes}

val root_hash_encode : root_hash -> micheline
val root_hash_decode : micheline -> root_hash
val root_hash_generator : unit -> root_hash
val root_hash_micheline : micheline


(*Type definition for storage *)

type storage = {vault : vault;root_hash : root_hash}

val storage_encode : storage -> micheline
val storage_decode : micheline -> storage
val storage_generator : unit -> storage
val storage_micheline : micheline


val deploy :             ?amount:int64 ->
                         ?node:string ->
                         ?name:string ->
                         ?from:Blockchain.identity ->
                         storage -> (string * string, Tzfunc__.Rp.error) result Lwt.t
                         
val test_storage_download : 
kt1:Proto.A.contract -> base:EzAPI__Url.TYPES.base_url -> unit -> (unit, Tzfunc__.Rp.error) result