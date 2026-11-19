/-
`path/filepath`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/path/filepath/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.path.filepath.Init
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

theorem path_filepath.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.path.filepath.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.path.filepath.SkipDir.init := @initNoop,
        _root_.Perennial.path.filepath.SkipAll.init := @initNoop,
        _root_.Perennial.path.filepath.lstat.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
