module

public import Refimpl.google_golang_org.grpc.metadata.Impl
public import Spec.google_golang_org.grpc.metadata.FromIncomingContext

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
variable [ref : google_golang_org.grpc.metadata.Refimpl]
variable [package_sem : google_golang_org.grpc.metadata.Assumptions]

theorem metadata.FromIncomingContext.model_proof :
    model% (EtcdGrove.metadata.FromIncomingContext.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.metadata.incomingOf := @metadata.incomingOf] := by
  intro ctx
  wp_start as -
  wp_auto
  iapply HΦ
  ileft
  ipureintro
  exact ⟨rfl, rfl⟩

end proof

end Model
end EtcdGrove
end Perennial
