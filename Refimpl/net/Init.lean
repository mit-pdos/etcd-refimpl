/-
`net`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/net/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.net.Init
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

theorem net.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.net.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.net.rfc6724policyTable.init := @initNoop,
        _root_.Perennial.net.confVal.init := @initNoop,
        _root_.Perennial.net.netdns.init := @initNoop,
        _root_.Perennial.net.multipathtcp.init := @initNoop,
        _root_.Perennial.net.errLameReferral.init := @initNoop,
        _root_.Perennial.net.errCannotUnmarshalDNSMessage.init := @initNoop,
        _root_.Perennial.net.errCannotMarshalDNSMessage.init := @initNoop,
        _root_.Perennial.net.errServerMisbehaving.init := @initNoop,
        _root_.Perennial.net.errInvalidDNSResponse.init := @initNoop,
        _root_.Perennial.net.errNoAnswerFromDNSServer.init := @initNoop,
        _root_.Perennial.net.errServerTemporarilyMisbehaving.init := @initNoop,
        _root_.Perennial.net.netedns0.init := @initNoop,
        _root_.Perennial.net.distantFuture.init := @initNoop,
        _root_.Perennial.net.lookupOrderName.init := @initNoop,
        _root_.Perennial.net.defaultNS.init := @initNoop,
        _root_.Perennial.net.getHostname.init := @initNoop,
        _root_.Perennial.net.testHookLookupIP.init := @initNoop,
        _root_.Perennial.net.testPreHookSetKeepAlive.init := @initNoop,
        _root_.Perennial.net.testHookSetKeepAlive.init := @initNoop,
        _root_.Perennial.net.testHookStepTime.init := @initNoop,
        _root_.Perennial.net.testHookCanceledDial.init := @initNoop,
        _root_.Perennial.net.hostsFilePath.init := @initNoop,
        _root_.Perennial.net.socketFunc.init := @initNoop,
        _root_.Perennial.net.connectFunc.init := @initNoop,
        _root_.Perennial.net.listenFunc.init := @initNoop,
        _root_.Perennial.net.getsockoptIntFunc.init := @initNoop,
        _root_.Perennial.net.errInvalidInterface.init := @initNoop,
        _root_.Perennial.net.errInvalidInterfaceIndex.init := @initNoop,
        _root_.Perennial.net.errInvalidInterfaceName.init := @initNoop,
        _root_.Perennial.net.errNoSuchInterface.init := @initNoop,
        _root_.Perennial.net.errNoSuchMulticastInterface.init := @initNoop,
        _root_.Perennial.net.flagNames.init := @initNoop,
        _root_.Perennial.net.zoneCache.init := @initNoop,
        _root_.Perennial.net.v4InV6Prefix.init := @initNoop,
        _root_.Perennial.net.IPv4bcast.init := @initNoop,
        _root_.Perennial.net.IPv4allsys.init := @initNoop,
        _root_.Perennial.net.IPv4allrouter.init := @initNoop,
        _root_.Perennial.net.IPv4zero.init := @initNoop,
        _root_.Perennial.net.IPv6zero.init := @initNoop,
        _root_.Perennial.net.IPv6unspecified.init := @initNoop,
        _root_.Perennial.net.IPv6loopback.init := @initNoop,
        _root_.Perennial.net.IPv6interfacelocalallnodes.init := @initNoop,
        _root_.Perennial.net.IPv6linklocalallnodes.init := @initNoop,
        _root_.Perennial.net.IPv6linklocalallrouters.init := @initNoop,
        _root_.Perennial.net.classAMask.init := @initNoop,
        _root_.Perennial.net.classBMask.init := @initNoop,
        _root_.Perennial.net.classCMask.init := @initNoop,
        _root_.Perennial.net.protocols.init := @initNoop,
        _root_.Perennial.net.services.init := @initNoop,
        _root_.Perennial.net.DefaultResolver.init := @initNoop,
        _root_.Perennial.net.«_».init := @initNoop,
        _root_.Perennial.net.errMalformedDNSRecordsDetail.init := @initNoop,
        _root_.Perennial.net.readProtocolsOnce.init := @initNoop,
        _root_.Perennial.net.errNoSuitableAddress.init := @initNoop,
        _root_.Perennial.net.errMissingAddress.init := @initNoop,
        _root_.Perennial.net.errCanceled.init := @initNoop,
        _root_.Perennial.net.ErrWriteToConnected.init := @initNoop,
        _root_.Perennial.net.aLongTimeAgo.init := @initNoop,
        _root_.Perennial.net.noDeadline.init := @initNoop,
        _root_.Perennial.net.noCancel.init := @initNoop,
        _root_.Perennial.net.«_».init := @initNoop,
        _root_.Perennial.net.errTimeout.init := @initNoop,
        _root_.Perennial.net.errNoSuchHost.init := @initNoop,
        _root_.Perennial.net.errUnknownPort.init := @initNoop,
        _root_.Perennial.net.errClosed.init := @initNoop,
        _root_.Perennial.net.ErrClosed.init := @initNoop,
        _root_.Perennial.net.«_».init := @initNoop,
        _root_.Perennial.net.«_».init := @initNoop,
        _root_.Perennial.net.pollSplice.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_C2func_getaddrinfo.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_C2func_getnameinfo.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc_free.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc_freeaddrinfo.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc_gai_strerror.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc_getaddrinfo.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc_getnameinfo.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc_res_search.init := @initNoop,
        _root_.Perennial.net._cgo_77133bf98b3a_Cfunc__Cmalloc.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
