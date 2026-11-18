/-
Every axiom of clockwork's trust boundary, proved in the model (`#model_check`), and the binding
class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.github_com.jonboulle.clockwork.Laws
public import Refimpl.github_com.jonboulle.clockwork.NewRealClock
public import Refimpl.github_com.jonboulle.clockwork.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  clockwork.NewRealClock.model_proof
  clockwork.clockLb_persistent.model_proof
  clockwork.stampAt_persistent.model_proof
  clockwork.clockLb_init.model_proof
  clockwork.clockLb_le.model_proof
  clockwork.stampAt_elim.model_proof
  clockwork.stampAt_clockLb.model_proof
  clockwork.opaqueInitsOk.model_proof

#bound_check github_com.jonboulle.clockwork.Refimpl

end Model
end EtcdGrove
end Perennial
