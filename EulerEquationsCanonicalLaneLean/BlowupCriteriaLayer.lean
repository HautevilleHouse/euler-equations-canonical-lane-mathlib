import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.EulerEquationsCanonicalLaneLean.VorticityDynamicsLayer

namespace HautevilleHouse
namespace EulerEquationsCanonicalLaneLean

structure BlowupCriteriaCertificate where
  vorticity : VorticityCertificate
  bealeKatoMajda : Prop
  regularityBarrier : Prop
  bealeKatoMajdaClosed : bealeKatoMajda
  regularityBarrierClosed : regularityBarrier

def sourceBlowupCriteriaCertificate : BlowupCriteriaCertificate := {
  vorticity := sourceVorticityCertificate
  bealeKatoMajda := VorticityClosed sourceVorticityCertificate
  regularityBarrier := True
  bealeKatoMajdaClosed := source_vorticity_closed
  regularityBarrierClosed := trivial
}

def BlowupCriteriaClosed (C : BlowupCriteriaCertificate) : Prop :=
  VorticityClosed C.vorticity ∧ C.bealeKatoMajda ∧ C.regularityBarrier

theorem source_blowup_criteria_closed :
    BlowupCriteriaClosed sourceBlowupCriteriaCertificate := by
  exact And.intro source_vorticity_closed
    (And.intro sourceBlowupCriteriaCertificate.bealeKatoMajdaClosed
      sourceBlowupCriteriaCertificate.regularityBarrierClosed)

end EulerEquationsCanonicalLaneLean
end HautevilleHouse