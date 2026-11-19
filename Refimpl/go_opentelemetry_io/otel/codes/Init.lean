/-
otel `codes`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_opentelemetry_io/otel/codes/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.go_opentelemetry_io.otel.codes.Init
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

theorem otelcodes.opaqueInitsOk.model_proof :
    model% (type_of% (go_opentelemetry_io.otel.codes.opaqueInitsOk (GF := GF) (hG := hG))) with
      [go_opentelemetry_io.otel.codes.codeToStr.init := @initNoop,
        go_opentelemetry_io.otel.codes.strToCode.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
