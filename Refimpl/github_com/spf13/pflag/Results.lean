/-
`github_com/spf13/pflag`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.github_com.spf13.pflag.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  github_com_spf13_pflag.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
