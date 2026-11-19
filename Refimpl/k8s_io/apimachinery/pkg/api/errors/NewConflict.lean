module

public import Refimpl.k8s_io.apimachinery.pkg.api.errors.Impl
public import Spec.k8s_io.apimachinery.pkg.api.errors.NewConflict

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

theorem apierrors.NewConflict.model_proof :
    model% (EtcdGrove.apierrors.NewConflict.spec (GF := GF) (hG := hG)) with [] := by
  intro gr name err
  wp_start as -
  iapply wp_fupd
  wp_auto
  ipersist «$v3»
  imodintro
  iapply HΦ
  iexists _
  iframe
  isplitr
  · unfold apierrors.statusDetailsAt; iright; iexists _; iframe «$v3»
    iapply (ownSlice_nil (V := k8s_io.apimachinery.pkg.apis.«meta».v1.StatusCause) DFrac.discard)
  ipureintro
  exact ⟨rfl, rfl, rfl⟩

end proof

end Model
end EtcdGrove
end Perennial
