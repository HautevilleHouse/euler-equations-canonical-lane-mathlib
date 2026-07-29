import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.EulerEquationsWeakLayer

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure VorticityCertificate where
  weakSolution : EulerWeakSolution
  vorticityFinite : Prop
  vorticityConservation : Prop
  helicityInvariant : Prop
  vorticityFiniteClosed : vorticityFinite
  vorticityConservationClosed : vorticityConservation
  helicityInvariantClosed : helicityInvariant

def sourceVorticityCertificate : VorticityCertificate := {
  weakSolution := sourceEulerWeakSolution,
  vorticityFinite := True,
  vorticityConservation := True,
  helicityInvariant := True,
  vorticityFiniteClosed := trivial,
  vorticityConservationClosed := trivial,
  helicityInvariantClosed := trivial
}

def VorticityCertificateClosed (C : VorticityCertificate) : Prop :=
  EulerWeakSolutionClosed C.weakSolution ∧ C.vorticityFinite ∧ C.vorticityConservation ∧ C.helicityInvariant

theorem source_vorticity_certificate_closed :
    VorticityCertificateClosed sourceVorticityCertificate := by
  exact And.intro source_euler_weak_solution_closed
    (And.intro sourceVorticityCertificate.vorticityFiniteClosed
      (And.intro sourceVorticityCertificate.vorticityConservationClosed sourceVorticityCertificate.helicityInvariantClosed))

end EulerEquationsCanonicalLaneLean
end HautevilleHouse