/-
`github.com/xiang90/probing`'s axioms proved in the model (`#model_check`; `NewHandler` relative to
net/http's `WriteHeader` spec: `Impl.lean`), and the binding class checked against etcd-grove's own
translated bodies (`#bound_check`).
-/
module

public import Refimpl.github_com.xiang90.probing.NewHandler
public import Refimpl.github_com.xiang90.probing.NewProber

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  probing.NewHandler.model_proof
  probing.NewProber.model_proof

#bound_check github_com.xiang90.probing.Refimpl

end Model
end EtcdGrove
end Perennial
