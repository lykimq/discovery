let downgrade = [
"drop consensus_storage cascade";
"drop consensus_deposit cascade";
"drop consensus_update_root_hash cascade";
"drop consensus_withdraw cascade";
"drop bm_consensus_vault cascade";
"drop bm_consensus_used_handles cascade";
"drop bm_consensus_known_handles_hash cascade";
]

let upgrade = ["create table consensus_storage(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
storage_content jsonb not null)" ;

"create index consensus_storage_contract_index on consensus_storage(contract)" ;
"create index consensus_storage_block_index on consensus_storage(block)" ;
"create index consensus_storage_level_index on consensus_storage(level)" ;
"create index consensus_storage_tsp_index on consensus_storage(tsp)" ;
"create index consensus_storage_main_index on consensus_storage(main)" ;

"create table consensus_deposit(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
deposit_parameter jsonb not null)" ;

"create index consensus_deposit_contract_index on consensus_deposit(contract)" ;
"create index consensus_deposit_block_index on consensus_deposit(block)" ;
"create index consensus_deposit_level_index on consensus_deposit(level)" ;
"create index consensus_deposit_tsp_index on consensus_deposit(tsp)" ;
"create index consensus_deposit_main_index on consensus_deposit(main)" ;

"create table consensus_update_root_hash(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
update_root_hash_parameter jsonb not null)" ;

"create index consensus_update_root_hash_contract_index on consensus_update_root_hash(contract)" ;
"create index consensus_update_root_hash_block_index on consensus_update_root_hash(block)" ;
"create index consensus_update_root_hash_level_index on consensus_update_root_hash(level)" ;
"create index consensus_update_root_hash_tsp_index on consensus_update_root_hash(tsp)" ;
"create index consensus_update_root_hash_main_index on consensus_update_root_hash(main)" ;

"create table consensus_withdraw(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
withdraw_parameter jsonb not null)" ;

"create index consensus_withdraw_contract_index on consensus_withdraw(contract)" ;
"create index consensus_withdraw_block_index on consensus_withdraw(block)" ;
"create index consensus_withdraw_level_index on consensus_withdraw(level)" ;
"create index consensus_withdraw_tsp_index on consensus_withdraw(tsp)" ;
"create index consensus_withdraw_main_index on consensus_withdraw(main)" ;

"create table bm_consensus_vault(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
key_vault_parameter jsonb not null, \
value_vault_parameter jsonb not null)" ;

"create index bm_consensus_vault_contract_index on bm_consensus_vault(contract)" ;
"create index bm_consensus_vault_block_index on bm_consensus_vault(block)" ;
"create index bm_consensus_vault_level_index on bm_consensus_vault(level)" ;
"create index bm_consensus_vault_tsp_index on bm_consensus_vault(tsp)" ;
"create index bm_consensus_vault_main_index on bm_consensus_vault(main)" ;

"create table bm_consensus_used_handles(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
key_used_handles_parameter jsonb not null, \
value_used_handles_parameter jsonb not null)" ;

"create index bm_consensus_used_handles_contract_index on bm_consensus_used_handles(contract)" ;
"create index bm_consensus_used_handles_block_index on bm_consensus_used_handles(block)" ;
"create index bm_consensus_used_handles_level_index on bm_consensus_used_handles(level)" ;
"create index bm_consensus_used_handles_tsp_index on bm_consensus_used_handles(tsp)" ;
"create index bm_consensus_used_handles_main_index on bm_consensus_used_handles(main)" ;

"create table bm_consensus_known_handles_hash(\
contract varchar not null, \
transaction varchar not null, \
block varchar not null, \
index int not null, \
level int not null, \
tsp timestamp not null, \
main boolean not null, \
key_known_handles_hash_parameter jsonb not null, \
value_known_handles_hash_parameter jsonb not null)" ;

"create index bm_consensus_known_handles_hash_contract_index on bm_consensus_known_handles_hash(contract)" ;
"create index bm_consensus_known_handles_hash_block_index on bm_consensus_known_handles_hash(block)" ;
"create index bm_consensus_known_handles_hash_level_index on bm_consensus_known_handles_hash(level)" ;
"create index bm_consensus_known_handles_hash_tsp_index on bm_consensus_known_handles_hash(tsp)" ;
"create index bm_consensus_known_handles_hash_main_index on bm_consensus_known_handles_hash(main)" ;
]