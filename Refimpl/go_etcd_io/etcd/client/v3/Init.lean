/-
`go_etcd_io/etcd/client/v3`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/client/v3/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.client.v3
public import Proof.go_etcd_io.etcd.client.v3.Init
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
variable [ref : _root_.Perennial.go_etcd_io.etcd.client.v3.Refimpl]

theorem go_etcd_io_etcd_client_v3.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.client.v3.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.client.v3.ErrNoAvailableEndpoints.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.client.v3.ErrOldCluster.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.client.v3.ErrMutuallyExclusiveCfg.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.client.v3.defaultWaitForReady.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.client.v3.defaultMaxCallSendMsgSize.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.client.v3.defaultMaxCallRecvMsgSize.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem go_etcd_io_etcd_client_v3.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.client.v3.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
