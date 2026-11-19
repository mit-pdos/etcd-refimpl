/-
otel `attribute`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_opentelemetry_io/otel/attribute/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.go_opentelemetry_io.otel.attribute.Init
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

theorem attribute.opaqueInitsOk.model_proof :
    model% (type_of% (go_opentelemetry_io.otel.«attribute».opaqueInitsOk (GF := GF) (hG := hG))) with
      [go_opentelemetry_io.otel.«attribute».«_».init := @initNoop,
        go_opentelemetry_io.otel.«attribute».defaultEncoderID.init := @initNoop,
        go_opentelemetry_io.otel.«attribute».keyValueType.init := @initNoop,
        go_opentelemetry_io.otel.«attribute».emptyHash.init := @initNoop,
        go_opentelemetry_io.otel.«attribute».userDefinedEmptySet.init := @initNoop,
        go_opentelemetry_io.otel.«attribute».emptySet.init := @initNoop,
        go_opentelemetry_io.otel.«attribute»._Type_index.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
