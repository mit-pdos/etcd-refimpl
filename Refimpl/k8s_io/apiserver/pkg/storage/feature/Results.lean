/-
`k8s_io/apiserver/pkg/storage/feature`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.apiserver.pkg.storage.feature.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_apiserver_pkg_storage_feature.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
