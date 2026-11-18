/-
grpc `health`'s law axiom (`grpcHealthSrv_persistent`, etcd-grove's
`Proof/google_golang_org/grpc/InvGrpcServer.lean`), read in the model.
-/
module

public import Refimpl.google_golang_org.grpc.health.Impl

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section proof
variable [GooseExts] {GF : BundledGFunctors}

theorem health.grpcHealthSrv_persistent.model_proof :
    model% (type_of% (EtcdGrove.grpcHealthSrv_persistent (GF := GF))) with
      [EtcdGrove.grpcHealthSrv := @grpcHealthSrv] := by
  intro hs; unfold grpcHealthSrv; infer_instance

end proof

end Model
end EtcdGrove
end Perennial
