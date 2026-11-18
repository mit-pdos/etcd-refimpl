/-
clockwork's predicate axioms (`Proof/github_com/jonboulle/clockwork/Defs.lean`), read in the model.
-/
module

public import Refimpl.github_com.jonboulle.clockwork.Impl

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

theorem clockwork.clockLb_persistent.model_proof :
    model% (type_of% (EtcdGrove.clockwork.clockLb_persistent (GF := GF))) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  intro γc n; unfold clockwork.clockLb; infer_instance

theorem clockwork.stampAt_persistent.model_proof :
    model% (type_of% (EtcdGrove.clockwork.stampAt_persistent (GF := GF))) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  intro γc P T; unfold clockwork.stampAt; infer_instance

theorem clockwork.clockLb_init.model_proof :
    model% (type_of% (EtcdGrove.clockwork.clockLb_init (GF := GF))) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  intro γc; unfold clockwork.clockLb
  iintro; iexists (0 : Int); itrivial

theorem clockwork.clockLb_le.model_proof :
    model% (type_of% (EtcdGrove.clockwork.clockLb_le (GF := GF))) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  intro γc n m _; unfold clockwork.clockLb; iintro _; itrivial

theorem clockwork.stampAt_elim.model_proof :
    model% (type_of% (EtcdGrove.clockwork.stampAt_elim (GF := GF))) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  intro γc P _ T; unfold clockwork.stampAt; iintro #H; iexact H

theorem clockwork.stampAt_clockLb.model_proof :
    model% (type_of% (EtcdGrove.clockwork.stampAt_clockLb (GF := GF))) with
      [EtcdGrove.clockwork.clockLb := @clockwork.clockLb,
        EtcdGrove.clockwork.stampAt := @clockwork.stampAt] := by
  intro γc P T; unfold clockwork.stampAt clockwork.clockLb; iintro _; itrivial

end proof

end Model
end EtcdGrove
end Perennial
