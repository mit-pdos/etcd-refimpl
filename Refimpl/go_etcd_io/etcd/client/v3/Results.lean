/-
`go_etcd_io/etcd/client/v3`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.client.v3.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_client_v3.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
