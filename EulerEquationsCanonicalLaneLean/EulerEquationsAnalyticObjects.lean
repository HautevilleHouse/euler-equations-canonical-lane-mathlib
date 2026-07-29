import canonicalLaneMathlib.AdmissibleClass

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
  materialDerivative : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveEulerOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField,
  gradient := fun _ => zeroVectorField,
  materialDerivative := fun u => u,
  pressureProjection := fun u => u,
  pressureProjectionIdempotent := by intro u; rfl
}

structure EulerFlow where
  velocity : VectorField
  pressure : ScalarField
  density : ℝ
  operators : EulerOperators

def primitiveEulerFlow : EulerFlow := {
  velocity := zeroVectorField,
  pressure := zeroScalarField,
  density := 1,
  operators := primitiveEulerOperators
}

def Incompressible (F : EulerFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def AdvectiveDerivative (F : EulerFlow) : Prop :=
  F.operators.materialDerivative F.velocity = zeroVectorField

def PressureProjected (F : EulerFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def EulerEquationClosed (F : EulerFlow) : Prop :=
  Incompressible F ∧ AdvectiveDerivative F ∧ PressureProjected F

theorem primitive_euler_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveEulerOperators.pressureProjection (primitiveEulerOperators.pressureProjection u) =
      primitiveEulerOperators.pressureProjection u := by
  rfl

theorem primitive_euler_flow_incompressible_checked :
    Incompressible primitiveEulerFlow := by
  rfl

theorem primitive_euler_flow_advective_derivative_checked :
    AdvectiveDerivative primitiveEulerFlow := by
  rfl

theorem primitive_euler_flow_pressure_projected_checked :
    PressureProjected primitiveEulerFlow := by
  rfl

theorem primitive_euler_flow_equation_closed_checked :
    EulerEquationClosed primitiveEulerFlow := by
  exact And.intro primitive_euler_flow_incompressible_checked
    (And.intro primitive_euler_flow_advective_derivative_checked primitive_euler_flow_pressure_projected_checked)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse