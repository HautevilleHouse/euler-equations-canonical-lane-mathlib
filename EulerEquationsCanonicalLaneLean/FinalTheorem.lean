import EulerEquationsCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

def ConstrainedEulerClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_euler_endgame (A : AdmissibleClass) :
    ConstrainedEulerClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse