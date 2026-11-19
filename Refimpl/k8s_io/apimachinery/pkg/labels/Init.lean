/-
apimachinery `labels`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/apimachinery/pkg/labels/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.k8s_io.apimachinery.pkg.labels.Init
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

theorem labels.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.apimachinery.pkg.labels.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.apimachinery.pkg.labels.unaryOperators.init := @initNoop,
        k8s_io.apimachinery.pkg.labels.binaryOperators.init := @initNoop,
        k8s_io.apimachinery.pkg.labels.validRequirementOperators.init := @initNoop,
        k8s_io.apimachinery.pkg.labels.sharedEverythingSelector.init := @initNoop,
        k8s_io.apimachinery.pkg.labels.sharedNothingSelector.init := @initNoop,
        k8s_io.apimachinery.pkg.labels.string2token.init := @initNoop,
        k8s_io.apimachinery.pkg.labels.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
