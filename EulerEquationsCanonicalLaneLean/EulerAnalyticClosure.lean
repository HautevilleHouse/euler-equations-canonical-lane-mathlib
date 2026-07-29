import EulerEquationsCanonicalLaneLean.EulerAnalyticCertificate

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

def EulerAdmittedAnalyticClosure : Prop :=
  EulerAnalyticCertificateClosed sourceEulerAnalyticCertificate ∧
  ConstrainedEulerClosure analyticAdmissibleClass

def UnrestrictedClassicalEulerBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.unrestrictedEulerStackCarried = true

theorem euler_admitted_analytic_closure_checked :
    EulerAdmittedAnalyticClosure := by
  exact And.intro source_euler_analytic_certificate_closed
    (constrained_euler_endgame analyticAdmissibleClass)

theorem unrestricted_classical_euler_boundary_carried_checked :
    UnrestrictedClassicalEulerBoundaryCarried := by
  exact And.intro rfl rfl

end EulerEquationsCanonicalLaneLean
end HautevilleHouse