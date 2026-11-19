/-
`encoding/json`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.encoding.json.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  encoding_json.opaqueInitsOk.model_proof
  encoding_json.initFuncsOk.model_proof

#bound_check _root_.Perennial.encoding.json.Refimpl

end Model
end EtcdGrove
end Perennial
