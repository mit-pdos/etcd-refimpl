/-
`k8s_io/component_base/featuregate`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.component_base.featuregate.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_component_base_featuregate.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
