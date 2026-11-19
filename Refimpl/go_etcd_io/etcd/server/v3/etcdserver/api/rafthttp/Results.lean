/-
`go_etcd_io/etcd/server/v3/etcdserver/api/rafthttp`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.opaqueInitsOk.model_proof
  go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errorsNewVarsInit.model_proof

end Model
end EtcdGrove
end Perennial
