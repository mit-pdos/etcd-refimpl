/-
`google_golang_org/grpc`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.google_golang_org.grpc.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  google_golang_org_grpc.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
