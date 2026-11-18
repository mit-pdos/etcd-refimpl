/-
`clockwork.NewRealClock`, read in the model: the reference implementation returns a `*realClock`
whose `Now` returns the zero time and whose `After` returns a channel already holding one value.
-/
module

public import Refimpl.github_com.jonboulle.clockwork.Impl
public import Spec.github_com.jonboulle.clockwork.NewRealClock

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
variable [ref : github_com.jonboulle.clockwork.Refimpl]
variable [package_sem : github_com.jonboulle.clockwork.Assumptions]

theorem clockwork.NewRealClock.model_proof :
    model% (EtcdGrove.clockwork.NewRealClock.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  wp_start
  wp_alloc res as Hres
  wp_auto
  wp_alloc rc as Hrc
  wp_auto
  iapply HΦ
  iexists ⟨_, #rc⟩
  isplitr
  · ipureintro; rfl
  isplitr
  · iintro !> !> %Φ _ HΦ
    dsimp only
    wp_method_call
    wp_auto
    iapply HΦ; itrivial
  · iintro !> %d %P %n #HP Hn !> %Φ _ HΦ
    dsimp only
    wp_method_call
    wp_auto
    wp_apply chan.wp_make2 (V := time.Time) (W64 1) as %ch %γ ⟨#Hch, %Hcap, Hown⟩
    · ipureintro; decide
    imod start_bag (V := time.Time)
        (fun _ => clockwork.clockLb (GF := GF) EtcdGrove.clockwork.realClock (n + sint.Z d))
        (ChanState.Buffered []) ch γ trivial $$ Hch Hown with #Hbag
    wp_apply (wp_bag_send γ ch (zero_val time.Time)
        (fun _ => clockwork.clockLb (GF := GF) EtcdGrove.clockwork.realClock (n + sint.Z d))) $$ [Hbag]
    · iframe #; unfold clockwork.clockLb; itrivial
    iapply HΦ
    iexists n
    isplitr
    · ipureintro; exact Int.le_refl n
    unfold clockwork.stampAt
    iframe #

end proof

end Model
end EtcdGrove
end Perennial
