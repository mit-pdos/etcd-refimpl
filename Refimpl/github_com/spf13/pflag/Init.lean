/-
`github_com/spf13/pflag`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/github_com/spf13/pflag/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.github_com.spf13.pflag.Init
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

theorem github_com_spf13_pflag.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.github_com.spf13.pflag.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.github_com.spf13.pflag.ErrHelp.init := @initNoop,
        _root_.Perennial.github_com.spf13.pflag.CommandLine.init := @initNoop,
        _root_.Perennial.github_com.spf13.pflag.Usage.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
