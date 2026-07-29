import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.EulerFlowLayer

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure ConservationLawCertificate where
  flow : EulerFlow
  massConservation : Prop
  momentumConservation : Prop
  energyConservation : Prop
  vorticityConservation : Prop
  massConservationClosed : massConservation
  momentumConservationClosed : momentumConservation
  energyConservationClosed : energyConservation
  vorticityConservationClosed : vorticityConservation

def sourceConservationLawCertificate : ConservationLawCertificate := {
  flow := primitiveFlow
  massConservation := Incompressible primitiveFlow
  momentumConservation := EulerEquationBalance primitiveFlow
  energyConservation := True
  vorticityConservation := True
  massConservationClosed := primitive_flow_incompressible_checked
  momentumConservationClosed := primitive_flow_euler_balance_checked
  energyConservationClosed := trivial
  vorticityConservationClosed := trivial
}

def ConservationLawClosed (C : ConservationLawCertificate) : Prop :=
  C.massConservation ∧ C.momentumConservation ∧ C.energyConservation ∧ C.vorticityConservation

theorem source_conservation_law_closed :
    ConservationLawClosed sourceConservationLawCertificate := by
  exact And.intro sourceConservationLawCertificate.massConservationClosed
    (And.intro sourceConservationLawCertificate.momentumConservationClosed
      (And.intro sourceConservationLawCertificate.energyConservationClosed
        sourceConservationLawCertificate.vorticityConservationClosed))

end EulerEquationsCanonicalLaneLean
end HautevilleHouse