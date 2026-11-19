/-
`google_golang_org/grpc/credentials`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.google_golang_org.grpc.credentials.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  google_golang_org_grpc_credentials.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
