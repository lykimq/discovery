open Tzfunc.Proto
let code = EzEncoding.destruct script_expr_enc.json  {|[{"prim":"parameter","args":[{"prim":"or","args":[{"prim":"or","args":[{"prim":"pair","args":[{"prim":"address","annots":["%address"]},{"prim":"ticket","args":[{"prim":"bytes"}],"annots":["%ticket"]}],"annots":["%deposit"]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"int","annots":["%block_height"]},{"prim":"bytes","annots":["%block_payload_hash"]}]},{"prim":"list","args":[{"prim":"option","args":[{"prim":"key"}]}],"annots":["%current_validator_keys"]},{"prim":"bytes","annots":["%handles_hash"]}]},{"prim":"pair","args":[{"prim":"list","args":[{"prim":"option","args":[{"prim":"signature"}]}],"annots":["%signatures"]},{"prim":"bytes","annots":["%state_hash"]}]},{"prim":"list","args":[{"prim":"key_hash"}],"annots":["%validators"]}],"annots":["%update_root_hash"]}]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"contract","args":[{"prim":"ticket","args":[{"prim":"bytes"}]}],"annots":["%callback"]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"nat","annots":["%amount"]},{"prim":"bytes","annots":["%data"]}]},{"prim":"nat","annots":["%id"]},{"prim":"address","annots":["%owner"]}]},{"prim":"address","annots":["%ticketer"]}],"annots":["%handle"]}]},{"prim":"bytes","annots":["%handles_hash"]},{"prim":"list","args":[{"prim":"pair","args":[{"prim":"bytes"},{"prim":"bytes"}]}],"annots":["%proof"]}],"annots":["%withdraw"]}]}]},{"prim":"storage","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"bytes","annots":["%current_block_hash"]},{"prim":"int","annots":["%current_block_height"]}]},{"prim":"bytes","annots":["%current_handles_hash"]},{"prim":"bytes","annots":["%current_state_hash"]}]},{"prim":"list","args":[{"prim":"key_hash"}],"annots":["%current_validators"]}],"annots":["%root_hash"]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"big_map","args":[{"prim":"bytes"},{"prim":"unit"}],"annots":["%known_handles_hash"]},{"prim":"big_map","args":[{"prim":"nat"},{"prim":"unit"}],"annots":["%used_handles"]}]},{"prim":"big_map","args":[{"prim":"pair","args":[{"prim":"address"},{"prim":"bytes"}]},{"prim":"ticket","args":[{"prim":"bytes"}]}],"annots":["%vault"]}],"annots":["%vault"]}]}]},{"prim":"code","args":[[{"prim":"LAMBDA","args":[{"prim":"pair","args":[{"prim":"string"},{"prim":"bool"}]},{"prim":"unit"},[{"prim":"UNPAIR"},{"prim":"SWAP"},{"prim":"NOT"},{"prim":"IF","args":[[{"prim":"FAILWITH"}],[{"prim":"DROP"},{"prim":"UNIT"}]]}]]},{"prim":"SWAP"},{"prim":"UNPAIR"},{"prim":"SWAP"},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"IF_LEFT","args":[[{"prim":"IF_LEFT","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DROP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"CDR"},{"prim":"READ_TICKET"},{"prim":"UNPAIR"},{"prim":"SWAP"},{"prim":"CAR"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"NONE","args":[{"prim":"ticket","args":[{"prim":"bytes"}]}]},{"prim":"DUP","args":[{"int":"3"}]},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"PAIR"},{"prim":"GET_AND_UPDATE"},{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"}],[{"prim":"DIG","args":[{"int":"4"}]},{"prim":"SWAP"},{"prim":"PAIR"},{"prim":"JOIN_TICKETS"},{"prim":"IF_NONE","args":[[{"prim":"DROP"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"unreachable"}]},{"prim":"FAILWITH"}],[{"prim":"PAIR"}]]}]]},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"SOME"},{"prim":"SWAP"},{"prim":"UPDATE"},{"prim":"DUG","args":[{"int":"2"}]}],[{"prim":"DUP"},{"prim":"CDR"},{"prim":"CDR"},{"prim":"PACK"},{"prim":"BLAKE2B"},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"CDR"},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"3"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CDR"},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"3"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"4"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CAR"},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"PACK"},{"prim":"BLAKE2B"},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CAR"},{"prim":"DUP","args":[{"int":"4"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"COMPARE"},{"prim":"GT"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"old block height"}]},{"prim":"PAIR"},{"prim":"DIG","args":[{"int":"6"}]},{"prim":"SWAP"},{"prim":"EXEC"},{"prim":"DROP"},{"prim":"DUP","args":[{"int":"4"}]},{"prim":"CDR"},{"prim":"SIZE"},{"prim":"INT"},{"prim":"PUSH","args":[{"prim":"int"},{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"int"},{"int":"2"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"MUL"},{"prim":"EDIV"},{"prim":"IF_NONE","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"DIV by 0"}]},{"prim":"FAILWITH"}],[]]},{"prim":"CAR"},{"prim":"DUP","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"4"}]},{"prim":"CDR"},{"prim":"CAR"},{"prim":"CAR"},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]},{"prim":"LOOP_LEFT","args":[[{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"IF_CONS","args":[[{"prim":"DUP"},{"prim":"IF_NONE","args":[[{"prim":"DUP","args":[{"int":"5"}]},{"prim":"IF_CONS","args":[[{"prim":"IF_NONE","args":[[{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"DROP","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"2"}]},{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"5"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"5"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"DUP","args":[{"int":"6"}]},{"prim":"IF_CONS","args":[[{"prim":"IF_NONE","args":[[{"prim":"DROP","args":[{"int":"2"}]},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"IF_CONS","args":[[{"prim":"IF_NONE","args":[[{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"DROP","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"2"}]},{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"5"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"5"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"7"}]},{"prim":"DROP","args":[{"int":"2"}]},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"CHECK_SIGNATURE"},{"prim":"IF","args":[[{"prim":"PUSH","args":[{"prim":"int"},{"int":"1"}]},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"SUB"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"4"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"bad signature"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"DROP"},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"IF_CONS","args":[[{"prim":"IF_NONE","args":[[{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"DROP","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"2"}]},{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"5"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"5"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}]]}]]}]]}]]}],[{"prim":"DROP"},{"prim":"SWAP"},{"prim":"IF_CONS","args":[[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validators and signatures have different size"}]},{"prim":"FAILWITH"}],[{"prim":"PUSH","args":[{"prim":"int"},{"int":"0"}]},{"prim":"SWAP"},{"prim":"COMPARE"},{"prim":"GT"},{"prim":"IF","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"not enough key-signature matches"}]},{"prim":"FAILWITH"}],[{"prim":"UNIT"}]]}]]},{"prim":"RIGHT","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"list","args":[{"prim":"option","args":[{"prim":"key"}]}]},{"prim":"list","args":[{"prim":"option","args":[{"prim":"signature"}]}]}]},{"prim":"bytes"},{"prim":"int"}]}]}]]}]]},{"prim":"DROP"},{"prim":"DUP","args":[{"int":"4"}]},{"prim":"CDR"},{"prim":"SIZE"},{"prim":"INT"},{"prim":"PUSH","args":[{"prim":"int"},{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"int"},{"int":"2"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"MUL"},{"prim":"EDIV"},{"prim":"IF_NONE","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"DIV by 0"}]},{"prim":"FAILWITH"}],[]]},{"prim":"CAR"},{"prim":"DUP","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]},{"prim":"LOOP_LEFT","args":[[{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"IF_CONS","args":[[{"prim":"IF_NONE","args":[[{"prim":"DIG","args":[{"int":"3"}]},{"prim":"IF_CONS","args":[[{"prim":"DROP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validator_keys and validators have different size"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DIG","args":[{"int":"4"}]},{"prim":"IF_CONS","args":[[{"prim":"DIG","args":[{"int":"2"}]},{"prim":"HASH_KEY"},{"prim":"COMPARE"},{"prim":"EQ"},{"prim":"IF","args":[[{"prim":"PUSH","args":[{"prim":"int"},{"int":"1"}]},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"SUB"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP","args":[{"int":"4"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validator_key does not match validator hash"}]},{"prim":"FAILWITH"}]]}],[{"prim":"DROP","args":[{"int":"4"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validator_keys and validators have different size"}]},{"prim":"FAILWITH"}]]}]]}],[{"prim":"DROP"},{"prim":"SWAP"},{"prim":"IF_CONS","args":[[{"prim":"DROP","args":[{"int":"3"}]},{"prim":"PUSH","args":[{"prim":"string"},{"string":"validator_keys and validators have different size"}]},{"prim":"FAILWITH"}],[{"prim":"PUSH","args":[{"prim":"int"},{"int":"0"}]},{"prim":"SWAP"},{"prim":"COMPARE"},{"prim":"GT"},{"prim":"IF","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"not enough keys"}]},{"prim":"FAILWITH"}],[{"prim":"UNIT"}]]}]]},{"prim":"RIGHT","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"list","args":[{"prim":"option","args":[{"prim":"key"}]}]},{"prim":"list","args":[{"prim":"key_hash"}]}]},{"prim":"bytes"},{"prim":"int"}]}]}]]}]]},{"prim":"DROP"},{"prim":"DUP","args":[{"int":"3"}]},{"prim":"CDR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"4"}]},{"prim":"CDR"},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CDR"},{"prim":"PAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"UNIT"},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"SWAP"},{"prim":"SOME"},{"prim":"SWAP"},{"prim":"UPDATE"}]]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"PAIR"},{"prim":"NIL","args":[{"prim":"operation"}]}],[{"prim":"DUP"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"DUP"},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"MEM"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"unknown handles hash"}]},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"9"}]},{"prim":"SWAP"},{"prim":"EXEC"},{"prim":"DROP"},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"MEM"},{"prim":"NOT"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"already used handle"}]},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"9"}]},{"prim":"SWAP"},{"prim":"EXEC"},{"prim":"DROP"},{"prim":"SENDER"},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CDR"},{"prim":"COMPARE"},{"prim":"EQ"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"only the owner can withdraw a handle"}]},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"9"}]},{"prim":"SWAP"},{"prim":"EXEC"},{"prim":"DROP"},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"CDR"},{"prim":"CDR"},{"prim":"PUSH","args":[{"prim":"int"},{"int":"1"}]},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"SIZE"},{"prim":"INT"},{"prim":"SUB"},{"prim":"DIG","args":[{"int":"6"}]},{"prim":"DUG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]},{"prim":"LOOP_LEFT","args":[[{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"SWAP"},{"prim":"IF_CONS","args":[[{"prim":"UNPAIR"},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"DUP","args":[{"int":"2"}]},{"prim":"CONCAT"},{"prim":"BLAKE2B"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"COMPARE"},{"prim":"EQ"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"invalid proof hash"}]},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"12"}]},{"prim":"SWAP"},{"prim":"EXEC"},{"prim":"DROP"},{"prim":"PUSH","args":[{"prim":"nat"},{"int":"0"}]},{"prim":"DUP","args":[{"int":"9"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"ABS"},{"prim":"PUSH","args":[{"prim":"nat"},{"int":"1"}]},{"prim":"LSL"},{"prim":"AND"},{"prim":"COMPARE"},{"prim":"NEQ"},{"prim":"IF","args":[[{"prim":"DROP"}],[{"prim":"SWAP"},{"prim":"DROP"}]]},{"prim":"SWAP"},{"prim":"PUSH","args":[{"prim":"int"},{"int":"1"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"SUB"},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"LEFT","args":[{"prim":"unit"}]}],[{"prim":"DROP"},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"PACK"},{"prim":"BLAKE2B"},{"prim":"SWAP"},{"prim":"COMPARE"},{"prim":"EQ"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"invalid handle data"}]},{"prim":"PAIR"},{"prim":"DUP","args":[{"int":"8"}]},{"prim":"SWAP"},{"prim":"EXEC"},{"prim":"RIGHT","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"int"},{"prim":"list","args":[{"prim":"pair","args":[{"prim":"bytes"},{"prim":"bytes"}]}]}]},{"prim":"bytes"}]}]}]]}]]},{"prim":"DIG","args":[{"int":"7"}]},{"prim":"DROP","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"NONE","args":[{"prim":"ticket","args":[{"prim":"bytes"}]}]},{"prim":"DUP","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"CDR"},{"prim":"PAIR"},{"prim":"GET_AND_UPDATE"},{"prim":"IF_NONE","args":[[{"prim":"DROP"},{"prim":"PUSH","args":[{"prim":"string"},{"string":"unreachable"}]},{"prim":"FAILWITH"}],[{"prim":"PAIR"}]]},{"prim":"UNPAIR"},{"prim":"READ_TICKET"},{"prim":"CDR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CAR"},{"prim":"SWAP"},{"prim":"SUB"},{"prim":"ABS"},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CAR"},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"SPLIT_TICKET"},{"prim":"IF_NONE","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"unreachable"}]},{"prim":"FAILWITH"}],[]]},{"prim":"UNPAIR"},{"prim":"DUG","args":[{"int":"2"}]},{"prim":"DUP","args":[{"int":"6"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"CDR"},{"prim":"DUP","args":[{"int":"7"}]},{"prim":"CDR"},{"prim":"PAIR"},{"prim":"SWAP"},{"prim":"SOME"},{"prim":"SWAP"},{"prim":"UPDATE"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CAR"},{"prim":"PUSH","args":[{"prim":"mutez"},{"int":"0"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"TRANSFER_TOKENS"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"UNIT"},{"prim":"DIG","args":[{"int":"5"}]},{"prim":"CAR"},{"prim":"CDR"},{"prim":"CAR"},{"prim":"SWAP"},{"prim":"SOME"},{"prim":"SWAP"},{"prim":"UPDATE"},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"NIL","args":[{"prim":"operation"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"CONS"},{"prim":"SWAP"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"PAIR"},{"prim":"SWAP"}]]},{"prim":"PAIR"}]]}]|}