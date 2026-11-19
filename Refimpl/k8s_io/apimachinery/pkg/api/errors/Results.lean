/-
The modelled axioms of `k8s.io/apimachinery/pkg/api/errors`' trust boundary, proved in the model
(`#model_check`), and the binding class checked against etcd-grove's own translated bodies
(`#bound_check`).
-/
module

public import Refimpl.k8s_io.apimachinery.pkg.api.errors.HasStatusCause
public import Refimpl.k8s_io.apimachinery.pkg.api.errors.IsTimeout
public import Refimpl.k8s_io.apimachinery.pkg.api.errors.NewConflict
public import Refimpl.k8s_io.apimachinery.pkg.api.errors.NewInternalError
public import Refimpl.k8s_io.apimachinery.pkg.api.errors.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  apierrors.HasStatusCause.model_proof
  apierrors.IsTimeout.model_proof
  apierrors.NewConflict.model_proof
  apierrors.NewInternalError.model_proof
  apierrors.opaqueInitsOk.model_proof

#bound_check k8s_io.apimachinery.pkg.api.errors.Refimpl

end Model
end EtcdGrove
end Perennial
