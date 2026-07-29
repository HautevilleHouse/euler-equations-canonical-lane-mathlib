import EulerEquationsCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure EulerAnalyticCertificate where
  substrate : MathlibPDESubstrate
  operatorsClosed : Prop
  weakLayerClosed : Prop
  energyLayerClosed : Prop
  compactnessLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  weakLayerClosedProof : weakLayerClosed
  energyLayerClosedProof : energyLayerClosed
  compactnessLayerClosedProof : compactnessLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceEulerAnalyticCertificate : EulerAnalyticCertificate := {
  substrate := mathlibPDESubstrate,
  operatorsClosed := EulerEquationClosed primitiveFlow,
  weakLayerClosed := WeakSolutionEnvelopeClosed sourceWeakSolutionEnvelope,
  energyLayerClosed := EnergyEnstrophyClosed sourceEnergyEnstrophyCertificate,
  compactnessLayerClosed := CompactnessRigidityClosed sourceCompactnessRigidityCertificate,
  endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate,
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable,
  operatorsClosedProof := primitive_flow_euler_equation_closed_checked,
  weakLayerClosedProof := source_weak_solution_envelope_closed,
  energyLayerClosedProof := source_energy_enstrophy_closed,
  compactnessLayerClosedProof := source_compactness_rigidity_closed,
  endpointLayerClosedProof := source_regularity_endpoint_closed,
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def EulerAnalyticCertificateClosed (C : EulerAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_euler_analytic_certificate_closed :
    EulerAnalyticCertificateClosed sourceEulerAnalyticCertificate := by
  exact And.intro sourceEulerAnalyticCertificate.operatorsClosedProof
    (And.intro sourceEulerAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceEulerAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceEulerAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceEulerAnalyticCertificate.endpointLayerClosedProof
            sourceEulerAnalyticCertificate.canonicalCarriageImportedProof))))

end EulerEquationsCanonicalLaneLean
end HautevilleHouse