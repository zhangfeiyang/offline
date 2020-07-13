// --------------------------------------------------------------------------//
/** 
 * Solar neutrino generator imported from Borexino
 * AUTHOR: D. Franco
 * Revised by A. Caminata and S. Marcocci, Sept. 2014
 * Revised by X.F. Ding July 2016
*/
// --------------------------------------------------------------------------//

#ifndef _GENERATORSolarNeutrino2_HH
#define _GENERATORSolarNeutrino2_HH
#include "CLHEP/Random/RandFlat.h"
#include <vector>
using std::vector;

//---------------------------------------------------------------------------//
/**Solar Neutrino generator: generates solar neutrino spectra, including distortions due to oscillations; stores information only about recoiled electron and interacting neutrino (slower than GeneratorSolarNeutrino)
*/
class SolarNeutrinoSpectrum {
public:

  ///default constructor
  SolarNeutrinoSpectrum();

  ///destructor

  ///public interface
  bool GeneratePrimaries(double &electron_kinetic_energy);
  bool SetNeutrinoType(const char *neutype);



  
   ///Used to set cross sections at tree-level  
   void SetOldSigma(bool val) { fOldSigma=val;}
   void     SetNeutrinoType(int k)  { fNeutrinoType = k ;}
   int    GetNeutrinoType()         { return fNeutrinoType ;}

   void     SetDM2(double val)      { DM2 =  val ;}
   double GetDM2()                  { return DM2 ;}
   
   void     SetTG2T(double val)     { TG2T = val;}
   double GetTG2T()                 { return TG2T ;}
  
   void     SetBinning(int k)       { fNumberOfSteps = k;}
   int    GetBinning()              { return fNumberOfSteps ;}

  enum Neutrinos {pp=0,pep=1,hep=2,be7=3,b8=4,n13=5,o15=6,f17=7,cno=8,be7_862=9, be7_384=10};

  //private  members
private:
   
  ///Calculates the survive probability
  double survive(double ,  int ) ;
  double I_f (double ) ;
  double k_e (double ) ;
  double k_mu (double ) ;
  ///Calculates the nu_e - e  cross section 
  double cross_nue(double, double ) ;
  ///Calculates the nu_mu - e  cross section 
  double cross_nux(double, double ) ;

  double EnergySpectrum  (double, int ) ;
  double Normalizer  (int ) ;
  void CumulativeDistribution  (int ) ;
  double ShootEnergy(int )  ;
  
  double N13NuSpectrum (double ) ;
  double O15NuSpectrum (double ) ;
  double F17NuSpectrum (double ) ;
  double B8NuSpectrum  (double ) ;
  double PPNuSpectrum  (double ) ;
  double BE7NuSpectrum (double ) ;
  double HEPNuSpectrum (double ) ;

  double  Interpolate(double, double, double, double, double) ;
  
  double fMinus(double , double );
  double fPlus(double , double );
  double fPlusMinus(double , double );

  bool                       fVolumeFlag ;
  bool                       fEnergyDistribution;

  int                        fNumberOfSteps;
  double                     emass;

  double                     DM2;
  double                     TG2T;

  double                     AlphaPee[11];
  double                     BetaPee[11];
  double                     NuEndPoint[11];
  
  vector<double>             fEnergyBin;
  vector<double>             fProbability ;

  int                        fNeutrinoType;
  int                        fnbin;
  double                     fstep;
  bool                       isFirstTime;  
  double                     fNormaNue; 
  double                     fNormaNux; 
  bool                       is_read;
  bool                       fOldSigma;
  vector<double>             fNuEnergy;
  vector<double>             fNuProbability ;
  double UniformRand() { return CLHEP::RandFlat::shoot(0.0, 1.0); };
  char *prefix;

};
#endif
