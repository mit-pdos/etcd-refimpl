/-
Every axiom of klog's trust boundary, proved in the model (`#model_check`), and the binding class
checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.k8s_io.klog.v2.Background
public import Refimpl.k8s_io.klog.v2.V
public import Refimpl.k8s_io.klog.v2.Errorf
public import Refimpl.k8s_io.klog.v2.Warningf
public import Refimpl.k8s_io.klog.v2.Verbose__Infof
public import Refimpl.k8s_io.klog.v2.Verbose__InfoS
public import Refimpl.k8s_io.klog.v2.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  klog.Background.model_proof
  klog.V.model_proof
  klog.Errorf.model_proof
  klog.Warningf.model_proof
  klog.Verbose.Infof.model_proof
  klog.Verbose.InfoS.model_proof
  klog.opaqueInitsOk.model_proof
  klog.initFuncsOk.model_proof

#bound_check k8s_io.klog.v2.Refimpl

end Model
end EtcdGrove
end Perennial
