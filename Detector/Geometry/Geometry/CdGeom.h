#ifndef JUNO_CD_GEOM_H
#define JUNO_CD_GEOM_H

//
//  This class provides geometry for Central Detector
//
//  Author: Zhengyun You  2013-11-20
//

#include "Identifier/Identifier.h"
#include "Geometry/PmtGeom.h"
#include "TString.h"
#include <map>
#include <vector>
#include "TGeoSphere.h"
#include "TGeoTube.h"
#include "GeoUtil.h"
#include "TGeoMatrix.h"

class TGeoManager;
class TGeoVolume;
class TGeoNode;
class TGeoPhysicalNode;

class CdGeom
{
    public :

        typedef std::map<Identifier, PmtGeom*>::iterator PmtMapIt; 

        CdGeom();
        ~CdGeom();

        // Initialization
        //-----------------------------------------------
        bool init();
        bool initRootGeo();
        void setGeomFileName(std::string name) { m_geomFileName = name; }
        void setGeomPathName(std::string name) { m_geomPathName = name; }
        void setFastInit(bool fastInit) { m_fastInit = fastInit; }
        bool readRootGeoFile();

        // Getter
        //-----------------------------------------------
        unsigned int findPmtNum() { return m_nPmt; }
        unsigned int findPmt20inchNum() { return m_nPmt20inch; }
        unsigned int findPmt3inchNum() { return m_nPmt3inch; }

        PmtGeom* getPmt(Identifier id);
        PmtGeom* getPmt(int layer, int azimuth, int pmt);
        unsigned int getPmtNum() { return m_mapIdToPmt.size(); }
        int getPmtType(TString name);

        // Useful functions  
        //-----------------------------------------------
        void printPmt();
        void initCdInfo();
       
        // Find the intersected Pmt from a vertex + direction
        PmtGeom* findCrossedPmt(const TVector3 vtx, const TVector3 dir);
        PmtGeom* findCrossedPmtFast(const TVector3 vtx, const TVector3 dir);

        // Orgnize Pmts into layers
        bool orgnizePmt(); 
        int getLayerNum() { return m_layerNum; }
        int getAzimuthNum(int layer);
    
        // Verbosisty
        void setVerb(int value) { m_verb = value; }
        int  getVerb() { return m_verb; }

        // Get Cd info; unit mm
        double getCdBallRmax() { return pAcrylicBall->GetRmax()*GeoUtil::cm2mm(); }
        double getCdBallRmin() { return pLsBall->GetRmax()*GeoUtil::cm2mm(); }
        double getCdChimneyRmax() { return pAcrylicChimney->GetRmax()*GeoUtil::cm2mm(); } 
        double getCdChimneyRmin() { return pAcrylicChimney->GetRmin()*GeoUtil::cm2mm(); }   
        double getCdChimneyDz() { return pAcrylicChimney->GetDz()*GeoUtil::cm2mm(); }
        TVector3 getChimneyTrans() { return TVector3((pChimneyTrans->GetTranslation())[0], (pChimneyTrans->GetTranslation())[1], (pChimneyTrans->GetTranslation())[2])*GeoUtil::cm2mm(); } 
        void printCd();

    private :

        // analyze TGeo tree and set 
        //-----------------------------------------------
        void analyzeGeomStructure();
        void searchPmt();
        void searchPmtMother(TGeoNode* node);
        void searchPmtBottom(TGeoNode* node);
        void setPathMother();
        TString setPathBottom();

        bool setPhyNodes();
        bool setPhyNodesManually();
        bool setPhyNodesAuto();
        PmtGeom* addPmt(Identifier id, TGeoPhysicalNode *phyNode, int pmtType);

        // members

        bool m_useDefaultGeom;
        std::string m_geomFileName;
        std::string m_geomPathName;
        TGeoManager *m_geom;
        std::map<Identifier, PmtGeom*> m_mapIdToPmt;
        bool m_fastInit;

        // root geometry structur analysis
        int m_nPmt;
        int m_nPmt20inch;
        int m_nPmt3inch;
        TGeoVolume* m_volPmt20inch;
        TGeoVolume* m_volPmt3inch;
        TGeoNode*   m_nodePmt20inch;
        TGeoNode*   m_nodePmt3inch;

        bool m_isPmtMotherFound;
        TGeoNode* m_nodePmtMother;
        std::vector<TGeoNode*> m_nodeMotherVec; 
        TString m_pathMother;

        bool m_isPmtBottomFound;
        std::vector<TGeoNode*> m_nodeBottomVec;
        TString m_pathBottom20inch;
        TString m_pathBottom3inch;

        // re-organize with layer
        int m_layerNum;
        std::vector<int> m_azimuthNum; 

        int m_verb;

        // get Cd info
        TGeoSphere *pAcrylicBall;
        TGeoTube *pAcrylicChimney;
        TGeoSphere *pLsBall;
        TGeoTube *pLsChimney;
        TGeoMatrix *pChimneyTrans;

		// is or not composite shape
		bool m_AcrylicIsComposite;
		bool m_LsIsComposite;
};

#endif // JUNO_CD_GEOM_H
