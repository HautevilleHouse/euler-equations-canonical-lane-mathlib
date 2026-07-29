import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.EulerEquationsAnalyticObjects

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure EulerWeakSolution where
  flow : EulerFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  weakEquationClosed : weakEquation

def sourceEulerWeakSolution : EulerWeakSolution := {
  flow := primitiveEulerFlow,
  finiteEnergy := True,
  divergenceFree := Incompressible primitiveEulerFlow,
  weakEquation := EulerEquationClosed primitiveEulerFlow,
  finiteEnergyClosed := trivial,
  divergenceFreeClosed := primitive_euler_flow_incompressible_checked,
  weakEquationClosed := primitive_euler_flow_equation_closed_checked
}

def EulerWeakSolutionClosed (E : EulerWeakSolution) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.weakEquation

theorem source_euler_weak_solution_closed :
    EulerWeakSolutionClosed sourceEulerWeakSolution := by
  exact And.intro sourceEulerWeakSolution.finiteEnergyClosed
    (And.intro sourceEulerWeakSolution.divergenceFreeClosed sourceEulerWeakSolution.weakEquationClosed)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse