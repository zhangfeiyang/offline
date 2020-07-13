#ifndef DATABASESVC_H
#define DATABASESVC_H

#include <boost/python.hpp>
//#include <memory>
#include <string>
#include "MySQLInterface.h"
#include "DBIResult.h"
#include "Context.h"
#include "DBInterfaceBase.h"
#include "SniperKernel/SvcBase.h"

class DBInterfaceBase;
class DBIResult;
class MySQLInterface;

class DatabaseSvc : public SvcBase
{

 public :

 DatabaseSvc(const std::string& name);
 virtual ~DatabaseSvc(){};

 bool initialize();
 bool finalize();

 /*void Update() const { svc -> Update(); }
 void Query() const{ svc -> Query(); }
 void Lookup_column() const { svc -> Lookup_column(); }
 void Insertdatapath() const { svc -> Insertdatapath(); }
 void Insertdatacode() const { svc -> Insertdatacode(); }*/
 void Session(const DBIRequest&);
 DBIResult& FetchResult() const { return svc -> FetchResult(); }
 private :

 void Update() const { svc -> Update(); }
 void Lookupquery() const { svc -> Lookupquery(); }
 void Query() const{ svc -> Query(); }
 void Lookup_column() const { svc -> Lookup_column(); }
 void Insertdatapath() const { svc -> Insertdatapath(); }
 void Insertdatacode() const { svc -> Insertdatacode(); }

 //DBIResult& FetchResult() const { return svc -> FetchResult(); }

 std::string furl;
 std::string fuser;
 std::string fpassword;
 int fdbtype;

 DBInterfaceBase* svc;
 Context db_context;
 Con_Info coninfo;
 DBIRequest request;

 bool Connect() const { return (svc -> Connect()); }
 bool Reconnect() const {return (svc -> Reconnect());}
 void Use_MySQL_Connector();
};

#endif
