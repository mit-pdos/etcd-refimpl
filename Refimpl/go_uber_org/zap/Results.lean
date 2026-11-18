/-
zap's model (`Refimpl/go_uber_org/zap/`): every axiom of zap's trust boundary in etcd-grove's
`etc/tcb-baseline.txt` (the 23 function specs `zap.*.wp_proof`, `zapcore.CheckedEntry.Write.wp_proof`,
and the package initializers' `opaqueInitsOk` and `zapcore.initFuncsOk`) is a theorem of the model,
resting on none of etcd-grove's axioms (`#model_check`).
-/
module

public import Refimpl.go_uber_org.zap.Bool
public import Refimpl.go_uber_org.zap.ByteString
public import Refimpl.go_uber_org.zap.Duration
public import Refimpl.go_uber_org.zap.Error
public import Refimpl.go_uber_org.zap.Impl
public import Refimpl.go_uber_org.zap.Init
public import Refimpl.go_uber_org.zap.Int
public import Refimpl.go_uber_org.zap.Int32
public import Refimpl.go_uber_org.zap.Int64
public import Refimpl.go_uber_org.zap.Logger__Check
public import Refimpl.go_uber_org.zap.Logger__Debug
public import Refimpl.go_uber_org.zap.Logger__Error
public import Refimpl.go_uber_org.zap.Logger__Fatal
public import Refimpl.go_uber_org.zap.Logger__Info
public import Refimpl.go_uber_org.zap.Logger__Panic
public import Refimpl.go_uber_org.zap.Logger__Warn
public import Refimpl.go_uber_org.zap.NewNop
public import Refimpl.go_uber_org.zap.Stack
public import Refimpl.go_uber_org.zap.String
public import Refimpl.go_uber_org.zap.Stringer
public import Refimpl.go_uber_org.zap.Strings
public import Refimpl.go_uber_org.zap.Uint
public import Refimpl.go_uber_org.zap.Uint32
public import Refimpl.go_uber_org.zap.Uint64
public import Refimpl.go_uber_org.zap.zapcore.CheckedEntry__Write
public import Refimpl.go_uber_org.zap.zapcore.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  zap.Bool.model_proof
  zap.ByteString.model_proof
  zap.Duration.model_proof
  zap.Error.model_proof
  zap.Int'.model_proof
  zap.Int32.model_proof
  zap.Int64.model_proof
  zap.Logger.Check.model_proof
  zap.Logger.Debug.model_proof
  zap.Logger.Error.model_proof
  zap.Logger.Fatal.model_proof
  zap.Logger.Info.model_proof
  zap.Logger.Panic.model_proof
  zap.Logger.Warn.model_proof
  zap.NewNop.model_proof
  zap.Stack.model_proof
  zap.String.model_proof
  zap.Stringer.model_proof
  zap.Strings.model_proof
  zap.Uint.model_proof
  zap.Uint32.model_proof
  zap.Uint64.model_proof
  zap.opaqueInitsOk.model_proof
  zapcore.CheckedEntry.Write.model_proof
  zapcore.initFuncsOk.model_proof
  zapcore.opaqueInitsOk.model_proof

#bound_check go_uber_org.zap.Refimpl
#bound_check go_uber_org.zap.zapcore.Refimpl

end Model
end EtcdGrove
end Perennial
