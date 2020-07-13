#include "DatabaseSvc/DBITableRow.h"
#include "SniperKernel/SniperLog.h"

ClassImp(DBITableRow);

DBITableRow::DBITableRow()
{
 //LogInfo << "Constructing TableRow class..." << std::endl;
 cl  = 0;
 lis = 0;
}

DBITableRow::~DBITableRow()
{
 //LogInfo << "Destroying TableRow class..." << std::endl;
}

std::string DBITableRow::GetTableName()
 {
  std::string TableName(this -> GetName());
  return TableName;
 }

std::string DBITableRow::GetMemberNamebyIndex(int id)
 {
  if(!lis||!cl)
  Init();
  TObject *ObjName = lis -> At(id);
  const char* name = ObjName -> GetName();
  std::string MemberName(name);
  return MemberName;
 }

std::string DBITableRow::GetMemberTypebyName(std::string name)
 {
  if(!lis||!cl)
  Init();
  const char* NameUse = name.c_str();
  TDataMember* obj = cl -> GetDataMember(NameUse);
  const char* typ = obj -> GetTrueTypeName();
  std::string TypeName(typ);
  return TypeName;
 }

std::string DBITableRow::GetMemberValuebyIndex(int id)
 {
  return GetMemberValuebyName(GetMemberNamebyIndex(id));
 }

std::string DBITableRow::GetMemberValuebyName(std::string name)
 {
  if(!lis||!cl)
  Init();
  const char* NameUse = name.c_str();
  //std::cout << "########check if the name is correct#########" << std::endl;
  TDataMember* obj = cl -> GetDataMember(NameUse);
  //std::cout << "#########this query should be output if the name if correct#########" << std::endl;
  const char* typ = obj -> GetTrueTypeName();
  //std::cout << "#########this query should be output if the obj is valid#########" << std::endl;
  TMethodCall *getter = obj -> GetterMethod(cl);
  //std::cout << "getter address: "<< getter << std::endl;
  //const char* forbool = "bool";
  const char* forlong = "long";
  const char* fordouble = "double";
  const char* forfloat = "float";
  //const char* forint = "int";
  const char* forchar = "char*";
  if(!strcmp(typ, forlong))
  {
   long res_long;
   //std::cout << "#########before execute#########" << std::endl;
   getter -> Execute(this, "", res_long);
   //std::cout << "#########after execute#########" << std::endl;
   return ValueToString(res_long);
  }
  else if(!strcmp(typ, forfloat))
  {
   double res_float;
   getter -> Execute(this, "", res_float);
   return ValueToString(res_float);
  }
  else if(!strcmp(typ, forchar))
  {
   char* res_char;
   getter -> Execute(this, "", &res_char);
   return ValueToString(res_char);
  }
  /*else if(!strcmp(typ, forint))
  {
   int res_int;
   getter -> Execute(this, "", res_int);
   return ValueToString(res_int);
  }
  else if(!strcmp(typ, forbool))
  {
   bool res_bool;
   getter -> Execute(this, "", res_bool);
   return ValueToString(res_bool);
  }*/
  else if(!strcmp(typ, fordouble))
  {
   double res_double;
   //std::cout << "#########before execute#########" << std::endl;
   getter -> Execute(this, "", res_double);
   //std::cout << "#########after execute#########" << std::endl;
   return ValueToString(res_double);
  }
  else
  {
   LogError << "Type can not matched, check your member type" << std::endl;
  }
 }

std::string DBITableRow::GetMemberTypebyIndex(int id)
 {
  return (GetMemberTypebyName(GetMemberNamebyIndex(id)));
 }

void DBITableRow::Init()
 {
  cl = this -> IsA();
  if(!cl)
  LogError << "Something wrong in getting TClass from DBITableRow" << std::endl;
  else
  {
   lis = cl -> GetListOfDataMembers();
   if(!lis)
   LogError << "Something wrong in getting TList from TClass" << std::endl;
   else
   LogInfo << "DBITableRow init succeed" << std::endl;
  }
 }

 int DBITableRow::GetNumMember()
 {
  if(!lis||!cl)
  Init();
  int num = cl -> GetNdata();
  return num;
 }

 void DBITableRow::SetMemberValuebyName(/*char* value*/std::string& value, std::string name)
 {
  if(!lis||!cl)
  Init();
  const char* NameUse  = name.c_str();
  const char* ValueUse = value.c_str();
  TDataMember* obj = cl -> GetDataMember(NameUse);
  TMethodCall *setter = obj -> SetterMethod(cl);
  setter -> Execute(this, ValueUse);
 }

 void DBITableRow::SetMemberValuebyIndex(std::string& value, int id)
 {
  SetMemberValuebyName(value,GetMemberNamebyIndex(id));
 }

/*std::string DBITableRow::GetTableName()
{
  std::string n = std::string(typeid(*this).name());
  int length = n.size();
  int reallength;
  for (int i = 0; i <= length-1; i++)
  {
  if(isalpha(n[i]))
  break;
  reallength = i+1;
  }
  std::string s;
  for(reallength; reallength <= length-1; reallength++)
  s = s + n[reallength];
  return s;
}*/

