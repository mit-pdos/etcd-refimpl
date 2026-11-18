/-
Every axiom of `k8s.io/utils/clock`'s trust boundary, proved of the real code (`#model_check`),
and the binding class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.utils.clock.RealClock__Now
public import Refimpl.k8s_io.utils.clock.RealClock__NewTicker
public import Refimpl.k8s_io.utils.clock.RealClock__NewTimer
public import Refimpl.k8s_io.utils.clock.realTicker__C
public import Refimpl.k8s_io.utils.clock.realTicker__Stop
public import Refimpl.k8s_io.utils.clock.realTimer__C
public import Refimpl.k8s_io.utils.clock.realTimer__Stop
public import Refimpl.k8s_io.utils.clock.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  clock.RealClock.Now.model_proof
  clock.RealClock.NewTicker.model_proof
  clock.RealClock.NewTimer.model_proof
  clock.realTicker.C.model_proof
  clock.realTicker.Stop.model_proof
  clock.realTimer.C.model_proof
  clock.realTimer.Stop.model_proof
  clock.opaqueInitsOk.model_proof

#bound_check k8s_io.utils.clock.Refimpl

end Model
end EtcdGrove
end Perennial
