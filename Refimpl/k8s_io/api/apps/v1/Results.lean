/-
The modelled axioms of `k8s.io/api/apps/v1`'s trust boundary, proved in the model (`#model_check`), and
the binding class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.api.apps.v1.Resource

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  appsv1.Resource.model_proof

#bound_check k8s_io.api.apps.v1.Refimpl

end Model
end EtcdGrove
end Perennial
