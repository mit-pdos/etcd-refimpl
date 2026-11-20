/-
`go_etcd_io/etcd/server/v3/etcdserver/api/v3rpc`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.server.v3.etcdserver.api.v3rpc.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_server_v3_etcdserver_api_v3rpc.initFuncsOk.model_proof

#bound_check _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.v3rpc.Refimpl

end Model
end EtcdGrove
end Perennial
