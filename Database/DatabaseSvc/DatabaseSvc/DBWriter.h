#ifndef DBWRITER
#define DBWRITER

#include "Context.h"
#include "DatabaseSvc.h"
#include "DB_TableRow.h"

template <class T> class DBWriter
{

public:

DBWriter() {};
DBWriter(const Context& c);

virtual ~DBWriter() {};

DBWriter<T>& operator<<(const T& row);

private:

Context cx;

T temrow;

std::vector<T>* data;

};

template<class T>
DBWriter<T>::DBWriter(const Context& c):
cx(c)
{
LogInfo << "Constructing DBWriter..." << std::endl;
}

template<class T>
DBWriter<T>& DBWriter<T>::operator<<(const T& row)
{

temrow = row;
temrow.Store(cx);

return *this;

}

#endif
