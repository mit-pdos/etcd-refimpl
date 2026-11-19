/-
`google_golang_org/grpc`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/google_golang_org/grpc/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.google_golang_org.grpc.Init
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

theorem google_golang_org_grpc.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.google_golang_org.grpc.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.google_golang_org.grpc.noOpRegisterHealthListenerFn.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.unaryStreamDesc.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.ErrClientConnClosing.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errConnDrain.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errConnClosing.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errConnIdling.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.invalidDefaultServiceConfigErrPrefix.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.PickFirstBalancerName.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errNoTransportSecurity.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errTransportCredsAndBundle.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errNoTransportCredsInBundle.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errTransportCredentialsMissing.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.disconnectionsMetric.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.connectionAttemptsSucceededMetric.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.connectionAttemptsFailedMetric.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.openConnectionsMetric.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.ErrClientConnTimeout.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errContextCanceled.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errContextDeadline.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.statusOK.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.logger.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.defaultServerOptions.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.ErrServerStopped.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errDuplicatedName.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.errEmptyServiceNonEmptyMethod.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.metadataFromOutgoingContextRaw.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.emptyMethodConfig.init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop,
        _root_.Perennial.google_golang_org.grpc.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
