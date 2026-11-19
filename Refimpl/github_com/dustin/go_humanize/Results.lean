/-
`github_com/dustin/go_humanize`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.github_com.dustin.go_humanize.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  github_com_dustin_go_humanize.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
