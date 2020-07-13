#include "DatabaseSvc/SqlString.h"
#include "DatabaseSvc/DBIResultPtr.h"

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

std::string SqlString::updatequery(const std::string& setquery,
                                   const std::string& tablename,
                                   const std::string& rclimquery,
                                   const std::string& order,
                                   const std::string& rowcount)
{
 std::string query;
 query = "UPDATE " + tablename + " SET " + setquery;
 if(!rclimquery.empty())
 query = query + " WHERE " + rclimquery;
 if(!order.empty())
 query = query + " ORDER BY " + order;
 if(!rowcount.empty())
 query = query + " LIMIT " + rowcount;

 return query;
}

std::string SqlString::rntnamequery(const std::string& oldtablename,
                                    const std::string& newtablename)

{
 std::string query;
 query = "RENAME TABLE " + oldtablename + " TO " + newtablename;

 return query;
}

std::string SqlString::deltablequery(const std::string& tablename)

{
 std::string query;
 query = "DROP TABLE IF EXISTS " + tablename;

 return query;
}

std::string SqlString::delrecordquery(const std::string& tablename,
                                      const std::string& rclimquery,
                                      const std::string& rowcount)

{
 std::string query;
 query = "DELETE FROM " + tablename;
 if(!rclimquery.empty())
 query = query + " WHERE " + rclimquery;
 if(!rowcount.empty())
 query = query + " LIMIT " + rowcount;

 return query;
}

std::string SqlString::delcolumnquery(const std::string& columnname,
                                      const std::string& tablename)

{
 std::string query;
 query = "ALTER TABLE " + tablename + " DROP COLUMN " + columnname;

 return query;
}

std::string SqlString::addcolumnquery(const std::string& columnname,
                                      const std::string& tablename)

{
 std::string query;
 query = "ALTER TABLE " + tablename + " ADD COLUMN " + columnname;

 return query;
}

std::string SqlString::rncnamequery(const std::string& tablename,
                                    const std::string& oldcolumn,
                                    const std::string& newcolumn)

{
 std::string query;
 query = "ALTER TABLE " + tablename;
 query = query + " CHANGE " + oldcolumn + " " + newcolumn;

 return query;
}

std::string SqlString::insertquery(const std::string& tablename,
                                   const std::string& columnname,
                                   const std::string& values)
{
 std::string query;
 query = "INSERT INTO " + tablename;
 query = query + " " + columnname + " VALUES " + values;

 return query;
}
