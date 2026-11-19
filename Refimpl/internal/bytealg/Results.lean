/-
`internal/bytealg`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.internal.bytealg.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  internal_bytealg.initFuncsOk.model_proof

#bound_check _root_.Perennial.internal.bytealg.Refimpl

end Model
end EtcdGrove
end Perennial
