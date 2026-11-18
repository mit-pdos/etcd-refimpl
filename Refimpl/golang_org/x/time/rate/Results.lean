/-
Every axiom of `golang.org/x/time/rate`'s trust boundary, proved in the model (`#model_check`), and
the binding class checked against etcd-grove's own translated bodies (`#bound_check`).
-/
module

public import Refimpl.golang_org.x.time.rate.Every
public import Refimpl.golang_org.x.time.rate.NewLimiter
public import Refimpl.golang_org.x.time.rate.Limiter__Reserve
public import Refimpl.golang_org.x.time.rate.Limiter__Wait
public import Refimpl.golang_org.x.time.rate.Reservation__Delay

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  rate.Every.model_proof
  rate.NewLimiter.model_proof
  rate.Limiter.Reserve.model_proof
  rate.Limiter.Wait.model_proof
  rate.Reservation.Delay.model_proof

#bound_check golang_org.x.time.rate.Refimpl

end Model
end EtcdGrove
end Perennial
