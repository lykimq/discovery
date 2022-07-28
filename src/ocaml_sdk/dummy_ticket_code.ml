open Tzfunc.Proto

let code =
  EzEncoding.destruct
    script_expr_enc.json
    {|[{"prim":"parameter","args":[{"prim":"or","args":[{"prim":"or","args":[{"prim":"ticket","args":[{"prim":"bytes"}],"annots":["%burn_callback"]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"address","annots":["%deku_consensus"]},{"prim":"address","annots":["%deku_recipient"]}]},{"prim":"nat","annots":["%ticket_amount"]},{"prim":"bytes","annots":["%ticket_data"]}],"annots":["%mint_to_deku"]}]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"address","annots":["%deku_consensus"]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"nat","annots":["%amount"]},{"prim":"bytes","annots":["%data"]}]},{"prim":"nat","annots":["%id"]},{"prim":"address","annots":["%owner"]}]},{"prim":"address","annots":["%ticketer"]}],"annots":["%handle"]}]},{"prim":"bytes","annots":["%handles_hash"]},{"prim":"list","args":[{"prim":"pair","args":[{"prim":"bytes"},{"prim":"bytes"}]}],"annots":["%proof"]}],"annots":["%withdraw_from_deku"]}]}]},{"prim":"storage","args":[{"prim":"unit"}]},{"prim":"code","args":[[{"prim":"CAR"},{"prim":"IF_LEFT","args":[[{"prim":"IF_LEFT","args":[[{"prim":"DROP"},{"prim":"UNIT"},{"prim":"NIL","args":[{"prim":"operation"}]}],[{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"UNPAIR"},{"prim":"SWAP"},{"prim":"TICKET"},{"prim":"SWAP"},{"prim":"CONTRACT","args":[{"prim":"pair","args":[{"prim":"address","annots":["%address"]},{"prim":"ticket","args":[{"prim":"bytes"}],"annots":["%ticket"]}]}],"annots":["%deposit"]},{"prim":"IF_NONE","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"invalid deku consensus address"}]},{"prim":"FAILWITH"}],[]]},{"prim":"PUSH","args":[{"prim":"mutez"},{"int":"0"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"PAIR"},{"prim":"TRANSFER_TOKENS"},{"prim":"UNIT"},{"prim":"NIL","args":[{"prim":"operation"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"CONS"}]]}],[{"prim":"UNPAIR"},{"prim":"UNPAIR"},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"UNPAIR"},{"prim":"SELF","annots":["%burn_callback"]},{"prim":"DIG","args":[{"int":"3"}]},{"prim":"CONTRACT","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"contract","args":[{"prim":"ticket","args":[{"prim":"bytes"}]}],"annots":["%callback"]},{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"pair","args":[{"prim":"nat","annots":["%amount"]},{"prim":"bytes","annots":["%data"]}]},{"prim":"nat","annots":["%id"]},{"prim":"address","annots":["%owner"]}]},{"prim":"address","annots":["%ticketer"]}],"annots":["%handle"]}]},{"prim":"bytes","annots":["%handles_hash"]},{"prim":"list","args":[{"prim":"pair","args":[{"prim":"bytes"},{"prim":"bytes"}]}],"annots":["%proof"]}]}],"annots":["%withdraw"]},{"prim":"IF_NONE","args":[[{"prim":"PUSH","args":[{"prim":"string"},{"string":"invalid deku consensus address"}]},{"prim":"FAILWITH"}],[]]},{"prim":"PUSH","args":[{"prim":"mutez"},{"int":"0"}]},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"PAIR"},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"DIG","args":[{"int":"4"}]},{"prim":"PAIR"},{"prim":"PAIR"},{"prim":"TRANSFER_TOKENS"},{"prim":"UNIT"},{"prim":"NIL","args":[{"prim":"operation"}]},{"prim":"DIG","args":[{"int":"2"}]},{"prim":"CONS"}]]},{"prim":"PAIR"}]]}]|}
