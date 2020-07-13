#include "DatabaseSvc/DBIResultPtr.h"

void DBIResultPtr::init(Task* par, const std::string& path)
{
 this->m_obj = dynamic_cast<DatabaseSvc*>(par->find(path));
}

DBIResultPtr::DBIResultPtr(Task* par,
                           const std::string& path,
                           DBIRequest& rq):

PtrRequest(rq),
rowcountprotect(false)
{
 init(par, path);
}

DBIResultPtr::DBIResultPtr(const std::string& path, DBIRequest& rq):

PtrRequest(rq),
rowcountprotect(false)
{
 Task* par;

 try
 {
  par = Task::top();
 }
 catch(SniperException& e)
 {
  LogError << "TopTask=0: Please set TopTask or assign a TaskScope"
           << std::endl;
  throw e;
 }

 init (par, path);
}

DBIResultPtr::DBIResultPtr(const std::string& path):

rowcountprotect(false)
{
 Task* par;

 try
 {
  par = Task::top();
 }
 catch(SniperException& e)
 {
  LogError << "TopTask=0: Please set TopTask or assign a TaskScope"
           << std::endl;
  throw e;
 }

 init (par, path);
}

void DBIResultPtr::Session()
{
 m_obj -> Session(PtrRequest);
 rowcountprotect = false;
}

int DBIResultPtr::GetMaxRowcount()
{
 MvCursorafterLast();
 int max = m_obj->FetchResult().GetResult()->rowsCount() - 1;
 return max;
}
//id=0 means fetch the first line
void DBIResultPtr::GetResByRowNum(int id)
{
 //rowcountprotect prevents repeat-operations of moving cursor
 if(0 == id)
 rowcountprotect = false;
 if(false == rowcountprotect)
 {
  MvCursorbeforeFirst();
  rowcountprotect = true;
 }
 if(id >= RowCount)
 {
  int gap = id - RowCount;
  for(int i=0;i<=gap;i++)
  MvCursortoNext();
 }
 else
 {
  int gap = RowCount - id;
  for(int i=1;i<gap;i++)
  MvCursortoPrevious();
 }
}

void DBIResultPtr::MvCursorafterLast()
{
 if(m_obj->FetchResult().GetConnection()!=NULL)
 {
  if(m_obj->FetchResult().GetConnection()->isValid())
  LogInfo << "con is valid" << std::endl;
  else
  LogError << "con is unvalid" << std::endl;
 }
 else
 LogError << "con is unfetchable" << std::endl;
 m_obj->FetchResult().GetResult()->afterLast();

 if(true != m_obj->FetchResult().GetResult()->isAfterLast())
 LogError << "Position should be after last row (1)" << std::endl;
}

void DBIResultPtr::MvCursorbeforeFirst()
{
 RowCount = 0;
 if(m_obj->FetchResult().GetConnection()!=NULL)
 {
  if(m_obj->FetchResult().GetConnection()->isValid())
  LogInfo << "con is valid" << std::endl;
  else
  LogError << "con is unvalid" << std::endl;
 }
 else
 LogError<< "con is unfetchable" << std::endl;
 m_obj->FetchResult().GetResult()->beforeFirst();
}

void DBIResultPtr::MvCursortoNext()
{
 m_obj->FetchResult().GetResult()->next();
 RowCount++;
}

void DBIResultPtr::MvCursortoPrevious()
{
 m_obj->FetchResult().GetResult()->previous();
 RowCount--;
}

bool DBIResultPtr::GetBool(const std::string& str) const
{
 return m_obj->FetchResult().GetResult()->getBoolean(str);
}

int32_t DBIResultPtr::GetInt(const std::string& str) const
{
 return m_obj->FetchResult().GetResult()->getInt(str);
}

uint32_t DBIResultPtr::GetUInt(const std::string& str) const
{
 return m_obj->FetchResult().GetResult()->getUInt(str);
}

int64_t DBIResultPtr::GetInt64(const std::string& str) const
{
 return m_obj->FetchResult().GetResult()->getUInt64(str);
}

long double DBIResultPtr::GetDouble(const std::string& str) const
{
return m_obj->FetchResult().GetResult()->getDouble(str);
}

std::string DBIResultPtr::GetString(const std::string& str) const
{
return m_obj->FetchResult().GetResult()->getString(str);
}
