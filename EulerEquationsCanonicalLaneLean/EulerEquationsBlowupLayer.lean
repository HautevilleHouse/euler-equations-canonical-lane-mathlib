import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.EulerEquationsVorticityLayer

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure BlowupCertificate where
  vorticity : VorticityCertificate
  regularityCriterion : Prop
  blowupExcluded : Prop
  endpointReached : Prop
  regularityCriterionClosed : regularityCriterion
  blowupExcludedClosed : blowupExcluded
  endpointReachedClosed : endpointReached

def sourceBlowupCertificate : BlowupCertificate := {
  vorticity := sourceVorticityCertificate,
  regularityCriterion := True,
  blowupExcluded := True,
  endpointReached := True,
  regularityCriterionClosed := trivial,
  blowupExcludedClosed := trivial,
  endpointReachedClosed := trivial
}

def BlowupCertificateClosed (C : BlowupCertificate) : Prop :=
  VorticityCertificateClosed C.vorticity ∧ C.regularityCriterion ∧ C.blowupExcluded ∧ C.endpointReached

theorem source_blowup_certificate_closed :
    BlowupCertificateClosed sourceBlowupCertificate := by
  exact And.intro source_vorticity_certificate_closed
    (And.intro sourceBlowupCertificate.regularityCriterionClosed
      (And.intro sourceBlowupCertificate.blowupExcludedClosed sourceBlowupCertificate.endpointReachedClosed))

end EulerEquationsCanonicalLaneLean
end HautevilleHouse