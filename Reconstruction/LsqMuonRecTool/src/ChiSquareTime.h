#include "Minuit2/FCNBase.h"
#include "RecCdMuonAlg/PmtProp.h"

class TGraph; 
class ChiSquareTime : public ROOT::Minuit2::FCNBase
{
    public:
        ChiSquareTime (const PmtTable*);
        void setfix(TGraph*,TGraph*, TGraph*, TGraph*); 
        void setclight(double c);
        void setnLS(double n);
        void setvmuon(double v);

        double Up() const{return 1.;}; 
        double operator()(const std::vector<double>&par) const; 

    private:
        double firstHitTime(TVector3 r0, // start point of the track
                double t0,               //start time of the track
                TVector3 V,              // speed of the track particle
                double length,           // length of track
                const PmtProp& pmt ,     // pmt
                double* cosref=NULL,     // the cos of inject angle for fastest photon at the detector edge.
                bool *isFromStart=NULL
                ) const ; 

    private:
        const PmtTable* m_ptable;
        const TGraph* m_dtmean20;
        const TGraph* m_dtmean3;
        const TGraph* m_dtrms20;
        const TGraph *m_dtrms3; //fix line

        double m_nLSlight;
        double m_clight; //unit: mm/ns
        double m_vmuon;
};
