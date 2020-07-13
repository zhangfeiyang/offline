
#include "NormalTrackInfo.hh"
#include "G4ios.hh"

G4Allocator<NormalTrackInfo> aNormalTrackInformationAllocator;



NormalTrackInfo::NormalTrackInfo()
{
    originalTrackID = 0;
    // phys
    phys_michael_electron = 0;
    phys_neutron_capture = 0;
    from_cerenkov =false;
    is_reemission =false;
}

NormalTrackInfo::NormalTrackInfo(const G4Track* aTrack)
{
    originalTrackID = aTrack->GetTrackID();
    // phys
    phys_michael_electron = 0;
    phys_neutron_capture = 0;
    from_cerenkov =false;
    is_reemission =false;

    m_op_is_original_op = false;
    m_op_start_time = 0;
}

NormalTrackInfo::NormalTrackInfo(const NormalTrackInfo* aTrackInfo)
{
    originalTrackID = aTrackInfo->originalTrackID;
    // phys
    phys_michael_electron = 0;
    phys_neutron_capture = 0;

    from_cerenkov = aTrackInfo->from_cerenkov;
    is_reemission = aTrackInfo->is_reemission;

    m_op_is_original_op = false;
    m_op_start_time = aTrackInfo->m_op_start_time;

    pos_at_boundary = aTrackInfo->pos_at_boundary;
}

NormalTrackInfo::~NormalTrackInfo(){;}
