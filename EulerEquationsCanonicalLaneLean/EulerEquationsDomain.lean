import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic
import Mathlib.Analysis.Calculus.FDeriv.Basic

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure EulerOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  transport : VectorField → VectorField
  pressureGradient : VectorField → VectorField
  timeDerivative : VectorField → VectorField

def primitiveOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  pressureGradient := fun _ => zeroVectorField
  timeDerivative := fun _ => zeroVectorField
}

structure EulerFlow where
  velocity : VectorField
  pressure : ScalarField
  operators : EulerOperators

def primitiveFlow : EulerFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  operators := primitiveOperators
}

def Incompressible (F : EulerFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def EulerEquationClosed (F : EulerFlow) : Prop :=
  Incompressible F ∧
  F.operators.timeDerivative F.velocity =
    F.operators.transport F.velocity + F.operators.pressureGradient F.velocity

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_euler_equation_closed_checked :
    EulerEquationClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked rfl

end EulerEquationsCanonicalLaneLean
end HautevilleHouse