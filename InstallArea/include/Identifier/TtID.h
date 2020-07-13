#ifndef JUNO_DETECTOR_TT_ID_H
#define JUNO_DETECTOR_TT_ID_H

//
//  This class provide hierarchy and functions for Top Tracker Identifier
//
//  Author: Kaijie Li
//

#include "Identifier/JunoDetectorID.h"
#include <string>
#include <assert.h>

class TtID : public JunoDetectorID
{
    public:

        typedef Identifier::size_type  size_type; 
        typedef Identifier::value_type value_type; 

        /// constructor
        TtID();

        /// destructor 
        ~TtID();
 
        /// For a single channel
	static Identifier id ( unsigned int module,
		               unsigned int channel
			     );
        static Identifier id ( int value );
        static value_type getIntID ( unsigned int module,
		                     unsigned int channel
				   );
	static bool valuesOk ( const unsigned int module,
	                       const unsigned int channel
		       	     );
	/// Values of different levels (failure returns 0)
	static int module (const Identifier& id);
	static int channel (const Identifier& id);

	/// Max/Min values for each field (error returns -999)
	static int moduleMin();
	static int moduleMax();
        static int moduleChannelMin();
	static int moduleChannelMax();

	static int moduleChannelNumber();

	/// Set Module Max(when geometry not fixed)
	static void setModuleMax(unsigned int value) { MODULE_MAX = value; }
	static void setModuleChannelMin(unsigned int value) { MODULE_CHANNEL_MIN = value; }
	static void setModuleChannelMax(unsigned int value) { MODULE_CHANNEL_MAX = value; }
    private:

	typedef std::vector<Identifier> idVec;
	typedef idVec::const_iterator   idVecIt;

	static const unsigned int MODULE_INDEX    = 16;
	static const unsigned int MODULE_MASK     = 0x00FF0000;

        static const unsigned int CHANNEL_INDEX       = 0;
      	static const unsigned int CHANNEL_MASK        = 0x0000FFFF;

	static const unsigned int MODULE_MIN      = 0;
	static       unsigned int MODULE_MAX;
	
	static       unsigned int MODULE_CHANNEL_MIN;
	static       unsigned int MODULE_CHANNEL_MAX;

	//static const unsigned int MODULE_CHANNEL_MAX  = 0;
	//static const unsigned int MODULE_CHANNEL_MIN  = 0;

};

#endif // JUNO_DETECTOR_TT_ID_H
