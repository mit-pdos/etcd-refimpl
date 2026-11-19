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
  simp only [EtcdGrove.labels.selEmpty]
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
    rw [@decide_eq_false (EtcdGrove.labels.selMatch none L) (Classical.propDecidable _)
      (by simp [EtcdGrove.labels.selMatch])]
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
    have Hmatch : EtcdGrove.labels.selMatch (some S) L := by
      have Hml' : S.ml = ∅ := GMap.map_size_empty_inv _ Hml
      simp [EtcdGrove.labels.selMatch, Hml', Hreqs]
    wp_method_call; wp_call
    wp_auto
    wp_for
    rw [@decide_eq_true _ (Classical.propDecidable _) Hmatch]
    iapply HΦ₁; itrivial

theorem labels.LabelSelectorAsSelector.model_proof :
    model% (EtcdGrove.labels.LabelSelectorAsSelector.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.labels.reqsValid := @Model.labels.reqsValid] := by
  intro ls S
  cases S with
  | none =>
    unfold EtcdGrove.labels.lsOwn
    wp_start as %Hls
    subst Hls
    wp_auto
    wp_func_call; wp_call
    wp_auto
    iapply HΦ
    iright
    isplitr; · ipureintro; exact ⟨rfl, trivial⟩
    iapply labels.selOk_nothing
  | some S =>
    unfold EtcdGrove.labels.lsOwn
    wp_start as ⟨%ml, %ex, %rs, #Hls, #Hml, #Hex, %Hlen, -⟩
    ihave %Hnn := typedPointsto_not_null $$ Hls
    ihave %Hexlen := ownSlice_len $$ Hex
    wp_auto
    rw [decide_eq_false Hnn]
    wp_auto
    ihave Hls' := Hls
    iStructNamed Hls'
    icases Hml with (⟨%Hmn, %Hsz⟩ | #Hm)
    · subst Hmn
      wp_load
      rw [show (null : Loc) = map.nil from rfl]
      wp_auto
      wp_if_destruct
      · have Hreqs : S.reqs = [] := by
          apply List.eq_nil_of_length_eq_zero; rw [← Hlen, Hexlen.1, Hif]; rfl
        wp_func_call; wp_call
        wp_auto
        iapply HΦ
        iright
        isplitr; · ipureintro; exact ⟨rfl, Hsz, Hreqs⟩
        iapply labels.selOk_everything S Hsz Hreqs
      · iapply HΦ
        ileft
        ipureintro
        refine ⟨by simp [interface.mkOk], ?_⟩
        rintro ⟨-, Hreqs⟩
        apply Hif
        have : sint.nat ex.len = 0 := by rw [← Hexlen.1, Hlen, Hreqs]; rfl
        word
    · wp_load
      wp_auto
      wp_apply wp_map_len_lt $$ [$Hm] as ⟨-, %Hlt⟩
      wp_if_destruct
      · have Hsz : GMap.size S.ml = 0 := by word
        wp_if_destruct
        · have Hreqs : S.reqs = [] := by
            apply List.eq_nil_of_length_eq_zero; rw [← Hlen, Hexlen.1, Hif]; rfl
          wp_func_call; wp_call
          wp_auto
          iapply HΦ
          iright
          isplitr; · ipureintro; exact ⟨rfl, Hsz, Hreqs⟩
          iapply labels.selOk_everything S Hsz Hreqs
        · iapply HΦ
          ileft
          ipureintro
          refine ⟨by simp [interface.mkOk], ?_⟩
          rintro ⟨-, Hreqs⟩
          apply Hif
          have : sint.nat ex.len = 0 := by rw [← Hexlen.1, Hlen, Hreqs]; rfl
          word
      · iapply HΦ
        ileft
        ipureintro
        refine ⟨by simp [interface.mkOk], ?_⟩
        rintro ⟨Hsz, -⟩
        apply Hif
        rw [Hsz]; rfl

end proof

end Model
end EtcdGrove
end Perennial
