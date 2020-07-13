#include "SniperKernel/ToolFactory.h"

#include "TFile.h"
#include "TGraph.h"
#include "TMath.h"

#include "LsqMuonRecTool.h"
#include "ChiSquareTime.h"

DECLARE_TOOL(LsqMuonRecTool); 

    LsqMuonRecTool::LsqMuonRecTool(const std::string& name)
    :ToolBase(name)
    , m_ptable(NULL)
{
    declProp("FhtCorrFile", m_fname=""); 
    declProp("LSRadius", m_LSRadius = 17700); 
    declProp("LightSpeed", m_clight =299.792458); 
    declProp("LSRefraction", m_nLSlight = 1.485); 
    declProp("MuonSpeed", m_vmuon = 299.792458); 
    minuit = new TFitterMinuit(); 
}

LsqMuonRecTool::~LsqMuonRecTool()
{
    delete minuit; 
}


    bool
LsqMuonRecTool::configure(const Params* pars, const PmtTable* ptab)
{
    LogDebug  << "configure the reconstruct tool [LsqMuonRecTool]!"
        << std::endl; 

    m_ptable = ptab; 

    TFile* tempf = new TFile(m_fname.c_str()); 
    if(!tempf->IsOpen()) {
        LogError << "Failed to open the FhtCorrFile ["
            << m_fname << "]!!" << std::endl; 
        return false; 
    }
    TGraph* dtrms20 = (TGraph*)tempf->Get("grrms20"); 
    if(!dtrms20){
        LogError << "No TGraph grrms20 in FhtCorrFile [" 
            << m_fname << "]!!" << std::endl; 
        return false; 
    }
    TGraph* dtmean20 = (TGraph*)tempf->Get("grmean20"); 
    if(!dtmean20){
        LogError << "No TGraph grmean20 in FhtCorrFile [" 
            << m_fname << "]!!" << std::endl; 
        return false; 
    }
    TGraph* dtrms3 = (TGraph*)tempf->Get("grrms3"); 
    if(!dtrms3){
        LogError << "No TGraph grrms3 in FhtCorrFile [" 
            << m_fname << "]!!" << std::endl; 
        return false; 
    }
    TGraph* dtmean3 = (TGraph*)tempf->Get("grmean3"); 
    if(!dtmean3){
        LogError << "No TGraph grmean3 in FhtCorrFile [" 
            << m_fname << "]!!" << std::endl; 
        return false; 
    }
    fcn = new ChiSquareTime(m_ptable); 
    fcn->setfix(dtmean20, dtrms20, dtmean3, dtrms3); 
    fcn->setclight(m_clight);
    fcn->setnLS(m_nLSlight);
    fcn->setvmuon(m_vmuon);
    minuit->SetMinuitFCN(fcn); 

    return true; 
}

    bool
LsqMuonRecTool::reconstruct(JM::RecHeader* rh)
{
    LogDebug << "reconstructing..." << std::endl;

    //Calculate the inital values of arguments; 
    TVector3 r0, direction; 
    double t0, trackl; 
    int numPmtUsed = 0; 
    numPmtUsed = iniargs(r0, t0, direction, trackl); 
    double the0 = r0.Theta(); 
    double phi0 = r0.Phi(); 
    double theTrk = direction.Theta(); 
    double phiTrk = direction.Phi(); 

    double degree = TMath::Pi()/180; 
    double theta0_up, theta0_down, phi0_up, phi0_down;
    double theTrk_up, theTrk_down, phiTrk_up, phiTrk_down;
    double halfarea=20;

    theta0_up   = the0+halfarea*degree;
    theta0_down = the0-halfarea*degree;
    phi0_up     = phi0+halfarea*degree;
    phi0_down   = phi0-halfarea*degree;

    theTrk_up   = theTrk+halfarea*degree;
    theTrk_down = theTrk-halfarea*degree;
    phiTrk_up   = phiTrk+halfarea*degree;
    phiTrk_down = phiTrk-halfarea*degree;

    if(theta0_up>180*degree) theta0_up = 180*degree; else if (theta0_down<0) theta0_down = 0;  
    if(theTrk_up>180*degree) theTrk_up = 180*degree; else if (theTrk_down<0) theTrk_down = 0;  

    //FIXME set a proper range                                                                 
    theta0_down = theTrk_down = 0;                                                             
    theta0_up = theTrk_up = 180*degree;                                                        


    minuit->SetParameter(0, "rho0"  , m_LSRadius, 1, m_LSRadius, m_LSRadius);                                     
    minuit->FixParameter(0); 
    minuit->SetParameter(1, "theta0", the0  , 1*degree, theta0_down, theta0_up);             
    minuit->SetParameter(2, "phi0"  , phi0  , 1*degree, -180*degree,180*degree);               
    minuit->SetParameter(3, "t0"    , t0    , 1, 0, 0);                                      
    minuit->SetParameter(4, "theTrk", theTrk, 1*degree, theTrk_down, theTrk_up);             
    minuit->SetParameter(5, "phiTrk", phiTrk, 1*degree, -180*degree,180*degree);            
    minuit->SetParameter(6, "trackLength" , trackl, 1, 0, 2*m_LSRadius);                              
    minuit->SetPrintLevel(0);                                                                  
    minuit->CreateMinimizer();                                                                 
    if(numPmtUsed>0)                                                                         
    {                                                                                          
        double ier = minuit->Minimize();                                                       

        LogDebug << "------------------------------" << std::endl                              
            << "ier     :   "  << ier<< std::endl;                                             
    }                                                                                          
    double re_theta0=0, re_phi0=0, re_theTrk=0, re_phiTrk=0, re_rho0=0, re_t0=0 , re_trackl=0;

    // get the restrcution parameters
    if(numPmtUsed>0)
    {
        re_rho0     = minuit->GetParameter(0);
        re_theta0   = minuit->GetParameter(1);
        re_phi0     = minuit->GetParameter(2);
        re_t0       = minuit->GetParameter(3);
        re_theTrk   = minuit->GetParameter(4); 
        re_phiTrk   = minuit->GetParameter(5); 
        re_trackl   = minuit->GetParameter(6); 

        LogDebug << "Complete to miniut." << std::endl; 
    }

    double array[] = {re_rho0, re_theta0, re_phi0, re_t0, re_theTrk, re_phiTrk, re_trackl}; 
    std::vector<double> pars(array, array+sizeof(array)/sizeof(double)); 
    double chi2 = (*fcn)(pars);  
    double ndf = numPmtUsed-7; 
    TVector3 re_R0, re_dir, re_Re; 
    re_R0.SetMagThetaPhi(re_rho0, re_theta0, re_phi0); 
    re_dir.SetMagThetaPhi(1, re_theTrk, re_phiTrk); 
    re_Re = re_R0+re_dir*re_trackl; 
    double re_te = re_t0+re_trackl/m_vmuon; 

    CLHEP::HepLorentzVector start(re_R0[0], re_R0[1], re_R0[2], re_t0); 
    CLHEP::HepLorentzVector end(re_Re[0], re_Re[1], re_Re[2], re_te); 
    JM::RecTrack* mtrk = new JM::RecTrack(start, end); 
    mtrk->setQuality(chi2/ndf); 
    JM::CDTrackRecEvent* evt = new JM::CDTrackRecEvent();
    evt->addTrack(mtrk); 
    rh->setCDTrackEvent(evt);

    LogDebug << "------------------------------" << std::endl
        << "Result : " << std::endl
        << "chi2/ndf   :   " << chi2/ndf << std::endl
        << "re_rho0(mm):   "  << re_rho0<< std::endl
                                 << "re_theta0  :   "  << re_theta0*180/TMath::Pi()<< std::endl
                                 << "re_phi0    :   "  << re_phi0*180/TMath::Pi() << std::endl
                                 << "re_t0(ns)  :   "  << re_t0<< std::endl
                                                          << "re_theTrk  :   "  << re_theTrk*180/TMath::Pi()<< std::endl
                                                          << "re_phiTrk  :   "  << re_phiTrk*180/TMath::Pi()<< std::endl
                                                          << "re_trackl(mm)  :   "  << re_trackl<< std::endl
                                                                                       << "start(" << re_R0[0] << ", " << re_R0[1] << ", " << re_R0[2] << ", " << re_t0 << "ns) "  << std::endl
                                                                                       << "end(" << re_Re[0] << ", " << re_Re[1] << ", " << re_Re[2] << ", " << re_te <<  "ns) " << std::endl;
    minuit->Clear();
    return true;
}
std::ostream& operator << (std::ostream& s, const TVector3& v)
{
    s  <<  "("  <<  v.x()  <<  ", "  <<  v.y()  <<  ", "  <<  v.z()  <<  ")"; 
    return s; 
}

TVector3 operator/ (const TVector3& v1, double c)
{
    double x = v1.x()/c; 
    double y = v1.y()/c; 
    double z = v1.z()/c; 
    return TVector3(x, y, z); 
}
    int
LsqMuonRecTool::iniargs(TVector3 & r0, double & t0, 
        TVector3 & direction, double& length )// output
{
    TVector3 Rchgcen(0, 0, 0); //charge center of all pmt signals
    double tempCharge=0 ;
    t0 = 999999; 
    length=0; 

    double chargetotal=0; 
    int numPmtUsed=0; 
    const PmtTable& ptab = *m_ptable; 
    unsigned int pmtnum = ptab.size(); 
    for (unsigned int i = 0; i < pmtnum; ++i)
    {
        if(ptab[i].used == 1){
            if (ptab[i].fht<t0)
            {
                t0 = ptab[i].fht; 
                r0 = ptab[i].pos;
            }
            //find the max. charge PMT 
            if(ptab[i].q>tempCharge)  {

                tempCharge = ptab[i].q;
                //r0 = ptab[i].pos; 
            } 
            Rchgcen += ptab[i].pos*ptab[i].q; 
            chargetotal += ptab[i].q; 
            numPmtUsed++; 
        }
    }
    Rchgcen = Rchgcen / chargetotal; 
    direction = (Rchgcen-r0).Unit(); 
    length = 2*(Rchgcen-r0).Mag(); 
    TVector3 re = 2*Rchgcen - r0; 

    LogDebug  << std::endl
        <<"Pmt used count: " << numPmtUsed << std::endl
        <<"Inital argument: " << std::endl
        << " r0:" << r0 << std::endl
        << " t0:" << t0 << std::endl
        << " re:" << re << std::endl
        << " theta0:" << r0.Theta()*180/TMath::Pi() << std::endl
        << " phi0:" << r0.Phi()*180/TMath::Pi() << std::endl
        << " theTrk:" << direction.Theta()*180/TMath::Pi() << std::endl
        << " phiTrk:" << direction.Phi() *180/TMath::Pi()<< std::endl
        << " tracklength:" << length << std::endl; 

    return numPmtUsed; 

}
