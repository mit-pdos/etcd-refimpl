/-
otel `attribute`'s initialization axiom proved in the model (`#model_check`).
-/
module

public import Refimpl.go_opentelemetry_io.otel.attribute.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  attribute.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
