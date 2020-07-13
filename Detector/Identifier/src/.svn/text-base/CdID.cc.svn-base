//
//  Author: Zhengyun You  2013-11-20
//

#include "Identifier/CdID.h"
#include <assert.h>
#include <iostream>

unsigned int CdID::MODULE_MAX = 65535;  
unsigned int CdID::MODULE_20INCH_MIN = 0;
unsigned int CdID::MODULE_20INCH_MAX = 17738; // 17745; // findPmt20inchNum()-1
unsigned int CdID::MODULE_3INCH_MIN  = 17739; // 17746; // findPmt20inchNum()
unsigned int CdID::MODULE_3INCH_MAX  = 54310; // 54317; // findPmt20inchNum()+findPmt3inchNum()-1

CdID::CdID(void)
{
}

CdID::~CdID(void)
{
}

//----------------------------------------------------------------------------
bool CdID::valuesOk ( const unsigned int module,  
                       const unsigned int pmt
		     )
{
    // Check values
    //std::cout << " module = " << module << " pmt = " << pmt <<std::endl;
  
    if ( module  > MODULE_MAX)  return false;
    if ( pmt > MODULE_PMT_MAX)  return false;

    return true;
}

//----------------------------------------------------------------------------
int CdID::module (const Identifier& id)
{
    return ((id.getValue() & CdID::MODULE_MASK) >>  CdID::MODULE_INDEX);
}

//----------------------------------------------------------------------------
int CdID::pmt (const Identifier& id)
{
    return ((id.getValue() & CdID::PMT_MASK) >>  CdID::PMT_INDEX);
}

//----------------------------------------------------------------------------
bool CdID::is20inch (const Identifier& id)
{
    return (module(id) >= MODULE_20INCH_MIN && module(id) <= MODULE_20INCH_MAX);
}

//----------------------------------------------------------------------------
bool CdID::is3inch (const Identifier& id)
{
    return (module(id) >= MODULE_3INCH_MIN && module(id) <= MODULE_3INCH_MAX);
}

//----------------------------------------------------------------------------
int CdID::moduleMax()
{
    return MODULE_MAX;
}

//----------------------------------------------------------------------------
int CdID::moduleMin()
{
    return MODULE_MIN;
}

//----------------------------------------------------------------------------
int CdID::modulePmtMax()
{
    return MODULE_PMT_MAX;
}

//----------------------------------------------------------------------------
int CdID::modulePmtMin()
{
    return MODULE_PMT_MIN;
}

//----------------------------------------------------------------------------
int CdID::module20inchMin()
{
    return MODULE_20INCH_MIN;
}

//----------------------------------------------------------------------------
int CdID::module20inchMax()
{
    return MODULE_20INCH_MAX; 
}

//----------------------------------------------------------------------------
int CdID::module3inchMin()
{
    return MODULE_3INCH_MIN; 
}

//----------------------------------------------------------------------------
int CdID::module3inchMax()
{
    return MODULE_3INCH_MAX;
}

//----------------------------------------------------------------------------
int CdID::module20inchNumber() 
{
    return module20inchMax() - module20inchMin() + 1;
}

//----------------------------------------------------------------------------
int CdID::module3inchNumber() 
{ 
    return module3inchMax() - module3inchMin() + 1;
}

//----------------------------------------------------------------------------
Identifier CdID::id ( unsigned int module,
                      unsigned int pmt
                    )
{
    if (module >= MODULE_3INCH_SHIFT) {
        module = MODULE_3INCH_MIN + (module - MODULE_3INCH_SHIFT);
    }
 
    assert ( valuesOk(module, pmt) ); 
    unsigned int value = (JunoDetectorID::CD_ID << CD_INDEX) | 
                         (module << MODULE_INDEX) |
                         (pmt << PMT_INDEX);
    return Identifier(value); 
}

//----------------------------------------------------------------------------
Identifier CdID::id(unsigned int value)
{
    return Identifier(value);
}

//----------------------------------------------------------------------------
unsigned int CdID::getIntID ( unsigned int module,
                              unsigned int pmt
                            )
{
    unsigned int value = (JunoDetectorID::CD_ID << CD_INDEX) | 
                         (module << MODULE_INDEX) |
                         (pmt << PMT_INDEX);
    return value;
}
