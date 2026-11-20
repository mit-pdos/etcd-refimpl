module

public import Refimpl.go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.Impl

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
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.Refimpl]
variable [stats_sem : google_golang_org.grpc.stats.Assumptions]

include ref stats_sem in
theorem otelgrpc.NewServerHandler.model_proof :
    model% (EtcdGrove.otelgrpc.NewServerHandler.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.grpcStatsHandlerOk := @Model.grpcStatsHandlerOk] := by
  intro sl os
  wp_start as -
  wp_auto
  iapply HΦ
  ipureintro; rfl

end proof

end Model
end EtcdGrove
end Perennial
