/-
The modelled axioms of `metav1`'s label selectors (`LabelSelectorAsSelector`, and the predicate
`labels.reqsValid` its spec is written in), proved in the model (`#model_check`), and the binding
class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.apimachinery.pkg.apis.«meta».v1.LabelSelectorAsSelector

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  labels.LabelSelectorAsSelector.model_proof

#bound_check k8s_io.apimachinery.pkg.apis.«meta».v1.Refimpl

end Model
end EtcdGrove
end Perennial
