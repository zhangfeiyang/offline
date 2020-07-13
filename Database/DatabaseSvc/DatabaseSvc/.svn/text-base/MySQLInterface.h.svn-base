#ifndef MYSQLINTERFACE_H
#define MYSQLINTERFACE_H

#include "SqlString.h"
#include "DatabaseSvc.h"
#include "DBInterfaceBase.h"
#include "DBIResult.h"

class MySQLInterface: public DBInterfaceBase
{

 //friend class DBInterface;
 friend class DatabaseSvc;

 MySQLInterface(const Context& c): MySQL_Context(c) {}
 MySQLInterface(const Con_Info& ci) : mysqlconinfo(ci) {}

 void Lookup_column();

 void Lookupquery();

 void Query();

 void Insertdatapath();

 void Insertdatacode();

 void Update();

 bool IfConnect();

 bool Reconnect();

 void CreateStmt();

 DBIResult& FetchResult() {return MySQL_Result;}

 bool Connect();

 void SetUrl(std::string& url) { MySQL_Context.SetUrl(url); }
 void SetUser(std::string& user) { MySQL_Context.SetUser(user); }
 void SetPasswd(std::string& pasd) { MySQL_Context.SetPasswd(pasd); }
 void SetRequest(const DBIRequest& rq) { mysqlrequest = rq; }

 Con_Info& Getconinfo(){ return mysqlconinfo; }

 //corresbonding to the base class stuff
 void DeleteTable();
 void DeleteRecord();
 void DeleteColumn();
 void AddColumn();
 void RenameTable();
 void RenameColumn();

 Con_Info mysqlconinfo;
 DBIRequest mysqlrequest;
 Context MySQL_Context;

 DBIResult MySQL_Result;

};

#endif
