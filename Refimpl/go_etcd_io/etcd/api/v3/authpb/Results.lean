/-
`go_etcd_io/etcd/api/v3/authpb`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.api.v3.authpb.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_api_v3_authpb.opaqueInitsOk.model_proof
  go_etcd_io_etcd_api_v3_authpb.initFuncsOk.model_proof

#bound_check _root_.Perennial.go_etcd_io.etcd.api.v3.authpb.Refimpl

end Model
end EtcdGrove
end Perennial
