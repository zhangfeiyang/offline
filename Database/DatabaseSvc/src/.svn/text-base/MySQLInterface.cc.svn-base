#include "DatabaseSvc/MySQLInterface.h"
#include <stdexcept>

bool MySQLInterface::Connect()
{

 sql::Connection*
 con(sql::mysql::get_driver_instance()
 ->connect(mysqlconinfo.GetURL(),
           mysqlconinfo.GetUSER(),
           mysqlconinfo.GetPASSWORD()));

 MySQL_Result.SetConnection(con);

 if(IfConnect())

 {
  LogInfo << "Successfully accessed to " <<
  mysqlconinfo.GetURL() << std::endl;
  CreateStmt();
  return true;
 }

 else

 {
  LogError << "Connected failed" << std::endl;
  return false;
 }

}

void MySQLInterface::Update()
{
 if(Reconnect())
 {

  std::string query = SqlString::updatequery(mysqlrequest.GetSetquery(),
                                             mysqlrequest.GetTableName(),
                                             mysqlrequest.GetRclimquery(),
                                             mysqlrequest.GetOrder(),
                                             mysqlrequest.GetRowcount());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::RenameTable()
{
if(Reconnect())
 {

  std::string query = SqlString::rntnamequery(mysqlrequest.GetOldtablename(),
                                              mysqlrequest.GetNewtablename());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::DeleteTable()
{
 if(Reconnect())
 {

  std::string query = SqlString::deltablequery(mysqlrequest.GetSqlquery());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::DeleteRecord()
{
if(Reconnect())
 {

  std::string query = SqlString::delrecordquery(mysqlrequest.GetTableName(),
                                                mysqlrequest.GetRclimquery(),
                                                mysqlrequest.GetRowcount());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::DeleteColumn()
{
 if(Reconnect())
 {

  std::string query = SqlString::delcolumnquery(mysqlrequest.GetOldtablename(),
                                                mysqlrequest.GetNewtablename());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::AddColumn()
{
 if(Reconnect())
 {

  std::string query = SqlString::addcolumnquery(mysqlrequest.GetOldtablename(),
                                                mysqlrequest.GetNewtablename());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::RenameColumn()
{
 if(Reconnect())
 {

  std::string query = SqlString::rncnamequery(mysqlrequest.GetSetquery(),
                                              mysqlrequest.GetTableName(),
                                              mysqlrequest.GetRclimquery());

  MySQL_Result.GetStatement()->execute(query);
 }
}

void MySQLInterface::Lookupquery()
{
 if(Reconnect())
 {
  sql::ResultSet*
  res(MySQL_Result.GetStatement()->executeQuery(mysqlrequest.GetSqlquery()));
  MySQL_Result.SetResult(res);
 }
}

bool MySQLInterface::IfConnect()
{

 if(MySQL_Result.GetConnection()!=NULL)
 {

  if(MySQL_Result.GetConnection()->isValid())

  return true;

  else

  return false;

 }

 else

 return false;

}

bool MySQLInterface::Reconnect()

{

 for(int i=1;i<=5;i++)
 {
  if(IfConnect())
  return true;
  else
  Connect();
 }

 LogError << "Tried too many times " << std::endl;
 LogError << "Please check your coninformation " << std::endl;

 return false;

}

void MySQLInterface::Lookup_column()

{

 if(!IfConnect())
 Reconnect();

 if(IfConnect())

 {

 //Read out data from the table
 std::string read_query = "select ";
 int sizelength = mysqlrequest.GetProperty().size();
 for (int i = 0; i < sizelength; i++)
 read_query = read_query 
            + mysqlrequest.GetProperty()[i] + ",";
 if(false == read_query.empty())
 read_query.erase(read_query.end()-1);
 read_query = read_query + " from "
            + mysqlrequest.GetTableName();
 //read_query = read_query + " limit 0,5";

 LogInfo << read_query << std::endl;

 //Store the data
 sql::ResultSet*
 res(MySQL_Result.GetStatement()->executeQuery(read_query));

 MySQL_Result.SetResult(res);

 LogInfo << "Result has been stored" << std::endl;

 //The stuff below is used to test the code, just ignore it.
 /*size_t row_count = res->rowsCount()-1;
 std::cout << "row_count is " << row_count << std::endl;

 //Selecting in ascending order but fetching in descending (reverse) order

 res->afterLast();
 if(true != res->isAfterLast())
 throw std::runtime_error("Position should be after last row (1)");

 while (res->previous())
 {
 for(auto i : c.Get_Request().GetPro())
  {
  std::cout << "#\t\t Row " << row_count << " "
  << i << " = " <<
  res->getString(i) << std::endl;
  }
 row_count--;
 }*/

 //stmt->execute(your SQL query);
 
 //MySQL_Result.SetStatement(stmt);

 //std::shared_ptr<sql::ResultSet>
 //res(stmt->executeQuery(your SQL query));
 //
 //MySQL_Result.SetResult(res);
 //
 }

}

void MySQLInterface::CreateStmt()

{

 sql::Statement*
 stmt(MySQL_Result.GetConnection()->createStatement());

 MySQL_Result.SetStatement(stmt);

}

void MySQLInterface::Query()

{
 if(IfConnect())

 {

 MySQL_Result.GetStatement()->
 execute(mysqlrequest.GetSqlquery());

 }
}

void MySQLInterface::Insertdatapath()

{
 if(IfConnect())
 {

  std::string query;
  query = "load data local infile "
        + mysqlrequest.GetSqlquery()
        + " into table "
        + mysqlrequest.GetTableName();
  MySQL_Result.GetStatement()->execute(query);

  LogInfo << "Successfully inserted data to"
          << mysqlrequest.GetTableName() << std::endl;

 }
}

void MySQLInterface::Insertdatacode()
{
 if(IfConnect())
 {

  std::string query;
  query = "insert into "
        + mysqlrequest.GetTableName()
        + " values "
        + mysqlrequest.GetSqlquery();

  MySQL_Result.GetStatement()->execute(query);

  LogInfo <<  "Successfully inserted data to "
          << mysqlrequest.GetTableName() << std::endl;
 }
}
