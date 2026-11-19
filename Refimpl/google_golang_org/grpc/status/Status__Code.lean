module

public import Refimpl.google_golang_org.grpc.status.Impl
public import GeneratedProof.google_golang_org.grpc.codes
public import Spec.google_golang_org.grpc.status.Status__Code

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
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]
variable [sem : go.Semantics]
variable [codes_sem : google_golang_org.grpc.codes.Assumptions]
variable [ref : google_golang_org.grpc.internal.status.Refimpl]
variable [package_sem : google_golang_org.grpc.internal.status.Assumptions]

theorem status.Status.Code.model_proof :
    model% (EtcdGrove.status.Status.Code.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.statusCode := @statusCode, EtcdGrove.grpcStatusROP := @grpcStatusROP] := by
  intro s c
  wp_start as %Hro
  obtain ⟨-, rfl⟩ := Hro
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
