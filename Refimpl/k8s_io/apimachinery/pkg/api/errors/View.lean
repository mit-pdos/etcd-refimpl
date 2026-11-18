/-
What the models of `IsTimeout` and `HasStatusCause` share: an error has one view (`apiErrAt`), so the
answer computed from the view the precondition holds is the answer of every view.
-/
module

public import Refimpl.k8s_io.apimachinery.pkg.api.errors.Impl

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI Iris.ProofMode apierrors

section lemmas
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [package_sem : k8s_io.apimachinery.pkg.api.errors.Assumptions]

/-- `*StatusError` is an `APIStatus`. -/
theorem statusError_apiStatus : go.typeSetContains
    (go.GoType.PointerType k8s_io.apimachinery.pkg.api.errors.StatusError.ty)
    k8s_io.apimachinery.pkg.api.errors.APIStatus.ty = true := by
  go_type_set

/-- Two read-only details of one status hold the same causes. -/
theorem statusDetailsAt_agree (st : k8s_io.apimachinery.pkg.apis.«meta».v1.Status)
    (cs1 cs2 : List k8s_io.apimachinery.pkg.apis.«meta».v1.StatusCause) :
    statusDetailsAt (GF := GF) st cs1 ⊢ statusDetailsAt st cs2 -∗ ⌜cs1 = cs2⌝ := by
  unfold statusDetailsAt
  iintro H1 H2
  icases H1 with (⟨%Hn1, %Hc1⟩ | ⟨%d1, Hd1, Hs1⟩) <;>
    icases H2 with (⟨%Hn2, %Hc2⟩ | ⟨%d2, Hd2, Hs2⟩)
  · ipureintro; rw [Hc1, Hc2]
  · ihave %Hnn := typedPointsto_not_null $$ Hd2
    exact absurd Hn1 Hnn
  · ihave %Hnn := typedPointsto_not_null $$ Hd1
    exact absurd Hn2 Hnn
  · ihave %Hd := typedPointsto_agree_wand $$ Hd1 Hd2
    subst Hd
    iapply ownSlice_agree $$ Hs1 Hs2

/-- **An error has one view.** -/
theorem apiErrAt_agree (err : GoInterface) (w1 w2 : ApiErrView) :
    apiErrAt (GF := GF) err w1 ⊢ apiErrAt err w2 -∗ ⌜w1 = w2⌝ := by
  have hps := statusError_apiStatus (sem := sem) (package_sem := package_sem)
  cases w1 <;> cases w2 <;> unfold apiErrAt
  · rename_i st1 cs1 st2 cs2
    iintro ⟨%l1, %He1, Hl1, Hd1⟩ ⟨%l2, %He2, Hl2, Hd2⟩
    rw [He1] at He2
    simp only [interface.mkOk, GoInterface.ok.injEq, GoInterfaceOk.mk.injEq, true_and] at He2
    have Hl : l1 = l2 := by simpa using He2
    subst Hl
    ihave %Hst := typedPointsto_agree_wand $$ Hl1 Hl2
    simp only [k8s_io.apimachinery.pkg.api.errors.StatusError.mk.injEq] at Hst
    subst Hst
    ihave %Hcs := statusDetailsAt_agree $$ Hd1 Hd2
    ipureintro; rw [Hcs]
  · iintro ⟨%l, %He, -, -⟩ %Hp
    obtain ⟨ii, Hii, Hts, -⟩ := Hp
    rw [He] at Hii
    simp only [interface.mkOk, GoInterface.ok.injEq] at Hii
    subst Hii
    simp only [hps] at Hts
    exact absurd Hts (by decide)
  · iintro %Hp ⟨%l, %He, -, -⟩
    obtain ⟨ii, Hii, Hts, -⟩ := Hp
    rw [He] at Hii
    simp only [interface.mkOk, GoInterface.ok.injEq] at Hii
    subst Hii
    simp only [hps] at Hts
    exact absurd Hts (by decide)
  · iintro _ _; ipureintro; rfl

/-- **The answer of the view held is the answer of every view.** -/
theorem apiErrAt_answer {A : Type} (f : ApiErrView → A) (err : GoInterface) (w : ApiErrView) :
    apiErrAt (GF := GF) err w ⊢ □ ∀ w', apiErrAt err w' -∗ ⌜f w = f w'⌝ := by
  iintro #Hw
  imodintro
  iintro %w' Hw'
  ihave %Heq := apiErrAt_agree $$ Hw Hw'
  ipureintro; rw [Heq]

/-- The precondition, as a view: a `*StatusError` with its status and causes, or a plain error. -/
theorem apiErrOk_view (err : GoInterface) :
    apiErrOk (GF := GF) err ⊢
      (∃ (l : Loc) (st : k8s_io.apimachinery.pkg.apis.«meta».v1.Status) cs,
        ⌜err = interface.mkOk
          (go.GoType.PointerType k8s_io.apimachinery.pkg.api.errors.StatusError.ty) #l⌝ ∗
        l ↦□ k8s_io.apimachinery.pkg.api.errors.StatusError.mk st ∗ statusDetailsAt st cs ∗
        apiErrAt err (.status st cs)) ∨
      (∃ ii : GoInterfaceOk, ⌜err = GoInterface.ok ii ∧
        ii.ty ≠ go.GoType.PointerType k8s_io.apimachinery.pkg.api.errors.StatusError.ty⌝ ∗
        apiErrAt err .plain) := by
  have hps := statusError_apiStatus (sem := sem) (package_sem := package_sem)
  unfold apiErrOk
  iintro (⟨%l, %st, %He, #Hl, %cs, #Hd⟩ | #Hp)
  · ileft
    iexists l, st, cs
    isplitr; · ipureintro; exact He
    iframe Hl Hd
    unfold apiErrAt
    iexists l
    iframe Hl Hd
    ipureintro; exact He
  · iright
    unfold apiErrAt
    icases Hp with %Hp
    obtain ⟨ii, Hii, Hts, Hleaf⟩ := Hp
    iexists ii
    isplitl
    · ipureintro
      refine ⟨Hii, ?_⟩
      intro Hty
      rw [Hty, hps] at Hts
      exact absurd Hts (by decide)
    · ipureintro; exact ⟨ii, Hii, Hts, Hleaf⟩

end lemmas

end Model
end EtcdGrove
end Perennial
