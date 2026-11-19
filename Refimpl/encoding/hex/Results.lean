/-
`encoding/hex`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.encoding.hex.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  encoding_hex.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
