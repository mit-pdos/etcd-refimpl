module

public import Refimpl.google_golang_org.grpc.health.Impl
public import Spec.google_golang_org.grpc.health.Server__SetServingStatus

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : google_golang_org.grpc.health.Refimpl]
variable [package_sem : google_golang_org.grpc.health.Assumptions]

theorem health.Server.SetServingStatus.model_proof :
    model% (EtcdGrove.health.Server.SetServingStatus.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.grpcHealthSrv := @grpcHealthSrv] := by
  intro hs service status
  wp_start
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
