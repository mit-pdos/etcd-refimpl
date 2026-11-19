/-
`net/http`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/net/http/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.net.http
public import Proof.net.http.Init
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
variable [ref : _root_.Perennial.net.http.Refimpl]

theorem net_http.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.net.http.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.net.http.DefaultClient.init := @initNoop,
        _root_.Perennial.net.http.ErrSchemeMismatch.init := @initNoop,
        _root_.Perennial.net.http.ErrUseLastResponse.init := @initNoop,
        _root_.Perennial.net.http.httpcookiemaxnum.init := @initNoop,
        _root_.Perennial.net.http.errBlankCookie.init := @initNoop,
        _root_.Perennial.net.http.errEqualNotFoundInCookie.init := @initNoop,
        _root_.Perennial.net.http.errInvalidCookieName.init := @initNoop,
        _root_.Perennial.net.http.errInvalidCookieValue.init := @initNoop,
        _root_.Perennial.net.http.errCookieNumLimitExceeded.init := @initNoop,
        _root_.Perennial.net.http.cookieNameSanitizer.init := @initNoop,
        _root_.Perennial.net.http.sentinelHandler.init := @initNoop,
        _root_.Perennial.net.http.errCrossOriginRequest.init := @initNoop,
        _root_.Perennial.net.http.errCrossOriginRequestFromOldBrowser.init := @initNoop,
        _root_.Perennial.net.http.errInvalidUnsafePath.init := @initNoop,
        _root_.Perennial.net.http.httpservecontentkeepheaders.init := @initNoop,
        _root_.Perennial.net.http.errSeeker.init := @initNoop,
        _root_.Perennial.net.http.errNoOverlap.init := @initNoop,
        _root_.Perennial.net.http.unixEpochTime.init := @initNoop,
        _root_.Perennial.net.http.errMissingSeek.init := @initNoop,
        _root_.Perennial.net.http.errMissingReadDir.init := @initNoop,
        _root_.Perennial.net.http.httpservecontentmaxranges.init := @initNoop,
        _root_.Perennial.net.http.timeFormats.init := @initNoop,
        _root_.Perennial.net.http.headerNewlineToSpace.init := @initNoop,
        _root_.Perennial.net.http.headerSorterPool.init := @initNoop,
        _root_.Perennial.net.http.aLongTimeAgo.init := @initNoop,
        _root_.Perennial.net.http.NoBody.init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.maxSlice.init := @initNoop,
        _root_.Perennial.net.http.ErrMissingFile.init := @initNoop,
        _root_.Perennial.net.http.ErrNotSupported.init := @initNoop,
        _root_.Perennial.net.http.ErrUnexpectedTrailer.init := @initNoop,
        _root_.Perennial.net.http.ErrMissingBoundary.init := @initNoop,
        _root_.Perennial.net.http.ErrNotMultipart.init := @initNoop,
        _root_.Perennial.net.http.ErrHeaderTooLong.init := @initNoop,
        _root_.Perennial.net.http.ErrShortBody.init := @initNoop,
        _root_.Perennial.net.http.ErrMissingContentLength.init := @initNoop,
        _root_.Perennial.net.http.reqWriteExcludeHeader.init := @initNoop,
        _root_.Perennial.net.http.ErrNoCookie.init := @initNoop,
        _root_.Perennial.net.http.multipartByReader.init := @initNoop,
        _root_.Perennial.net.http.errMissingHost.init := @initNoop,
        _root_.Perennial.net.http.respExcludeHeader.init := @initNoop,
        _root_.Perennial.net.http.ErrNoLocation.init := @initNoop,
        _root_.Perennial.net.http.httpmuxgo121.init := @initNoop,
        _root_.Perennial.net.http.ErrBodyNotAllowed.init := @initNoop,
        _root_.Perennial.net.http.ErrHijacked.init := @initNoop,
        _root_.Perennial.net.http.ErrContentLength.init := @initNoop,
        _root_.Perennial.net.http.ErrWriteAfterFlush.init := @initNoop,
        _root_.Perennial.net.http.ServerContextKey.init := @initNoop,
        _root_.Perennial.net.http.LocalAddrContextKey.init := @initNoop,
        _root_.Perennial.net.http.crlf.init := @initNoop,
        _root_.Perennial.net.http.colonSpace.init := @initNoop,
        _root_.Perennial.net.http.copyBufPool.init := @initNoop,
        _root_.Perennial.net.http.errTooLarge.init := @initNoop,
        _root_.Perennial.net.http.extraHeaderKeys.init := @initNoop,
        _root_.Perennial.net.http.headerContentLength.init := @initNoop,
        _root_.Perennial.net.http.headerDate.init := @initNoop,
        _root_.Perennial.net.http.rstAvoidanceDelay.init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.ErrAbortHandler.init := @initNoop,
        _root_.Perennial.net.http.htmlReplacer.init := @initNoop,
        _root_.Perennial.net.http.DefaultServeMux.init := @initNoop,
        _root_.Perennial.net.http.stateName.init := @initNoop,
        _root_.Perennial.net.http.ErrServerClosed.init := @initNoop,
        _root_.Perennial.net.http.http2server.init := @initNoop,
        _root_.Perennial.net.http.ErrHandlerTimeout.init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.uniqNameNext.init := @initNoop,
        _root_.Perennial.net.http.socksnoDeadline.init := @initNoop,
        _root_.Perennial.net.http.socksaLongTimeAgo.init := @initNoop,
        _root_.Perennial.net.http.ErrLineTooLong.init := @initNoop,
        _root_.Perennial.net.http.suppressedHeaders304.init := @initNoop,
        _root_.Perennial.net.http.suppressedHeadersNoBody.init := @initNoop,
        _root_.Perennial.net.http.excludedHeadersNoBody.init := @initNoop,
        _root_.Perennial.net.http.ErrBodyReadAfterClose.init := @initNoop,
        _root_.Perennial.net.http.singleCRLF.init := @initNoop,
        _root_.Perennial.net.http.doubleCRLF.init := @initNoop,
        _root_.Perennial.net.http.errTrailerEOF.init := @initNoop,
        _root_.Perennial.net.http.httplaxcontentlength.init := @initNoop,
        _root_.Perennial.net.http.nopCloserType.init := @initNoop,
        _root_.Perennial.net.http.nopCloserWriterToType.init := @initNoop,
        _root_.Perennial.net.http.http2client.init := @initNoop,
        _root_.Perennial.net.http.errCannotRewind.init := @initNoop,
        _root_.Perennial.net.http.ErrSkipAltProtocol.init := @initNoop,
        _root_.Perennial.net.http.DefaultTransport.init := @initNoop,
        _root_.Perennial.net.http.errKeepAlivesDisabled.init := @initNoop,
        _root_.Perennial.net.http.errConnBroken.init := @initNoop,
        _root_.Perennial.net.http.errCloseIdle.init := @initNoop,
        _root_.Perennial.net.http.errTooManyIdle.init := @initNoop,
        _root_.Perennial.net.http.errTooManyIdleHost.init := @initNoop,
        _root_.Perennial.net.http.errCloseIdleConns.init := @initNoop,
        _root_.Perennial.net.http.errReadLoopExiting.init := @initNoop,
        _root_.Perennial.net.http.errIdleConnTimeout.init := @initNoop,
        _root_.Perennial.net.http.errServerClosedIdle.init := @initNoop,
        _root_.Perennial.net.http.testHookProxyConnectTimeout.init := @initNoop,
        _root_.Perennial.net.http.«_».init := @initNoop,
        _root_.Perennial.net.http.errCallerOwnsConn.init := @initNoop,
        _root_.Perennial.net.http.errClosedEarly.init := @initNoop,
        _root_.Perennial.net.http.maxWriteWaitBeforeConnReuse.init := @initNoop,
        _root_.Perennial.net.http.errTimeout.init := @initNoop,
        _root_.Perennial.net.http.errRequestCanceled.init := @initNoop,
        _root_.Perennial.net.http.errRequestCanceledConn.init := @initNoop,
        _root_.Perennial.net.http.errRequestDone.init := @initNoop,
        _root_.Perennial.net.http.testHookEnterRoundTrip.init := @initNoop,
        _root_.Perennial.net.http.testHookWaitResLoop.init := @initNoop,
        _root_.Perennial.net.http.testHookRoundTripRetried.init := @initNoop,
        _root_.Perennial.net.http.testHookPrePendingDial.init := @initNoop,
        _root_.Perennial.net.http.testHookPostPendingDial.init := @initNoop,
        _root_.Perennial.net.http.testHookMu.init := @initNoop,
        _root_.Perennial.net.http.testHookReadLoopBeforeNextRead.init := @initNoop,
        _root_.Perennial.net.http.errReadOnClosedResBody.init := @initNoop,
        _root_.Perennial.net.http.errConcurrentReadOnResBody.init := @initNoop,
        _root_.Perennial.net.http.gzipPool.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem net_http.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.net.http.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl | rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
