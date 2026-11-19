/-
`k8s_io/apiserver/pkg/util/flowcontrol`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.apiserver.pkg.util.flowcontrol.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_apiserver_pkg_util_flowcontrol.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
