/-
`github_com/Masterminds/semver/v3`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/github_com/Masterminds/semver/v3/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.github_com.Masterminds.semver.v3.Init
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

theorem github_com_Masterminds_semver_v3.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.github_com.Masterminds.semver.v3.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.github_com.Masterminds.semver.v3.ErrConstraintTooLong.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrTooManyConstraintGroups.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.CoerceNewVersion.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.DetailedNewVersionErrors.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrInvalidSemVer.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrEmptyString.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrInvalidCharacters.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrSegmentStartsZero.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrInvalidMetadata.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrInvalidPrerelease.init := @initNoop,
        _root_.Perennial.github_com.Masterminds.semver.v3.ErrVersionTooLong.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
