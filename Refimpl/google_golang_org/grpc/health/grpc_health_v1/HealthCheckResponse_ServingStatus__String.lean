module

public import Refimpl.google_golang_org.grpc.health.Impl
public import Spec.google_golang_org.grpc.health.grpc_health_v1.HealthCheckResponse_ServingStatus__String

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
variable [ref : google_golang_org.grpc.health.grpc_health_v1.Refimpl]
variable [package_sem : google_golang_org.grpc.health.grpc_health_v1.Assumptions]

theorem grpc_health_v1.HealthCheckResponse_ServingStatus.String.model_proof :
    model% (EtcdGrove.grpc_health_v1.HealthCheckResponse_ServingStatus.String.spec (GF := GF) (hG := hG)) with [] := by
  intro st
  wp_start
  -- Perennial has `NotInterface` instances for the type constructors, but none for the
  -- predeclared types (`go.int32` is a plain `def`), which a value receiver's method resolution needs
  haveI : go.NotInterface go.int32 := ⟨trivial⟩
  wp_auto
  wp_method_call
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
