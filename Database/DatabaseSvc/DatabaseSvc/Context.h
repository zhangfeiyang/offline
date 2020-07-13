#ifndef CONTEXT_H
#define CONTEXT_H

#include <string>
#include "Con_Info.h"
#include "DBIRequest.h"
#include "SniperKernel/SniperLog.h"

class Context
{

 public:

 Context(const Con_Info& coninf, const DBIRequest& reque):
 fCon_Info(coninf),
 fRequest(reque){}

 Context(const DBIRequest& reque):
 fRequest(reque){}

 Context() {};

 virtual ~Context() {};

 void SetUrl(std::string& url){ fCon_Info.SetUrl(url); }

 void SetUser(std::string& user){ fCon_Info.SetUser(user); }

 void SetPasswd(std::string& pasd){ fCon_Info.SetPasswd(pasd); }

 const Con_Info& Get_Con_Info() const { return fCon_Info; }

 const DBIRequest& Get_Request() const { return fRequest; }

 private:

 Con_Info fCon_Info;

 DBIRequest fRequest;

};

#endif
