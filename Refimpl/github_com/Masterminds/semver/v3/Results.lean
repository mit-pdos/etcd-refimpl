/-
`github_com/Masterminds/semver/v3`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.github_com.Masterminds.semver.v3.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  github_com_Masterminds_semver_v3.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
