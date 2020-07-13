#ifndef COMMON_INPUT_REVISER_H
#define COMMON_INPUT_REVISER_H

#include "SniperKernel/Incident.h"

class IInputStream;

class InputReviser : public Incident
{
    public :

        InputReviser(const std::string& msg, bool infinite = false);

        virtual ~InputReviser();

        virtual bool fire();

        bool  reset(int entry);

        int   getEntries();
        int   getEntry();
        std::string getFileName();

    private :

        bool init();

        bool              m_infinite;
        bool              m_revise;
        int               m_entries;
        IInputStream*     m_is;
};

#endif
