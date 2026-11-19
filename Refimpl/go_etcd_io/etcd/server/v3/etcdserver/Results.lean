/-
`go_etcd_io/etcd/server/v3/etcdserver`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.server.v3.etcdserver.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_server_v3_etcdserver.opaqueInitsOk.model_proof
  go_etcd_io_etcd_server_v3_etcdserver.initFuncsOk.model_proof

#bound_check _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.Refimpl

end Model
end EtcdGrove
end Perennial
