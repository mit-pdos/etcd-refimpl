/-
`k8s_io/apimachinery/pkg/apis/meta/v1/unstructured`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.apimachinery.pkg.apis.«meta».v1.unstructured.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_apimachinery_pkg_apis_meta_v1_unstructured.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
