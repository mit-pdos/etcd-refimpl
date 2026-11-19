module

public import Refimpl.k8s_io.apimachinery.pkg.api.errors.View
public import Spec.k8s_io.apimachinery.pkg.api.errors.HasStatusCause

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

theorem apierrors.HasStatusCause.model_proof :
    model% (EtcdGrove.apierrors.HasStatusCause.spec (GF := GF) (hG := hG)) with [] := by
  intro err name
  wp_start as #Hok
  ihave Hv := apiErrOk_view $$ Hok
  icases Hv with (⟨%l, %st, %cs, %He, #Hl, #Hd, #Hw⟩ | ⟨%ii, ⟨%He, %Hty⟩, #Hw⟩)
  · ihave #Hans := apiErrAt_answer
      (fun w => match w with | .status _ cs => apierrors.causeIn cs name | .plain => false) err _ $$ Hw
    subst He
    wp_auto
    ihave Hl' := Hl
    iStructNamed Hl'
    iStructNamed ErrStatus
    wp_auto
    wp_if_destruct
    · iunfold apierrors.statusDetailsAt at Hd
      icases Hd with (⟨-, %Hcs⟩ | ⟨%d, Hdp, -⟩)
      · subst Hcs
        iapply HΦ
        imodintro
        iintro %w Hw'
        ihave %h := Hans $$ Hw'
        ipureintro
        refine Eq.trans ?_ h
        rfl
      · ihave %Hnn := typedPointsto_not_null $$ Hdp
        exact absurd Hif Hnn
    · iunfold apierrors.statusDetailsAt at Hd
      icases Hd with (⟨%Hnull, -⟩ | ⟨%d, #Hdp, #Hcs⟩)
      · exact absurd Hnull Hif
      ihave Hdp' := Hdp
      iStructNamed Hdp'
      ihave %Hcslen := ownSlice_len $$ Hcs
      wp_auto
      ihave IH : iprop(∃ (n : w64) (cv : k8s_io.apimachinery.pkg.apis.«meta».v1.StatusCause),
          "i" ∷ i_ptr ↦ n ∗
          "cause" ∷ cause_ptr ↦ cv ∗
          "%Hn" ∷ ⌜0 ≤ sint.Z n ∧ sint.Z n ≤ (cs.length : Int) ∧
            name ∉ (cs.take (sint.Z n).toNat).map (·.Type')⌝) $$ [i cause]
      · iexists _, _
        iframe
        ipureintro
        exact ⟨by word, by word, by simp⟩
      wp_for IH
      wp_if_destruct
      · have Hlt : (sint.Z n).toNat < cs.length := by word
        obtain ⟨x, Hx⟩ : ∃ x, cs[(sint.Z n).toNat]? = some x :=
          ⟨_, List.getElem?_eq_getElem Hlt⟩
        simp only [show 0 ≤ sint.Z n ∧ sint.Z n < sint.Z d.Causes'.len from ⟨Hn.1, Hif⟩]
        wp_apply wp_load_slice_index d.Causes' (sint.Z n) cs DFrac.discard x Hn.1 $$ [Hcs] as -
        · isplitr
          · iexact Hcs
          · ipureintro; exact Hx
        wp_if_destruct
        · wp_for_post
          iapply HΦ
          imodintro
          iintro %w Hw'
          ihave %h := Hans $$ Hw'
          ipureintro
          refine Eq.trans ?_ h
          simp only [apierrors.causeIn]
          symm
          apply decide_eq_true
          exact List.mem_map.mpr ⟨x, List.mem_of_getElem? Hx, rfl⟩
        · wp_for_post
          iframe
          iexists _, _
          iframe
          ipureintro
          refine ⟨by word, by word, ?_⟩
          have Hsucc : (sint.Z (n + W64 1)).toNat = (sint.Z n).toNat + 1 := by word
          rw [Hsucc, List.take_add_one, Hx]
          simp only [Option.toList_some, List.map_append, List.mem_append, List.map_cons,
            List.map_nil, List.mem_singleton, not_or]
          exact ⟨Hn.2.2, fun h => Hif h.symm⟩
      · iapply HΦ
        imodintro
        iintro %w Hw'
        ihave %h := Hans $$ Hw'
        ipureintro
        refine Eq.trans ?_ h
        have Hall : cs.take (sint.Z n).toNat = cs := List.take_of_length_le (by word)
        rw [Hall] at Hn
        simp only [apierrors.causeIn]
        exact (decide_eq_false Hn.2.2).symm
  · ihave #Hans := apiErrAt_answer
      (fun w => match w with | .status _ cs => apierrors.causeIn cs name | .plain => false) err _ $$ Hw
    subst He
    wp_auto
    simp only [Hty, decide_false]
    wp_auto
    iapply HΦ
    imodintro
    iintro %w Hw'
    ihave %h := Hans $$ Hw'
    ipureintro
    exact Eq.trans rfl h

end proof

end Model
end EtcdGrove
end Perennial
