/-
`go.opentelemetry.io/otel/trace`'s `SpanFromContext` proved in the model (`#model_check`), and the
binding class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.go_opentelemetry_io.otel.trace.SpanFromContext
public import Refimpl.go_opentelemetry_io.otel.trace.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  trace.SpanFromContext.model_proof
  trace.opaqueInitsOk.model_proof

#bound_check go_opentelemetry_io.otel.trace.Refimpl

end Model
end EtcdGrove
end Perennial
