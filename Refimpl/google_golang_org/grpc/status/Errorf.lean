module

public import Refimpl.google_golang_org.grpc.status.Impl
public import GeneratedProof.google_golang_org.grpc.codes
public import Spec.google_golang_org.grpc.status.Errorf

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
variable [ref : google_golang_org.grpc.status.Refimpl]
variable [package_sem : google_golang_org.grpc.status.Assumptions]

theorem status.Errorf.model_proof :
    model% (EtcdGrove.status.Errorf.spec (GF := GF) (hG := hG)) with [] := by
  intro c format args
  wp_start as -
  wp_auto
  iapply HΦ
  ipureintro
  -- a nil `*Error` in an interface is not the nil interface
  simp

end proof

end Model
end EtcdGrove
end Perennial
