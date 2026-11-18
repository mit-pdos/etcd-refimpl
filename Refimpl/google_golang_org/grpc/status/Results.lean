/-
grpc `status`'s axioms proved in the model (`#model_check`; `status.Error` and `status.FromError`
are not: no implementation meets them, README "Findings"), and the binding classes checked against
etcd-grove's translated bodies.
-/
module

public import Refimpl.google_golang_org.grpc.status.Code
public import Refimpl.google_golang_org.grpc.status.Errorf
public import Refimpl.google_golang_org.grpc.status.Status__Code

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  status.Code.model_proof
  status.Errorf.model_proof
  status.Status.Code.model_proof

#bound_check google_golang_org.grpc.status.Refimpl
#bound_check google_golang_org.grpc.internal.status.Refimpl

end Model
end EtcdGrove
end Perennial
