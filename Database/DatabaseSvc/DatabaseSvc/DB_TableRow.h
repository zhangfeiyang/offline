#ifndef DB_TABLEROW_H
#define DB_TABLEROW_H

#include <iostream>
#include <string>
#include "Context.h"
#include "DBWriter.h"

class DB_TableRow
{

 public:

 DB_TableRow() {};
 virtual ~DB_TableRow() {};

 

 virtual void Store(Context& c) = 0;
 //virtual void Store(std::string& tablename,
                    //std::string& colname,
                    //std::string& values) = 0;

};

#endif
