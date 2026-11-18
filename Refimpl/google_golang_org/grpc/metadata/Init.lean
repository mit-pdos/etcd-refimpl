/-
grpc `metadata`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/google_golang_org/grpc/metadata/Init.lean`), read in the model: the untranslated
package-variable initializer is `initNoop`, and its `init()` is Go (empty).
-/
module

public import Refimpl.google_golang_org.grpc.metadata.Impl

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
variable [ref : google_golang_org.grpc.metadata.Refimpl]

theorem metadata.opaqueInitsOk.model_proof :
    model% (type_of% (google_golang_org.grpc.metadata.opaqueInitsOk (GF := GF) (hG := hG))) with
      [google_golang_org.grpc.metadata.loggableMetadataKeys.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem metadata.initFuncsOk.model_proof :
    model% (type_of% (google_golang_org.grpc.metadata.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  obtain rfl : f = google_golang_org.grpc.metadata.init.«0» := by simpa using hf
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
