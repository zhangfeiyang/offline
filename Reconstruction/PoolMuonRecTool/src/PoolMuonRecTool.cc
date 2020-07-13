#include "SniperKernel/ToolFactory.h"

#include "TFile.h"
#include "TGraph.h"
#include "TMath.h"
#include "TSpectrum2.h"
#include "TH2F.h"
// #include "TROOT.h"

#include "PoolMuonRecTool.h"

DECLARE_TOOL(PoolMuonRecTool); 

  PoolMuonRecTool::PoolMuonRecTool(const std::string& name)
  :ToolBase(name)
   , m_ptable(NULL)
{
  declProp("MaxPoints", maxpositions = 7);
  declProp("PECut", PMTThreshold_pe = 19);
  declProp("NpmtCut", PMTThreshold_n = 1);
  declProp("DistanceCut", AroundPePlus_DisCut = 7000);
  //declProp("FhtCorrFile", m_fname="");
}

PoolMuonRecTool::~PoolMuonRecTool()
{
}


  bool
PoolMuonRecTool::configure(const Params* pars, const PmtTable* ptab)
{
  LogDebug  << "configure the reconstruct tool [PoolMuonRecTool]!"
    << std::endl; 

  m_ptable = ptab; 

  return true; 
}

  bool
PoolMuonRecTool::reconstruct(JM::RecHeader* rh)
{
  JM::WPRecEvent* evt = new JM::WPRecEvent();
  LogDebug << "reconstructing water pool charge only ..." << std::endl;
  const PmtTable& ptab = *m_ptable;
  unsigned int pmtnum = ptab.size();
  const double DEG = 180./TMath::Pi();
  //int maxpositions  = 7;//fitting 
  //double PMTThreshold_pe = 19; //for fitting used, pe selected cut for each pmt, >PMTThreshold_pe cut, not >=
  //int PMTThreshold_n = 1; //for fitting used, total npmt cut, >=PMTThreshold_n, not >PMTThreshold_n
  //double AroundPePlus_DisCut = 7000;//meter, <=AroundPePlus_DisCut, not <AroundPePlus_DisCut
  double RADIUS_BALL = 20752; //J16 is 20.752
  double RADIUS_WALL = 21655; // pmt ring Radius
  int AroundPePlus_PeCut = PMTThreshold_pe;//1st deal fit points, merge same points, for deal edge points
  int FitPointDiscard_PeCut = PMTThreshold_pe;  //>FitPointDiscard_PeCut

  double CornerMerge_DisCut = 3000;
  double PointMerge_DisCut = 3000;     // <PointMerge_DisCut, merge, default is 3m
  int rec_pecut = PMTThreshold_pe;//for re-rec used
  double rec_discut = AroundPePlus_DisCut;//m, for re-rec used
  double trackL, trackLcyl, pmtfht;
  double pmtq;
  TVector3 vtmp, point, X1, X2, line1, line2, line3, dir, vpos;
  TVector3 X1cyl, X2cyl;
  TVector3 center(0,0,0);
  TVector3 centercyl(0,0,-RADIUS_WALL/2.);
  TVector3  fitp(0,0,1);
  //  std::vector<double>    PmtPe;//the charge of picked pmt
  //  std::vector<TVector3>  PmtPos;
  //  std::vector<double>    OptPmtPe;//the charge of picked pmt
  //  std::vector<TVector3>  OptPmtPos;
  //  std::vector<double>    vpe_around;
  //  std::vector<TVector3>  vfitp;
  //  std::vector<TVector3>    rectracks;
  //  std::vector<TVector3>    qwpoints;//charge weight center
  //  std::vector<TVector3>    vrec_in;//charge weight center
  //  std::vector<TVector3>    vrec_out;//charge weight center
  PmtPe.clear(); 
  PmtPos.clear();
  OptPmtPe.clear();
  OptPmtPos.clear();
  vpe_around.clear();
  vfitp.clear();
  rectracks.clear();
  qwpoints.clear();
  vrec_in.clear();
  vrec_out.clear();


  double totalpe = 0;
  int wpnpmt =0;
  for (unsigned int i = 0; i < pmtnum; ++i)
  {
    if(ptab[i].used == 1){
      if(ptab[i].type  == _PMTINCH20){
        wpnpmt++;
        pmtq = ptab[i].q;
        pmtfht = ptab[i].fht;
        vpos = ptab[i].pos;
        PmtPe.push_back(pmtq); 
        PmtPos.push_back(vpos);
        if(pmtq > PMTThreshold_pe && pmtfht<500){
          OptPmtPe.push_back(pmtq);
          OptPmtPos.push_back(vpos);
        }
        totalpe += pmtq;
      }
    }
  }
  LogDebug<<" Water pool npmts: "<<wpnpmt<<" fired !!!"<<std::endl;
  if(int(OptPmtPe.size()) < PMTThreshold_n){
    //CLHEP::HepLorentzVector start(0, 0, 0, -1); 
    //CLHEP::HepLorentzVector end(0, 0, 0, -1); 
    //JM::RecTrack* mtrk = new JM::RecTrack(start, end);
    //mtrk->setPESum(0);
    //mtrk->setQuality(0.);
    //rh->addTrack(mtrk);
    LogDebug<<" Can't select enough pmts: "<<OptPmtPe.size()<<" < "<<PMTThreshold_n<<" Npmt cut."<<std::endl;
    return true;
  }
  // gDirectory->Cd("Rint:/");
  // gROOT->cd();
  TSpectrum2 *spec2 = new TSpectrum2(maxpositions);
  TH2F* h_all1 = new TH2F("h_all1","",100,-70000,70000,100,-66000,35000); //all pmt pe that > pe threshold
  //project selected pmts on to theta phi plane
  for(unsigned int i = 0; i < OptPmtPe.size(); i++){
    double theta = OptPmtPos[i].Theta();
    double phi = OptPmtPos[i].Phi();
    double fillx= 0;
    double filly = 0;
    if(OptPmtPos[i].Z()>0){
      filly = RADIUS_BALL*(TMath::Pi()/2-theta);
      fillx = RADIUS_BALL*sin(theta)*phi;
      h_all1->Fill(fillx, filly, OptPmtPe[i]);
    }
    else if(OptPmtPos[i].Z()>-RADIUS_WALL+300){
      fillx = RADIUS_WALL*phi;
      filly = OptPmtPos[i].Z();
      h_all1->Fill(fillx, filly, OptPmtPe[i]);
    }
    else {
      fillx = OptPmtPos[i].X();
      filly = -44000 + OptPmtPos[i].Y();
      h_all1->Fill(fillx, filly, OptPmtPe[i]);
    }
  }
  //TSpectrum fit
  LogDebug<<" 1. fitting by TSpectrum2 ..."<<std::endl;
  int nAllxy = spec2->Search(h_all1,2,"noMarkov goff");
  float *xpeaks = spec2->GetPositionX();
  float *ypeaks = spec2->GetPositionY();
  double rectheta, recphi;
  double tx, ty, tz;
  for(int i=0; i<nAllxy; i++){
    if(ypeaks[i]>0) {
      rectheta = TMath::Pi()/2 - ypeaks[i]/RADIUS_BALL;
      if(rectheta < 0){ rectheta = TMath::Pi()/2.; }
      recphi = xpeaks[i]/(RADIUS_BALL*sin(rectheta));

      tx = RADIUS_BALL*sin(rectheta)*cos(recphi);
      ty = RADIUS_BALL*sin(rectheta)*sin(recphi);
      tz = RADIUS_BALL*cos(rectheta);
    }
    else if(ypeaks[i]>-RADIUS_WALL+300){
      recphi = xpeaks[i]/RADIUS_WALL;
      tx = RADIUS_WALL*cos(recphi);
      ty = RADIUS_WALL*sin(recphi);
      tz = ypeaks[i];
    }
    else{
      tx = xpeaks[i];
      ty = ypeaks[i] + 44000;
      tz = -RADIUS_WALL;
    }
    fitp.SetXYZ(tx,ty,tz);
    vfitp.push_back(fitp);
  }
  delete h_all1;
  delete spec2;

  for(int i =0; i<int(vfitp.size()); i++){
    LogDebug<<"  Fit point vfitp xyz: "<<i<<" : ("<<vfitp[i].X()<<", "<<vfitp[i].Y()<<", "<<vfitp[i].Z()<<")"<<std::endl;
  }

  if(nAllxy>0){
    //according fit points, see around all pe status 
    LogDebug<<" 2. According fit points, see around pe status ..."<<std::endl;
    int nFitp = nAllxy;
    int nerase = 0;
    for(int ip=0; ip<nAllxy; ip++){
      double  npe = 0;
      for(int i = 0; i < int(PmtPe.size()); i++){
        if(PmtPe[i] <= AroundPePlus_PeCut) continue;
        double  dis = (PmtPos[i]-vfitp[ip]).Mag();
        if(dis > AroundPePlus_DisCut) continue;
        npe += PmtPe[i];
      }
      if(npe > FitPointDiscard_PeCut){//if fit points pe is too low, discard it
        vpe_around.push_back(npe);
      }
      else{
        vfitp.erase(vfitp.begin() + ip - nerase);
        LogDebug<<"  MARK: this events around pe is smaller than "<<FitPointDiscard_PeCut<<" pe, so discard it."<<std::endl;
        nFitp --;
        nerase ++;
      }
    }
    //deal wall bottom corner events, if <3m dis, merge them, 
    LogDebug<<" 3.1 deal wall bottom corner events, if <"<<CornerMerge_DisCut<<" mm dis, merge them ..."<<std::endl;
    int vfitpL = vfitp.size();
    for(int ip = 0; ip < vfitpL-1; ip++){
      for(int jp = ip+1; jp < vfitpL; jp++){
        TVector3 vd = vfitp[ip] - vfitp[jp];
        if(vd.Mag() < CornerMerge_DisCut){
          if((vfitp[ip].Z()>-RADIUS_WALL + 0.1 && vfitp[jp].Z()<=-RADIUS_WALL + 0.1) ||(vfitp[ip].Z()<=-RADIUS_WALL + 0.1 &&       vfitp[jp].Z()>-RADIUS_WALL + 0.1)){
            LogDebug<<"  WARNING: Corner merge using, this 2 fit points is  too near: "<<vd.Mag()<<" mm"<<std::endl;
            int charge = vpe_around[ip] + vpe_around[jp];
            point = 1.*(vfitp[ip] * vpe_around[ip] + vfitp[jp] * vpe_around[jp])*(1./(vpe_around[ip] + vpe_around[jp]));
            vfitp.erase(vfitp.begin()+jp);//first erase the second point
            vfitp.erase(vfitp.begin()+ip);
            vfitp.push_back(point);
            vpe_around.erase(vpe_around.begin()+jp);
            vpe_around.erase(vpe_around.begin()+ip);
            vpe_around.push_back(charge);
            ip=0;
            jp=0;
            vfitpL = vfitp.size();
          }
        }
      }
    }
    //merge too near points   
    LogDebug<<"   3.2 deal too near events, if 2 points <"<<PointMerge_DisCut<<" mm merge them"<<std::endl;
    vfitpL = vfitp.size();
    for(int ip = 0; ip < vfitpL-1; ip++){
      for(int jp = ip+1; jp < vfitpL; jp++){
        TVector3 vd = vfitp[ip] - vfitp[jp];
        if(vd.Mag() < PointMerge_DisCut){
          LogDebug<<"  WARNING: this 2 fit points is  too near: "<<vd.Mag()<<" mm, "<<std::endl;
          double charge = vpe_around[ip] + vpe_around[jp];
          point = 1.*(vfitp[ip] * vpe_around[ip] + vfitp[jp] * vpe_around[jp])*(1./(vpe_around[ip] + vpe_around[jp]));
          vfitp.erase(vfitp.begin()+jp);
          vfitp.erase(vfitp.begin()+ip);
          vfitp.push_back(point);
          vpe_around.erase(vpe_around.begin()+jp);
          vpe_around.erase(vpe_around.begin()+ip);
          vpe_around.push_back(charge);
          ip=0;
          jp=0;
          vfitpL = vfitp.size();
        }
      }
    }

    for(int i=0; i<vfitp.size(); i++){
      LogDebug<<"  After selection, vfitp left: "<<vfitp.size()<<" points, i "<<i<<", xyz("<<vfitp[i].X()<<" "<<vfitp[i].Y()<<" "<<vfitp[i].Z()<<"), pe_around: "<<vpe_around[i]<<std::endl;
    }

    //rec fitting points by charge weighted ...
    nFitp = vfitp.size();
    LogDebug<<"  fitting points left finally: "<<nFitp<<std::endl;
    LogDebug<<" 4. rec fitting points by charge weighted ... "<<std::endl;
    for(int j = 0; j < nFitp; j++){//here can not used vfitp.size() instead nFitp
      int maxpos = max_element(vpe_around.begin(), vpe_around.end()) - vpe_around.begin();
      vtmp = vfitp[maxpos];
      vpe_around.erase(vpe_around.begin()+maxpos);
      vfitp.erase(vfitp.begin()+maxpos);

      double rec_x_tmp = 0;
      double rec_y_tmp = 0;
      double rec_z_tmp = 0;
      double npe_tmp = 0;

      //rec in point
      for(unsigned int i = 0; i < PmtPe.size(); i++){
        if(PmtPe[i] <= rec_pecut) continue;
        double  dis = (PmtPos[i] - vtmp).Mag();
        if(dis > rec_discut) continue;
        rec_x_tmp += PmtPos[i].X() * PmtPe[i];
        rec_y_tmp += PmtPos[i].Y() * PmtPe[i];
        rec_z_tmp += PmtPos[i].Z() * PmtPe[i];
        npe_tmp += PmtPe[i];
      }

      if(npe_tmp >0){
        rec_x_tmp /= npe_tmp;
        rec_y_tmp /= npe_tmp;
        rec_z_tmp /= npe_tmp;
        point.SetXYZ(rec_x_tmp, rec_y_tmp, rec_z_tmp);
        qwpoints.push_back(point);
      }
    }

    //check repeat same rec points, since large distance cut
    if(qwpoints.size()>=2){
      for(int ic =0; ic<int(qwpoints.size())-1; ic++){
        for(int id=ic+1; id<int(qwpoints.size()); ) {
          X1 = qwpoints[ic];
          X2 = qwpoints[id];
          if((X1-X2).Mag()<0.01)
            qwpoints.erase(qwpoints.begin()+id);
          else id++;
        }
      }
    }


    //sorting from +Z -> -Z 
    int nsize = int(qwpoints.size())-1;
    for(int j=0;j<nsize;j++){
      for(int i=0;i<nsize-j;i++){
        if(qwpoints[i].Z()<qwpoints[i+1].Z()){
          std::swap(qwpoints[i],qwpoints[i+1]);
        }
      }
    }

    for(int i=0; i<int(qwpoints.size()); i++){
      LogDebug<<" 5. Rec points size: "<<qwpoints.size()<<", i: "<<i<<", xyz: "<<qwpoints[i].X()<<", "<<qwpoints[i].Y()<<", "<<qwpoints[i].Z()<<")"<<std::endl;
    }

    LogDebug<<" 6. Parallel tracks finding ..."<<std::endl;
    //find parallel tracks
    int np = qwpoints.size();
    int nlines = np/2;
    int temp_c = 0;
    int mark[6] = {0,0,0,0,0,0};
    double minangle = 10000;
    LogDebug<<" np= "<<np<<", nlines= "<<nlines<<std::endl;
    if(nlines==0 && np==1) {;}
    if(nlines == 1){//2-3 points
      mark[0] = 0;
      mark[1] = int(qwpoints.size())-1;
    }
    else if(nlines == 2){ //4-5 points
      if(np>3){
        for(int i=0; i<np-3; i++){
          for(int j = i+1; j<np; j++){
            for(int k = i+1; k<np-1; k++){
              if(k==j) continue;
              for(int l=k+1; l<np; l++){
                if(l==j) continue;
                line1 = qwpoints[j] - qwpoints[i];
                line2 = qwpoints[l] - qwpoints[k];
                double angle = line1.Angle(line2);
                if(angle<minangle){
                  minangle = angle;
                  mark[0] = i;
                  mark[1] = j;
                  mark[2] = k;
                  mark[3] = l;
                }
                temp_c++;
              }
            }
          }
        }
      }
    }
    else if(nlines==3){//6-7 points
      if(np>5){
        for(int i=0; i<np-5; i++){
          for(int j = i+1; j<np; j++){
            for(int k = i+1; k<np-3; k++){
              if(k==j) continue;
              for(int l=k+1; l<np; l++){
                if(l==j) continue;
                for(int p=k+1; p<np-1; p++){
                  if(p==j || p==l ) continue;
                  for(int q = p+1; q<np; q++ ){
                    if(q==j || q==l) continue;
                    temp_c++;
                    line1 = qwpoints[j] - qwpoints[i];
                    line2 = qwpoints[l] - qwpoints[k];
                    line3 = qwpoints[q] - qwpoints[p];
                    double angle1 = line1.Angle(line2);
                    double angle2 = line1.Angle(line3);
                    double angle3 = line2.Angle(line3);
                    if(angle1 + angle2 + angle3 < minangle){
                      minangle = angle1 + angle2 + angle3;
                      mark[0] = i;
                      mark[1] = j;
                      mark[2] = k;
                      mark[3] = l;
                      mark[4] = p;
                      mark[5] = q;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    LogDebug<<" 7. reconed points by charge center is not on the pmt surface, need re-calculate it again ..."<<std::endl;
    for(int ir =0; ir< nlines; ir++){
      rectracks.clear();
      trackL = 0;
      vpos = qwpoints[mark[ir*2]];
      dir = qwpoints[mark[ir*2+1]] - qwpoints[mark[ir*2]];
      dir.SetMag(1.);
      X1.SetXYZ(0,0,0);
      X2.SetXYZ(0,0,0);
      trackL = hitSphereAll(RADIUS_BALL, center, vpos, dir, X1, X2);
      if(trackL > 0){
        if(X1.Z() > 0)
          rectracks.push_back(X1);
        if(X2.Z() > 0)
          rectracks.push_back(X2);
      }
      trackLcyl =0;
      X1cyl.SetXYZ(0,0,0);
      X2cyl.SetXYZ(0,0,0);
      trackLcyl = hitCylinderAll(RADIUS_WALL, RADIUS_WALL*2,  centercyl, vpos, dir, X1cyl, X2cyl);
      if(trackLcyl>0){
        if(X1cyl.Z()>-0.1){
          if(sqrt(X1cyl.X()*X1cyl.X() +X1cyl.Y()*X1cyl.Y()) > RADIUS_BALL) //hit middle of water pool around side
            rectracks.push_back(X1cyl);
        }
        if(X1cyl.Z()<-0.1 &&  X1cyl.Z() > -RADIUS_WALL+0.1){
          rectracks.push_back(X1cyl);
        }
        if(X2cyl.Z()<-0.1 &&  X2cyl.Z() > -RADIUS_WALL+0.1){
          rectracks.push_back(X2cyl);
        }
        else if( X2cyl.Z() <= -RADIUS_WALL+0.1){
          rectracks.push_back(X2cyl);
        }
      }
      if(rectracks.size()>=2) {
        int itrk = int(rectracks.size())-1;
        vrec_in.push_back(rectracks[0]);
        vrec_out.push_back(rectracks[itrk]);
      }
    }
    //sorting rec points from +Z -> -Z 
    int rsize = int(vrec_in.size())-1;
    for(int j=0;j<rsize;j++){
      for(int i=0;i<rsize-j;i++){
        if(vrec_in[i].Z()<vrec_in[i+1].Z()){
          std::swap(vrec_in[i],vrec_in[i+1]);
          std::swap(vrec_out[i],vrec_out[i+1]);
        }
      }
    }
    //add tracks
    for(unsigned int i=0; i<vrec_in.size(); i++){
      CLHEP::HepLorentzVector start(vrec_in[i].X(), vrec_in[i].Y(), vrec_in[i].Z(), -1);
      CLHEP::HepLorentzVector end(vrec_out[i].X(), vrec_out[i].Y(), vrec_out[i].Z(), -1);
      JM::RecTrack* mtrk = new JM::RecTrack(start, end);
      mtrk->setPESum(totalpe);
      mtrk->setQuality(1);
      evt->addTrack(mtrk);
      LogDebug << "add reconstructed track point in xyz: "<<vrec_in[i].X()<<", "<<vrec_in[i].Y()<<", "<<vrec_in[i].Z()<<std::endl;
      LogDebug << "add reconstructed track point out xyz: "<<vrec_out[i].X()<<", "<<vrec_out[i].Y()<<", "<<vrec_out[i].Z()<<std::endl;

    }

  }
  else {
    //can not fit any points
    //CLHEP::HepLorentzVector start(0, 0, 0, -1); 
    //CLHEP::HepLorentzVector end(0, 0, 0, -1); 
    //JM::RecTrack* mtrk = new JM::RecTrack(start, end);
    //mtrk->setPESum(0);
    //mtrk->setQuality(0.);
    //rh->addTrack(mtrk);
    LogDebug<<" TSpectrum2 can not fit anly point, so none track added"<<std::endl;
  }

  rh->setWPEvent(evt);

  LogDebug << "------------------------------" << std::endl;
  return true;
}
std::ostream& operator << (std::ostream& s, const TVector3& v)
{
  s  <<  "("  <<  v.x()  <<  ", "  <<  v.y()  <<  ", "  <<  v.z()  <<  ")"; 
  return s; 
}

double PoolMuonRecTool::hitSphereAll(double tarR, TVector3 &center, TVector3 &vpos, TVector3 &dir, TVector3 &X1, TVector3 &X2){
  double R = tarR;
  double trackL = 0.;
  double x1=0., y1=0.,z1=0., x2=0., y2=0., z2=0.;
  double x0 = vpos.X(), y0 = vpos.Y(), z0 = vpos.Z();
  double px = dir.X(), py =dir.Y(), pz = dir.Z();
  double xc = center.X(), yc = center.Y(), zc = center.Z();
  double a = px*px + py*py + pz*pz;
  double b = 2*(px*(x0-xc) + py*(y0-yc) + pz*(z0-zc));
  double c = (x0-xc)*(x0-xc) + (y0-yc)*(y0-yc) + (z0-zc)*(z0-zc) - R*R;
  double delta = b*b - 4*a*c;
  //std::cout<<" delta: "<<delta<<std::endl;
  double k1=0, k2=0;
  //if(pz > 0){ std::cout<<"WARNING: muon up going!! pz >= 0: "<<pz<<std::endl; }
  //if(pz == 0){ std::cout<<"WARNING: muon flat going!! pz == 0: "<<pz<<std::endl;}
  if (delta < 0) {trackL = 0; x1 = 0.; y1 = 0.; z1 = 0.; x2 = 0.; y2 = 0.; z2 = 0.; //std::cout<<" delta < 0"<<std::endl;
  }
  else if(delta == 0){//tangency with sphere
    k1 = -b/(2*a);
    x1 = px * k1 + x0;
    y1 = py * k1 + y0;
    z1 = pz * k1 + z0;
    x2 = x1; y2 = y1; z2 = z1;
    trackL = 0;
    //std::cout<<" delta = 0 "<<std::endl;
  }
  else{ //delta > 0
    k1 = (-b + sqrt(delta))/(2*a);
    k2 = (-b - sqrt(delta))/(2*a);
    z1 = pz * k1 + z0;
    z2 = pz * k2 + z0;
    if(z1<z2){ double kk = k1; k1 = k2; k2 = kk; }

    x1 = px * k1 + x0;
    y1 = py * k1 + y0;
    z1 = pz * k1 + z0;
    x2 = px * k2 + x0;
    y2 = py * k2 + y0;
    z2 = pz * k2 + z0;

    trackL = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2));
  }

  X1.SetXYZ(x1, y1, z1);
  X2.SetXYZ(x2, y2, z2);
  //  std::cout<<" track L in sphere: "<<trackL<<std::endl;
  //  std::cout<<" hit points: xyz1: ("<<x1<<", "<<y1<<", "<<z1<<")"<<std::endl;
  //  std::cout<<" hit points: xyz2: ("<<x2<<", "<<y2<<", "<<z2<<")"<<std::endl;
  return trackL;
}


double PoolMuonRecTool::hitCylinderAll(double tarH, double tarD, TVector3 &centercyl, TVector3 &vpos, TVector3 &dir, TVector3 &X1cyl, TVector3 &X2cyl){
  double R = tarD/2.;
  double trackL = 0.;
  double x1=0., y1=0.,z1=0., x2=0., y2=0., z2=0.;
  double x0=vpos.X(), y0=vpos.Y(), z0=vpos.Z();
  double px = dir.X(), py =dir.Y(), pz = dir.Z();
  double xc = centercyl.X(), yc = centercyl.Y(), zc = centercyl.Z();
  double a = px * px + py * py;
  double b = 2*((x0-xc) * px + (y0-yc) * py);
  double c = (x0-xc) * (x0-xc) + (y0-yc) * (y0-yc) - R * R;
  double delta = b*b - 4*a*c;
  //std::cout<<" delta: "<<delta<<std::endl;
  double k1=0, k2;
  //  if(pz > 0){ std::cout<<"WARNING: muon up going!! pz >= 0: "<<pz<<std::endl; }
  //  if(pz == 0){ std::cout<<"WARNING: muon flat going!! pz == 0: "<<pz<<std::endl;}
  //vertical muon
  if(px == 0 && py == 0){
    if((x0-xc) * (x0-xc) + (y0-yc) * (y0-yc) <= R * R){
      trackL = tarH; x1 = x0; y1 = y0; z1 = tarH/2. + zc; x2 = x0;y2 = y0; z2 = -tarH/2. + zc;
      //std::cout<<" Vertical muon! Hit bottom and top of cylinder"<<std::endl;
    }
    else{ trackL = 0; 
      //std::cout<<"WARNING: vetical muon hit outer side!"<<std::endl;
    }
  }
  //slope muon
  else {
    //delta < 0, no hit with cylinder
    if (delta < 0) {trackL = 0; x1 = 0.; y1 = 0.; z1 = 0.; x2 = 0.; y2 = 0.; z2 = 0.;
      //std::cout<<" Delta < 0, no hit with cylinder"<<std::endl;
    }
    else if(delta == 0){//tangency with cylinder
      k1 = - b /(2*a);
      trackL = 0;
      if(fabs(pz * k1 + z0 - zc) > tarH/2.){//tangency at outer cylinder
        x1 = 0.; y1 = 0.; z1 = 0.; x2 = 0.; y2 = 0.; z2 = 0.;
        //std::cout<<" Tangency at outer cylinder "<<std::endl;
      }
      else{
        x1 = px * k1 + x0;
        y1 = py * k1 + y0;
        z1 = pz * k1 + z0;
        x2 = x1; y2 = y1; z2 = z1;
        //std::cout<<" line tangency with cylinder! x1=x2, y1=y2;"<<std::endl;
      }
    }
    else{ //delta > 0
      k1 = (- b - sqrt(delta)) / (2 * a);
      k2 = (- b + sqrt(delta)) / (2 * a);
      z1 = pz * k1 + z0;
      z2 = pz * k2 + z0;
      if(z1<z2){ double kk = k1; k1 = k2; k2 = kk; kk = z1; z1 = z2; z2 = kk;}
      if(fabs(z1-zc) > tarH/2.) { //upper root hit top
        x1 = (tarH/2. + zc - z0) * px / pz + x0;
        y1 = (tarH/2. + zc - z0) * py / pz + y0;
        z1 = tarH/2. + zc;
        //std::cout<<"upper Hit top "<<std::endl;
      }
      else{//hit side wall
        x1 = px * k1 + x0;
        y1 = py * k1 + y0;
        z1 = pz * k1 + z0;
        //std::cout<<"upper Hit side wall"<<std::endl;
      }
      if(fabs(z2-zc) > tarH/2.){//down root hit btm
        x2 = (-tarH/2. + zc - z0) * px / pz + x0;
        y2 = (-tarH/2. + zc - z0) * py / pz + y0;
        z2 = -tarH/2. + zc;
        //std::cout<<"down Hit btm "<<std::endl;
      }
      else{//hit side wall
        x2 = px * k2 + x0;
        y2 = py * k2 + y0;
        z2 = pz * k2 + z0;
        //std::cout<<"down Hit side wall "<<std::endl;
      }
      if((x1-xc) * (x1-xc) + (y1-yc) * (y1-yc) > R * R + 0.01) { trackL = 0; x1 = 0; y1 = 0; z1 = 0;}
      if((x2-xc) * (x2-xc) + (y2-yc) * (y2-yc) > R * R + 0.01) { trackL = 0; x2 = 0; y2 = 0; z2 = 0;}
      if(((x1-xc) * (x1-xc) + (y1-yc) * (y1-yc) <= R * R  + 0.001) && ((x2-xc) * (x2-xc) + (y2-yc) * (y2-yc) <= R * R + 0.001)){
        trackL = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2));
      }
      else {trackL = 0;}
    }

  }
  //if(trackL <=0){std::cout<<" Line no hit with cylinder!"<<std::endl;}
  X1cyl.SetXYZ(x1,y1,z1);
  X2cyl.SetXYZ(x2,y2,z2);
  //std::cout<<" track L in cylinder: "<<trackL<<std::endl;
  //std::cout<<" hit points: xyz1: ("<<x1<<", "<<y1<<", "<<z1<<")"<<std::endl;
  //std::cout<<" hit points: xyz2: ("<<x2<<", "<<y2<<", "<<z2<<")"<<std::endl;
  return trackL;
}



