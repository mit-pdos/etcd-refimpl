/-
Every axiom of `k8s.io/utils/trace`'s trust boundary, proved in the model (`#model_check`), and the
binding class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.utils.trace.New
public import Refimpl.k8s_io.utils.trace.Trace__LogIfLong

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  trace.New.model_proof
  trace.Trace.LogIfLong.model_proof

#bound_check k8s_io.utils.trace.Refimpl

end Model
end EtcdGrove
end Perennial
