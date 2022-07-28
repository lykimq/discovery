(* This file is only generated once, but as long as it exists it
   will not be overwritten, you can safely write in it. To find
   examples for your scenarios, you can look at scenarios.example.ml *)

(* compile the project using:
    eval $(opam env --switch=/home/quyen/factori --set-switch)
   make deps
   make ocaml
   make run_scenario_ocaml
   Using : https://ghostnet.tzkt.io/
   to see the contract KT1xxx
*)

open Discovery_ocaml_interface
open Consensus_ocaml_interface
open Tzfunc.Rp
open Factori_types

(* Using the info from node/i/identity.json
   - key_hash_0 : data/0 and so on
*)
let key_hash_0 = "tz1cQHF5EpGrGWt3fdYLJrWmNZBVw2oKqPwY"

let key_hash_1 = "tz1W3vJkX7kfbp8Y4RfdTmgQwV1Gm5cwcPHU"

let key_hash_2 = "tz1Zhp7V6VAH5Fvc3Q8To92tJXWfyvu9FRN5"

let key_hash_3 = "tz1TJ4PxhKwumAqScGyJYBkUdo2U2PJRB49Y"

let uri = "http://localhost:4440"

let nonce = Z.zero

let discovery_storage = Literal [(key_hash_0, (nonce, uri))]

(* This discovery_kt1 address is deployed in the ithaca_node
   provided by factori lib *)
let discovery_kt1 = "KT1Fp4eEdKcugr8Ftf19UBdMTnyCsTut3LtR"

(* This consensus_kt1 address is deployed in the ithaca_node provided
   by factori lib *)
let consensus_kt1 = "KT1Ves3jg62PfHbgSSwbCyr9pX4KjFFUs74a"

let empty_bytes = Crypto.H.mk ""

let ticket_bytes = Ticket empty_bytes

let vault_storage =
  {
    vault = Literal [ (*("", empty_bytes), ticket_bytes*) ];
    used_handles = Literal [(Z.zero, ())];
    known_handles_hash = Literal [(empty_bytes, ())];
  }

let root_hash =
  {
    current_validators = [key_hash_0; key_hash_1; key_hash_2; key_hash_3];
    current_state_hash = empty_bytes;
    current_handles_hash = empty_bytes;
    current_block_height = Z.zero;
    current_block_hash = empty_bytes;
  }

let consensus_storage = {vault = vault_storage; root_hash}

let main () =
  let _ = Tzfunc.Node.set_silent true in
  Format.printf "Calling discovery contract@." ;
  Format.printf "KT1: %s@." discovery_kt1 ;
  Format.printf "Calling consensus contract@." ;
  (*let>? consensus_kt1, _op_hash =
      Consensus_ocaml_interface.deploy
      ~node:Blockchain.ithaca_node
      ~name:"consensus"
      ~from:Blockchain.alice_flextesa
      ~amount:10000L
      consensus_storage
    in*)
  Format.printf "KT1: %s@." consensus_kt1 ;

  Lwt.return_ok ()

let _ = Lwt_main.run (main ())
