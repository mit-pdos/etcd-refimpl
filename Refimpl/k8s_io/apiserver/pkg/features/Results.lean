/-
`k8s_io/apiserver/pkg/features`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.apiserver.pkg.features.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_apiserver_pkg_features.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
