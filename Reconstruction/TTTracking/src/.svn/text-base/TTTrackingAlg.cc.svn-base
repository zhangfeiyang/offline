/*
TotTracker Tracking


Author: A.Meregaglia, C.Jollet (IPHC)
*/

#include "Event/CalibHeader.h"
#include "Event/TTCalibEvent.h"
#include "Event/CalibEvent.h"
#include "Event/RecHeader.h"
#include "EvtNavigator/NavBuffer.h"
#include "BufferMemMgr/IDataMemMgr.h"
#include "DataRegistritionSvc/DataRegistritionSvc.h"
#include "Geometry/RecGeomSvc.h"
#include "Identifier/Identifier.h"
#include "Identifier/CdID.h"
#include "TH1D.h"
#include "TMath.h"
#include "TMinuit.h"

#include "TTTrackingAlg.h"
#include "SniperKernel/AlgFactory.h"
#include "RootWriter/RootWriter.h"
#include <bitset>

static int np;
static double xfit[100];
static double yfit[100];
static double zfit[100];
static double error[100];

void fcn(Int_t &, Double_t *, Double_t &, Double_t *, Int_t);

/////////////////////////////////////////
Double_t func(float xx,float yy,float zz,Double_t *par){
  Double_t value=(
		  pow((xx-par[0])*par[4]-(yy-par[1])*par[3],2)+
		  pow((yy-par[1])*par[5]-(zz-par[2])*par[4],2)+
		  pow((zz-par[2])*par[3]-(xx-par[0])*par[5],2)
		  )/(par[3]*par[3]+par[4]*par[4]+par[5]*par[5]);

  return value;
}
/////////////////////////////////////////////

void fcn(Int_t &npar, Double_t *gin, Double_t &f, Double_t *par, Int_t iflag)
{
  Int_t i;
  Double_t chisq = 0;
  for(i=0;i<np;i++){
    if(xfit[i]!=999&&yfit[i]!=999&&zfit[i]!=999){
      chisq+=func(xfit[i],yfit[i],zfit[i],par)/pow(error[i],2);
    }
  }
  f=chisq;
}

/////////////////////////////////////////

DECLARE_ALGORITHM(TTTrackingAlg);

TTTrackingAlg::TTTrackingAlg(const std::string& name)
	:AlgBase(name)
{
  // Set Default Values of Some Parameters

  declProp("Det_Type",m_det_type);


}

TTTrackingAlg::~TTTrackingAlg()
{

}

bool
TTTrackingAlg::initialize()
{
  if (m_det_type == "Balloon")
  {

  }
  if (m_det_type == "Acrylic")
  {

  }
  if (m_det_type == "TT")
  {

    m_evt_treeTTReco = 0;
    // check the RootWriter is Valid.
    SniperPtr<RootWriter> svc("RootWriter");
    if (svc.invalid()) {
      LogError << "Can't Locate RootWriter. If you want to use it, please "
	       << "enalbe it in your job option file."
	       << std::endl;
      return false;
    }
    m_evt_treeTTReco = svc->bookTree("SIMEVT/TT", "TT Tracking");
    m_evt_treeTTReco->Branch("evtID", &m_eventID, "evtID/I");
    m_evt_treeTTReco->Branch("NTotPoints",&m_NTotPoints,"NTotPoints/I");
    m_evt_treeTTReco->Branch("PointX",&m_PointX,"PointX[NTotPoints]/D");
    m_evt_treeTTReco->Branch("PointY",&m_PointY,"PointY[NTotPoints]/D");
    m_evt_treeTTReco->Branch("PointZ",&m_PointZ,"PointZ[NTotPoints]/D");
    m_evt_treeTTReco->Branch("NTracks",&m_NTracks,"NTracks/I");
    m_evt_treeTTReco->Branch("NPoints",&m_NPoints,"NPoints[NTracks]/I");
    m_evt_treeTTReco->Branch("Coeff0",&m_Coeff0,"Coeff0[NTracks]/D");
    m_evt_treeTTReco->Branch("Coeff1",&m_Coeff1,"Coeff1[NTracks]/D");
    m_evt_treeTTReco->Branch("Coeff2",&m_Coeff2,"Coeff2[NTracks]/D");
    m_evt_treeTTReco->Branch("Coeff3",&m_Coeff3,"Coeff3[NTracks]/D");
    m_evt_treeTTReco->Branch("Coeff4",&m_Coeff4,"Coeff4[NTracks]/D");
    m_evt_treeTTReco->Branch("Coeff5",&m_Coeff5,"Coeff5[NTracks]/D");
    m_evt_treeTTReco->Branch("Chi2",&m_Chi2,"Chi2[NTracks]/D");
   
       
  }

// Get Data Navigator
  SniperDataPtr<JM::NavBuffer> navBuf(getScope(), "/Event");
  if( navBuf.invalid() )
  {
    LogError << "cannot get the NavBuffer @ /Event" << std::endl;
    return false;
  }
  m_buf = navBuf.data();

// Register Output Data: RecHeader
  // SniperPtr<DataRegistritionSvc> drSvc("DataRegistritionSvc");
  // if ( drSvc.invalid() ) 
  // {
  //   LogError << "Failed to get DataRegistritionSvc instance!"
  //            << std::endl;
  //   return false;
  // }
  // drSvc->registerData("JM::RecEvent", "/Event/Rec");



  LogInfo << objName() << " initialized successfully." << std::endl;
  return true;
}

bool 
TTTrackingAlg::execute()
{
  LogDebug << "---------------------------------------" << std::endl;
  LogDebug << "Processing event " << m_evt_id << std::endl;

/*       
   if (m_evt_id<83013)
    {
      m_evt_id++;
      return true;
    }
  */
  // Get Input Data
  // initialize

  m_NTracks=0; 
  m_NTotPoints=0;



  JM::EvtNavigator* nav = m_buf->curEvt();



  JM::CalibHeader* sh = dynamic_cast<JM::CalibHeader*>(nav->getHeader("/Event/Calib"));
  if (not sh) 
    return false;

  JM::TTCalibEvent* se  = dynamic_cast<JM::TTCalibEvent*>(sh->ttEvent());
  if (not se) 
    return false;



  // create a TTRecEvent
  JM::RecHeader* rec_hdr = new JM::RecHeader();
  JM::TTRecEvent* rec_event = new JM::TTRecEvent();

  const std::list<JM::CalibTTChannel*>& tmp_calibttcol = se->calibTTCol();

  //  const std::vector<JM::SimTTHit*>& tmp_hits_tt = se->getTTHitsVec();
  //JM::SimTTHit* tthit = 0; 
 //TIter nexttthit(se -> getTTHitsVec());
  int wallID(0);
  int nhitwallx[512]={0};
  int nhitwally[512]={0};
  double xhitwall[512][100];
  double yhitwall[512][100];
  double zhitwall[512][2];
  
  //--------------cross-talk filter-----------------------
  
  Int_t Module[10000]={0};
  Int_t flag(0);
  Int_t NMod(0);
  Int_t Strip[10000][64]={0};
  Int_t IC[10000][64]={0};
  Float_t SumPE[10000][64]={0};
  Int_t NStrip[10000]={0};
  Float_t MaxPE(0);
  Int_t StripWithMaxPE(0);
  Int_t CTFlag[10000]={0};
  Int_t icount(0); 
  long channelID(0);

  char binarynumberchar[5000];
  char binarypmt[4];
  char binarystrip[11];
  char binarybox[9];
  
  char * pEnd;

 for (std::list<JM::CalibTTChannel*>::const_iterator ithit = tmp_calibttcol.begin();
      ithit != tmp_calibttcol.end(); ++ithit)

   //  for (std::vector<JM::SimTTHit*>::const_iterator ithit = tmp_hits_tt.begin();
   //           ithit != tmp_hits_tt.end(); ++ithit) 
    {
      flag=0;
      //JM::SimTTHit* tthit = *ithit;
      JM::CalibTTChannel* tthit = *ithit;
      //channelID=tthit->getChannelID();
      channelID=tthit->pmtId();

      //LogDebug << "channel " << channelID << std::endl;
      
      sprintf (binarynumberchar,"%s",StringconvertDecimalToBinary(channelID,29).c_str());

      for(int gg=0;gg<4;gg++)
	binarypmt[gg]=binarynumberchar[14+gg];
      for(int gg=0;gg<11;gg++)
	binarystrip[gg]=binarynumberchar[18+gg];
      for(int gg=0;gg<9;gg++)
	binarybox[gg]=binarynumberchar[5+gg];

         
      Int_t BoxIDv0=strtoull(binarybox,&pEnd, 2);
      Int_t PMTID=strtoull(binarypmt,&pEnd, 2);
      Int_t stripID=strtoull(binarystrip,&pEnd, 2);
      Int_t BoxID(0);
      BoxID=BoxIDv0*100+PMTID;     

      Int_t StripUniqueID(0);
      Int_t UniquePMT(0);

      if(PMTID<8)
	UniquePMT=PMTID;
      else if(PMTID<12)
	UniquePMT=11-PMTID;
      else
	UniquePMT=19-PMTID;

      StripUniqueID=(BoxIDv0)*100 + 10*UniquePMT+stripID;
 
      if(NMod!=0)
	{
	  for(int j=0;j<NMod;j++)
	    {
	      Int_t checkBoxIDv0=(int)(Module[j]/100);
	      Int_t checkPMT=(int)(Module[j]%100);
	      
	      if( (BoxIDv0==checkBoxIDv0) &&
		  ( PMTID==checkPMT
		    || (PMTID+checkPMT==11 && abs(PMTID-checkPMT)>4)
		    || (PMTID+checkPMT==19 && abs(PMTID-checkPMT)>4)
		    )
		  )
		{
		  int flagstrip=0;
		  for(int kk=0;kk<NStrip[j];kk++)
		  {
		    if( Strip[j][kk]==stripID)
		  	  {
		  	    //SumPE[j][kk]+=tthit->getPE();
			    SumPE[j][kk]+=tthit->nPE();
		  	    flagstrip=1;
			    break;
		  	  }
		  }
		  if(flagstrip==0)
		    {
		      Strip[j][NStrip[j]]=stripID;
		      IC[j][NStrip[j]]=StripUniqueID;
		      //SumPE[j][NStrip[j]]=tthit->getPE();
		      SumPE[j][NStrip[j]]=tthit->nPE();
		      NStrip[j]+=1;
		    }
		  flag=1;
		  break;
		}
	    }
	}
      if(flag==0)
	{
	  Module[NMod]=BoxID;
	  Strip[NMod][0]=stripID;
	  IC[NMod][0]=StripUniqueID;
	  // SumPE[NMod][0]=tthit->getPE();
	  SumPE[NMod][0]=tthit->nPE();
	  NStrip[NMod]+=1;
	  NMod+=1;
	}

      
    }

  icount=0;
  for(int i=0;i<NMod;i++)
    {
      if(NStrip[i]>1)
	{
	  MaxPE=-1;
	  for(int j=0;j<NStrip[i];j++)
	    {
	      MaxPE=TMath::Max(MaxPE,SumPE[i][j]);
	      if(MaxPE==SumPE[i][j]) StripWithMaxPE=Strip[i][j];
	    }
	  Int_t m=(StripWithMaxPE+1)/8;
	  m=8*m-(StripWithMaxPE+1);
	  
	  for(int j=0;j<NStrip[i];j++)
	    {
	      if(Strip[i][j]!=StripWithMaxPE)
		{
		  
		  Int_t DStrip=abs(StripWithMaxPE-Strip[i][j]);
		  
		  if(fabs(DStrip)==8){CTFlag[icount]=IC[i][j];}
		  if(fabs(DStrip)==16){CTFlag[icount]=IC[i][j];}
		  if(m!=0 && m!=-1 && fabs(DStrip)==1){CTFlag[icount]=IC[i][j];}
		  if(m<-2 && m>-7 && fabs(DStrip)==2){CTFlag[icount]=IC[i][j];}
		  if((m==-2 || m==-1) && DStrip==-2){CTFlag[icount]=IC[i][j];}
		  if((m==-7 || m==0) && DStrip==2){CTFlag[icount]=IC[i][j];}
		  if(m<-1 && m>-8 && (fabs(DStrip)==7 || fabs(DStrip)==9)){CTFlag[icount]=IC[i][j];}
		  if(m<-1 && m>-8 && (fabs(DStrip)==15 || fabs(DStrip)==17)){CTFlag[icount]=IC[i][j];}
		  if(m<-2 && m>-7 && (fabs(DStrip)==6 || fabs(DStrip)==10)){CTFlag[icount]=IC[i][j];}
		  if(m==-1 &&  (DStrip==7 || DStrip==-9 )){CTFlag[icount]=IC[i][j];}
		  if(m==-1 &&  (DStrip==15 || DStrip==-17 )){CTFlag[icount]=IC[i][j];}
		  if(m==-1 && DStrip==-1){CTFlag[icount]=IC[i][j];}
		  if((m==-1 || m==-2) && (DStrip==6 || DStrip==-10)){CTFlag[icount]=IC[i][j];}
		  if(m==0 && DStrip==1){CTFlag[icount]=IC[i][j];}
		  if(m==0 && (DStrip==-7 || DStrip==9)){CTFlag[icount]=IC[i][j];}
		  if(m==0 && (DStrip==-15 || DStrip==17)){CTFlag[icount]=IC[i][j];}
		  if((m==0 || m==-7) && (DStrip==-6 || DStrip==10)){CTFlag[icount]=IC[i][j];}
		  if(CTFlag[icount]>0 && (SumPE[i][j]>3 || SumPE[i][j]/MaxPE>0.3)){CTFlag[icount]=0;}
		  
		  if(CTFlag[icount]>0)
		    icount++;
		}
	      
	    }
	}
    }
  
  //---------------end cross-talk filter------------------

  //loop on hits from data model and set threshold if not done already
  
  
  for (std::list<JM::CalibTTChannel*>::const_iterator ithit = tmp_calibttcol.begin();
       ithit != tmp_calibttcol.end(); ++ithit)
    
    {
      JM::CalibTTChannel* tthit = *ithit;
      
      //  for (std::vector<JM::SimTTHit*>::const_iterator ithit = tmp_hits_tt.begin();
      // ithit != tmp_hits_tt.end(); ++ithit) 
      //{
      //JM::SimTTHit* tthit = *ithit;
      

      //channelID=tthit->getChannelID();
      channelID=tthit->pmtId();
      
      sprintf (binarynumberchar,"%s",StringconvertDecimalToBinary(channelID,29).c_str());
      
      for(int gg=0;gg<4;gg++)
	binarypmt[gg]=binarynumberchar[14+gg];
      for(int gg=0;gg<11;gg++)
	binarystrip[gg]=binarynumberchar[18+gg];
      for(int gg=0;gg<9;gg++)
	binarybox[gg]=binarynumberchar[5+gg];
      
      
      Int_t BoxIDv0=strtoull(binarybox,&pEnd, 2);
      Int_t PMTID=strtoull(binarypmt,&pEnd, 2);
      Int_t stripID=strtoull(binarystrip,&pEnd, 2);
      
      Int_t StripUniqueID(0);
      Int_t UniquePMT(0);

      if(PMTID<8)
	UniquePMT=PMTID;
      else if(PMTID<12)
	UniquePMT=11-PMTID;
      else
	UniquePMT=19-PMTID;

      StripUniqueID=(BoxIDv0)*100 + 10*UniquePMT+stripID;
      Int_t flag(0);
      for(int kk=0;kk<icount;kk++)
	{

	  if(CTFlag[kk]==StripUniqueID)  
	    flag=1;
	    // continue;     //Hits tagged as CT are removed
	}
      if(flag==1) continue;

    
      wallID=strtoull(binarybox,&pEnd, 2);      

      
      //  if(tthit->getX()<1e9)
      if(tthit->x()<1e9)
	{
	  xhitwall[wallID][nhitwallx[wallID]]=tthit->x();
	  nhitwallx[wallID]++;
	  zhitwall[wallID][0]=tthit->z();
	}
      //else if(tthit->getY()<1e9)
      else if(tthit->y()<1e9)
	{
	  yhitwall[wallID][nhitwally[wallID]]=tthit->y();
	  nhitwally[wallID]++;
	  zhitwall[wallID][1]=tthit->z();
	}      
      
    }
  
  //second loop to merge neighbouring strips
  int nhitwallxL2[512]={0};
  double xhitwallL2[512][100];
  int nhitwallyL2[512]={0};
  double yhitwallL2[512][100];
  
  for(int kwall=0;kwall<512;kwall++)
    {
      if(nhitwallx[kwall]==0 || nhitwally[kwall]==0)
	continue;
      
      int nx(0);
      double xxx(0);
      double xarray[nhitwallx[kwall]];
      
      for(int khit=0;khit<nhitwallx[kwall];khit++)
	xarray[khit]=xhitwall[kwall][khit];
      
      std::sort(xarray, xarray+ nhitwallx[kwall] );
      
      for(int khit=0;khit<nhitwallx[kwall];khit++)
	{
	  
	  if((nhitwallx[kwall]-khit==1) || ( (nhitwallx[kwall]-khit>1) && (fabs(xarray[khit]-xarray[khit+1])>30 )) )
	    {
	      xxx+=xarray[khit];
	      nx++;
	      xhitwallL2[kwall][nhitwallxL2[kwall]]=xxx/nx;
	      nhitwallxL2[kwall]++;
	      xxx=0;
	      nx=0;
	    }
	  else 
	    {
	      xxx+=xarray[khit];
	      nx++;
	    }
	} 
      
      int ny(0);
      double yyy(0);
      double yarray[nhitwallx[kwall]];

      for(int khit=0;khit<nhitwally[kwall];khit++)
	yarray[khit]=yhitwall[kwall][khit];

      std::sort(yarray, yarray+ nhitwally[kwall] );

      for(int khit=0;khit<nhitwally[kwall];khit++)
	{
	  
	  if((nhitwally[kwall]-khit==1) || ( (nhitwally[kwall]-khit>1) && (fabs(yarray[khit]-yarray[khit+1])>30 )) )
	    {
	      yyy+=yarray[khit];
	      ny++;
	      yhitwallL2[kwall][nhitwallyL2[kwall]]=yyy/ny;
	      nhitwallyL2[kwall]++;
	      yyy=0;
	      ny=0;
	    }
	  else 
	    {
	      yyy+=yarray[khit];
	      ny++;
	    }
	} 
    }
  

  //3rd loop to build the 3D points  and do the linear fit

  int n3D(0);
  double x3D[100];
  double y3D[100];
  double z3D[100];
  int ntouchedwalls(0);

  for(int kwall=0;kwall<512;kwall++)
    {
      
      if(nhitwallx[kwall]==0 || nhitwally[kwall]==0)
	continue;

      ntouchedwalls++;
      
      
      for(int khitx=0;khitx<nhitwallxL2[kwall];khitx++)
	for(int khity=0;khity<nhitwallyL2[kwall];khity++)
	  {
	    x3D[n3D]=xhitwallL2[kwall][khitx];
	    y3D[n3D]=yhitwallL2[kwall][khity];
	    z3D[n3D]=(zhitwall[kwall][0] + zhitwall[kwall][1])/2.;
	    n3D++;


	    //avoid showers
	    if(n3D>80)
	      {
		m_evt_id++;
		return true;
	      }
	    
	  }
    }

  

  
  //combinations of 3D points an fit
 
  int loop(ntouchedwalls);
  int minnpt(3);
  int foundtrack(0);
  int redoloop3(0);
  int additionalchi2(7);

  double newx3D[100];
  double newy3D[100];
  double newz3D[100];
  int leftnp(0);

  //avoid very long loops or segmentation fault
  if(loop==2 && n3D<10)
   minnpt=2;

  if(loop>4 && n3D>30)
    loop=4;

  while(loop>=minnpt && n3D>1)
    {

       
      double ztest[n3D];
      
      std::vector<bool> v(n3D);
      //std::fill(v.begin() + ntouchedwalls, v.end(), true);
      std::fill(v.begin() + loop, v.end(), true);
      foundtrack=0;
      
      static Double_t vstart[6];
      Double_t step[6]={0.1,0.1,0.1,0.1,0.1,0.1};
      float sx0,sy0,sz0; 
      float xmin,xmax,ymin,ymax,zmin,zmax;
      
      do{

	np=0;
	leftnp=0;
	

	bool Isfit(true);
	sx0=0;sy0=0;sz0=0;
	xmin=1E5;xmax=-1E5;
	ymin=1E5;ymax=-1E5;
	zmin=1E5; zmax=-1E5;
	


	for (int i = 0; i < n3D; ++i) {
	  if (!v[i]) {
	    xfit[np]=x3D[i];
	    yfit[np]=y3D[i];
	    zfit[np]=z3D[i];
	    ztest[np]=z3D[i];
	    np++;
	  }
	  else{
	    newx3D[leftnp]=x3D[i];
	    newy3D[leftnp]=y3D[i];
	    newz3D[leftnp]=z3D[i];
	    leftnp++;
	  }
	}
	
	std::sort(ztest, ztest+ np );
	
	for(int uu=1;uu<np;uu++)
	  if(ztest[uu]==ztest[uu-1])
	    Isfit=false;
	
	if(Isfit)  //do not try the fit with points in the same wall
	  {
	    m_NPoints[m_NTracks]=np;
	    
	    for(int uu=0;uu<np;uu++)
	      {
		
		
		sx0=sx0+xfit[uu];
		sy0=sy0+yfit[uu];
		sz0=sz0+zfit[uu];
                
		xmin=(xmin<xfit[uu])?xmin:xfit[uu];
		xmax=(xmax>xfit[uu])?xmax:xfit[uu];
		ymin=(ymin<yfit[uu])?ymin:yfit[uu];
		ymax=(ymax>yfit[uu])?ymax:yfit[uu];
		zmin=(zmin<zfit[uu])?zmin:zfit[uu];
		zmax=(zmax>zfit[uu])?zmax:zfit[uu];
                
		error[uu]=13.;
	      }
	    
	    //DO FIT
	    TMinuit *gMinuit2R= new TMinuit(6);
	    gMinuit2R->SetPrintLevel(-1);
	    gMinuit2R->SetFCN(fcn);
	    
	    vstart[0]=sx0/np;
	    vstart[1]=sy0/np;
	    vstart[2]=sz0/np;
	    vstart[3]=(xmin*ymin+xmax*ymax)/(sqrt(xmin*xmin+xmax*xmax)*sqrt(ymin*ymin+ymax*ymax));
	    vstart[4]=(ymin*zmin+ymax*zmax)/(sqrt(ymin*ymin+ymax*ymax)*sqrt(zmin*zmin+zmax*zmax));
	    vstart[5]=(xmin*zmin+xmax*zmax)/(sqrt(xmin*xmin+xmax*xmax)*sqrt(zmin*zmin+zmax*zmax));
	    
	    gMinuit2R->DefineParameter(0,"x1",vstart[0],step[0],-1E5,1E5);
	    gMinuit2R->DefineParameter(1,"x2",vstart[1],step[1],-1E5,1E5);
	    gMinuit2R->DefineParameter(2,"x3",vstart[2],step[2],-1E5,1E5);
	    gMinuit2R->DefineParameter(3,"v1",vstart[3],step[3],-1E5,1E5);
	    gMinuit2R->DefineParameter(4,"v2",vstart[4],step[4],-1E5,1E5);
	    gMinuit2R->DefineParameter(5,"v3",vstart[5],step[5],-1E5,1E5);
	    
	    
	    gMinuit2R->Command("SET NOW");
	    gMinuit2R->Command("MINI");
	    // Print results
	     Double_t amin,edm,errdef;
	    Int_t nvpar,nparx,icstat;
	    gMinuit2R->mnstat(amin,edm,errdef,nvpar,nparx,icstat);
	    double chi2R=amin;
	    Double_t Rp[6];
	    Double_t Rep[6];
	    
	    gMinuit2R->GetParameter(0,Rp[0],Rep[0]);
	    gMinuit2R->GetParameter(1,Rp[1],Rep[1]);
	    gMinuit2R->GetParameter(2,Rp[2],Rep[2]);
	    gMinuit2R->GetParameter(3,Rp[3],Rep[3]);
	    gMinuit2R->GetParameter(4,Rp[4],Rep[4]);
	    gMinuit2R->GetParameter(5,Rp[5],Rep[5]);
	    
	    
	    //xRbottom=Rp[3]/Rp[5]*(zbottom-Rp[2])+Rp[0];
	    //yRbottom=Rp[4]/Rp[5]*(zbottom-Rp[2])+Rp[1];
	    

	    if((np>3 && chi2R<3) || (np==3 && chi2R<(3+redoloop3*additionalchi2) ) || (np==2 && chi2R<0.1))
	      {
	

		for(int uu=0;uu<np;uu++)
		  {
		    m_PointX[m_NTotPoints]=xfit[uu];
		    m_PointY[m_NTotPoints]=yfit[uu];
		    m_PointZ[m_NTotPoints]=zfit[uu];
		    m_NTotPoints++;

                    rec_event->addPoint(xfit[uu], yfit[uu], zfit[uu]);
		  }
		m_Chi2[m_NTracks]=chi2R;
		m_Coeff0[m_NTracks]=Rp[0];
		m_Coeff1[m_NTracks]=Rp[1];
		m_Coeff2[m_NTracks]=Rp[2];
		m_Coeff3[m_NTracks]=Rp[3];
		m_Coeff4[m_NTracks]=Rp[4];
		m_Coeff5[m_NTracks]=Rp[5];
	
		m_NTracks++;
		foundtrack=1;

                rec_event->addTrack(np, Rp, chi2R);
	      }	    
	  }
	
	
      } while (std::next_permutation(v.begin(), v.end()) && foundtrack==0);

      if(foundtrack==0)//if not track is found try with less point else continue with the same number of points after removing the used 3D hits
	{
	  loop--;
	}   
      else
	{
	  for(int uu=0;uu<leftnp;uu++)
	    {
	      x3D[uu]=newx3D[uu];
	      y3D[uu]=newy3D[uu];
	      z3D[uu]=newz3D[uu];
	    }

	  n3D-=np;
	  if(loop>n3D)
	    loop=n3D;
	}

       if(m_NTracks==0 && loop==2 && redoloop3==0)
	 {
           redoloop3=1;
	   loop=3;
	 }

       if(m_NTracks==0 && loop==2 && n3D<4)
	 {
	   minnpt=2;
	 }

    }//end if 3D points
  
  
   
  m_eventID=m_evt_id;
  
  
  if (m_evt_treeTTReco) {
    m_evt_treeTTReco -> Fill();
  }

  rec_hdr->setTTEvent(rec_event);
  nav->addHeader("/Event/Rec", rec_hdr);
  
  m_evt_id ++;
  return true;
}



bool TTTrackingAlg::finalize()
{
  LogInfo << objName() << " finalized successfully." << std::endl;
  return true;
}


// Private Functions
std::string TTTrackingAlg::StringconvertDecimalToBinary(int n, int nbit)
{
  //if nbit is not 29 this should not work!
  if(nbit!=29)
    {
      LogError<<" Error in the expected bit size "<<std::endl;
      return false;
    }
  std::string strout = std::bitset<29>(n).to_string();
  
  return strout;
}
 
