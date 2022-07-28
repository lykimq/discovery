open Tzfunc.Proto
open Factori_types
(*Type definition for handle *)

type handle = {ticketer : address;owner : address;id : nat;data : bytes;amount : nat}


(** Encode elements of type handle into micheline *)
val handle_encode : handle -> micheline

(** Decode elements of type micheline as handle *)
val handle_decode : micheline -> handle

(** Generate random elements of type handle*)
val handle_generator : unit -> handle

(** The micheline type corresponding to type handle*)
val handle_micheline : micheline


(*Type definition for withdraw *)

type withdraw = {proof : (bytes *
 bytes) list;handles_hash : bytes;handle : handle;callback : contract}


(** Encode elements of type withdraw into micheline *)
val withdraw_encode : withdraw -> micheline

(** Decode elements of type micheline as withdraw *)
val withdraw_decode : micheline -> withdraw

(** Generate random elements of type withdraw*)
val withdraw_generator : unit -> withdraw

(** The micheline type corresponding to type withdraw*)
val withdraw_micheline : micheline



(** Call entrypoint withdraw of the smart contract. *)
val call_withdraw :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                withdraw -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for update_root_hash *)

type update_root_hash = {validators : key_hash list;state_hash : bytes;signatures : signature option list;handles_hash : bytes;current_validator_keys : key option list;block_payload_hash : bytes;block_height : int_michelson}


(** Encode elements of type update_root_hash into micheline *)
val update_root_hash_encode : update_root_hash -> micheline

(** Decode elements of type micheline as update_root_hash *)
val update_root_hash_decode : micheline -> update_root_hash

(** Generate random elements of type update_root_hash*)
val update_root_hash_generator : unit -> update_root_hash

(** The micheline type corresponding to type update_root_hash*)
val update_root_hash_micheline : micheline



(** Call entrypoint update_root_hash of the smart contract. *)
val call_update_root_hash :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                update_root_hash -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for deposit *)

type deposit = {ticket : bytes ticket;address : address}


(** Encode elements of type deposit into micheline *)
val deposit_encode : deposit -> micheline

(** Decode elements of type micheline as deposit *)
val deposit_decode : micheline -> deposit

(** Generate random elements of type deposit*)
val deposit_generator : unit -> deposit

(** The micheline type corresponding to type deposit*)
val deposit_micheline : micheline



(** Call entrypoint deposit of the smart contract. *)
val call_deposit :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                deposit -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for vault *)

type vault = {vault : ((address *
 bytes),bytes ticket) big_map;used_handles : (nat,unit) big_map;known_handles_hash : (bytes,unit) big_map}


(** Encode elements of type vault into micheline *)
val vault_encode : vault -> micheline

(** Decode elements of type micheline as vault *)
val vault_decode : micheline -> vault

(** Generate random elements of type vault*)
val vault_generator : unit -> vault

(** The micheline type corresponding to type vault*)
val vault_micheline : micheline


(*Type definition for root_hash *)

type root_hash = {current_validators : key_hash list;current_state_hash : bytes;current_handles_hash : bytes;current_block_height : int_michelson;current_block_hash : bytes}


(** Encode elements of type root_hash into micheline *)
val root_hash_encode : root_hash -> micheline

(** Decode elements of type micheline as root_hash *)
val root_hash_decode : micheline -> root_hash

(** Generate random elements of type root_hash*)
val root_hash_generator : unit -> root_hash

(** The micheline type corresponding to type root_hash*)
val root_hash_micheline : micheline


(*Type definition for storage *)

type storage = {vault : vault;root_hash : root_hash}


(** Encode elements of type storage into micheline *)
val storage_encode : storage -> micheline

(** Decode elements of type micheline as storage *)
val storage_decode : micheline -> storage

(** Generate random elements of type storage*)
val storage_generator : unit -> storage

(** The micheline type corresponding to type storage*)
val storage_micheline : micheline



(** A function to deploy the smart contract.
           - amount is the initial balance of the contract
           - node allows to choose on which chain we are deploying
           - name allows to choose a name for the contract you are deploying
           - from is the account which will originate the contract (and pay for its origination)
           The function returns a pair (kt1,op_hash) where kt1 is the address of the contract
           and op_hash is the hash of the origination operation
       *)
val deploy :             ?amount:int64 ->
                         ?node:string ->
                         ?name:string ->
                         ?from:Blockchain.identity ->
                         storage -> (string * string, Tzfunc__.Rp.error) result Lwt.t

(** Downloads and decodes the storage, and then reencodes it.
Allows to check the robustness of the encoding and decoding functions. *)
val test_storage_download :
kt1:Proto.A.contract -> base:EzAPI__Url.TYPES.base_url -> unit -> (unit, Tzfunc__.Rp.error) result