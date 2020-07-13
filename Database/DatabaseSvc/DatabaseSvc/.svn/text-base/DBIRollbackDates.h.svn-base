#ifndef DBIROLLBACKDATES_H
#define DBIROLLBACKDATES_H

#include <map>
#include <vector>
#include <string>
#include "Context/TimeStamp.h"

#ifndef ROOT_Rtypes
#if !defined(__CINT__) || defined(__MAKECINT__)
#include "Rtypes.h"
#endif
#endif

class DBIRollbackDates
{
 public:

 typedef std::map<std::string, std::string> name_map_t;

 DBIRollbackDates();
 virtual ~DBIRollbackDates();

 //const std::string& Get(const std::string& tableName) const;
 void Show();

 //void Clear() {fTableToDate.clear();}
 void Set(const std::vector<std::string>& config);
 //void Set(const std::string& config);

 private:

 std::map<std::string,std::string> fTableToDate;

};

#endif
