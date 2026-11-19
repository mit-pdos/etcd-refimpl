/-
`encoding/base64`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.encoding.base64.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  encoding_base64.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
