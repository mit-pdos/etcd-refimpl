/-
k8s.io/utils/clock's package-initialization axiom (`opaqueInitsOk`, etcd-grove's
`Proof.k8s_io.utils.clock.Init.lean`), read in the model: each untranslated
package-variable initializer is the model's `initNoop`.
-/
module

public import Refimpl.k8s_io.utils.clock.Impl
public import Proof.k8s_io.utils.clock.Init

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

theorem clock.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.utils.clock.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.utils.clock.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
