/-
grpc `codes`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/google_golang_org/grpc/codes/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`, and its `init()`s are Go (empty: it sets no `internal.CanonicalString` hook).
-/
module

public import Refimpl.Gen.google_golang_org.grpc.codes
public import Proof.google_golang_org.grpc.codes.Init
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
variable [ref : google_golang_org.grpc.codes.Refimpl]

theorem codes.opaqueInitsOk.model_proof :
    model% (type_of% (google_golang_org.grpc.codes.opaqueInitsOk (GF := GF) (hG := hG))) with
      [google_golang_org.grpc.codes.strToCode.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem codes.initFuncsOk.model_proof :
    model% (type_of% (google_golang_org.grpc.codes.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  subst hf
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
