module

public import Refimpl.k8s_io.apimachinery.pkg.api.errors.Impl
public import Spec.k8s_io.apimachinery.pkg.api.errors.NewInternalError

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
variable [ref : k8s_io.apimachinery.pkg.api.errors.Refimpl]
variable [package_sem : k8s_io.apimachinery.pkg.api.errors.Assumptions]

theorem apierrors.NewInternalError.model_proof :
    model% (EtcdGrove.apierrors.NewInternalError.spec (GF := GF) (hG := hG)) with [] := by
  intro err
  wp_start as -
  wp_auto
  wp_apply wp_slice_literal
  isplitr
  · ipureintro; rfl
  iintro %sl ⟨Hsl, -⟩
  wp_auto
  iapply wp_fupd
  imod ownSlice_persist $$ Hsl with Hsl
  ipersist «$v3»
  imodintro
  iapply HΦ
  iexists _, _
  iframe
  isplitr
  · unfold apierrors.statusDetailsAt; iright; iexists _; iframe «$v3»
    iexact Hsl
  ipureintro
  exact ⟨rfl, rfl, rfl, rfl⟩

end proof

end Model
end EtcdGrove
end Perennial
