#ifndef DBIRESULT_H
#define DBIRESULT_H

//#include <memory>
#include "mysql_connection.h"
#include "mysql_public_iface.h"

class DBIResult
{

 public:

 DBIResult() {};

 DBIResult(sql::Connection* con):

 MySQL_con(con){}

 DBIResult(sql::Statement* stmt):

 MySQL_statement(stmt){}

 DBIResult(sql::ResultSet* res):

 MySQL_res(res){}

 DBIResult(sql::Connection* con,
        sql::ResultSet*  res):

 MySQL_con(con),
 MySQL_res(res){}

 DBIResult(sql::Connection* con,
        sql::Statement* stmt):

 MySQL_con(con),
 MySQL_statement(stmt){}

 DBIResult(sql::Statement* stmt,
        sql::ResultSet* res):

 MySQL_statement(stmt),
 MySQL_res(res){}

 DBIResult(sql::Connection* con,
        sql::Statement* stmt,
        sql::ResultSet* res):

 MySQL_con(con),
 MySQL_statement(stmt),
 MySQL_res(res){}

 virtual ~DBIResult() {};

 void SetConnection(sql::Connection* con) {MySQL_con = con ;}
 //void SetConnection(std::shared_ptr<sql::Connection> con) {MySQL_con = con;}

 sql::Connection* GetConnection() { return MySQL_con; }

 void SetStatement(sql::Statement* stmt) {MySQL_statement = stmt ;}
 //void SetStatement(std::shared_ptr<sql::Statement> stmt) {MySQL_stmt = stmt;}

 sql::Statement* GetStatement() { return MySQL_statement; }

 void SetResult(sql::ResultSet* res) {MySQL_res = res ;}
 //void SetDBIResult(std::shared_ptr<sql::DBIResultSet> res) {MySQL_res = res;}

 sql::ResultSet* GetResult() { return MySQL_res; }

 private:

 sql::Connection* MySQL_con;

 sql::Statement* MySQL_statement;

 sql::ResultSet* MySQL_res;

};

#endif
