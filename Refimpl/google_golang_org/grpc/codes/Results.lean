/-
grpc `codes`'s initialization axioms proved in the model (`#model_check`), and the binding class
checked against etcd-grove's translated bodies (`#bound_check`).
-/
module

public import Refimpl.google_golang_org.grpc.codes.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  codes.opaqueInitsOk.model_proof
  codes.initFuncsOk.model_proof

#bound_check google_golang_org.grpc.codes.Refimpl

end Model
end EtcdGrove
end Perennial
