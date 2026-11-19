/-
`go_etcd_io/etcd/pkg/v3/featuregate`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.go_etcd_io.etcd.pkg.v3.featuregate.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  go_etcd_io_etcd_pkg_v3_featuregate.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
