module

public import Refimpl.k8s_io.apimachinery.pkg.api.errors.View
public import Spec.k8s_io.apimachinery.pkg.api.errors.IsTimeout

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

/-- `IsTimeout`'s answer on a status, as the reference implementation computes it. -/
theorem apierrors.timeoutV_eq (st : k8s_io.apimachinery.pkg.apis.«meta».v1.Status) :
    apierrors.timeoutV st =
      if st.Reason' = go!"Timeout" then true
      else if st.Reason' ∈ apierrors.knownReasons then false
      else decide (st.Code' = W32 504) := by
  unfold apierrors.timeoutV
  by_cases h1 : st.Reason' = go!"Timeout" <;> by_cases h2 : st.Reason' ∈ apierrors.knownReasons <;>
    simp [h1, h2]

theorem apierrors.IsTimeout.model_proof :
    model% (EtcdGrove.apierrors.IsTimeout.spec (GF := GF) (hG := hG)) with [] := by
  intro err
  wp_start as #Hok
  ihave Hv := apiErrOk_view $$ Hok
  icases Hv with (⟨%l, %st, %cs, %He, #Hl, #Hd, #Hw⟩ | ⟨%ii, ⟨%He, %Hty⟩, #Hw⟩)
  · ihave #Hans := apiErrAt_answer
      (fun w => match w with | .status st _ => apierrors.timeoutV st | .plain => false) err _ $$ Hw
    subst He
    wp_auto
    all_goals sorry
  · ihave #Hans := apiErrAt_answer
      (fun w => match w with | .status st _ => apierrors.timeoutV st | .plain => false) err _ $$ Hw
    subst He
    wp_auto
    simp only [Hty, decide_false]
    wp_auto
    iapply HΦ
    iexact Hans

end proof

end Model
end EtcdGrove
end Perennial
