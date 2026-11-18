module

public import Refimpl.github_com.xiang90.probing.Impl
public import Proof.net.http.Boundary

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
variable [http_sem : _root_.Perennial.net.http.Assumptions]

include ref package_sem http_sem in
/-- Relative to net/http's `ResponseWriter.WriteHeader` (`Impl.lean`). -/
theorem probing.NewHandler.model_proof
    (hWriteHeader : ∀ H : http.HttpNet GF, http.respWriteHeader_spec H) :
    model% (EtcdGrove.probing.NewHandler.spec (GF := GF) (hG := hG)) with [] := by
  wp_start as -
  wp_auto
  iapply HΦ
  isplitr
  · ipure_intro; exact http.handlerRegOk_ptr _ _
  imodintro
  iintro %H %a %Rs %pats %pat #Hresp %Hhdr
  unfold http.handlerFor
  iexists _
  isplitr; · ipure_intro; rfl
  imodintro
  iintro %wi %r %R %γk %rd - %Hroute - - - Hw Hhd %Hfl HRs
  obtain ⟨Hhost, Hmux⟩ := Hroute
  wp_auto
  wp_apply hWriteHeader H _ wi a R γk (W64 200) rfl $$ [$Hw Hhd] as Hw
  · isplitr
    · imodintro; iapply Hresp; ipure_intro
      exact ⟨Hhost, http.route_of_muxRoute Hmux⟩
    isplitr
    · ipure_intro; decide
    simp only [http.hdrsReady]
    iexists _; iframe; ipure_intro
    exact ⟨Hhdr R (http.route_of_muxRoute Hmux), http.respHdrsOk_nil⟩
  wp_auto
  iframe HRs; unfold http.handlerDone; ileft; iexists _, _; iexact Hw

end proof

end Model
end EtcdGrove
end Perennial
