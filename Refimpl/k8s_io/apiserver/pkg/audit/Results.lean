/-
`k8s_io/apiserver/pkg/audit`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.apiserver.pkg.audit.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_apiserver_pkg_audit.opaqueInitsOk.model_proof
  k8s_io_apiserver_pkg_audit.initFuncsOk.model_proof

#bound_check _root_.Perennial.k8s_io.apiserver.pkg.audit.Refimpl

end Model
end EtcdGrove
end Perennial
