/-
clockwork's package-initialization axiom (`opaqueInitsOk`, etcd-grove's
`Proof/github_com/jonboulle/clockwork/Init.lean`), read in the model: each untranslated
package-variable initializer is the model's `initNoop`.
-/
module

public import Refimpl.github_com.jonboulle.clockwork.Impl
public import Proof.github_com.jonboulle.clockwork.Init

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

theorem clockwork.opaqueInitsOk.model_proof :
    model% (type_of% (github_com.jonboulle.clockwork.opaqueInitsOk (GF := GF) (hG := hG))) with
      [github_com.jonboulle.clockwork.keyClock.init := @initNoop,
        github_com.jonboulle.clockwork.ErrFakeClockDeadlineExceeded.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
