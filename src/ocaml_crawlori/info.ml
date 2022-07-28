open Tzfunc
open Proto

type z = (A.uzarith[@encoding A.uzarith_enc.json]) [@@deriving encoding]

type contract_info = {
  ci_address : A.contract; [@encoding A.contract_enc.json]
  ci_kind : string;
  ci_bmid_discovery_ : z option;
  ci_bmid_consensus_vault_vault : z option;
  ci_bmid_consensus_vault_used_handles : z option;
  ci_bmid_consensus_vault_known_handles_hash : z option;
}
[@@deriving encoding]

let info_of_row r =
  {
    ci_address = r#address;
    ci_kind = r#kind;
    ci_bmid_discovery_ =
      Option.bind r#bmid_discovery_ (fun s -> Some (Z.of_string s));
    ci_bmid_consensus_vault_vault =
      Option.bind r#bmid_consensus_vault_vault (fun s -> Some (Z.of_string s));
    ci_bmid_consensus_vault_used_handles =
      Option.bind r#bmid_consensus_vault_used_handles (fun s ->
          Some (Z.of_string s));
    ci_bmid_consensus_vault_known_handles_hash =
      Option.bind r#bmid_consensus_vault_known_handles_hash (fun s ->
          Some (Z.of_string s));
  }

let track_contract ?ci_bmid_consensus_vault_known_handles_hash
    ?ci_bmid_consensus_vault_used_handles ?ci_bmid_consensus_vault_vault
    ?ci_bmid_discovery_ address kind =
  {
    ci_address = address;
    ci_kind = kind;
    ci_bmid_discovery_;
    ci_bmid_consensus_vault_vault;
    ci_bmid_consensus_vault_used_handles;
    ci_bmid_consensus_vault_known_handles_hash;
  }
