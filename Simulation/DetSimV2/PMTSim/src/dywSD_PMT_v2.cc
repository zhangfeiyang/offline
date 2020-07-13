//--------------------------------------------------------------------------
//                            dywSD_PMT_v2
//
// PMTs are difined as sensitive detector. They collect hits on them.
// The data members of hits are set up here using the information of G4Step.
// -------------------------------------------------------------------------
// Author: Liang Zhan, 2006/01/27
// Modified by: Weili Zhong, 2006/03/01
// -------------------------------------------------------------------------

#include "dywSD_PMT_v2.hh"
#include "dywHit_PMT.hh"
#include "G4Step.hh"
#include "G4HCofThisEvent.hh"
#include "G4Track.hh"
#include "G4SDManager.hh"
#include "G4UnitsTable.hh"
#include <cassert>
#include "NormalTrackInfo.hh"
#include "G4OpticalPhoton.hh"
#include "Randomize.hh"
#include "G4DataInterpolation.hh"

////////////////////////////////////////////////////////////////////////////////

dywSD_PMT_v2::dywSD_PMT_v2(const std::string& name)
:G4VSensitiveDetector(name),hitCollection(0), hitCollection_muon(0)
{
    G4String HCname;
    collectionName.insert(HCname="hitCollection");
    collectionName.insert(HCname="hitCollectionMuon");

    m_debug = true;
    m_time_window = 1; // 1ns

    m_pmthitmerger = 0;

    m_hit_type = 1; // 1 for normal, 2 for muon

    m_ce_flat_value = 0.9;

    MCP20inch_m_ce_flat_value = 0.85;
    MCP8inch_m_ce_flat_value = 0.85;
    Ham20inch_m_ce_flat_value = 0.95;
    Ham8inch_m_ce_flat_value = 0.7;
    HZC9inch_m_ce_flat_value = 0.67;

    MCP20inch_m_EAR_value = 1.;
    MCP8inch_m_EAR_value = 1.;
    Ham20inch_m_EAR_value = 0.93;
    Ham8inch_m_EAR_value = 0.88;
    HZC9inch_m_EAR_value = 0.92;

    m_disable = false;
    // 20inchfunc (1D)
    // FIXME: following are not used in current code
    m_ce_func_str = "0.9*[0]/(1+[1]*exp(-[2]*x))";
    m_ce_func_params.push_back(1.006); // p0
    m_ce_func_params.push_back(0.9023);// p1
    m_ce_func_params.push_back(0.1273);// p2

    m_ce_func = 0;
}

dywSD_PMT_v2::~dywSD_PMT_v2()
{;}

void dywSD_PMT_v2::Initialize(G4HCofThisEvent *HCE)
{
    if (m_debug) {
        G4cout << "dywSD_PMT_v2::Initialize" << G4endl;
    }
    hitCollection = new dywHit_PMT_Collection(SensitiveDetectorName,collectionName[0]);
    hitCollection_muon = new dywHit_PMT_muon_Collection(SensitiveDetectorName,collectionName[1]);

    // changed from a static variable to a normal variable by Jillings, August 2, 2006
    int HCID = -1;
    if(HCID<0) HCID = G4SDManager::GetSDMpointer()->GetCollectionID(hitCollection);
    HCE->AddHitsCollection( HCID, hitCollection ); 

    HCID = -1;
    if(HCID<0) HCID = G4SDManager::GetSDMpointer()->GetCollectionID(hitCollection_muon);
    HCE->AddHitsCollection( HCID, hitCollection_muon ); 

    m_pmtid2idincol.clear();
    assert( m_pmtid2idincol.size() == 0 );

    if (m_pmthitmerger) {
        if (m_hit_type == 1) {
            m_pmthitmerger->init(hitCollection);
        } else if (m_hit_type == 2) {
            // TODO
            m_pmthitmerger->init(hitCollection_muon);
        } else {
            G4cout << "unknown hit type [" << m_hit_type << "]" << G4endl;
        }
    }
    // make sure the PMT merger exists.
    assert(m_pmthitmerger);
}

G4bool dywSD_PMT_v2::ProcessHits(G4Step * step,G4TouchableHistory*)
{
    if (m_disable) {
        return false;
    }
    // TODO: now it only support the single PE.
    // = only accept the optical photon
    G4Track* track = step->GetTrack();
    if (track->GetDefinition() != G4OpticalPhoton::Definition()) {
        return false;
    }
    G4StepPoint* preStepPoint = step->GetPreStepPoint();
    G4StepPoint* postStepPoint = step->GetPostStepPoint();
    double edep = step->GetTotalEnergyDeposit();
    // = only when the photon is detected by the surface, the edep is non-zero.
    // = the QE is already applied in the OpBoundaryProcess::DoAbsorption
    if (edep<=0.0) {
        return false;
    }
    // TODO: get CE and angle response from data.
    // = decide the CE (collection efficiency)
    // = the CE can be different at different position
    // == volume name
    std::string volname = track->GetVolume()->GetName(); // physical volume
    // == position
    const G4AffineTransform& trans = track->GetTouchable()->GetHistory()->GetTopTransform();
    const G4ThreeVector& global_pos = postStepPoint->GetPosition();
    G4ThreeVector local_pos = trans.TransformPoint(global_pos);
    // LT
    if (0) {
    std::cout << "DEBUG volname: " 
              << volname
              << " pre/post: "
              << preStepPoint->GetPhysicalVolume()->GetName() << "/"
              << postStepPoint->GetPhysicalVolume()->GetName()
              << " t: "
              << preStepPoint->GetGlobalTime() << "/"
              << postStepPoint->GetGlobalTime()
              << " pos: (" 
              << local_pos.x() << ", "
              << local_pos.y() << ", "
              << local_pos.z() << ") "
              << "r: " << sqrt(local_pos.x()*local_pos.x() + local_pos.y()*local_pos.y())
              << std::endl;
    }
    double ce = get_ce(volname, local_pos);
    double f_angle_response = 1.0;
    // = final DE = QE * CE, but QE is already applied, so only CE is important.
    // = DE: Detection Efficiency
    double de = ce*f_angle_response;

    if (G4UniformRand() > de) {
        return false;
    }
    // ========================================================================
    // create the transient PMT Hit Object
    // ========================================================================
    // == get the copy number -> pmt id
    int pmtid = get_pmtid(track);
    // == hit time
    double hittime = postStepPoint->GetGlobalTime();
    // == momentum and polarization
    G4ThreeVector local_pol = trans.TransformAxis(track->GetPolarization());
    local_pol = local_pol.unit();
    G4ThreeVector local_dir = trans.TransformAxis(track->GetMomentum());
    local_dir = local_dir.unit();
    // == wavelength 
    double wavelength = twopi*hbarc / edep;
    // == additional information from User Track information
    int producerID = -1;
    bool is_from_cerenkov = false;
    bool is_reemission = false;
    bool is_original_op = false;
    double t_start = 0;
    G4ThreeVector boundary_pos;
    G4VUserTrackInformation* trkinfo = track->GetUserInformation();
    if (trkinfo) {
        NormalTrackInfo* normaltrk = dynamic_cast<NormalTrackInfo*>(trkinfo);
        if (normaltrk) {
            producerID = normaltrk->GetOriginalTrackID();
            is_from_cerenkov = normaltrk->isFromCerenkov();
            is_reemission = normaltrk->isReemission();

            t_start = normaltrk->getOriginalOPStartTime();

            is_original_op = normaltrk->isOriginalOP();
            boundary_pos = normaltrk->getBoundaryPos();
        }
    }
    // ========================================================================
    // Save the Hit into hit collection
    // * without merge
    // * with merge
    //   + This is for the muon simulation or some events with a lot of hits
    //   + some values can't merge.
    //   + the flags such as producerID, is from cerenkov, is from scintillation,
    //     is reemission, is original op will be not right
    // ========================================================================
    // = check the merge flag first
    if (m_pmthitmerger and m_pmthitmerger->getMergeFlag()) {
        // == if merged, just return true. That means just update the hit
        // NOTE: only the time and count will be update here, the others 
        //       will not filled.
        bool ok = m_pmthitmerger->doMerge(pmtid, hittime);
        if (ok) {
            return true;
        }
    }
    // = save the hit in the collection
    if (m_hit_type == 1) {
        dywHit_PMT* hit_photon = new dywHit_PMT();
        hit_photon->SetPMTID(pmtid);
        hit_photon->SetWeight(1.0);
        hit_photon->SetTime(hittime);
        hit_photon->SetWavelength(wavelength);
        hit_photon->SetKineticEnergy(edep);
        hit_photon->SetPosition(local_pos);
        hit_photon->SetMomentum(local_dir); 
        hit_photon->SetPolarization(local_pol); 

        hit_photon->SetGlobalPosition(global_pos);
        hit_photon->SetGlobalMomentum(track->GetMomentum()); 
        hit_photon->SetGlobalPolarization(track->GetPolarization()); 

        hit_photon->SetCount(1); // FIXME

        hit_photon->SetProducerID(producerID);
        hit_photon->SetFromCerenkov(is_from_cerenkov);
        hit_photon->SetReemission(is_reemission);
        hit_photon->SetOriginalOP(is_original_op);
        hit_photon->SetOriginalOPStartT(t_start);
        hit_photon->SetBoundaryPosition(boundary_pos);
        // == insert
        if (m_pmthitmerger) {
            m_pmthitmerger->saveHit(hit_photon);
        }
    } else if (m_hit_type == 2) {
        // save the muon only
        dywHit_PMT_muon* hit_photon = new dywHit_PMT_muon();
        hit_photon->SetPMTID(pmtid);
        hit_photon->SetTime(hittime);
        hit_photon->SetCount(1); // FIXME
        if (m_pmthitmerger) {
            m_pmthitmerger->saveHit(hit_photon);
        }
    } else {

    }
    return true;  
}

void dywSD_PMT_v2::EndOfEvent(G4HCofThisEvent*){
    if (m_debug) {
        G4cout << "dywSD_PMT_v2::EndOfEvent" << G4endl;
    }
}

void dywSD_PMT_v2::clear(){}

void dywSD_PMT_v2::DrawAll(){} 

void dywSD_PMT_v2::PrintAll(){} 

void dywSD_PMT_v2::SimpleHit(const ParamsForSD_PMT&){}

int dywSD_PMT_v2::get_pmtid(G4Track* track) {
    int ipmt= -1;
    // find which pmt we are in
    // The following doesn't work anymore (due to new geometry optimization?)
    //  ipmt=fastTrack.GetEnvelopePhysicalVolume()->GetMother()->GetCopyNo();
    // so we do this:
    {
        const G4VTouchable* touch= track->GetTouchable();
        int nd= touch->GetHistoryDepth();
        int id=0;
        for (id=0; id<nd; id++) {
            if (touch->GetVolume(id)==track->GetVolume()) {
                int idid=1;
                G4VPhysicalVolume* tmp_pv=NULL;
                for (idid=1; idid < (nd-id); ++idid) {
                    tmp_pv = touch->GetVolume(id+idid);

                    G4LogicalVolume* mother_vol = tmp_pv->GetLogicalVolume();
                    G4LogicalVolume* daughter_vol = touch->GetVolume(id+idid-1)->
                        GetLogicalVolume();
                    int no_daugh = mother_vol -> GetNoDaughters();
                    if (no_daugh > 1) {
                        int count = 0;
                        for (int i=0; (count<2) &&(i < no_daugh); ++i) {
                            if (daughter_vol->GetName()
                                    ==mother_vol->GetDaughter(i)->GetLogicalVolume()->GetName()) {
                                ++count;
                            }
                        }
                        if (count > 1) {
                            break;
                        }
                    }
                    // continue to find
                }
                ipmt= touch->GetReplicaNumber(id+idid-1);
                break;
            }
        }
        if (ipmt < 0) {
            G4Exception("dywPMTOpticalModel: could not find envelope -- where am I !?!", // issue
                    "", //Error Code
                    FatalException, // severity
                    "");
        }
    }

    return ipmt;
}

// ============================================================================
// = Collection Efficiency Related
// ============================================================================
// == change the Collection Efficiency Mode
void dywSD_PMT_v2::setCEMode(const std::string& mode) {
    m_ce_mode = mode;
}

// == get the Collection Efficiency 
double dywSD_PMT_v2::get_ce(const std::string& volname, const G4ThreeVector& localpos) {
    // volname:
    // * PMT_20inch_body_phys
    // * PMT_3inch_body_phys
    if (m_ce_mode == "None") {
        return 1.0;
    } else if (m_ce_mode == "20inch") {
        // only 20inch PMT will be affected
        // G4cout << volname << G4endl;
        if (volname == "PMT_20inch_body_phys") {
            // calculate the angle theta
            double theta = localpos.theta();
            // do interpolate
            static double s_theta[] = {
                0.*deg, 9.*deg, 18.*deg, 27.*deg, 36.*deg, 45.*deg,
                54.*deg, 63.*deg, 72.*deg, 81.*deg, 90.*deg,
            };
            static double s_ce[] =    { 
                0.8,    0.98,   0.9,     0.87,    0.97,    0.93,    
                1.0,     0.77,    0.79,    0.33,    0.
            };
            static G4DataInterpolation s_di(s_theta, s_ce, 11, 0., 0.);
            return s_di.CubicSplineInterpolation(theta);
        }
    } else if (m_ce_mode == "20inchflat"){
        // This is a flat mode which means no matter where the photon
        // hits, use the same CE.
        if (volname == "PMT_20inch_body_phys") {
            // FIXME It's a fixed number here, we can make it a variable
            // if it is needed to be modified.
            // -- 2015.10.10 Tao Lin <lintao@ihep.ac.cn>
            static double mean_val = m_ce_flat_value;
            return mean_val;
        }
    }else if (m_ce_mode == "flat"){
        // This is a flat mode which means no matter where the photon
        // hits, use the same CE.
        // G4cout << "PMT volume name : "<<volname << G4endl;
        if (volname == "R12860TorusPMTManager_body_phys") {
            // FIXME It's a fixed number here, we can make it a variable
            // if it is needed to be modified.
            static double Ham20inch_R12860_mean_val = Ham20inch_m_ce_flat_value*Ham20inch_m_EAR_value;
            return Ham20inch_R12860_mean_val;
        }
        else if (volname == "MCP20inchPMTManager_body_phys") {
            // FIXME It's a fixed number here, we can make it a variable
            // if it is needed to be modified.
            static double MCP20inch_mean_val = MCP20inch_m_ce_flat_value*MCP20inch_m_EAR_value;
            return MCP20inch_mean_val;
        }
        else if (volname == "Ham8inchPMTManager_body_phys") {
            // FIXME It's a fixed number here, we can make it a variable
            // if it is needed to be modified.
            static double Ham8inch_mean_val = Ham8inch_m_ce_flat_value*Ham8inch_m_EAR_value;
            return Ham8inch_mean_val;
        }
        else if (volname == "MCP8inchPMTManager_body_phys") {
            // FIXME It's a fixed number here, we can make it a variable
            // if it is needed to be modified.
            static double MCP8inch_mean_val = MCP8inch_m_ce_flat_value*MCP8inch_m_EAR_value;
            return MCP8inch_mean_val;
        }
        else if (volname == "HZC9inchPMTManager_body_phys") {
            // FIXME It's a fixed number here, we can make it a variable
            // if it is needed to be modified.
            static double HZC9inch_mean_val = HZC9inch_m_ce_flat_value*HZC9inch_m_EAR_value;
            return HZC9inch_mean_val;
        }
    }else if (m_ce_mode == "20inchfunc") {
        // In this mode, user needs to input:
        // 1. a function, which can be interpret by ROOT TF1.
        // 2. a list of parameters
        if (!m_ce_func) {
            G4cout << "WARNING: The CE Function is not defined." << G4endl;
            assert(m_ce_func);
        }
        // calculate the angle theta
        double theta = localpos.theta(); // unit: radians
        if (theta>CLHEP::halfpi) { theta = CLHEP::halfpi; }
        // convert angle
        // NOTE: the angle needs to be converted
        // 1. pi/2-theta
        // 2. radian -> degree
        theta = (CLHEP::halfpi-theta)/degree;
        return m_ce_func->Eval(theta);
    } else {
        G4cout << "WARNING: unknown CE mode " << m_ce_mode << G4endl;
    }

    return 1.0;
}

void
dywSD_PMT_v2::setCEFunc(const std::string& func, const std::vector<double>& param)
{
    // detele origial function
    if (m_ce_func) {
        delete m_ce_func;
        m_ce_func = 0;
    }

    // Info:
    std::cout << "Following is the CE Function detail:" << std::endl;
    std::cout << "CE Function: " << func << std::endl;
    // angle from 0 to 90 deg.
    // angle is from equator
    m_ce_func = new TF1("ce", func.c_str(), 0, 90);
    std::cout << "CE Params: ";
    for (size_t i = 0; i < param.size(); ++i) {
        std::cout << param[i] << " "; 
        m_ce_func->SetParameter(i, param[i]);
    }
    std::cout << std::endl;
}
