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

(* Using the info from node/0/identity.json *)
let key_hash = "tz1cQHF5EpGrGWt3fdYLJrWmNZBVw2oKqPwY"

let uri = "http://localhost:4440"

let nonce = Z.zero

let discovery_storage = Literal [(key_hash, (nonce,uri))]

(* This discovery_kt1 address is deployed in the ithaca_node 
   provided by factori lib *)
let discovery_kt1 = "KT1Fp4eEdKcugr8Ftf19UBdMTnyCsTut3LtR"

let main () =
  let _ = Tzfunc.Node.set_silent true in 
  Format.printf "Calling discovery contract@.";
  Format.printf "KT1: %s@." discovery_kt1;
  (*Format.printf "Deploying the contract@.";
    let>? discovery_kt1, _op_hash =
    deploy 
    ~node:Blockchain.ithaca_node
    ~name:"discovery"
    ~from:Blockchain.alice_flextesa
    ~amount:10000L
    discovery_storage  
  in 
  Format.printf "KT1: %s@." discovery_kt1;*)

  Lwt.return_ok ()
  
  let _ = Lwt_main.run (main ())