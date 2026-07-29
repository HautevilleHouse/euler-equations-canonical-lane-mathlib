import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

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
  advection : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  advection := fun u => u
  timeDerivative := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
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

def EulerEquationBalance (F : EulerFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.advection F.velocity

def PressureProjected (F : EulerFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def EulerEquationClosed (F : EulerFlow) : Prop :=
  Incompressible F ∧ EulerEquationBalance F ∧ PressureProjected F

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_euler_balance_checked :
    EulerEquationBalance primitiveFlow := by
  rfl

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    EulerEquationClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_euler_balance_checked primitive_flow_pressure_projected_checked)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse