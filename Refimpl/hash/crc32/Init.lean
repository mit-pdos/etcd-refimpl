/-
`hash/crc32`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/hash/crc32/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.hash.crc32.Init
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

theorem hash_crc32.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.hash.crc32.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.hash.crc32.IEEETable.init := @initNoop,
        _root_.Perennial.hash.crc32.castagnoliInitOnce.init := @initNoop,
        _root_.Perennial.hash.crc32.ieeeInitOnce.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
