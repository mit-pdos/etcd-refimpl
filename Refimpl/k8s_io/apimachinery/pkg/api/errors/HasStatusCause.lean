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
    all_goals sorry
  · ihave #Hans := apiErrAt_answer
      (fun w => match w with | .status _ cs => apierrors.causeIn cs name | .plain => false) err _ $$ Hw
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
