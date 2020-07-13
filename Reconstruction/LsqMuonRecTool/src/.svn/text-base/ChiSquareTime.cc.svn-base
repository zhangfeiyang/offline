#include "ChiSquareTime.h"
#include "TGraph.h"
#include "TMath.h"
#include "SniperKernel/SniperLog.h"

ChiSquareTime::ChiSquareTime(const PmtTable* ptab)
     : m_ptable(ptab)
{
}

void
ChiSquareTime::setclight(double c){
    m_clight = c;
}

void
ChiSquareTime::setnLS(double n){
    m_nLSlight = n;
}

void
ChiSquareTime::setvmuon(double v){
    m_vmuon = v;
}

void
ChiSquareTime::setfix(TGraph*mean20, TGraph*rms20, TGraph*mean3, TGraph*rms3)
{
    m_dtmean20 = mean20; 
    m_dtrms20  = rms20; 
    m_dtmean3  = mean3; 
    m_dtrms3   = rms3; 
}
double
ChiSquareTime::operator()(const std::vector<double>&par)const{

    double chisq=0; 

    const PmtTable& ptab = *m_ptable; 
    unsigned int pmtnum = ptab.size(); 
    unsigned int inum; 
    for(inum=0; inum<pmtnum; inum++){
        if(ptab[inum].used  ==  true){
            double q = ptab[inum].q ; 
            double t_sigma , dtfix ; 
            if(ptab[inum].type  == _PMTINCH3){
                t_sigma= m_dtrms3->Eval(q); 
                dtfix = m_dtmean3->Eval(q); 
            }
            else if(ptab[inum].type  == _PMTINCH20){
                t_sigma= m_dtrms20->Eval(q); 
                dtfix = m_dtmean20->Eval(q); 
            }
            else {
                LogError << "The pmt "  << inum << " is neither 20 inch nor 3 inch ?" << std::endl; 
            }
            TVector3 r0; 
            r0.SetMagThetaPhi(par[0], par[1], par[2]); 
            double t0 = par[3]; 
            TVector3 direction; 
            direction.SetMagThetaPhi(1, par[4], par[5]); 
            double length = par[6]; 

            bool fromStart = false; 
            double cosref = 0; 
            double fHTExp = firstHitTime(r0, t0, direction, length, ptab[inum], &cosref, &fromStart); 
            double delta = fHTExp+dtfix-ptab[inum].fht; 
            chisq  +=  (delta*delta)/(t_sigma*t_sigma); 
        }
    }
    return chisq; 
}


double 
ChiSquareTime::firstHitTime(TVector3 r0, 
        double t0, 
        TVector3 direction, 
        double length, 
        const PmtProp& pmt, 
        double* cosref, 
        bool* isFromStart 
        ) const
{
    //this theta is the angle between the first hit photon's track and the muon track.
    double tantheta  = TMath::Sqrt(m_nLSlight*m_nLSlight-1); 

    TVector3 Vu = direction* m_vmuon; 
    TVector3 Ri = pmt.pos; 

    //end point of the track
    TVector3 Re = r0+direction*length; 

    // the perpendicular foot of the ipmt to the track.
    TVector3 Rperp = r0+direction*(Ri-r0)*direction; 

    //dtperp is the time muon fly from r0 to Rperp; 
    double dtperp = (Rperp-r0)*direction/m_vmuon;  

    // photon emitted from point C of the track fistly hit to the ipmt;
    // dtc is the time of muon from r0 to point C; 
    TVector3 Rc; 
    double dtc = dtperp-(Ri-Rperp).Mag()/(m_vmuon*tantheta); 

    //dte is the time muon fly from r0 to Re; 
    double dte = length/m_vmuon; 

    //if the dtc small than zero,  means the 'fastest light' point is out of the LS, 
    //so the injection point is the fastest light point.
    if(dtc<0){
        Rc = r0; 
        dtc = 0; 
        if(isFromStart!=NULL) *isFromStart = true; 
    }
    //if the dtc is greater than dte, meaning that the 'fastest light' point is after the Re, 
    //so the end point is the fastest light point.
    else if(dtc>dte){
        Rc = Re; 
        dtc = dte; 
        if(isFromStart!=NULL) *isFromStart = false; 
    }
    else{
        Rc = r0+Vu*dtc; 
        if(isFromStart!=NULL) *isFromStart = false; 
    }

    if(cosref!=NULL) *cosref = (Ri-Rc).Dot(Ri)/((Ri-Rc).Mag()*Ri.Mag()); 
    double ti = t0 + dtc + m_nLSlight/m_clight*(Ri-Rc).Mag(); 
    return ti; 
}

