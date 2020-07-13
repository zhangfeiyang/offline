
#include "Event/ElecFeeChannel.h"
ClassImp(JM::ElecFeeChannel);

std::vector<unsigned int>&  JM::ElecFeeChannel::tdc() 
{
    if (m_tdc.size()==0 || m_tdc.size()!=m_adc.size()) {
        m_tdc.clear();

        for (int i = 0; i < m_adc.size(); ++i) {
            m_tdc.push_back(i);
        }
    }
    return m_tdc;
}

const std::vector<unsigned int>&  JM::ElecFeeChannel::tdc() const
{
    // FIXME
    // because this function is const, we could not modify m_tdc
    static std::vector<unsigned int> tdc;
    if (tdc.size()==0 || tdc.size()!=m_adc.size()) {
        tdc.clear();

        for (int i = 0; i < m_adc.size(); ++i) {
            tdc.push_back(i);
        }
    }
    return tdc;
}

