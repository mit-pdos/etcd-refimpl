/-
`go_etcd_io/etcd/server/v3/etcdserver/api/snap`'s package-initialization axioms (`initFuncsOk`; its `opaqueInitsOk` is gone, every such variable translated in etcd-grove since `1ed1c7f480`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/api/snap/Init.lean`), read in the model: its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.server.v3.etcdserver.api.snap
public import Proof.go_etcd_io.etcd.server.v3.etcdserver.api.snap.Init
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
variable [ref : _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.snap.Refimpl]

theorem go_etcd_io_etcd_server_v3_etcdserver_api_snap.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.snap.initFuncsOk (GF := GF) (hG := hG))) with [] := by
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
