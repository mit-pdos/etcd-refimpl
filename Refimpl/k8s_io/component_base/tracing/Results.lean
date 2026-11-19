/-
Every axiom of component-base `tracing`'s trust boundary, proved in the model (`#model_check`), and
the binding class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.component_base.tracing.Start
public import Refimpl.k8s_io.component_base.tracing.SpanFromContext
public import Refimpl.k8s_io.component_base.tracing.Span__AddEvent
public import Refimpl.k8s_io.component_base.tracing.Span__End

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  tracing.Start.model_proof
  tracing.SpanFromContext.model_proof
  tracing.Span.AddEvent.model_proof
  tracing.Span.End.model_proof

#bound_check k8s_io.component_base.tracing.Refimpl

end Model
end EtcdGrove
end Perennial
