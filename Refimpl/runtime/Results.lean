/-
`runtime`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.runtime.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  runtime.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
