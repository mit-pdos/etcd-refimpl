/-
prometheus's axioms proved in the model (`#model_check`), and the binding class checked against etcd-grove's translated bodies
(`#bound_check`).
-/
module

public import Refimpl.github_com.prometheus.client_golang.prometheus.CounterVec__WithLabelValues
public import Refimpl.github_com.prometheus.client_golang.prometheus.ExponentialBuckets
public import Refimpl.github_com.prometheus.client_golang.prometheus.GaugeVec__With
public import Refimpl.github_com.prometheus.client_golang.prometheus.GaugeVec__WithLabelValues
public import Refimpl.github_com.prometheus.client_golang.prometheus.HistogramVec__WithLabelValues
public import Refimpl.github_com.prometheus.client_golang.prometheus.MustRegister
public import Refimpl.github_com.prometheus.client_golang.prometheus.NewCounter
public import Refimpl.github_com.prometheus.client_golang.prometheus.NewGauge
public import Refimpl.github_com.prometheus.client_golang.prometheus.NewHistogram
public import Refimpl.github_com.prometheus.client_golang.prometheus.Register
public import Refimpl.github_com.prometheus.client_golang.prometheus.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  prometheus.CounterVec.WithLabelValues.model_proof
  prometheus.ExponentialBuckets.model_proof
  prometheus.GaugeVec.With.model_proof
  prometheus.GaugeVec.WithLabelValues.model_proof
  prometheus.HistogramVec.WithLabelValues.model_proof
  prometheus.MustRegister.model_proof
  prometheus.NewCounter.model_proof
  prometheus.NewGauge.model_proof
  prometheus.NewHistogram.model_proof
  prometheus.Register.model_proof
  prometheus.opaqueInitsOk.model_proof
  prometheus.initFuncsOk.model_proof

#bound_check github_com.prometheus.client_golang.prometheus.Refimpl

end Model
end EtcdGrove
end Perennial
