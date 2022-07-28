open Tzfunc
open Proto
type z = (A.uzarith[@encoding A.uzarith_enc.json])[@@deriving encoding]

type contract_info = {ci_address : A.contract [@encoding A.contract_enc.json];ci_kind : string;ci_bmid_discovery_ : z option}[@@deriving encoding]
let info_of_row r=
{ci_address = r#address;
ci_kind = r#kind;
ci_bmid_discovery_ = Option.bind r#bmid_discovery_ (fun s -> Some (Z.of_string s))}

let track_contract ?ci_bmid_discovery_ address kind=
{ci_address = address;
ci_kind = kind;
ci_bmid_discovery_ = ci_bmid_discovery_}