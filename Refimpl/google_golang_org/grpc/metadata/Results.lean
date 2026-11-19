/-
grpc `metadata`'s axioms proved in the model (`#model_check`; `AppendToOutgoingContext` is not met
by any implementation: README "Findings"), and the binding
class checked against etcd-grove's translated bodies.
-/
module

public import Refimpl.google_golang_org.grpc.metadata.FromIncomingContext
public import Refimpl.google_golang_org.grpc.metadata.FromOutgoingContext
public import Refimpl.google_golang_org.grpc.metadata.Laws
public import Refimpl.google_golang_org.grpc.metadata.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  metadata.FromIncomingContext.model_proof
  metadata.FromOutgoingContext.model_proof
  metadata.incomingOf_cancelCtx.model_proof
  metadata.opaqueInitsOk.model_proof
  metadata.initFuncsOk.model_proof

#bound_check google_golang_org.grpc.metadata.Refimpl

end Model
end EtcdGrove
end Perennial
