let downgrade =
  [
    "drop discovery_storage cascade";
    "drop discovery__default cascade";
    "drop bm_discovery_ cascade";
  ]

let upgrade =
  [
    "create table discovery_storage(contract varchar not null, transaction \
     varchar not null, block varchar not null, index int not null, level int \
     not null, tsp timestamp not null, main boolean not null, storage_content \
     jsonb not null)";
    "create index discovery_storage_contract_index on \
     discovery_storage(contract)";
    "create index discovery_storage_block_index on discovery_storage(block)";
    "create index discovery_storage_level_index on discovery_storage(level)";
    "create index discovery_storage_tsp_index on discovery_storage(tsp)";
    "create index discovery_storage_main_index on discovery_storage(main)";
    "create table discovery__default(contract varchar not null, transaction \
     varchar not null, block varchar not null, index int not null, level int \
     not null, tsp timestamp not null, main boolean not null, \
     _default_parameter jsonb not null)";
    "create index discovery__default_contract_index on \
     discovery__default(contract)";
    "create index discovery__default_block_index on discovery__default(block)";
    "create index discovery__default_level_index on discovery__default(level)";
    "create index discovery__default_tsp_index on discovery__default(tsp)";
    "create index discovery__default_main_index on discovery__default(main)";
    "create table bm_discovery_(contract varchar not null, transaction varchar \
     not null, block varchar not null, index int not null, level int not null, \
     tsp timestamp not null, main boolean not null, key__parameter jsonb not \
     null, value__parameter jsonb not null)";
    "create index bm_discovery__contract_index on bm_discovery_(contract)";
    "create index bm_discovery__block_index on bm_discovery_(block)";
    "create index bm_discovery__level_index on bm_discovery_(level)";
    "create index bm_discovery__tsp_index on bm_discovery_(tsp)";
    "create index bm_discovery__main_index on bm_discovery_(main)";
  ]
