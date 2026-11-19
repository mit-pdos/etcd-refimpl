/-
`github_com/go_logr/logr`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.github_com.go_logr.logr.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  github_com_go_logr_logr.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
