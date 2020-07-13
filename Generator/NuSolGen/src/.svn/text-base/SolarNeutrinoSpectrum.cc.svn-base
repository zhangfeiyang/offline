// --------------------------------------------------------------------------//
/** 
 * Solar neutrino generator imported from Borexino
 * AUTHOR: D. Franco
 * Revised by A. Caminata and S. Marcocci, Sept. 2014
 * Revised by X.F. Ding July 2016
 * X F Ding
 * 	18 Aug 2016 Modify the endpoint. use bahcall's b8 spectrum
 * 	1 Sep 2016 fix thetaw bug. it should be thetaw2. switch back to new sigma
 */
// --------------------------------------------------------------------------//
#include "TF1.h"
#include "SolarNeutrinoSpectrum.hh"
#include <cmath>
#include <iostream>
#include <fstream>
#include <cstdlib>
//#include "G4Electron.hh"
// in G4SystemOfUnits you can find using CLHEP::MeV
#include "G4SystemOfUnits.hh"
#include "TMath.h"
using std::cout;
using std::endl;
using std::cerr;
using std::ifstream;
//---------------------------------------------------------------------------//

SolarNeutrinoSpectrum::SolarNeutrinoSpectrum() {
    prefix = std::getenv("NUSOLGENROOT");
    if(!prefix) {
        std::cerr<<"Please set $NUSOLGENROOT to the location of the NuSolarGen package root."<<std::endl;
        throw -1;
    }
    //pi = 3.14159265;
    emass = 0.510998928*MeV; 
    //emass  = G4Electron::Definition()->GetPDGMass ()/MeV;
    //according to pp-nu internal note April 16, 2014
    DM2    = 7.54 ;
    TG2T   = 0.44 ;
    isFirstTime = true ;
    is_read     = false ;
    fOldSigma=false; //neutrino cross-sections at tree-level
    fNeutrinoType = -1;

    fNumberOfSteps = 10000;

    AlphaPee[pp]  = 4.68  ;
    AlphaPee[pep] = 5.13  ;
    AlphaPee[hep] = 3.96  ;
    AlphaPee[be7] = 6.16  ;
    AlphaPee[b8]  = 6.81  ;
    AlphaPee[n13] = 6.22  ;
    AlphaPee[o15] = 6.69  ;
    AlphaPee[f17] = 6.74  ;
    AlphaPee[be7_862] = AlphaPee[be7]  ;
    AlphaPee[be7_384] = AlphaPee[be7]  ;

    BetaPee[pp]  =  0.109  ;
    BetaPee[pep] =  0.079  ;
    BetaPee[hep] =  0.165 ;
    BetaPee[be7] =  0.029 ;
    BetaPee[b8]  =  0.01 ;
    BetaPee[n13] =  0.054 ;
    BetaPee[o15] =  0.013 ;
    BetaPee[f17] =  0.012 ;
    BetaPee[be7_862] = BetaPee[be7] ;
    BetaPee[be7_384] = BetaPee[be7] ;

    NuEndPoint[pp]  =  0.423  ;
    NuEndPoint[pep] =  1.44  ;
    NuEndPoint[hep] =  18.784;
    NuEndPoint[be7] =  0.862 ;
    NuEndPoint[b8]  =  16.36;
    NuEndPoint[n13] =  1.199 ;
    NuEndPoint[o15] =  1.732 ;
    NuEndPoint[f17] =  1.74 ;
    NuEndPoint[be7_862] =  0.862 ;
    NuEndPoint[be7_384] =  0.3843 ;

    fnbin  = 4000;
    fNormaNue = 0;
    fNormaNux = 0;

    fVolumeFlag = false ;
    //cout<<"construction finished"<<endl;

}

//---------------------------------------------------------------------------//

bool SolarNeutrinoSpectrum::SetNeutrinoType(const char *neutype) {
    std::string newValue(neutype);
    if(newValue == "pp") {
        SetNeutrinoType(SolarNeutrinoSpectrum::pp);
    } else if(newValue == "Be7") {
        SetNeutrinoType(SolarNeutrinoSpectrum::be7);
    } else if(newValue == "Be7_862") {
        SetNeutrinoType(SolarNeutrinoSpectrum::be7_862);
    } else if(newValue == "Be7_384") {
        SetNeutrinoType(SolarNeutrinoSpectrum::be7_384);
    } else if(newValue == "B8") {
        SetNeutrinoType(SolarNeutrinoSpectrum::b8);
    } else if(newValue == "N13") {
        SetNeutrinoType(SolarNeutrinoSpectrum::n13);
    } else if(newValue == "O15") {
        SetNeutrinoType(SolarNeutrinoSpectrum::o15);
    } else if(newValue == "F17") {
        SetNeutrinoType(SolarNeutrinoSpectrum::f17);
    } else if(newValue == "pep") {
        SetNeutrinoType(SolarNeutrinoSpectrum::pep);
    } else if(newValue == "hep") {
        SetNeutrinoType(SolarNeutrinoSpectrum::hep);
    } else
        return false;
    return true;
}

bool SolarNeutrinoSpectrum::GeneratePrimaries(double &electron_kinetic_energy) {
    if(isFirstTime) {
    cout<<"initialization"<<endl;
        if(fNeutrinoType < 0) {
            fNeutrinoType = be7;
        }  
        DM2   *= 1.E-5;
        CumulativeDistribution(fNeutrinoType);
        cout<<"cum finished"<<endl;
        fstep =  (NuEndPoint[fNeutrinoType]*1.05)/double(fnbin);
        for(int k=0; k<fnbin;k++) {
            double norma_nue = 0; 
            double norma_nux = 0; 
            for(int i=0;i<fnbin;i++) {
                norma_nue += cross_nue(fstep*i+fstep/3.,fstep*k+fstep/3.)*fstep;
                norma_nux += cross_nux(fstep*i+fstep/3.,fstep*k+fstep/3.)*fstep;
            }
            if(fNormaNue < norma_nue) fNormaNue = norma_nue;
            if(fNormaNux < norma_nux) fNormaNux = norma_nux;
        }
        cout<<"fNormaNue = "<<fNormaNue<<endl;
        cout<<"fNormaNux = "<<fNormaNux<<endl;

        isFirstTime = false ;
    }
    //cout<<"ini finished"<<endl;
    double EEnergy = 0;
    double NuEnergy ; 

    int nutype = 0; // nutype = 0 for nu_e and 1 for nu_mu or nu_tau
    bool isGenerated = false;
    //std::cout << "DEBUG: start generated." << std::endl;
    while(!isGenerated) {
        NuEnergy  =  ShootEnergy(fNeutrinoType);
        double probx = 1-survive(NuEnergy, fNeutrinoType) ;
        // here I choose if it is a nue or nux
        if(UniformRand() < probx) {  // nux
            nutype = 1; 
            EEnergy = 0;
            double sum = 0;
            double value = UniformRand();
            if(value < cross_nux(0,NuEnergy)*fstep/fNormaNux) {
                isGenerated = false ; 
                break ;        
            } 
            //cout<<cross_nux(0,NuEnergy)*fstep/fNormaNux<<endl;
            for(int i=0;i<fnbin;i++) {  // generation of the recoiled electron pdf
                EEnergy = fstep*i+fstep/3.;
                sum += cross_nux(EEnergy,NuEnergy)*fstep/fNormaNux;
                if(cross_nux(EEnergy,NuEnergy) == 0) {
                    isGenerated = false ; 
                    break ;
                }
                if(sum > value) {
                    isGenerated = true ;
                    if(UniformRand()> fNormaNux/fNormaNue) isGenerated = false;    
                    break;        
                }
            }
        } else {    // nue
            nutype = 0; 
            EEnergy = 0;
            double sum = 0;
            double value = UniformRand();
            if(value < cross_nue(0,NuEnergy)*fstep/fNormaNue) {
                isGenerated = false ; 
                break ;        
            }
            for(int i=0;i<fnbin;i++) { // generation of the recoiled electron pdf
                EEnergy = fstep*i+fstep/3.;
                sum += cross_nue(EEnergy,NuEnergy)*fstep/fNormaNue;
                if(cross_nue(EEnergy,NuEnergy) == 0) {
                    isGenerated = false ; 
                    break ;
                }
                if(sum > value) {
                    isGenerated = true ; 
                    break;        
                }      
            }
        }        
    } 
    //cout<<"generated"<<endl;

    electron_kinetic_energy = EEnergy * MeV;
    if(fNeutrinoType== pp){
        if(EEnergy/MeV>0.07)
            return true;
        else
            return false;
    }else{
        return true;

    }
}
//-------------------------------------------------------------------------
//     Survival probability Pee
//     from: P.C. de Holanda, Wei Liao and A. Yu. Smirnov (hep-ph/0404042)
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::survive(double E, int k) {
    if(TG2T == 0)  return 1 ;
    if(DM2  == 0)  return 1 ;
    double theta  =  atan(sqrt(TG2T));
    double sin22  =  pow(sin(2*theta),2.);
    double cos2   =  sqrt(1.-sin22) ;
    double gamma  =  2.*AlphaPee[k]*E*1.E6/DM2*1.E-12 ;

    double delta  = 3./2.*pow(gamma,2.)*sin22*BetaPee[k]
        /pow(pow(cos2 - gamma,2.)+sin22,2.);

    double cos2m  = (cos2 - gamma)/sqrt(pow(cos2-gamma,2.)+sin22);

    return 0.5 + 0.5*(1.-delta)*cos2m*cos2 ;  
}

double SolarNeutrinoSpectrum::I_f(double E) {
    double x=sqrt(1+2*emass/E);
    return 1./6.*(1./3.+(3.-x*x)*(1./2.*x*log((x+1.)/(x-1.))-1.));
}

double SolarNeutrinoSpectrum::k_e(double E) {
    return 0.9786+0.0097*I_f(E);
}
double SolarNeutrinoSpectrum::k_mu(double E) {
    return 0.9965-0.00037*I_f(E);
}

double SolarNeutrinoSpectrum::fMinus(double z, double q){
    double E=z*q+emass;
    double l=sqrt(E*E-emass*emass);
    double val= (E/l*log((E+l)/emass)-1.)*(2*log(1.-z-emass/(E+l))-log(1.-z)-1./2.*log(z)-5./12.)+1./2.*(TMath::DiLog(z)-TMath::DiLog(l/E))-1./2.*log(1.-z)*log(1.-z)-(11./12.+z/2.)*log(1-z)+z*(log(z)+1/2.*log(2*q/emass))-(31./18.+1./12.*log(z))*l/E-11./12.*z+z*z/24.;
    if(val!=val)
        return 0;
    else
        return val;
}


double SolarNeutrinoSpectrum::fPlus(double z, double q){
    double E=z*q+emass;
    double l=sqrt(E*E-emass*emass);
    double val= 1./(1.-z)/(1.-z)*(E/l*log((E+l)/emass)-1.)*((1-z)*(1-z)*(2*log(1-z-emass/(E+l))-log(1-z)-log(z)/2.-2./3.)-(z*z*log(z)+1-z)/2)-(1-z)*(1-z)/2.*(log(1-z)*log(1-z)+l/E*(TMath::DiLog(1.-z)-log(z)*log(1-z)))+log(1-z)*(z*z/2.*log(z)+(1-z)/3.*(2*z-1./2.))-z*z/2.*TMath::DiLog(1-z)-z*(1-2*z)/3.*log(z)-z*(1-z)/6.-l/E/12.*(log(z)+(1-z)*(115-109*z)/6.);
    if(val==val)
        return val;
    else
        return 0;
}

double SolarNeutrinoSpectrum::fPlusMinus(double z, double q){
    double E=z*q+emass;
    double l=sqrt(E*E-emass*emass);
    double val= (E/l*log((E+l)/emass)-1.)*2.*log(1.-z-emass/(E+l));
    if(val==val)
        return val;
    else
        return 0;
}

//-------------------------------------------------------------------------
//     Electroweak interaction nu_e + e-
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::cross_nue(double E, double nuE) {
    //from K. Nakamura et al. (Particle Data Group), J. Phys. G, 37, 075021 (2010)
    double sigma = 0;
    if(!fOldSigma){
        double rhoNC=1.0127;
        double sintw2=0.23116;
        //from Bahcall et al. PhysRevD. 51, 11 1995
        double gl=rhoNC*(1./2.-k_e(E)*sintw2)-1;
        double gr=-rhoNC*k_e(E)*sintw2;
        double z= E/nuE;
        double alpha=7.297e-3;
        if(E < nuE/(1.+emass/2./nuE))
            sigma=gl*gl*(1.+alpha/M_PI*fMinus(z,nuE))+gr*gr*(1.-z)*(1.-z)*(1.+alpha/M_PI*fPlus(z,nuE))-gr*gl*emass*z/nuE*(1+alpha/M_PI*fPlusMinus(z,nuE));
        if(sigma < 0) sigma = 0 ;
    }else{
        double gr = 0.23 ;
        double gl = 0.5 + gr ;
        if(E > nuE/(1+emass/2./nuE)) return 0 ;
        else  sigma = gl*gl+gr*gr*pow(1.-E/nuE,2.) - gl*gr*E*emass/nuE/nuE ;

        if(sigma < 0) sigma = 0 ;
    }
    return sigma ;
}

//-------------------------------------------------------------------------
//     Electroweak interaction nu_mu + e- or nu_tau + e-
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::cross_nux(double E, double nuE) {
    double sigma = 0;
    if(!fOldSigma){
        //from K. Nakamura et al. (Particle Data Group), J. Phys. G, 37, 075021 (2010) 
        double rhoNC=1.0127;
        double sintw2=0.23116;
        //                        //from Bahcall et al. PhysRevD. 51, 11 1995
        double gl=rhoNC*(1./2.-k_mu(E)*sintw2);
        double gr=-rhoNC*k_mu(E)*sintw2;
        double z= E/nuE;
        double alpha=7.297e-3;

        if(E < nuE/(1+emass/2./nuE))
            sigma=gl*gl*(1.+alpha/M_PI*fMinus(z,nuE))+gr*gr*(1.-z)*(1.-z)*(1.+alpha/M_PI*fPlus(z,nuE))-gr*gl*emass*z/nuE*(1+alpha/M_PI*fPlusMinus(z,nuE));
        if(sigma < 0) sigma = 0 ;
    }else{
        double gr = 0.23 ;
        double gl = - 0.5 + gr ;
        if(E > nuE/(1+emass/2./nuE)) return 0 ;
        else   sigma = gl*gl+gr*gr*pow(1.-E/nuE,2.) - gl*gr*E*emass/nuE/nuE ;

        if(sigma < 0) sigma = 0 ;
    }
    return sigma ;

}

//-------------------------------------------------------------------------
//     N13
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::N13NuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        //from Bahcall:http://www.sns.ias.edu/~jnb/SNdata/Export/CNOspectra/n13.dat
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "n13spectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }
    if(E>NuEndPoint[n13]) return 0.;
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}


//-------------------------------------------------------------------------
//     O15
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::O15NuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        //from Bahcall: http://www.sns.ias.edu/~jnb/SNdata/Export/CNOspectra/o15.dat
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "o15spectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }

    if(E>NuEndPoint[o15]) return 0.;  
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}

//-------------------------------------------------------------------------
//     F17
//-------------------------------------------------------------------------
// Only 0.04% of the main CNO branch
double SolarNeutrinoSpectrum::F17NuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        //from Bahcall: http://www.sns.ias.edu/~jnb/SNdata/Export/CNOspectra/f17.dat
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "f17spectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }

    if(E>NuEndPoint[f17]) return 0.;  
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}

//-------------------------------------------------------------------------
//     B8
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::B8NuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        //from:W. Winter et al., PHYSICAL REVIEW C 73, 025503 (2006)
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "b8spectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }

    if(E>NuEndPoint[b8]) return 0.;  
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}

//-------------------------------------------------------------------------
//     PP
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::PPNuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        //from Bahcall: http://www.sns.ias.edu/~jnb/SNdata/Export/PPenergyspectrum/ppenergytab
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "ppspectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }

    if(E>NuEndPoint[pp]) return 0.;  
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}
//-------------------------------------------------------------------------
//     Be7
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::BE7NuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "be7spectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }

    if(E>NuEndPoint[be7]) return 0.;  
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}
//-------------------------------------------------------------------------
//     HEP
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::HEPNuSpectrum(double E) {
    if(!is_read) {
        is_read = true;
        double ene, prob;
        //from Bahcall: http://www.sns.ias.edu/~jnb/SNdata/Export/Hepspectrum/hepspectrum.dat
        std::string spcfilename = prefix;
        spcfilename += "/data/";
        spcfilename += "hepspectrum.dat";
        ifstream fil(spcfilename.c_str());
        if(!fil.is_open()) { 
            cerr<<"file "<<spcfilename<<" does not exists."<<endl;
            throw -1; 
        }
        while(!fil.eof()) {
            fil >> ene >> prob;
            if(fil.eof()) break ;
            fNuEnergy.push_back(ene);
            fNuProbability.push_back(prob);
        }
        fil.close();
    }

    if(E>NuEndPoint[hep]) return 0.;  
    double bin = fNuEnergy[1] - fNuEnergy[0];
    int    k = int(E/bin) ;
    return fNuProbability[k];
}
//-------------------------------------------------------------------------
//    Energy Spectrum
//-------------------------------------------------------------------------
double SolarNeutrinoSpectrum::EnergySpectrum(double E, int k) {
    double value = 0;
    if(k == pp) {
        value = PPNuSpectrum(E);                   
    } else if(k == b8) {
        value = B8NuSpectrum(E);                   
    } else if(k == f17) {
        value = F17NuSpectrum(E);                   
    } else if(k == o15) {
        value = O15NuSpectrum(E);                   
    } else if(k == n13) {
        value = N13NuSpectrum(E);                   
    }  else if(k == be7) {
        //value = BE7NuSpectrum(E);                        
        if(E == 0.3843) value =  0.103;
        else if(E == NuEndPoint[be7]) value =  0.897;
        else value = 0;
    }  else if(k == be7_862) {                      
        if(E == NuEndPoint[be7_862]) value =  1;
        else value = 0;
    }  else if(k == be7_384) {                      
        if(E == NuEndPoint[be7_384]) value =  1;
        else value = 0;
    }  else if(k == hep) {
        value = HEPNuSpectrum(E);                        
    }  else if(k == pep) {
        if(E == NuEndPoint[pep]) value =  1;  
        else value = 0;
    }

    return value ;
}
//-------------------------------------------------------------------------
//    Cumulative Distribution
//-------------------------------------------------------------------------
void SolarNeutrinoSpectrum::CumulativeDistribution(int k) {
    double sum = 0;
    double endpoint = NuEndPoint[k] ;
    double step = endpoint/double(fNumberOfSteps);
    for(int i = 0; i< fNumberOfSteps ; i++) {
        double bin = float(i)*step + step/3. ;
        sum += EnergySpectrum(bin,k)*step ;
        fEnergyBin.push_back(bin);
        fProbability.push_back(sum);
    }
    for(int i = 0; i< fNumberOfSteps; i++){
        fProbability[i]=fProbability[i]/fProbability[fNumberOfSteps-1];
        //cout<<fEnergyBin[i]<<" "<<fProbability[i]<<endl;
    }
}
//-------------------------------------------------------------------------
//    Energy Shooter with linear interpolation
//-------------------------------------------------------------------------

double SolarNeutrinoSpectrum::ShootEnergy(int k) {
    double val = UniformRand();
    if((k != pep) && (k != be7) && (k != be7_862) && (k != be7_384)) {
        for(int i=0;i<int(fProbability.size());i++) {
            if(fProbability[i] >= val) {
                if(i == 0) return fEnergyBin[0];
                double deltaX = val - fProbability[i] ;
                double y = fEnergyBin[i] - fEnergyBin[i-1] ;
                double x = fProbability[i] - fProbability[i-1] ;
                return deltaX*y/x + fEnergyBin[i];
            }
        }
    } else if(k == be7) {
        if(val < 0.897) return NuEndPoint[be7];
        else return 0.3843;
    } else if(k == be7_862) return NuEndPoint[be7_862];
    else if(k == be7_384) return NuEndPoint[be7_384];
    else if(k == pep) return NuEndPoint[pep];

    return 0;
}
//-------------------------------------------------------------------------
//    Pure interpolation
//-------------------------------------------------------------------------

double SolarNeutrinoSpectrum::Interpolate(double prob1, double prob2, double eE1, double eE2, double val) {
    if(eE1 < 0) eE1 = 0;
    double deltaX = val -  prob1;
    double y = eE2 - eE1 ;
    double x = prob2 - prob1 ;
    return deltaX*y/x + eE1;
}
