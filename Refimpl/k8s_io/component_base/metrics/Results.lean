/-
component-base `metrics`'s modelled axioms proved in the model (`#model_check`), and the binding
class checked against etcd-grove's translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.component_base.metrics.HistogramVec__WithContext
public import Refimpl.k8s_io.component_base.metrics.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  kmetrics.HistogramVec.WithContext.model_proof
  kmetrics.opaqueInitsOk.model_proof
  kmetrics.initFuncsOk.model_proof

#bound_check k8s_io.component_base.metrics.Refimpl

end Model
end EtcdGrove
end Perennial
