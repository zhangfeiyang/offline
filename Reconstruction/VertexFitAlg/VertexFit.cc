#include "VertexFit.h"
#include "TTree.h"
#include "TMath.h"
#include <iterator>
#include <TCanvas.h>
#include <TH1F.h>
#include <TFile.h>
#include <TString.h>
#include <TRandom.h>
#include "Hit.h"
#include <iostream>
#include <string>

using namespace std;

bool SortByhitTime(const Hit& hit1, const Hit& hit2){
    return hit1.hitTime() < hit2.hitTime();
}  // the sort function can not in a class 




int main(int argc, char*argv[]){

    m_pmt_num = 17746;
    SPEED_LS = 5.143;  // unit: ns/m
    SPEED_BUFFER = 4.5;//3.0;
    m_pmt_center_r = 19.5; //m
    m_pmt_r = 0.254;
    m_pmt_front_r = m_pmt_center_r - m_pmt_r;
    m_ls_r = 17.7;  

    m_scan_time_window =1000; //ns

    PE_Num_per_1MeV = 1200; //1MeV correspond to 1200 pe

    string input_file_name = argv[1];
    energy_cut = atof(argv[2]) * PE_Num_per_1MeV; //pe number
    cout<<"energy cut: " <<energy_cut<<" pe"<<endl;


    load_root_data(input_file_name); 
    load_PMT_position_data("PMT_position.root");

    load_edep_position_data(input_file_name);//because we have different version root,so the edep position label are different. we need different function to give options. 

    get_zone_vertex();
    get_pmt_position();
    get_TOF_table();




    //loop event
    int nEntries = t_evt->GetEntries();
    //int nEntries = 10;
    cout<<"nEntries: " <<nEntries<<endl;

    int EvtNum=0;

    for(int evtID=0; evtID<nEntries; evtID++){
        t_evt->GetEntry(evtID);

        cout<<"evtID: "<<evtID<<endl;

        if(m_nPhotons > energy_cut){


            //find_firstHitTime_in_one_evt(); //just for supernova event,because this event every hitTime is true time, we need relative time

            initial_before_each_evt_begin();
            Add_Dark_Noise(); //put into both corrected and not corrected vector

            get_PMT_first_hitTime_Collection();

            get_firstHitTime_corrected_Hit_Collection(); //correct each pmt's first hitTime

            //  get_corrected_Hit_Collection();   //correct Hit and put it into vector, darks not be corrected

            find_maxPmtNum_with_corrected();


            cout<<"nPhotons: " <<m_nPhotons<<endl;

            EvtNum++;



            //   break;
        }


    }

    cout<<"EvtNum when m_nPhotons>120: "<< EvtNum<<endl;

}


void load_root_data(string input_file_name){

    TFile* f1 = TFile::Open(input_file_name.c_str());
    t_evt = (TTree*)f1->Get("evt");

    t_evt->SetBranchAddress("pmtID", m_pmtID);
    t_evt->SetBranchAddress("nPhotons", &m_nPhotons);
    t_evt->SetBranchAddress("hitTime", m_hitTime); //you must chech the VertexFit.c, double hitTime just for supernova.

}


void load_edep_position_data(string input_file_name){


    //t_evt->SetBranchAddress("edepX", &m_edepX);
    //t_evt->SetBranchAddress("edepY", &m_edepY);
    //t_evt->SetBranchAddress("edepZ", &m_edepZ);
    t_evt->SetBranchAddress("edep_pos_x", &m_edepX);
    t_evt->SetBranchAddress("edep_pos_y", &m_edepY);
    t_evt->SetBranchAddress("edep_pos_z", &m_edepZ);

}



void load_PMT_position_data(string pmt_position){

    TFile* f1 = TFile::Open(pmt_position.c_str());


    //load pmt information
    t_pmtInfo = (TTree*)f1->Get("pmtInfo");
    t_pmtInfo->SetBranchAddress("pmt_pos_x", &m_pmt_pos_x);
    t_pmtInfo->SetBranchAddress("pmt_pos_y", &m_pmt_pos_y);
    t_pmtInfo->SetBranchAddress("pmt_pos_z", &m_pmt_pos_z);


}





void get_zone_vertex(){
    double x=0;
    double y=0;
    double z=0;
    double R=0;
    int zone_id=0;

    for(int x_index=-3; x_index<=3; x_index++){
        for(int y_index=-3; y_index<=3; y_index++){
            for(int z_index=-3; z_index<=3; z_index++){
                x = x_index*5*1e3; //unit mm
                y = y_index*5*1e3;
                z = z_index*5*1e3;
                R=sqrt(pow(x,2)+pow(y,2)+pow(z,2));
                if(R<17.7*1e3){
                    zone_vertex[zone_id].SetX(x);
                    zone_vertex[zone_id].SetY(y);
                    zone_vertex[zone_id].SetZ(z);
                    //cout<<"zone x:"<<zone_vertex[zone_id].X()<<" zone y:"<<zone_vertex[zone_id].Y()<<" zone z:"<<zone_vertex[zone_id].Z()<<endl;
                    //cout<<"x:"<<x<<" y:"<<y<<" z:"<<z<<endl;
                    //cout<<"zone_id: "<<zone_id<<endl;
                    //cout<<"map size: " << zone_vertex.size()<<endl;
                    zone_id++;
                }
            }
        }
    }
    m_zone_num = zone_id;
    cout<<"zone num: "<<m_zone_num<<endl;
}


void get_pmt_position(){
    float x;
    float y;
    float z;


    for(int pmtID=0; pmtID<m_pmt_num; pmtID++){
        t_pmtInfo->GetEntry(pmtID);
        x=m_pmt_pos_x;
        y=m_pmt_pos_y;
        z=m_pmt_pos_z;
        //cout<<"x:"<<x<<" y:"<<y<<" z:"<<z<<endl;
        TVector3 pmtCenter(x,y,z);
        m_pmt_pos.push_back(pmtCenter);
    }


    // for (int i=0;i<m_pmt_num; i+=1000){
    //    cout  << "Pmt ID:" << i << std::endl;
    //    cout  << "Position:" << m_pmt_pos[i].X() << "\t" 
    //         << m_pmt_pos[i].Y() << "\t"
    //         << m_pmt_pos[i].Z() << std::endl;
    // } 
}


void get_TOF_table(){

    for(int zone_id=0; zone_id<m_zone_num; zone_id++){
        double vertex_x = zone_vertex[zone_id].X();
        double vertex_y = zone_vertex[zone_id].Y();
        double vertex_z = zone_vertex[zone_id].Z();


        for(int pmt_id=0; pmt_id<m_pmt_num; pmt_id++){

            double TOF = calTOF(vertex_x, vertex_y, vertex_z, pmt_id);
            TOF_table[zone_id][pmt_id] = TOF;
        }
    }

    //for(int i=0; i<1000; i+=100){
    //    cout<<"TOF: "<< TOF_table[55][i]<<endl;
    //}

}


    double 
calTOF(double x,double y,double z,int id)
{
    // use pmt front 
    double pmt_pos_x=m_pmt_pos[id].X()*m_pmt_front_r/m_pmt_center_r;
    double pmt_pos_y=m_pmt_pos[id].Y()*m_pmt_front_r/m_pmt_center_r;
    double pmt_pos_z=m_pmt_pos[id].Z()*m_pmt_front_r/m_pmt_center_r;

    double dx = (x-pmt_pos_x)/1000;  // m
    double dy = (y-pmt_pos_y)/1000;  // m
    double dz = (z-pmt_pos_z)/1000;  // m

    double r0 = TMath::Sqrt(x*x+y*y+z*z)/1000;            // vertex radius
    double dist = TMath::Sqrt(dx*dx+dy*dy+dz*dz);         // distance between pmt and vertex

    double cos_theta = (m_pmt_front_r*m_pmt_front_r+dist*dist-r0*r0)/(2*m_pmt_front_r*dist);

    double theta = TMath::ACos(cos_theta);

    double dist_buffer = m_pmt_front_r*cos_theta-TMath::Sqrt(
            m_ls_r*m_ls_r-m_pmt_front_r*m_pmt_front_r*TMath::Sin(theta)*TMath::Sin(theta));
    return (dist-dist_buffer)*SPEED_LS+dist_buffer*SPEED_BUFFER;

}



void initial_before_each_evt_begin(){

    map<int, vector<double> >::iterator it_clear;

    for(it_clear = corrected_hitTime_table.begin();
            it_clear!=corrected_hitTime_table.end();
            it_clear++){
        (it_clear->second).clear(); 
    }

    corrected_hitTime_table.clear();  
    Hit_Collection.clear();
    corrected_Hit_Collection.clear();
    T_pmtNum.clear();

    pmtID_hitTime_map.clear();
    pmtID_firstHitTime_map.clear();


}



void Add_Dark_Noise(){
    double DarkRate = 50*1e3;//50kHz
    double preTolerance = 300;

    for(int pmtID=0; pmtID < m_pmt_num; pmtID++){
        int Ndark = PoissonRand(DarkRate * m_scan_time_window * 1.0e-9);

        for (int dummy = 0; dummy < Ndark; ++dummy) {
            double hitTime = gRandom->Rndm() * m_scan_time_window - preTolerance; // hitTime from -300ns to 700ns 

            Hit_Collection.push_back( Hit(pmtID, hitTime) );

            for(int i=0; i<m_zone_num; i++){
                corrected_Hit_Collection[i].push_back( Hit(pmtID, hitTime) );
            }
        }

    }

    cout<<"dark noise in corrected collection at zone_id=0: " << corrected_Hit_Collection[0].size() <<endl;
}


int PoissonRand(double mean){

    int n;
    if (mean <= 0) return 0;

    double expmean = exp(-mean);
    double pir = 1;
    n = -1;
    while(1) {
        n++;
        pir *= gRandom->Rndm();
        if (pir <= expmean) break;
    }
    return n;

}



void get_corrected_Hit_Collection(){
    for(int zone_id=0; zone_id<m_zone_num; zone_id++){

        // correct hitTime for one zone_id, and sort hitTime vector

        for(int PhotonID=0; PhotonID<m_nPhotons; PhotonID++){
            int hit_pmtId = m_pmtID[PhotonID];
            //cout<<"hit_pmtID: " << hit_pmtId<<endl;
            double hit_hitTime = m_hitTime[PhotonID];

            if(hit_hitTime<m_scan_time_window){
                double corrected_hitTime = hit_hitTime - TOF_table[zone_id][hit_pmtId];
                //double corrected_hitTime = hit_hitTime; 

                corrected_Hit_Collection[zone_id].push_back(Hit(hit_pmtId, corrected_hitTime));


            }
        }
        std::sort(corrected_Hit_Collection[zone_id].begin(),
                corrected_Hit_Collection[zone_id].end(),
                SortByhitTime);

    }

    cout<<"corrected Hit collection size at zone_id=0: " << corrected_Hit_Collection[0].size()<<endl;


    //cout hitTime without corrected
    //    for(int PhotonID=0; PhotonID<m_nPhotons; PhotonID++){
    //        double hit_hitTime = m_hitTime[PhotonID];
    //        cout<<"hitTime without corrected: " << hit_hitTime<<endl;
    //
    //    }




    //    vector<Hit>::iterator it;
    //    for(it=corrected_Hit_Collection[0].begin();
    //            it!=corrected_Hit_Collection[0].end();
    //            it++){
    //
    //        cout<<"hit time: " << it->hitTime()<<endl;
    //    }
}


void find_maxPmtNum_with_corrected(){

    vector<Hit>::iterator it;
    int true_vertex_zone_id = 0;
    double max_pmt_num = 0;
    int time_window = 1000;
    int trigger_window = 25;
    int start_time = -300;

    for(int zone_id=0; zone_id<m_zone_num; zone_id++){
        //initial
        T_pmtNum.clear();

        //slip window to find max_pmt_num
        for(it=corrected_Hit_Collection[zone_id].begin();
                it!=corrected_Hit_Collection[zone_id].end();
                it++){
            int time_index = int( (it->hitTime() ) - start_time); //because correction, some hitTime < 0, we need >0 as index.

            T_pmtNum[time_index][it->pmtID()]=1;  // the 1 is not use, we just use the size
        }

        for(int i=0; i<time_window-trigger_window; i++){
            double pmt_num_in_triggerWindow = 0;

            for(int j=0; j<trigger_window; j++){
                pmt_num_in_triggerWindow += T_pmtNum[i+j].size();

            }

            if(pmt_num_in_triggerWindow > max_pmt_num){
                //LogInfo<<"max pmt num change: "<< max_pmt_num<<endl;
                max_pmt_num = pmt_num_in_triggerWindow;
                true_vertex_zone_id = zone_id;
            }
        }
    }

    cout<<"max_pmt_num: " << max_pmt_num<<endl;
    cout<<"true_vertex_zone_id: " <<true_vertex_zone_id<<endl;


    double vertex_x = zone_vertex[true_vertex_zone_id].X();
    double vertex_y = zone_vertex[true_vertex_zone_id].Y();
    double vertex_z = zone_vertex[true_vertex_zone_id].Z();

    double vertex_R = TMath::Sqrt(vertex_x*vertex_x + vertex_y*vertex_y + vertex_z*vertex_z); //unit mm

    cout<<"vertex_R(mm): " <<vertex_R<<endl;
    cout<<"vertex_R^3(mm^3): "<<vertex_R*vertex_R*vertex_R<<endl;


    double edep_R = TMath::Sqrt(m_edepX*m_edepX + m_edepY*m_edepY + m_edepZ*m_edepZ);
    cout<<"edep_R: " <<edep_R<<endl;

    double delta_R = edep_R - vertex_R;
    cout<<"delta_R: "<< delta_R<<endl;


    //cout the corrected hitTime

    //    for(it=corrected_Hit_Collection[true_vertex_zone_id].begin();
    //            it!=corrected_Hit_Collection[true_vertex_zone_id].end();
    //            it++){

    //        double time_corrected = it->hitTime();
    //        cout<<"corrected hitTime: "  << time_corrected<<endl;


    //    }


    //    for(it=corrected_Hit_Collection[58].begin();
    //            it!=corrected_Hit_Collection[58].end();
    //            it++){

    //        double time_corrected = it->hitTime();
    //        cout<<"corrected hitTime in wrong box: "  << time_corrected<<endl;


    //    }



    //h_R->Fill(vertex_R);
    /*
       for(int i=100; i<180; i+=10){
       TCanvas* c1 = new TCanvas;
       TH1F* h1 = new TH1F("h1","h1",int(time_window/trigger_window), start_time, start_time+time_window);
       for(it=corrected_hitTime_table[i].begin();
       it!=corrected_hitTime_table[i].end();
       it++){
       h1->Fill(*it);  
       }
       h1->Draw();
       c1->Print(TString::Format("histo_%d.png", i),"png");
       delete h1;
       }
       */

}




void get_PMT_first_hitTime_Collection(){

    vector<double>::iterator it;
    double PMT_first_hitTime = 0;

    cout<<"m_nPhotons: " <<m_nPhotons<<endl;


    for(int photonIndex=0; photonIndex<m_nPhotons; photonIndex++){

        pmtID_hitTime_map[m_pmtID[photonIndex]].push_back(m_hitTime[photonIndex]);     
       // cout<<"m_hitTime: " <<m_hitTime[photonIndex]<<endl;

    } 

//////////////////////////////////add dark noise///////////////////////////////////
    double DarkRate = 50*1e3;//50kHz
    double preTolerance = 300;

    for(int pmtID=0; pmtID < m_pmt_num; pmtID++){
        int Ndark = PoissonRand(DarkRate * m_scan_time_window * 1.0e-9);

        for (int dummy = 0; dummy < Ndark; ++dummy) {
            double hitTime = gRandom->Rndm() * m_scan_time_window - preTolerance; // hitTime from -300ns to 700ns 
            pmtID_hitTime_map[pmtID].push_back(hitTime);
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////



    for(int pmtIndex=0; pmtIndex<m_pmt_num; pmtIndex++){


        if(pmtID_hitTime_map[pmtIndex].size()>1){
            sort(pmtID_hitTime_map[pmtIndex].begin(),pmtID_hitTime_map[pmtIndex].end() );
        }

        if(pmtID_hitTime_map[pmtIndex].size()>0){

            //cout<<"pmtIndex: " <<pmtIndex<<endl;
            it = pmtID_hitTime_map[pmtIndex].begin();
            //PMT_first_hitTime = *it - first_hitTime_in_one_evt;   //just for suernova 
            PMT_first_hitTime = *it ;
            //cout<<"PMT_first_hitTime: " <<PMT_first_hitTime<<endl;

            pmtID_firstHitTime_map[pmtIndex]=PMT_first_hitTime;


        }


    }

    cout<<"pmtID_firstHitTime_map size: " <<pmtID_firstHitTime_map.size()<<endl;

}



void get_firstHitTime_corrected_Hit_Collection(){


    map<int, double>::iterator it;

    for(int zone_id=0; zone_id<m_zone_num; zone_id++){
        for(it=pmtID_firstHitTime_map.begin();
                it!=pmtID_firstHitTime_map.end();
                it++){

            int hit_pmtId = it->first;
            double hit_hitTime = it->second;

            if(hit_hitTime<m_scan_time_window){
                double corrected_hitTime = hit_hitTime - TOF_table[zone_id][hit_pmtId];
                //double corrected_hitTime = hit_hitTime; 

                corrected_Hit_Collection[zone_id].push_back(Hit(hit_pmtId, corrected_hitTime));

            }

        }

        std::sort(corrected_Hit_Collection[zone_id].begin(),
                corrected_Hit_Collection[zone_id].end(),
                SortByhitTime);

    }

    cout<<"corrected Hit collection size at zone_id=0: " << corrected_Hit_Collection[0].size()<<endl;

}


void find_firstHitTime_in_one_evt(){

    vector<double> temp_hitTimeVector;

    for(int photonIndex=0; photonIndex<m_nPhotons; photonIndex++){

        temp_hitTimeVector.push_back(m_hitTime[photonIndex]);

    }

    sort(temp_hitTimeVector.begin(),
            temp_hitTimeVector.end());

    first_hitTime_in_one_evt = temp_hitTimeVector[0];
    cout<<"first_hitTime_in_one_evt: " << first_hitTime_in_one_evt<<endl;


    //vector<double>::iterator it;
    //for(it=temp_hitTimeVector.begin();
    //        it!=temp_hitTimeVector.end();
    //        it++){
    //    cout<<"temp_hitTimeVector: "  << *it<<endl;
    //}



}












