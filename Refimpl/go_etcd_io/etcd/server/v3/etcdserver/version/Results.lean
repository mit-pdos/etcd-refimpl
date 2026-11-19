/-
`go_etcd_io/etcd/server/v3/etcdserver/version`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.server.v3.etcdserver.version.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_server_v3_etcdserver_version.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
