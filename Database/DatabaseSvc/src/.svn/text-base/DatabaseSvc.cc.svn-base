#include <iostream>
#include "DatabaseSvc/DatabaseSvc.h"
#include "SniperKernel/SvcFactory.h"

DECLARE_SERVICE(DatabaseSvc);

DatabaseSvc::DatabaseSvc(const std::string& name):
SvcBase(name)

{
 declProp("Url", furl);
 declProp("User", fuser);
 declProp("Password", fpassword);
 declProp("DB_Type", fdbtype=1);

 LogInfo << "constructing DBInterface..." << std::endl;

 if(1==fdbtype)

 {
  LogInfo << "DB_Svc will connect to MySQL with Connector..." << std::endl;
 }
}

void DatabaseSvc::Session(const DBIRequest& rq)
{

 svc -> SetRequest(rq);

 if(lookup == rq.GetRequest())
 {
  LogInfo << "the request is select " /*<< extract fproperty*/<< "from "
           << rq.GetTableName() << std::endl;

  Lookup_column();

 }

 else if(infilepath == rq.GetRequest())
 {

  LogInfo << "the request is load data local infile "
            << rq.GetSqlquery()
            << " into table "
            << rq.GetTableName() << std::endl;

  Insertdatapath();

 }

 else if(query == rq.GetRequest())
 {
  LogInfo << "Going to query.." << std::endl;

  Query();
 }

 else if(update == rq.GetRequest())
 {
  LogInfo << "Going to update.." << std::endl;

  Update();
 }

 else if(lkupquery == rq.GetRequest())
 {
  LogInfo << "Going to look up data in query.." << std::endl;

  Lookupquery();
 }
}

bool DatabaseSvc::initialize()
{
 if(1 == fdbtype)
 {
  coninfo.SetUrl(furl);
  coninfo.SetUser(fuser);
  coninfo.SetPasswd(fpassword);
  coninfo.SetDBType(MySQL);

  svc = new MySQLInterface(coninfo);

  //return Connect();
  return Reconnect();
 }
 //Remember this one is going to be changed to logerror
 LogInfo << "DatabaseSvc is not initialized in Mysql way" << std::endl;
 return false;
}

bool DatabaseSvc::finalize()
{
 LogInfo << "Destroying DatabaseSvc..." << std::endl;
 return true;
}
