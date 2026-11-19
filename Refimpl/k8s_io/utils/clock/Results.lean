/-
`k8s_io/utils/clock`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.utils.clock.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_utils_clock.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
