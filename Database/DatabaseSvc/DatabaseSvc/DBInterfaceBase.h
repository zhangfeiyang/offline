#ifndef DBINTERFACEBASE_H
#define DBINTERFACEBASE_H

#include <iostream>

#include "Context.h"
#include "DBIResult.h"

class DBIResult;

class DBInterfaceBase
{

 //friend class DBInterface;

 //protected:
 public:

 DBInterfaceBase() {};
 virtual ~DBInterfaceBase() {};

 //private:

 virtual bool Connect()  = 0;

 virtual bool Reconnect() = 0;

 virtual void Query()  = 0;

 virtual void Lookupquery() = 0;

 virtual void Update() = 0;

 virtual void Lookup_column() = 0;

 virtual void Insertdatapath() = 0;

 virtual void Insertdatacode() = 0;

 //normally these can not be used through interface as consider of safety.
 virtual void DeleteTable() = 0;
 virtual void DeleteRecord() = 0;
 virtual void DeleteColumn() = 0;
 virtual void AddColumn() = 0;
 virtual void RenameTable() = 0;
 virtual void RenameColumn() = 0;
 //*************************

 virtual DBIResult& FetchResult() = 0;

 virtual void SetUrl(std::string&) = 0;

 virtual void SetUser(std::string&) = 0;

 virtual void SetPasswd(std::string&) = 0;

 virtual void SetRequest(const DBIRequest&) = 0;

 virtual Con_Info& Getconinfo() = 0;

};

#endif
