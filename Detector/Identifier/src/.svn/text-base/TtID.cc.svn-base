//
//  Author: Kaijie Li
//

#include "Identifier/TtID.h"
#include <assert.h>
#include <iostream>

unsigned int TtID::MODULE_MAX = 255;
unsigned int TtID::MODULE_CHANNEL_MIN = 0;
unsigned int TtID::MODULE_CHANNEL_MAX = 30720;

TtID::TtID(void)
{
}

TtID::~TtID(void)
{
}

//----------------------------------------------------------------------------
bool TtID::valuesOk ( const unsigned int module,
                      const unsigned int channel
		    )
{
    if ( module  > MODULE_MAX)  return false;
    if ( channel > MODULE_CHANNEL_MAX)  return false;

    return true;
}

//----------------------------------------------------------------------------
int TtID::module (const Identifier& id)
{
    return ((id.getValue() & TtID::MODULE_MASK) >>  TtID::MODULE_INDEX);
}

//----------------------------------------------------------------------------
int TtID::channel(const Identifier& id)
{
    return ((id.getValue() & TtID::CHANNEL_MASK) >>  TtID::CHANNEL_INDEX);
}

//----------------------------------------------------------------------------
int TtID::moduleMax()
{
    return MODULE_MAX;
}

//----------------------------------------------------------------------------
int TtID::moduleMin()
{
    return MODULE_MIN;
}

//----------------------------------------------------------------------------
int TtID::moduleChannelMax()
{
    return MODULE_CHANNEL_MAX;
}

//----------------------------------------------------------------------------
int TtID::moduleChannelMin()
{
    return MODULE_CHANNEL_MIN;
}

//----------------------------------------------------------------------------
int TtID::moduleChannelNumber()
{
    return moduleChannelMax() - moduleChannelMin() + 1;
}

//----------------------------------------------------------------------------
Identifier TtID::id ( unsigned int module,
                      unsigned int channel
					)
{
	assert ( valuesOk(module, channel) );
	unsigned int value = (JunoDetectorID::TT_ID << TT_INDEX) |
			     (module << MODULE_INDEX) |
			     (channel << CHANNEL_INDEX);
	return Identifier(value);
}

//----------------------------------------------------------------------------
Identifier TtID::id(int value)
{
    return Identifier(value);
}

//----------------------------------------------------------------------------
unsigned int TtID::getIntID ( unsigned int module,
                              unsigned int channel
							)
{
    unsigned int value = (JunoDetectorID::TT_ID << TT_INDEX) |
                         (module << MODULE_INDEX) |
                         (channel << CHANNEL_INDEX);
    return value;
}

