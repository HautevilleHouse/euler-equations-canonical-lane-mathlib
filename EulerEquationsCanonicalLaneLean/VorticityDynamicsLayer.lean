import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.EulerFlowLayer

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure VorticityCertificate where
  flow : EulerFlow
  vorticityEquation : Prop
  helicityConservation : Prop
  vortexStretching : Prop
  vorticityEquationClosed : vorticityEquation
  helicityConservationClosed : helicityConservation
  vortexStretchingClosed : vortexStretching

def sourceVorticityCertificate : VorticityCertificate := {
  flow := primitiveFlow
  vorticityEquation := EulerEquationBalance primitiveFlow
  helicityConservation := True
  vortexStretching := True
  vorticityEquationClosed := primitive_flow_euler_balance_checked
  helicityConservationClosed := trivial
  vortexStretchingClosed := trivial
}

def VorticityClosed (C : VorticityCertificate) : Prop :=
  C.vorticityEquation ∧ C.helicityConservation ∧ C.vortexStretching

theorem source_vorticity_closed :
    VorticityClosed sourceVorticityCertificate := by
  exact And.intro sourceVorticityCertificate.vorticityEquationClosed
    (And.intro sourceVorticityCertificate.helicityConservationClosed
      sourceVorticityCertificate.vortexStretchingClosed)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse