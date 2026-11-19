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

end Model
end EtcdGrove
end Perennial
