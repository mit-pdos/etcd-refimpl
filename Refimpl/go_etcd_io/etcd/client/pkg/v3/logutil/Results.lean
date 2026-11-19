/-
`go_etcd_io/etcd/client/pkg/v3/logutil`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.client.pkg.v3.logutil.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_client_pkg_v3_logutil.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
