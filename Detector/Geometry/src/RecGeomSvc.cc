//
//  Author: Zhengyun You  2013-11-20
//

#include <boost/python.hpp>
#include "Geometry/RecGeomSvc.h"
#include "SniperKernel/SvcFactory.h"
#include <iostream>

DECLARE_SERVICE(RecGeomSvc);

RecGeomSvc::RecGeomSvc(const std::string& name)
    : SvcBase(name)
{
    //declProp("Output", fmap);
    declProp("GeomFile", m_geomFileName); 
    declProp("GeomPathInRoot", m_geomPathName=""); 
    declProp("FastInit", m_fastInit=false);
}

RecGeomSvc::~RecGeomSvc()
{
}

bool RecGeomSvc::initialize()
{
    initRootGeom();

    return true;
}

bool RecGeomSvc::initRootGeom()
{
    initCdGeomControl(true);
    initWpGeomControl(true);
    initTtGeomControl(true);

    return true;
}

void RecGeomSvc::initCdGeomControl(bool value)
{
     if (value)
     initCdGeom();
     else
     LogDebug << "Do not initialize CdGeom." << std::endl;
}

void RecGeomSvc::initWpGeomControl(bool value)
{
     if (value)
     initWpGeom();
     else
     LogDebug << "Do not initialize WpGeom." << std::endl;
}
void RecGeomSvc::initTtGeomControl(bool value)
{
     if (value)
     initTtGeom();
     else
     LogDebug << "Do not initialize TtGeom." << std::endl;
}

bool RecGeomSvc::initCdGeom()
{
    LogDebug << "initCdGeom " << std::endl;
    LogDebug << "GeomFile " << m_geomFileName << std::endl;

    m_CdGeom = new CdGeom();
    m_CdGeom->setVerb(0);
    m_CdGeom->setGeomFileName(m_geomFileName);
    m_CdGeom->setGeomPathName(m_geomPathName);
    m_CdGeom->setFastInit(m_fastInit);
    m_CdGeom->initRootGeo();
    m_CdGeom->printCd();
    LogInfo << "CdDetector Pmt size " << m_CdGeom->getPmtNum() << std::endl;
  
    return true;
}

bool RecGeomSvc::initWpGeom()
{
  LogDebug << "initWpGeom " << std::endl;
  LogDebug << "GeomFile " << m_geomFileName << std::endl;

  m_WpGeom = new WpGeom();
  m_WpGeom->setVerb(0);
  m_WpGeom->setGeomFileName(m_geomFileName);
  m_WpGeom->setGeomPathName(m_geomPathName);
  m_WpGeom->setFastInit(m_fastInit);
  m_WpGeom->initRootGeo();
  m_WpGeom->printWp();
  LogInfo << "WpDetector Pmt size " << m_WpGeom->getPmtNum() << std::endl;

  return true;
}

bool RecGeomSvc::initTtGeom()
{
    LogDebug << "initTtGeom " << std::endl;
    LogDebug << "GeomFile " << m_geomFileName << std::endl;

    m_TtGeom = new TtGeom();
    m_TtGeom->setVerb(1);
    m_TtGeom->setGeomFileName(m_geomFileName);
    m_TtGeom->setGeomPathName(m_geomPathName);
    m_TtGeom->setFastInit(m_fastInit);
    m_TtGeom->initRootGeo();
    LogInfo << "TtDetector channel size " << m_TtGeom->getChannelNum() << std::endl;

    return true;
}


CdGeom* RecGeomSvc::getCdGeom()
{
  if (!m_CdGeom)
  {
    LogDebug << "getCdGeom instance does not exist " << std::endl;
    return 0;
  }
  else
  {
    return m_CdGeom;
  }
}

WpGeom* RecGeomSvc::getWpGeom()
{
  if (!m_WpGeom)
  {
    LogDebug << "getWpGeom instance does not exist " << std::endl;
    return 0;
  }
  else
  {
    return m_WpGeom;
  }
}
TtGeom* RecGeomSvc::getTtGeom()
{
    if (!m_TtGeom)
    {
	LogDebug << "getTtGeom instance does not exist " << std::endl;
	return 0;
    }
    else
    {
        return m_TtGeom;
    }
}

bool RecGeomSvc::finalize()
{
    return true;
}

