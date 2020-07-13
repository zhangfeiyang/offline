#include <boost/python.hpp>
#include "SniperKernel/ToolFactory.h"
#include "SniperKernel/SniperLog.h"

#include "HepMC/GenEvent.h"
#include "HepMC/GenVertex.h"
#include "HepMC/GenParticle.h"

#include "GtHepEvtGenTool.h"
#include "HepEvt2HepMC.h"

DECLARE_TOOL(GtHepEvtGenTool);

GtHepEvtGenTool::GtHepEvtGenTool(const std::string& name)
    : ToolBase(name), m_parser(0)
{
    declProp("Source", m_source);
}

GtHepEvtGenTool::~GtHepEvtGenTool()
{
    if (m_parser) {
        delete m_parser;
    }
    m_parser = 0;
}

bool
GtHepEvtGenTool::configure()
{
    if (!m_parser) {
        if ("" == m_source) {
            LogError << "No HEPEvt source string given." << std::endl;
            return false;
        }
        m_parser = new HepEvt2HepMC;
        if (not m_parser->fill(m_source.c_str())) {
            LogError << "Failed to fill primary vertices using \""
                     << m_source << "\"" << std::endl;
            return false;
        }
        LogInfo  << "Filled HEPEvt cache with " << m_parser->cacheSize()
                << " events" << std::endl;
    }
    return true;
}

bool
GtHepEvtGenTool::mutate(HepMC::GenEvent& event)
{
    if (!m_parser)  {
        return false;
    }
    if (m_parser->cacheSize()>0) {
        LogDebug << "Reusing cache with " << m_parser->cacheSize()
                 << " events left" << std::endl; 
    } else {
        LogWarn << "WARNING: Reuse input source! Recommend more input lines!"
                << std::endl;
        if (not m_parser->fill(m_source.c_str())) {
            LogError << "Failed to fill primary vertices using \""
                     << m_source << "\"" << std::endl;
            return false;
        }
    }

    HepMC::GenEvent* new_event=0;
    if (not m_parser->generate(new_event)) {
        LogError << "Failed to generate new event" << std::endl;
        if (new_event) delete new_event;
        return false;
    }
    event = *new_event;
    delete new_event;

    return true;
}

