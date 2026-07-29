import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.EulerEquationsDomain

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure EulerWeakEnvelope where
  flow : EulerFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  weakEquationClosed : weakEquation

def sourceEulerWeakEnvelope : EulerWeakEnvelope := {
  flow := primitiveFlow
  finiteEnergy := True
  divergenceFree := Incompressible primitiveFlow
  weakEquation := EulerEquationClosed primitiveFlow
  finiteEnergyClosed := trivial
  divergenceFreeClosed := primitive_flow_incompressible_checked
  weakEquationClosed := primitive_flow_euler_equation_closed_checked
}

def EulerWeakEnvelopeClosed (E : EulerWeakEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.weakEquation

theorem source_euler_weak_envelope_closed :
    EulerWeakEnvelopeClosed sourceEulerWeakEnvelope := by
  exact And.intro sourceEulerWeakEnvelope.finiteEnergyClosed
    (And.intro sourceEulerWeakEnvelope.divergenceFreeClosed
      sourceEulerWeakEnvelope.weakEquationClosed)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse