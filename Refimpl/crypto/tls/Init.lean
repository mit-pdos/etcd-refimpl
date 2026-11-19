/-
`crypto/tls`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/crypto/tls/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.crypto.tls.Init
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

theorem crypto_tls.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.crypto.tls.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.crypto.tls.«_».init := @initNoop,
        _root_.Perennial.crypto.tls.alertText.init := @initNoop,
        _root_.Perennial.crypto.tls.signaturePadding.init := @initNoop,
        _root_.Perennial.crypto.tls.rsaSignatureSchemes.init := @initNoop,
        _root_.Perennial.crypto.tls.globalCertCache.init := @initNoop,
        _root_.Perennial.crypto.tls.supportedUpToTLS12.init := @initNoop,
        _root_.Perennial.crypto.tls.supportedOnlyTLS12.init := @initNoop,
        _root_.Perennial.crypto.tls.supportedOnlyTLS13.init := @initNoop,
        _root_.Perennial.crypto.tls.cipherSuites.init := @initNoop,
        _root_.Perennial.crypto.tls.cipherSuitesTLS13.init := @initNoop,
        _root_.Perennial.crypto.tls.cipherSuitesPreferenceOrder.init := @initNoop,
        _root_.Perennial.crypto.tls.cipherSuitesPreferenceOrderNoAES.init := @initNoop,
        _root_.Perennial.crypto.tls.disabledCipherSuites.init := @initNoop,
        _root_.Perennial.crypto.tls.hasGCMAsmAMD64.init := @initNoop,
        _root_.Perennial.crypto.tls.hasGCMAsmARM64.init := @initNoop,
        _root_.Perennial.crypto.tls.hasGCMAsmS390X.init := @initNoop,
        _root_.Perennial.crypto.tls.hasGCMAsmPPC64.init := @initNoop,
        _root_.Perennial.crypto.tls.hasAESGCMHardwareSupport.init := @initNoop,
        _root_.Perennial.crypto.tls.aesgcmCiphers.init := @initNoop,
        _root_.Perennial.crypto.tls.directSigning.init := @initNoop,
        _root_.Perennial.crypto.tls.helloRetryRequestRandom.init := @initNoop,
        _root_.Perennial.crypto.tls.deprecatedSessionTicketKey.init := @initNoop,
        _root_.Perennial.crypto.tls.supportedVersions.init := @initNoop,
        _root_.Perennial.crypto.tls.errNoCertificates.init := @initNoop,
        _root_.Perennial.crypto.tls.tlssha1.init := @initNoop,
        _root_.Perennial.crypto.tls._SignatureScheme_index_8.init := @initNoop,
        _root_.Perennial.crypto.tls._SignatureScheme_index_9.init := @initNoop,
        _root_.Perennial.crypto.tls._CurveID_index_0.init := @initNoop,
        _root_.Perennial.crypto.tls._CurveID_index_3.init := @initNoop,
        _root_.Perennial.crypto.tls._ClientAuthType_index.init := @initNoop,
        _root_.Perennial.crypto.tls.outBufPool.init := @initNoop,
        _root_.Perennial.crypto.tls.errShutdown.init := @initNoop,
        _root_.Perennial.crypto.tls.errEarlyCloseWrite.init := @initNoop,
        _root_.Perennial.crypto.tls.tlsmlkem.init := @initNoop,
        _root_.Perennial.crypto.tls.tlssecpmlkem.init := @initNoop,
        _root_.Perennial.crypto.tls.defaultCipherSuitesTLS13.init := @initNoop,
        _root_.Perennial.crypto.tls.defaultCipherSuitesTLS13NoAES.init := @initNoop,
        _root_.Perennial.crypto.tls.allowedSupportedVersionsFIPS.init := @initNoop,
        _root_.Perennial.crypto.tls.allowedCurvePreferencesFIPS.init := @initNoop,
        _root_.Perennial.crypto.tls.allowedSignatureAlgorithmsFIPS.init := @initNoop,
        _root_.Perennial.crypto.tls.allowedCipherSuitesFIPS.init := @initNoop,
        _root_.Perennial.crypto.tls.allowedCipherSuitesTLS13FIPS.init := @initNoop,
        _root_.Perennial.crypto.tls.errMalformedECHConfigList.init := @initNoop,
        _root_.Perennial.crypto.tls.errMalformedECHExt.init := @initNoop,
        _root_.Perennial.crypto.tls.errInvalidECHExt.init := @initNoop,
        _root_.Perennial.crypto.tls.fips140ems.init := @initNoop,
        _root_.Perennial.crypto.tls.tlsmaxrsasize.init := @initNoop,
        _root_.Perennial.crypto.tls.errClientKeyExchange.init := @initNoop,
        _root_.Perennial.crypto.tls.errServerKeyExchange.init := @initNoop,
        _root_.Perennial.crypto.tls.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
