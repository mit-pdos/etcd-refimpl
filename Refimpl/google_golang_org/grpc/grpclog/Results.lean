/-
`google_golang_org/grpc/grpclog`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.google_golang_org.grpc.grpclog.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  google_golang_org_grpc_grpclog.opaqueInitsOk.model_proof
  google_golang_org_grpc_grpclog.initFuncsOk.model_proof

#bound_check _root_.Perennial.google_golang_org.grpc.grpclog.Refimpl

end Model
end EtcdGrove
end Perennial
