module

public import Refimpl.github_com.xiang90.probing.Impl

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
variable [ref : github_com.xiang90.probing.Refimpl]
variable [package_sem : github_com.xiang90.probing.Assumptions]

include ref package_sem in
theorem probing.NewProber.model_proof :
    model% (EtcdGrove.probing.NewProber.spec (GF := GF) (hG := hG)) with [] := by
  intro rt
  wp_start as -
  wp_auto
  iapply HΦ
  unfold EtcdGrove.probing.proberOk
  iexists _
  isplitr; · ipure_intro; rfl
  isplitr
  · wp_start
    wp_auto
    iapply HΦ; itrivial
  · iintro %id
    wp_start
    wp_auto
    iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
