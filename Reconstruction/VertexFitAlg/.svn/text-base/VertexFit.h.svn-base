#ifndef VertexFit_h
#define VertexFit_h
#include "TVector3.h"
#include <TH1F.h>
#include <TTree.h>
#include "Hit.h"
#include <map>
#include <vector>
#include <string>


void load_root_data(std::string input_file_name);
void load_edep_position_data(std::string input_file_name);
void load_PMT_position_data(std::string pmt_position);

void find_firstHitTime_in_one_evt();


void registerData();
void saveData();
void get_pmt_position();
void get_zone_vertex();
void get_TOF_table();
void get_corrected_hitTime_table();
void initial_before_each_evt_begin();
void find_fit_vertex();
void find_maxPmtNum_without_corrected();
void find_maxPmtNum_with_corrected();
void chose_evt();

//use Hit class
void get_corrected_Hit_Collection();
void Add_Dark_Noise();
void get_PMT_first_hitTime_Collection();

void get_firstHitTime_corrected_Hit_Collection();

int PoissonRand(double mean);


double calTOF(double x,double y,double z,int id);

/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////


double first_hitTime_in_one_evt;



//input root varible

TTree* t_evt;
TTree* t_pmtInfo;

int m_nPhotons;
int m_pmtID[100000];
float m_hitTime[100000];   //for normal evt
//double m_hitTime[100000];  //just for supernova


float m_pmt_pos_x;
float m_pmt_pos_y;
float m_pmt_pos_z;

float m_edepX;
float m_edepY;
float m_edepZ;



//input command line parameter
double PE_Num_per_1MeV;
double energy_cut;


// geometry variable
int m_pmt_num;      // number of PMT
int m_zone_num;     // number of zones
double m_pmt_center_r;  // radius of PMT center in the steel ball   
double m_pmt_r;     // radius of PMT
double m_pmt_front_r;    // the minimum distance between PMT and center of steel ball
double m_ls_r;
std::vector<TVector3> m_pmt_pos;    // position of PMT
std::map<int, TVector3> zone_vertex; //key: zone ID, value:vertex x,y,z
std::map<int, std::map<int, double> > TOF_table; //key:zone id; sub_key:pmt id; sub_value:TOF between vertex and pmt
std::map<int, std::vector<double> > corrected_hitTime_table; // key:zone id; value:hitTime after TOF corrected.


//use Hit class

std::map<int, std::vector<Hit> > corrected_Hit_Collection; //key: zone id; value: Hit 

std::vector<Hit> Hit_Collection;
std::map<int, std::map<int,int> > T_pmtNum; //key: ns  sub_key:pmtID  sub_value: no use  we use (it->second).size() to represent the hit pmt num in the second.


std::map<int,std::vector<double> > pmtID_hitTime_map;  // used to save pmtID and photon's hitTime on this pmt

std::map<int, double> pmtID_firstHitTime_map;



// parameters
double SPEED_LS;
double SPEED_BUFFER;


//save data histogram
TH1F* h_R; 



//about time
double m_scan_time_window; //the consider time window












#endif
