open Tzfunc.Proto
open Factori_types
(*Type definition for handle *)

type handle = {ticketer : address;owner : address;id : nat;data : bytes;amount : nat}

val handle_encode : handle -> micheline
val handle_decode : micheline -> handle
val handle_generator : unit -> handle
val handle_micheline : micheline


(*Type definition for withdraw_from_deku *)

type withdraw_from_deku = {proof : (bytes *
 bytes) list;handles_hash : bytes;handle : handle;deku_consensus : address}

val withdraw_from_deku_encode : withdraw_from_deku -> micheline
val withdraw_from_deku_decode : micheline -> withdraw_from_deku
val withdraw_from_deku_generator : unit -> withdraw_from_deku
val withdraw_from_deku_micheline : micheline


val call_withdraw_from_deku :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                withdraw_from_deku -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for mint_to_deku *)

type mint_to_deku = {ticket_data : bytes;ticket_amount : nat;deku_recipient : address;deku_consensus : address}

val mint_to_deku_encode : mint_to_deku -> micheline
val mint_to_deku_decode : micheline -> mint_to_deku
val mint_to_deku_generator : unit -> mint_to_deku
val mint_to_deku_micheline : micheline


val call_mint_to_deku :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                mint_to_deku -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for burn_callback *)
type burn_callback = bytes ticket
val burn_callback_encode : burn_callback -> micheline
val burn_callback_decode : micheline -> burn_callback
val burn_callback_generator : unit -> burn_callback
val burn_callback_micheline : micheline


val call_burn_callback :   ?node:string -> ?debug:bool -> ?amount:int64 -> from:Blockchain.identity ->
                kt1:Tzfunc.Proto.A.contract ->
                burn_callback -> (string, Tzfunc__.Rp.error) result Lwt.t

(*Type definition for storage *)
type storage = unit
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