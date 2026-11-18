module

public import Refimpl.google_golang_org.grpc.metadata.Impl
public import Spec.google_golang_org.grpc.metadata.FromOutgoingContext

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
variable [ctx_sem : context.Assumptions]
variable [ref : google_golang_org.grpc.metadata.Refimpl]
variable [package_sem : google_golang_org.grpc.metadata.Assumptions]

theorem metadata.FromOutgoingContext.model_proof :
    model% (EtcdGrove.metadata.FromOutgoingContext.spec (GF := GF) (hG := hG)) with [] := by
  intro ctx cd
  wp_start as -
  wp_auto
  iapply HΦ
  ileft
  ipureintro
  rfl

end proof

end Model
end EtcdGrove
end Perennial
