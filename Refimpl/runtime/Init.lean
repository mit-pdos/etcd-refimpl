/-
`runtime`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/runtime/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.runtime.Init
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

theorem runtime.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.runtime.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.runtime.cgo_yield.init := @initNoop,
        _root_.Perennial.runtime.containermaxprocs.init := @initNoop,
        _root_.Perennial.runtime.debugPinnerKeepUnpin.init := @initNoop,
        _root_.Perennial.runtime.boundsErrorFmts.init := @initNoop,
        _root_.Perennial.runtime.boundsNegErrorFmts.init := @initNoop,
        _root_.Perennial.runtime.fastlog2Table.init := @initNoop,
        _root_.Perennial.runtime.inf.init := @initNoop,
        _root_.Perennial.runtime.dumphdr.init := @initNoop,
        _root_.Perennial.runtime.itabTableInit.init := @initNoop,
        _root_.Perennial.runtime.itabTable.init := @initNoop,
        _root_.Perennial.runtime.uint16Eface.init := @initNoop,
        _root_.Perennial.runtime.uint32Eface.init := @initNoop,
        _root_.Perennial.runtime.uint64Eface.init := @initNoop,
        _root_.Perennial.runtime.stringEface.init := @initNoop,
        _root_.Perennial.runtime.sliceEface.init := @initNoop,
        _root_.Perennial.runtime.uint16Type.init := @initNoop,
        _root_.Perennial.runtime.uint32Type.init := @initNoop,
        _root_.Perennial.runtime.uint64Type.init := @initNoop,
        _root_.Perennial.runtime.stringType.init := @initNoop,
        _root_.Perennial.runtime.sliceType.init := @initNoop,
        _root_.Perennial.runtime.emptyTypeAssertCache.init := @initNoop,
        _root_.Perennial.runtime.emptyInterfaceSwitchCache.init := @initNoop,
        _root_.Perennial.runtime.lockNames.init := @initNoop,
        _root_.Perennial.runtime.lockPartialOrder.init := @initNoop,
        _root_.Perennial.runtime.maps_errNilAssign.init := @initNoop,
        _root_.Perennial.runtime.useCheckmark.init := @initNoop,
        _root_.Perennial.runtime.cleanupFnPtrMask.init := @initNoop,
        _root_.Perennial.runtime.adviseUnused.init := @initNoop,
        _root_.Perennial.runtime.metricsSema.init := @initNoop,
        _root_.Perennial.runtime.finalizer1.init := @initNoop,
        _root_.Perennial.runtime.gcMarkWorkerModeStrings.init := @initNoop,
        _root_.Perennial.runtime.oneptrmask.init := @initNoop,
        _root_.Perennial.runtime.mSpanStateNames.init := @initNoop,
        _root_.Perennial.runtime.levelBits.init := @initNoop,
        _root_.Perennial.runtime.levelShift.init := @initNoop,
        _root_.Perennial.runtime.levelLogPages.init := @initNoop,
        _root_.Perennial.runtime.MemProfileRate.init := @initNoop,
        _root_.Perennial.runtime.goroutineProfile.init := @initNoop,
        _root_.Perennial.runtime.minOffAddr.init := @initNoop,
        _root_.Perennial.runtime.maxOffAddr.init := @initNoop,
        _root_.Perennial.runtime.doubleCheckReadMemStats.init := @initNoop,
        _root_.Perennial.runtime.pdEface.init := @initNoop,
        _root_.Perennial.runtime.pdType.init := @initNoop,
        _root_.Perennial.runtime.epfd.init := @initNoop,
        _root_.Perennial.runtime.haveHighResSleep.init := @initNoop,
        _root_.Perennial.runtime.procAuxv.init := @initNoop,
        _root_.Perennial.runtime.sysTHPSizePath.init := @initNoop,
        _root_.Perennial.runtime.urandom_dev.init := @initNoop,
        _root_.Perennial.runtime.sigset_all.init := @initNoop,
        _root_.Perennial.runtime.shiftError.init := @initNoop,
        _root_.Perennial.runtime.divideError.init := @initNoop,
        _root_.Perennial.runtime.overflowError.init := @initNoop,
        _root_.Perennial.runtime.floatError.init := @initNoop,
        _root_.Perennial.runtime.memoryError.init := @initNoop,
        _root_.Perennial.runtime.simdImmError.init := @initNoop,
        _root_.Perennial.runtime.rangeDoneError.init := @initNoop,
        _root_.Perennial.runtime.rangePanicError.init := @initNoop,
        _root_.Perennial.runtime.rangeExhaustedError.init := @initNoop,
        _root_.Perennial.runtime.rangeMissingPanicError.init := @initNoop,
        _root_.Perennial.runtime.panicnil.init := @initNoop,
        _root_.Perennial.runtime.pinnerLeakPanic.init := @initNoop,
        _root_.Perennial.runtime.asyncPreemptStack.init := @initNoop,
        _root_.Perennial.runtime.minhexdigits.init := @initNoop,
        _root_.Perennial.runtime.casgstatusAlwaysTrack.init := @initNoop,
        _root_.Perennial.runtime.stwReasonStrings.init := @initNoop,
        _root_.Perennial.runtime.worldsema.init := @initNoop,
        _root_.Perennial.runtime.gcsema.init := @initNoop,
        _root_.Perennial.runtime.forcegcperiod.init := @initNoop,
        _root_.Perennial.runtime.updatemaxprocs.init := @initNoop,
        _root_.Perennial.runtime.traceback_cache.init := @initNoop,
        _root_.Perennial.runtime.dbgvars.init := @initNoop,
        _root_.Perennial.runtime.waitReasonStrings.init := @initNoop,
        _root_.Perennial.runtime.isWaitingForSuspendG.init := @initNoop,
        _root_.Perennial.runtime.isIdleInSynctest.init := @initNoop,
        _root_.Perennial.runtime.sigsetAllExiting.init := @initNoop,
        _root_.Perennial.runtime.sigtable.init := @initNoop,
        _root_.Perennial.runtime.stackPoisonCopy.init := @initNoop,
        _root_.Perennial.runtime.maxstacksize.init := @initNoop,
        _root_.Perennial.runtime.maxstackceiling.init := @initNoop,
        _root_.Perennial.runtime.ptrnames.init := @initNoop,
        _root_.Perennial.runtime.startingStackSize.init := @initNoop,
        _root_.Perennial.runtime.intArgRegs.init := @initNoop,
        _root_.Perennial.runtime.traceAdvanceSema.init := @initNoop,
        _root_.Perennial.runtime.traceShutdownSema.init := @initNoop,
        _root_.Perennial.runtime.gStatusStrings.init := @initNoop,
        _root_.Perennial.runtime.traceBlockReasonStrings.init := @initNoop,
        _root_.Perennial.runtime.traceGoStopReasonStrings.init := @initNoop,
        _root_.Perennial.runtime.mallocScanTable.init := @initNoop,
        _root_.Perennial.runtime.mallocNoScanTable.init := @initNoop,
        _root_.Perennial.runtime.chansendpc.init := @initNoop,
        _root_.Perennial.runtime.chanrecvpc.init := @initNoop,
        _root_.Perennial.runtime.adjustSignalStack2Indirect.init := @initNoop,
        _root_.Perennial.runtime.vdsoLinuxVersion.init := @initNoop,
        _root_.Perennial.runtime.vdsoSymbolKeys.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
