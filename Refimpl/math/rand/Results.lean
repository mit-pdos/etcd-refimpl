/-
`math/rand`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.math.rand.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  math_rand.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
