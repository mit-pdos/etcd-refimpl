/-
`github_com/dustin/go_humanize`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/github_com/dustin/go_humanize/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.github_com.dustin.go_humanize.Init
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

theorem github_com_dustin_go_humanize.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.github_com.dustin.go_humanize.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.github_com.dustin.go_humanize.bigIECExp.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigKiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigMiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigGiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigTiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigPiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigEiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigZiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigYiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigRiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigQiByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.bigSIExp.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigSIByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigKByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigMByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigGByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigTByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigPByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigEByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigZByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigYByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigRByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.BigQByte.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.bigBytesSizeTable.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.ten.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.bytesSizeTable.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.renderFloatPrecisionMultipliers.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.renderFloatPrecisionRounders.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.siPrefixTable.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.minSIExponent.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.siParseAliases.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.revSIPrefixTable.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.errInvalid.init := @initNoop,
        _root_.Perennial.github_com.dustin.go_humanize.defaultMagnitudes.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
