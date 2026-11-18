/-
The modelled axioms of `k8s.io/apimachinery/pkg/labels`' trust boundary, proved in the model
(`#model_check`), and the binding class checked against etcd-grove's own translated bodies
(`#bound_check`). `labels.reqsValid` and `LabelSelectorAsSelector` are `metav1`'s (`Refimpl/k8s_io/
apimachinery/pkg/apis/meta/v1/`).
-/
module

public import Refimpl.k8s_io.apimachinery.pkg.labels.Everything

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  labels.Everything.model_proof

#bound_check k8s_io.apimachinery.pkg.labels.Refimpl

end Model
end EtcdGrove
end Perennial
