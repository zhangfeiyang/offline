#ifndef IJunoTimerSvc_h
#define IJunoTimerSvc_h

/* This class is migrated from IBesTimer in Boss.
 */ 
#include <boost/shared_ptr.hpp>

class JunoTimer;
typedef boost::shared_ptr<JunoTimer> JunoTimerPtr;

class IJunoTimerSvc {
    public:
        virtual JunoTimerPtr get(const std::string& name)=0;
        virtual ~IJunoTimerSvc(){}
};

#endif
