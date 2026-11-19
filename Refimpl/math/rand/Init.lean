/-
`math/rand`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/math/rand/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.math.rand.Init
public import Refimpl.Subst
public import Refimpl.Common

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
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]
variable [sem : go.Semantics]

theorem math_rand.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.math.rand.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.math.rand.ke.init := @initNoop,
        _root_.Perennial.math.rand.we.init := @initNoop,
        _root_.Perennial.math.rand.fe.init := @initNoop,
        _root_.Perennial.math.rand.kn.init := @initNoop,
        _root_.Perennial.math.rand.wn.init := @initNoop,
        _root_.Perennial.math.rand.fn.init := @initNoop,
        _root_.Perennial.math.rand.randautoseed.init := @initNoop,
        _root_.Perennial.math.rand.randseednop.init := @initNoop,
        _root_.Perennial.math.rand.rngCooked.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
