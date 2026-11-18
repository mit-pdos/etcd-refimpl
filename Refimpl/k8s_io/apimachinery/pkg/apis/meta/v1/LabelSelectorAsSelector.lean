module

public import Refimpl.k8s_io.apimachinery.pkg.apis.«meta».v1.Impl
public import Spec.k8s_io.apimachinery.pkg.apis.«meta».v1.LabelSelectorAsSelector

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
variable [ref : k8s_io.apimachinery.pkg.apis.«meta».v1.Refimpl]
variable [ref_labels : k8s_io.apimachinery.pkg.labels.Refimpl]
variable [package_sem : k8s_io.apimachinery.pkg.apis.«meta».v1.Assumptions]
variable [labels_sem : k8s_io.apimachinery.pkg.labels.Assumptions]
variable [runtime_sem : k8s_io.apimachinery.pkg.runtime.Assumptions]

/-- The selectors' contract (`selOk`) of `labels.Nothing()`, for `nil`. -/
theorem labels.selOk_nothing :
    ⊢ EtcdGrove.labels.selOk (GF := GF) (hG := hG)
      (interface.mkOk k8s_io.apimachinery.pkg.labels.nothingSelector.ty
        #k8s_io.apimachinery.pkg.labels.nothingSelector.mk) none := by
  unfold EtcdGrove.labels.selOk
  iexists _
  isplitr; · ipureintro; rfl
  isplitr
  · iintro !> %Φ₁ - HΦ₁
    wp_method_call; wp_call
    wp_auto
    iapply HΦ₁; itrivial
  · imodintro
    iintro %lm %L
    iintro !> %Φ₁ - HΦ₁
    wp_method_call; wp_call
    wp_auto
    simp only [EtcdGrove.labels.selMatch, decide_false]
    iapply HΦ₁; itrivial

/-- The selectors' contract (`selOk`) of `labels.Everything()`, for an empty selector. -/
theorem labels.selOk_everything (S : EtcdGrove.labels.SelV) (Hml : GMap.size S.ml = 0)
    (Hreqs : S.reqs = []) :
    ⊢ EtcdGrove.labels.selOk (GF := GF) (hG := hG)
      (interface.mkOk k8s_io.apimachinery.pkg.labels.internalSelector.ty #slice.nil) (some S) := by
  have Hempty : EtcdGrove.labels.selEmpty (some S) = true := by
    simp [EtcdGrove.labels.selEmpty, Hml, Hreqs]
  unfold EtcdGrove.labels.selOk
  iexists _
  isplitr; · ipureintro; rfl
  isplitr
  · iintro !> %Φ₁ - HΦ₁
    wp_method_call; wp_call
    wp_auto
    rw [Hempty]
    iapply HΦ₁; itrivial
  · imodintro
    iintro %lm %L
    iintro !> %Φ₁ - HΦ₁
    have Hmatch : decide (EtcdGrove.labels.selMatch (some S) L) = true := by
      have Hml' : S.ml = ∅ := GMap.size_eq_zero.mp Hml
      simp [EtcdGrove.labels.selMatch, Hml', Hreqs]
    wp_method_call; wp_call
    wp_auto
    rw [Hmatch]
    iapply HΦ₁; itrivial

theorem labels.LabelSelectorAsSelector.model_proof :
    model% (EtcdGrove.labels.LabelSelectorAsSelector.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.labels.reqsValid := @Model.labels.reqsValid] := by
  intro ls S
  cases S with
  | none =>
    wp_start as %Hls
    subst Hls
    wp_auto
    iapply HΦ
    iright
    isplitr; · ipureintro; exact ⟨rfl, trivial⟩
    iapply labels.selOk_nothing
  | some S =>
    wp_start as ⟨%ml, %ex, %rs, #Hls, #Hml, #Hex, %Hlen, -⟩
    ihave %Hnn := typedPointsto_not_null $$ Hls
    ihave %Hexlen := ownSlice_len $$ Hex
    wp_auto
    sorry

end proof

end Model
end EtcdGrove
end Perennial
