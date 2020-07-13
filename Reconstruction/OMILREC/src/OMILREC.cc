#include "OMILREC.h"
#include "TMath.h"
#include "TFile.h"
#include "TTree.h"
#include "TH1.h"
#include "TF1.h"
#include "TFitterMinuit.h"
#include "TString.h"
#include "TStopwatch.h"
#include "Minuit2/FCNBase.h"
#include "SniperKernel/AlgFactory.h"
#include "Event/RecHeader.h"
#include "Event/CalibHeader.h"
#include "Geometry/RecGeomSvc.h"
#include "Identifier/Identifier.h"
#include "Identifier/CdID.h"
#include <boost/filesystem.hpp>
#include "RootWriter/RootWriter.h"

#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "EvtNavigator/NavBuffer.h"
#include <map>
#include "TAxis.h"

namespace fs = boost::filesystem;

DECLARE_ALGORITHM(OMILREC); 

 OMILREC::OMILREC(const std::string& name)
:   AlgBase(name)
{
    m_iEvt = -1; 

    Total_num_PMT = 17739;
    PMT_R = 19.5;
    Ball_R = 19.246;
    LS_R = 17.7;
    pmt_r = 0.254;
    ChaCenRec_ratio = 1.2;
    m_Energy_Scale = 10577.2994;
   
    std::string base = getenv("OMILRECROOT");
    File_path = (fs::path(base)/"share").string();

    fap0 =1;///*0.998941;*/0.99349;// 0.99349;//
    fap1 =-0.0619723;///*-0.0360902;*/ 0.0351846;//-0.0432553;//-0.0360902;//-0.0351816;
    fap2 =-0.128378;///*-0.11531;*/-0.185473;//-0.106736;//-0.11531//-0.116051;
    fap3 =-0.0435327;///*-0.0861813;*/-0.16008;//-0.0810257;//-0.0861813//-0.0847666;
    fap4 = -0.0196508;///*-0.0446783;*/ -0.0591105;//-0.0459026;//-0.0446783//-0.0449179;
    fap5 =-0.051765;///*-0.0116353;*/ 0.041457;//-0.0165357;//-0.0116353//-0.0156252;

    declProp("TotalPMT", Total_num_PMT=17746);
    declProp("PMT_R", PMT_R);
    declProp("Ball_R",Ball_R);
    declProp("LS_R", LS_R);
    declProp("pmt_r", pmt_r);
    declProp("ChaCenRec_ratio", ChaCenRec_ratio);
    declProp("Energy_Scale", m_Energy_Scale);
    declProp("File_path", File_path);
    // declare property: simulation file 
    //declProp("SimFile", m_simfile);

    LogDebug<<"TotalPMT:"<<Total_num_PMT<<std::endl;
    LogDebug<<"PMT_R:"<<PMT_R<<std::endl;
    LogDebug<<"LS_R:"<<LS_R<<std::endl;
    LogDebug<<"Energy_Scale:"<<m_Energy_Scale<<std::endl;
    LogDebug<<"File_Path:"<<File_path<<std::endl;
    // logdebug of simulation file 
    //LogDebug<<"SimFile:"<< m_simfile << std::endl;
}

OMILREC::~OMILREC()
{
     map_file = PELikeFunFile.begin();
     while (map_file!=PELikeFunFile.end()) {
        delete map_file->second;
        ++map_file;
     }
     map_it = PELikeFunGraph.begin();
     while (map_it!=PELikeFunGraph.end()) {
        delete map_it->second;
        ++map_it;
     }
//   delete PMT_Geom;
}

bool OMILREC::initialize()
{
    MyFCN* fcn = new MyFCN(this);
    recminuit = new TFitterMinuit();
    recminuit->SetMinuitFCN(fcn);
    recminuit->SetPrintLevel(0); 
    // Load the Expected PE distribution
    Load_ExpectedPE();
    // Event navigator
    SniperDataPtr<JM::NavBuffer>  navBuf(getScope(), "/Event");
    if ( navBuf.invalid() ) {
        LogError << "cannot get the NavBuffer @ /Event" << std::endl;
        return false;
    }
    m_buf = navBuf.data();

    //Reconstruction Geometry service
    SniperPtr<RecGeomSvc> rgSvc("RecGeomSvc"); 
    if ( rgSvc.invalid()) {
        LogError << "Failed to get RecGeomSvc instance!" << std::endl;
        return false;
    }
    m_cdGeom = rgSvc->getCdGeom(); 

    // Get the geometry service for all PMT;    
    // Total_num_PMT = m_cdGeom->findPmtNum();
    Total_num_PMT = m_cdGeom->findPmt20inchNum();
    LogInfo << "Total PMT: " << Total_num_PMT << std::endl;
    for(int i = 0; i<Total_num_PMT; i++){
        unsigned int all_pmt_id = (unsigned int)i;
        Identifier all_id = Identifier(CdID::id(all_pmt_id,0));
     //   std::cout<<all_id<<std::endl;
        PmtGeom *all_pmt = m_cdGeom->getPmt(all_id);
        if ( !all_pmt ) {
            LogError << "Wrong Pmt Id " << i << std::endl;
        }
        TVector3 all_pmtCenter = all_pmt->getCenter();
        ALL_PMT_pos.push_back(Ball_R/PMT_R*all_pmtCenter);
    } 

    // read simulation file
    //LogDebug << "===> Reading simulation file " << std::endl;
    //sfile = new TFile(m_simfile.c_str());
    //evt = (TTree*)sfile->Get("evt");
    //evt->SetBranchAddress("edepX",&Coor_x);
    //evt->SetBranchAddress("edepY",&Coor_y);
    //evt->SetBranchAddress("edepZ",&Coor_z);

    LogInfo  << objName()
        << "   initialized successfully"
        << std::endl; 

    return true; 

}

bool OMILREC::execute()
{
    ++m_iEvt;

    LogDebug << "---------------------------------------" << std::endl;
    LogDebug << "Processing OMILREC algorithm to reconstruct energy" << std::endl;
    LogDebug << "Processing event " << m_iEvt << std::endl;

    JM::EvtNavigator* nav = m_buf->curEvt(); 

    //read CalibHit data
    JM::CalibHeader* chcol =(JM::CalibHeader*) nav->getHeader("/Event/Calib"); 

    const std::list<JM::CalibPMTChannel*>& chhlist = chcol->event()->calibPMTCol();
    std::list<JM::CalibPMTChannel*>::const_iterator chit = chhlist.begin();
    for(int i = 0; i<Total_num_PMT; i++){
       PMT_HIT[i] = 0;
    }
    double pe_sum = 0;
    while (chit!=chhlist.end()) {
        const JM::CalibPMTChannel  *calib = *chit++;

        unsigned int pmtId = calib->pmtId();
        Identifier id = Identifier(pmtId);
        if (not CdID::is20inch(id)) {
            continue;
        }

        double nPE = calib->nPE();
        double firstHitTime = calib->firstHitTime();
        PMT_HIT[CdID::module(id)] = nPE;
        Readout_PE.push_back(nPE);
        pe_sum = pe_sum +nPE;
        Readout_hit_time.push_back(firstHitTime);

        PmtGeom *pmt = m_cdGeom->getPmt(id);
        if ( !pmt ) {
            LogError << "Wrong Pmt Id " << id << std::endl;
        }
        TVector3 pmtCenter = pmt->getCenter();
        PMT_pos.push_back(Ball_R/PMT_R*pmtCenter);

  //      if (m_iEvt == 0) {
  //          LogDebug << "   pmtId : " << pmtId
  //              << "    nPE : " << nPE
  //              << "    firstHitTime : " << firstHitTime
  //              << "  pmtCenter : " << pmtCenter.x()
  //              << "  " <<  pmtCenter.y()
  //              << "  "  << pmtCenter.z() << std::endl;
  //      }
    }
  //     
    LogDebug  << "Done to read CalibPMT" << std::endl;

    num_PMT = PMT_pos.size();
    TStopwatch timer;
    timer.Start();
    
    /*********************************************************************/
    // Load RecEvent 
    /*********************************************************************/
    JM::RecHeader* aDataHdr = (JM::RecHeader*)nav->getHeader("/Event/Rec"); 
    JM::CDRecEvent* aData = aDataHdr->cdEvent();
    Coor_x = aData->xVec();
    Coor_y = aData->yVec();
    Coor_z = aData->zVec();
    LogDebug  << "Done to Load RecTimeLikeEvent" << std::endl;


    double n_fit;
    double E_rec;

    //evt->GetEntry(m_iEvt);
    recminuit->SetParameter(0,"n",10000, 10, 0, 500000);
    recminuit->SetParameter(1,"xpos",Coor_x[0],1000,-18000,18000);
    recminuit->SetParameter(2,"ypos",Coor_y[0],1000,-18000,18000);
    recminuit->SetParameter(3,"zpos",Coor_z[0],1000,-18000,18000);
    
    recminuit->FixParameter(1);
    recminuit->FixParameter(2);
    recminuit->FixParameter(3);
    recminuit->CreateMinimizer();
    
    int ief = recminuit->Minimize();
    LogDebug << "The ief is: " << ief << std::endl;

    n_fit = recminuit->GetParameter(0);
    n_fit = n_fit/m_Energy_Scale;
    LogDebug << "The n_fit is "<< n_fit << std::endl;

    // do chisquare calculations 
    //MyFCN* fun = (MyFCN*)recminuit->GetMinuitFCN();
    //std::vector<double> params;
    //params.push_back(n_fit);
    //m_energy_chi2 = (*fun)(params);
    //m_fired_pmt = num_PMT;
//    m_evt_tree->Fill();
    
    //LogDebug << "The chisquare of energy is "<< m_energy_chi2 << std::endl;

    
//   double  correction_par_1[6] = {6611.7 , -0.374468 , 0.000253141 , -1.11195e-07 , 2.39e-11 , -1.997e-15};//balloon
//   double  correction_par_2[6] = {1.51035e+06 , -1729.38 , 0.794653 ,-0.000182416 , 2.09194e-08 , -9.58881e-13};//balloon 

    /************************************************************************************************************************************
    LogDebug << "===> Doing old energy correction " << std::endl;
    double  correction_par_1[6] = {6722.2 , -0.45693 , 0.000367179 , -1.88242e-07, 4.866e-11 , -4.97147e-15};//Acrylic_NEW
    double  correction_par_2[6] = {162464 , -256.337 , 0.151185 , -4.17425e-05 , 5.5046e-09 , -2.80894e-13};//Acrylic_NEW
    f_correction_1 = new TF1("corr_1","[0]+[1]*x+[2]*x*x+[3]*x*x*x+[4]*x*x*x*x+[5]*x*x*x*x*x",0,4000);
    f_correction_1->SetParameters(correction_par_1);
    f_correction_2 = new TF1("corr_1","[0]+[1]*x+[2]*x*x+[3]*x*x*x+[4]*x*x*x*x+[5]*x*x*x*x*x",4000,6000);
    f_correction_2->SetParameters(correction_par_2);
    //LogDebug<<"n_fit is"<<n_fit<<std::endl;
//    n_fit = n_fit/m_Energy_Scale;
    //LogDebug<<"Energy_Scale"<<m_Energy_Scale<<std::endl;
    double R = TMath::Sqrt(x_fit*x_fit+y_fit*y_fit+z_fit*z_fit)/1000;
    double R_3 = R*R*R;
    if(R_3<4000) n_fit = n_fit/f_correction_1->Eval(R_3);
    else n_fit = n_fit/f_correction_2->Eval(R_3);
    n_fit = n_fit*1.93403;
    *************************************************************************************************************************************/
    //LogDebug<<"corrected n_fit is"<<n_fit<<std::endl; 

    // New Correction function
    /************************************************************************************************************************************
    LogDebug << "===> Doing new energy correction " << std::endl;
    double correction_par[7] = {0.4056, -4695, -647.3, 5.412e7, -2235, 1.876e7, 3420};
    f_correction = new TF1("correction","[0]+[1]/(x-[2])+[3]/pow((x-[4]),2)+[5]/pow((x-[6]),3)",4000,6000);
    f_correction->SetParameters(correction_par);
    double R = TMath::Sqrt(Coor_x*Coor_x+Coor_y*Coor_y+Coor_z*Coor_z)/1000;
    double R_3 = R*R*R;
    if(R_3>4000) n_fit = n_fit/f_correction->Eval(R_3);
    *************************************************************************************************************************************/

    //Non-linearity Correction for positron: Need to be corrected
    double  non_li_parameter[4] = {0.122495, 1.04074, 1.78087, 0.00189743};
    f_non_li_positron = new TF1("pos","(([1]+[3]*(x-1.022))/(1+[0]*exp(-[2]*(x-1.022)))*(x-1.022)+0.935802158)",0.2,12);
    f_non_li_positron->SetParameters(non_li_parameter); 
    E_rec = f_non_li_positron->GetX(n_fit);

    timer.Stop();
    double time = timer.RealTime();
    LogDebug<<"==========================================================="<<std::endl;
    LogDebug<<"The Reconstructed x is "<<Coor_x[0]<<std::endl;
    LogDebug<<"The Reconstructed y is "<<Coor_y[0]<<std::endl;
    LogDebug<<"The Reconstructed z is "<<Coor_z[0]<<std::endl;
    LogDebug<<"The Reconstructed n is "<<n_fit<<std::endl;
    LogDebug<<"The Reconstructed energy is "<<E_rec<<std::endl;
    LogDebug<<"The Reconstruction Process Cost "<<time<<std::endl;
    LogDebug<<"The Complete Reconstrution Process is Completed!"<<std::endl;
    LogDebug<<"==========================================================="<<std::endl;
     
    aData->setEnergy(n_fit);
    aData->setEprec(E_rec); 

    PMT_pos.clear();
    Readout_PE.clear();
    Readout_hit_time.clear();
    recminuit->Clear();
    delete f_non_li_positron;
    return true; 

}

bool OMILREC::Load_ExpectedPE() {
   LogDebug << "Load PE distribution" << std::endl;
   fs::path s(File_path);
   double CalibPosition[28] = {0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 11000, 12000, 13000, 14000, 15000, 16000, 16200, 16400, 16600, 16800, 17000, 17100, 17200, 17300, 17400, 17500, 17600};
   axis = new TAxis(27, CalibPosition);
   for (int i=0;i<28;i++) {
       CalibPos.push_back(CalibPosition[i]);
       std::string str = boost::lexical_cast<std::string>(CalibPosition[i]);
       std::string filename = "PE-theta-distribution-"+str+"mm.root";
       PELikeFunFile[CalibPosition[i]] = new TFile(TString((s/filename).string()));
       PELikeFunGraph[CalibPosition[i]] = (TGraph*)PELikeFunFile[CalibPosition[i]]->Get("Graph");
   }

   if(!PELikeFunFile[0])
   LogError  << "Failed to get Expected PE distribution!" << std::endl;

   return true;
}

double OMILREC::Calculate_Energy_Likelihood(double n0,
                                            double m_x,
                                            double m_y,
                                            double m_z)
{
  
  //std::cout<<n0<<std::endl;   

  double m_Likelihood = 0;
//  LogDebug << " ===> Calculating charge likelihood function" << std::endl;
  for(int i = 0; i< Total_num_PMT; i++){

     double pmt_pos_x = ALL_PMT_pos.at(i).X()*PMT_R/Ball_R;
     double pmt_pos_y = ALL_PMT_pos.at(i).Y()*PMT_R/Ball_R;
     double pmt_pos_z = ALL_PMT_pos.at(i).Z()*PMT_R/Ball_R;
     
     double ModuleSource = TMath::Sqrt(m_x*m_x + m_y*m_y + m_z*m_z);
//     LogDebug << "ModuleSource : " << ModuleSource << std::endl;
     double ModulePMT = TMath::Sqrt(pmt_pos_x*pmt_pos_x + pmt_pos_y*pmt_pos_y + pmt_pos_z*pmt_pos_z);
     double cos_theta = (pmt_pos_x*m_x + pmt_pos_y*m_y + pmt_pos_z*m_z)/ModuleSource/ModulePMT;
     double theta = TMath::ACos(cos_theta)*180/TMath::Pi();

     double m_average_PE;
     int Nbin = axis->FindBin(ModuleSource);
//     LogDebug << "Nbin " << Nbin << std::endl;
     if (Nbin <= 27) {
        double fraction = ModuleSource - CalibPos[Nbin-1];
//        LogDebug << "fraction: " << fraction << std::endl;
        double total = CalibPos[Nbin] - CalibPos[Nbin-1];
//        LogDebug << "total: " << total << std::endl;
        double weight = fraction/total;
//        LogDebug << "weight : " << weight << std::endl;
        m_average_PE = (1-weight)*(PELikeFunGraph[CalibPos[Nbin-1]]->Eval(theta)) + weight*(PELikeFunGraph[CalibPos[Nbin]]->Eval(theta));
     } else {
        m_average_PE = PELikeFunGraph[CalibPos[Nbin-1]]->Eval(theta);
     }

     /***********************************************************************************************

     double pmt_pos_x = ALL_PMT_pos.at(i).X()*PMT_R/Ball_R;
     double pmt_pos_y = ALL_PMT_pos.at(i).Y()*PMT_R/Ball_R;
     double pmt_pos_z = ALL_PMT_pos.at(i).Z()*PMT_R/Ball_R; 
     double dx = (m_x - pmt_pos_x)/1000;
     double dy = (m_y - pmt_pos_y)/1000;
     double dz = (m_z - pmt_pos_z)/1000;
     
     double r0 = (TMath::Sqrt(m_x*m_x+m_y*m_y+m_z*m_z))/1000;
     double dist = TMath::Sqrt(dx*dx+dy*dy+dz*dz);
    
     double cos_theta = (PMT_R*PMT_R+dist*dist-r0*r0)/(2*PMT_R*dist);
     
     double theta = TMath::ACos(cos_theta);
     
     //double f_theta = TMath::Cos(0.8718*theta);//fap0+ theta*(fap1 + theta*(fap2 + theta*(fap3 + theta*(fap4+theta*fap5))));//cos_theta;
     double f_theta = cos_theta;//fap0+ theta*(fap1 + theta*(fap2 + theta*(fap3 + theta*(fap4+theta*fap5))));//cos_theta;
     
     //double m_expected_PE = f_theta*n0*pmt_r*pmt_r/(4*dist*dist)*(0.065*TMath::Exp(-dist*m_eff_atten1)+0.935*TMath::Exp(-dist*m_eff_atten2));
     double m_expected_PE = f_theta*n0*pmt_r*pmt_r/(4*dist*dist)*TMath::Exp(-dist*m_effective_attenuation);
    
     if (r0 <= TMath::Sqrt(LS_R*LS_R*0.79267)) {
         m_Likelihood = m_Likelihood-PMT_HIT[i]*log(m_expected_PE)+m_expected_PE+log(TMath::Factorial(PMT_HIT[i]));
     } else {
         double cos_cross_theta = (r0*r0 + PMT_R*PMT_R - dist*dist)/(2*r0*PMT_R);
         if (cos_cross_theta > 0) {
            m_Likelihood = m_Likelihood-PMT_HIT[i]*log(m_expected_PE)+m_expected_PE+log(TMath::Factorial(PMT_HIT[i]));
         } else {
             m_Likelihood = m_Likelihood;
         }
     }

     // considering dark zone
    // if (r0 <= TMath::Sqrt(LS_R*LS_R*0.79267)) {
    //     //m_Likelihood = m_Likelihood-PMT_HIT[i]*log(m_expected_PE)+m_expected_PE+log(TMath::Factorial(PMT_HIT[i]))+pow((m_eff_atten1-0.1798)/0.0009931,2)+pow((m_eff_atten2-0.8115)/0.003467,2);
    //     m_Likelihood = m_Likelihood-PMT_HIT[i]*log(m_expected_PE)+m_expected_PE+log(TMath::Factorial(PMT_HIT[i]));
    // } else {
    //     double length_long = LS_R*0.45533 + TMath::Sqrt(r0*r0 - LS_R*LS_R*0.79267);
    //     double length_short = LS_R*0.45533 - TMath::Sqrt(r0*r0 - LS_R*LS_R*0.79267);
    //     double dist_long = TMath::Sqrt(PMT_R*PMT_R + length_long*length_long + 2*length_long*7.28543 - 313.29);
    //     double dist_short = TMath::Sqrt(PMT_R*PMT_R + length_short*length_short + 2*length_short*7.28543 - 313.29);
    //     if (PMT_HIT[i]!=0 && (dist<dist_short || dist>dist_long)) {
    //         m_Likelihood = m_Likelihood-PMT_HIT[i]*log(m_expected_PE)+m_expected_PE+log(TMath::Factorial(PMT_HIT[i]))+pow((m_eff_atten1-0.1798)/0.0009931,2)+pow((m_eff_atten2-0.8115)/0.003467,2);
    //     } else {
    //         if (dist>dist_short && dist<dist_long) {
    //            m_Likelihood = m_Likelihood;
    //         } else {
    //            m_Likelihood = m_Likelihood+m_expected_PE+pow((m_eff_atten1-0.1798)/0.0009931,2)+pow((m_eff_atten2-0.8115)/0.003467,2);
    //         }
    //     }
    // }

**************************************************************************************/
/**************************************************************************************
     LogDebug << " ===>Calculating charge likelihood function without dark zone effect " << std::endl;
  for(int i = 0; i< Total_num_PMT; i++){
     double pmt_pos_x = ALL_PMT_pos.at(i).X()*PMT_R/Ball_R;
     double pmt_pos_y = ALL_PMT_pos.at(i).Y()*PMT_R/Ball_R;
     double pmt_pos_z = ALL_PMT_pos.at(i).Z()*PMT_R/Ball_R;

     double dx = (m_x - pmt_pos_x)/1000;
     double dy = (m_y - pmt_pos_y)/1000;
     double dz = (m_z - pmt_pos_z)/1000;
     
     double r0 = (TMath::Sqrt(m_x*m_x+m_y*m_y+m_z*m_z))/1000;
     double dist = TMath::Sqrt(dx*dx+dy*dy+dz*dz);
    
     double cos_theta = (PMT_R*PMT_R+dist*dist-r0*r0)/(2*PMT_R*dist);
     
     double theta = TMath::ACos(cos_theta);
     
     double f_theta = cos_theta;//fap0+ theta*(fap1 + theta*(fap2 + theta*(fap3 + theta*(fap4+theta*fap5))));//cos_theta;

     double m_expected_PE = f_theta*n0*pmt_r*pmt_r/(4*dist*dist)*TMath::Exp(-dist*m_effective_attenuation);

     if(PMT_HIT[i]!=0){
        m_Likelihood = m_Likelihood+(m_expected_PE-PMT_HIT[i])+log(PMT_HIT[i]/m_expected_PE)*PMT_HIT[i];
     }
     
     else{
        m_Likelihood = m_Likelihood+m_expected_PE;
     }

**************************************************************************************/

        double m_expected_PE = n0*m_average_PE/11522;
        m_Likelihood = m_Likelihood-PMT_HIT[i]*log(m_expected_PE)+m_expected_PE+log(TMath::Factorial(PMT_HIT[i]));
    }

//    LogDebug << "Likelihood is " << m_Likelihood << std::endl;

    return m_Likelihood;
}

bool OMILREC::finalize()
{
    //sfile->Close("R");
    LogInfo  << objName()
        << "   finalized successfully" 
        << std::endl; 
    return true; 
}


