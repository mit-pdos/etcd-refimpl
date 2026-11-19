/-
`bufio`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.bufio.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  bufio.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
