/-
grpc `health`'s and `health/grpc_health_v1`'s package-initialization axioms (`opaqueInitsOk`,
`initFuncsOk`, etcd-grove's `Proof/google_golang_org/grpc/health/Init.lean` and
`.../health/grpc_health_v1/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`, and the `init()`s are Go (empty).
-/
module

public import Refimpl.google_golang_org.grpc.health.Impl

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

theorem health.opaqueInitsOk.model_proof :
    model% (type_of% (google_golang_org.grpc.health.opaqueInitsOk (GF := GF) (hG := hG))) with
      [google_golang_org.grpc.health.backoffStrategy.init := @initNoop,
        google_golang_org.grpc.health.backoffFunc.init := @initNoop,
        google_golang_org.grpc.health.logger.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem health.initFuncsOk.model_proof [ref : google_golang_org.grpc.health.Refimpl] :
    model% (type_of% (google_golang_org.grpc.health.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl | rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

theorem grpc_health_v1.opaqueInitsOk.model_proof :
    model% (type_of% (google_golang_org.grpc.health.grpc_health_v1.opaqueInitsOk (GF := GF) (hG := hG))) with
      [google_golang_org.grpc.health.grpc_health_v1.HealthCheckResponse_ServingStatus_name.init := @initNoop,
        google_golang_org.grpc.health.grpc_health_v1.HealthCheckResponse_ServingStatus_value.init := @initNoop,
        google_golang_org.grpc.health.grpc_health_v1.file_grpc_health_v1_health_proto_enumTypes.init := @initNoop,
        google_golang_org.grpc.health.grpc_health_v1.file_grpc_health_v1_health_proto_msgTypes.init := @initNoop,
        google_golang_org.grpc.health.grpc_health_v1.file_grpc_health_v1_health_proto_goTypes.init := @initNoop,
        google_golang_org.grpc.health.grpc_health_v1.file_grpc_health_v1_health_proto_depIdxs.init := @initNoop,
        google_golang_org.grpc.health.grpc_health_v1.Health_ServiceDesc.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem grpc_health_v1.initFuncsOk.model_proof
    [ref : google_golang_org.grpc.health.grpc_health_v1.Refimpl] :
    model% (type_of% (google_golang_org.grpc.health.grpc_health_v1.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  obtain rfl : f = google_golang_org.grpc.health.grpc_health_v1.init.«0» := by simpa using hf
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
