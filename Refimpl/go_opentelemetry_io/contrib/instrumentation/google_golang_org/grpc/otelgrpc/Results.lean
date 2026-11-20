/-
`otelgrpc`'s axioms proved in the model (`#model_check`; `NewServerHandler` with `grpcStatsHandlerOk`
modelled as the nil handler: `Impl.lean`), and the binding class checked against etcd-grove's own
translated bodies (`#bound_check`).
-/
module

public import Refimpl.go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.Init
public import Refimpl.go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.NewServerHandler

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  otelgrpc.NewServerHandler.model_proof
  otelgrpc.opaqueInitsOk.model_proof

#bound_check go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.Refimpl

end Model
end EtcdGrove
end Perennial
