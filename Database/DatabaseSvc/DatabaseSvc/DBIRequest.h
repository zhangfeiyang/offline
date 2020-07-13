#ifndef DBIREQUEST_H
#define DBIREQUEST_H

#include <string>
#include <vector>
#include "Con_Info.h"

typedef enum
{

 lookup,

 lkupquery,

 createtable,

 query,

 infilepath,

 insertcode,

 update,

 renametable

}
RequestType;

class DBIRequest
{

 public:

 DBIRequest() {};

 DBIRequest(const std::string& oldtablename,
         const std::string& newtablename,
         RequestType reqpro = renametable):

 foldtablename(oldtablename),
 fnewtablename(newtablename),
 freqpro(reqpro){}

 DBIRequest(const std::vector<std::string>& property,
         const std::string& tablename,
         RequestType reqpro = lookup):

 fproperty(property),
 ftablename(tablename),
 freqpro(reqpro){}

 DBIRequest(const std::string& sqlquery,
         RequestType reqpro = lkupquery):

 fsqlquery(sqlquery),
 freqpro(reqpro){}

 DBIRequest(const std::string& setquery,
         const std::string& tablename,
         const std::string& recordlimitquery,
         const std::string& order,
         const std::string& rowcount,
         RequestType reqpro = update):

 fsetquery(setquery),
 ftablename(tablename),
 frecordlimitquery(recordlimitquery),
 forder(order),
 frowcount(rowcount),
 freqpro(reqpro){}

 virtual ~DBIRequest() {};

 RequestType GetRequest() const{ return freqpro; }

 const std::string GetTableName() const{ return ftablename; }

 const std::string GetSqlquery() const { return fsqlquery; }

 const std::string GetSetquery() const { return fsetquery; }

 const std::string GetRclimquery() const { return frecordlimitquery; }

 const std::string GetOrder() const { return forder; }

 const std::string GetRowcount() const { return frowcount; }

 const std::vector<std::string> GetProperty() const{ return fproperty; }

 const std::string GetOldtablename() const { return foldtablename; }
 const std::string GetNewtablename() const { return fnewtablename; }

 private:

 std::vector<std::string> fproperty;

 std::string foldtablename;
 std::string fnewtablename;

 std::string fsetquery;

 std::string ftablename;

 std::string frecordlimitquery;

 std::string forder;

 std::string frowcount;

 std::string fsqlquery;

 RequestType freqpro;
};

#endif
