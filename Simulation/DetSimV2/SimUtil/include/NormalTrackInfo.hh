#ifndef NormalTrackInfo_hh
#define NormalTrackInfo_hh


#include "globals.hh"
#include "G4VUserTrackInformation.hh"

#include "G4Track.hh"
#include "G4Allocator.hh"
#include "G4ThreeVector.hh"

#include <map>

// Ref: http://geant4.slac.stanford.edu/Tips/

class NormalTrackInfo: public G4VUserTrackInformation {
    public:
        NormalTrackInfo();
        NormalTrackInfo(const G4Track* aTrack);
        NormalTrackInfo(const NormalTrackInfo* aTrackInfo);
        virtual ~NormalTrackInfo(); 


        inline void *operator new(size_t);
        inline void operator delete(void *aTrackInfo);
        inline int operator ==(const NormalTrackInfo& right) const {
            return (this==&right);
        }
    public:
        inline G4int GetOriginalTrackID() const {return originalTrackID;}

        inline void setMichaelElectron() {phys_michael_electron = 1;}
        inline G4int isMichaelElectron() {return phys_michael_electron;}

        inline void setNeutronCapture() {phys_neutron_capture = 1;}
        inline G4int isNeutronCapture() {return phys_neutron_capture;}

        inline void setFromCerenkov() {from_cerenkov = true;}
        inline G4bool isFromCerenkov(){return from_cerenkov;}

        inline void setReemission() {is_reemission = true;}
        inline G4bool isReemission(){return is_reemission;}


        inline void setOriginalOP() { m_op_is_original_op = true; }
        inline G4bool isOriginalOP() { return m_op_is_original_op; }
        inline void setOriginalOPStartTime(double t) {m_op_start_time = t;}
        inline double getOriginalOPStartTime() { return m_op_start_time; }

        inline void setBoundaryPos(const G4ThreeVector& pos) { pos_at_boundary = pos; }
        inline const G4ThreeVector& getBoundaryPos() const { return pos_at_boundary; }
    private:
        G4int originalTrackID;

        // special physics related
        G4int phys_michael_electron;
        G4int phys_neutron_capture;
        G4bool from_cerenkov;
        G4bool is_reemission;

        // the original OP info
        // Here, original means the parent of OP is not OP.
        G4bool m_op_is_original_op;
        G4double m_op_start_time;

        G4ThreeVector pos_at_boundary;
};

extern G4Allocator<NormalTrackInfo> aNormalTrackInformationAllocator;


inline void* NormalTrackInfo::operator new(size_t)
{ void* aTrackInfo;
  aTrackInfo = (void*)aNormalTrackInformationAllocator.MallocSingle();
  return aTrackInfo;
}

inline void NormalTrackInfo::operator delete(void *aTrackInfo)
{ aNormalTrackInformationAllocator.FreeSingle((NormalTrackInfo*)aTrackInfo);}

#endif
