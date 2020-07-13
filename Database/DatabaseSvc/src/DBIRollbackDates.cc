#include <cstring>
#include <stdexcept>
#include "DatabaseSvc/DBIRollbackDates.h"
#include "DatabaseSvc/DBI.h"

void DBIRollbackDates::Set(const std::vector<std::string>& config)
{

using std::string;

 bool  hasChanged = false;

 for(UInt_t i=0;i<config.size();i++) {

 string line = config[i];
 string::size_type p = line.find_first_of('=');
 if(p == string::npos) {
 std::cerr << "Incorrect form of rollback string; doesn't contain '=': " << line;
 }

 bool ok = true;
 string tablename = line.substr(0,p);

 p+=1;
 while(line[p]==' ') p++;
 string date = line.substr(p);

 TimeStamp ts(DBI::MakeTimeStamp(date,&ok));
 if ( ok ) {

 date = DBI::MakeDateTimeString(ts);
 int loc = date.size()-1;
 while ( loc && date[loc] == ' ' ) date.erase(loc--);

 fTableToDate[tablename] = date;
 hasChanged = true;

 } else {

 std::cout
 << "Illegal Rollback config item: " << line << std::endl
 << "Tablename = [" << tablename << "]   date = [" << date << "]" << std::endl;

 }
 }
 if ( hasChanged ) this->Show();
}

//This one is not completely finished, it will be finished later.
/*void DBIRollbackDates::Set(const std::string& str)
{

 LogInfo << "DBIRollbackDates::Set [" << str << "]" << std::endl;

 std::vector<std::string> v;
 std::string delim(",");
 //UtilString::String(v, str, delim);
 this->Set(v);
}*/

void DBIRollbackDates::Show() /*const*/
{

 LogInfo << "\n\nRollback Status:   ";
 if(0 == fTableToDate.size()) LogInfo << "Not enabled" << std::endl;
 else
 {
  LogInfo << std::endl;
  name_map_t::const_reverse_iterator itr = fTableToDate.rbegin();
  name_map_t::const_reverse_iterator itrEnd = fTableToDate.rend();
  for(; itr != itrEnd; ++itr)
  {
   std::string name = itr->first;
   if(name.size()<30) name.append(30-name.size(),' ');
   LogInfo << "\b" << name << "\b" << itr->second << std::endl;
  }
 }
}
