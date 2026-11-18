module

public import Refimpl.k8s_io.apimachinery.pkg.labels.Impl
public import Spec.k8s_io.apimachinery.pkg.labels.Everything

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI Iris.ProofMode

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : k8s_io.apimachinery.pkg.labels.Refimpl]
variable [package_sem : k8s_io.apimachinery.pkg.labels.Assumptions]

theorem labels.Everything.model_proof :
    model% (EtcdGrove.labels.Everything.spec (GF := GF) (hG := hG)) with [] := by
  wp_start
  wp_auto
  iapply HΦ
  iexists _
  isplitr; · ipureintro; rfl
  isplitr
  · iintro !> %Φ₁ - HΦ₁
    wp_func_call; wp_call
    wp_auto
    simp only [labels.internalSelector_ne_nothingSelector, decide_false]
    wp_auto
    iapply HΦ₁; itrivial
  · iintro !> %Φ₁ - HΦ₁
    wp_method_call; wp_call
    wp_auto
    iapply HΦ₁; itrivial

end proof

end Model
end EtcdGrove
end Perennial
