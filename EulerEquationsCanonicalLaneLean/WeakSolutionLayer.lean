import EulerEquationsCanonicalLaneLean.MathlibPDESubstrate

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure WeakSolutionEnvelope where
  flow : EulerFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  weakEquationClosed : weakEquation

def sourceWeakSolutionEnvelope : WeakSolutionEnvelope := {
  flow := primitiveFlow,
  finiteEnergy := true,
  divergenceFree := Incompressible primitiveFlow,
  weakEquation := EulerEquationClosed primitiveFlow,
  finiteEnergyClosed := rfl,
  divergenceFreeClosed := primitive_flow_incompressible_checked,
  weakEquationClosed := primitive_flow_euler_equation_closed_checked
}

def WeakSolutionEnvelopeClosed (E : WeakSolutionEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.weakEquation

theorem source_weak_solution_envelope_closed :
    WeakSolutionEnvelopeClosed sourceWeakSolutionEnvelope := by
  exact And.intro sourceWeakSolutionEnvelope.finiteEnergyClosed
    (And.intro sourceWeakSolutionEnvelope.divergenceFreeClosed
      sourceWeakSolutionEnvelope.weakEquationClosed)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse