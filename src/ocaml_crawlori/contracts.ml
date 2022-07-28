open Pg
open Crp
open Common
open Info
open E

let insert_all_operations ?(forward=false) ~dbh ~contract ~op parameter =
let kind = parameter in

       [%pgsql dbh "insert into all_operations(contract,kind,transaction,block,index,level,tsp,main) values ($contract,$kind,${op.bo_hash},${op.bo_block},${op.bo_index},${op.bo_level},${op.bo_tsp},$forward)"]

let discovery_register ~dbh ~forward config address kind op bmid_discovery_=
let>? () = [%pgsql dbh "insert into contracts\
(address,kind,transaction,block,index,level,tsp,main,bmid_discovery_) \
values \
($address,$kind,${op.bo_hash},${op.bo_block},${op.bo_index},\
${op.bo_level},${op.bo_tsp},$forward,$bmid_discovery_)"] in
config.contracts <- CSet.add (track_contract address kind ~ci_bmid_discovery_:bmid_discovery_) config.contracts ;
rok ()

let consensus_register ~dbh ~forward config address kind op bmid_consensus_vault_vault bmid_consensus_vault_used_handles bmid_consensus_vault_known_handles_hash=
let>? () = [%pgsql dbh "insert into contracts\
(address,kind,transaction,block,index,level,tsp,main,bmid_consensus_vault_vault,bmid_consensus_vault_used_handles,bmid_consensus_vault_known_handles_hash) \
values \
($address,$kind,${op.bo_hash},${op.bo_block},${op.bo_index},\
${op.bo_level},${op.bo_tsp},$forward,$bmid_consensus_vault_vault,$bmid_consensus_vault_used_handles,$bmid_consensus_vault_known_handles_hash)"] in
config.contracts <- CSet.add (track_contract address kind ~ci_bmid_consensus_vault_vault:bmid_consensus_vault_vault ~ci_bmid_consensus_vault_used_handles:bmid_consensus_vault_used_handles ~ci_bmid_consensus_vault_known_handles_hash:bmid_consensus_vault_known_handles_hash) config.contracts ;
rok ()

let dummy_ticket_register ~dbh ~forward config address kind op=
let>? () = [%pgsql dbh "insert into contracts\
(address,kind,transaction,block,index,level,tsp,main) \
values \
($address,$kind,${op.bo_hash},${op.bo_block},${op.bo_index},\
${op.bo_level},${op.bo_tsp},$forward)"] in
config.contracts <- CSet.add (track_contract address kind) config.contracts ;
rok ()