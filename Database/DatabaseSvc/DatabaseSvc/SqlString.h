#ifndef SQLSTRING_H
#define SQLSTRING_H
#include <string>
#include <vector>
#include "DBIResultPtr.h"
#include "DBITableRow.h"
#include "DBIRequest.h"

//class DBIResultPtr;

/*template<class T>
std::vector<T>& operator << (std::vector<T>& vc, DBIResultPtr& ptr)
 {
  T sample;
  std::string TableName = sample.GetTableName();
  std::string query = "select * from offline_db."+ TableName;
  DBIRequest request(query);
  ptr.SetRequest(request);
  ptr.Session();
  int row = ptr.GetMaxRowcount();
  int memnum = sample.GetNumMember();
  for(int i=0; i<row; i++)
  {
   ptr.GetResByRowNum(i);
   for(int j=0; j<memnum; j++)
   {
    std::string membername  = sample.GetMemberTypebyIndex(j);
    std::string membervalue = ptr.GetString(membername);
    const char* memvalue = membervalue.c_str();
    vc[i].SetMemberValuebyName(memvalue, membername);
   }
  }
 }*/

namespace SqlString
{
 std::string updatequery(const std::string&,
                         const std::string&,
                         const std::string&,
                         const std::string&,
                         const std::string&);
 std::string rntnamequery(const std::string&, const std::string&);
 std::string deltablequery(const std::string&);
 std::string delrecordquery(const std::string&,
                            const std::string&,
                            const std::string&);
 std::string delcolumnquery(const std::string&, const std::string&);
 std::string addcolumnquery(const std::string&, const std::string&);
 std::string rncnamequery(const std::string&,
                          const std::string&,
                          const std::string&);

 std::string insertquery(const std::string&,
                         const std::string&,
                         const std::string&);
}

#endif
