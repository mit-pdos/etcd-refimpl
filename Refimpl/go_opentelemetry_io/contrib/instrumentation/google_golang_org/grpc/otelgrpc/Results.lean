/-
`otelgrpc`'s initialization axiom proved in the model (`#model_check`).
-/
module

public import Refimpl.go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  otelgrpc.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
