/-
grpc `health`'s and `health/grpc_health_v1`'s axioms proved in the model (`#model_check`): the law
and the package initializers. Not the four function specs: see `Impl.lean`.
-/
module

public import Refimpl.google_golang_org.grpc.health.Laws
public import Refimpl.google_golang_org.grpc.health.Init
public import Refimpl.google_golang_org.grpc.health.Server__SetServingStatus
public import Refimpl.google_golang_org.grpc.health.grpc_health_v1.HealthCheckResponse_ServingStatus__String

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  health.Server.SetServingStatus.model_proof
  grpc_health_v1.HealthCheckResponse_ServingStatus.String.model_proof
  health.grpcHealthSrv_persistent.model_proof
  health.opaqueInitsOk.model_proof
  health.initFuncsOk.model_proof
  grpc_health_v1.opaqueInitsOk.model_proof
  grpc_health_v1.initFuncsOk.model_proof

#bound_check google_golang_org.grpc.health.Refimpl
#bound_check google_golang_org.grpc.health.grpc_health_v1.Refimpl

end Model
end EtcdGrove
end Perennial
