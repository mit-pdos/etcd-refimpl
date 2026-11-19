/-
`go_etcd_io/etcd/server/v3/storage/mvcc`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/storage/mvcc/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.server.v3.storage.mvcc
public import Proof.go_etcd_io.etcd.server.v3.storage.mvcc.Init
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
variable [ref : _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.Refimpl]

theorem go_etcd_io_etcd_server_v3_storage_mvcc.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.totalEventsCounter.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.dbTotalSize.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.dbTotalSizeInUse.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.dbOpenReadTxN.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.hashSec.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.hashRevSec.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.currentRev.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.compactRev.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem go_etcd_io_etcd_server_v3_storage_mvcc.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.storage.mvcc.initFuncsOk (GF := GF) (hG := hG))) with [] := by
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
