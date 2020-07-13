#ifndef DBITABLEROW_H
#define DBITABLEROW_H

#include <iostream>
#include <string>
//#include <typeinfo>
#include <sstream>
//#include <cctype>
//#include "SniperKernel/SniperLog.h"
#include "TObject.h"
#include "TClass.h"
#include "TList.h"
#include "TDataMember.h"
#include "TMethodCall.h"


class DBITableRow:public TObject
{
 public:
 DBITableRow();
 virtual ~DBITableRow();

 virtual int GetNumMember();
 virtual std::string GetTableName();
 virtual std::string GetMemberNamebyIndex(int);
 virtual std::string GetMemberTypebyIndex(int);
 virtual std::string GetMemberTypebyName(std::string);
 virtual std::string GetMemberValuebyIndex(int);
 virtual std::string GetMemberValuebyName(std::string);

 virtual void SetMemberValuebyIndex(std::string&, int);
 virtual void SetMemberValuebyName(std::string&, std::string);

 private:

 virtual void Init();

 TClass* cl;
 TList* lis;

 ClassDef(DBITableRow, 1)

};

template<class T>
std::string ValueToString(T& value)
 {
  std::ostringstream s;
  s << value;
  return s.str();
 }

#endif
