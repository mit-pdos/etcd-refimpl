/-
`go_etcd_io/etcd/server/v3/lease/leasehttp`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/lease/leasehttp/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.go_etcd_io.etcd.server.v3.lease.leasehttp.Init
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

theorem go_etcd_io_etcd_server_v3_lease_leasehttp.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.lease.leasehttp.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.lease.leasehttp.applyTimeout.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.lease.leasehttp.ErrLeaseHTTPTimeout.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
