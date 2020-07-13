#include <stdio.h>
#include <sstream>
#include <string>
#include <stdexcept>
#include "DatabaseSvc/DBI.h"

std::string DBI::MakeDateTimeString(const TimeStamp& timeStamp)
{
 return timeStamp.AsString("s");
}

TimeStamp DBI::MakeTimeStamp(const std::string& sqlDateTime,
                             bool* ok)
{
 struct date {
 int year;
 int month;
 int day;
 int hour;
 int min;
 int sec;};
 char dummy;

 static std::string lo = "1970-01-01 00:00:00";
 static std::string hi = "2038-01-19 03:14:07";

 TimeStamp nowTS;
 int nowDate = nowTS.GetDate();
 date defaultDate = {nowDate/10000, nowDate/100%100, nowDate%100,0,0,0};
 date input       = defaultDate;

 std::istringstream in(sqlDateTime);
 in >> input.year >> dummy >> input.month >> dummy >> input.day
 >> input.hour >> dummy >> input.min   >> dummy >> input.sec;

 if ( ok ) *ok = true;
 if (  sqlDateTime < lo || sqlDateTime > hi ) {
 if ( ok ) *ok = false;
 else { 
 static int bad_date_count = 0;
 if ( ++bad_date_count <= 20 ) {
 const char* last = (bad_date_count == 20) ? "..Last Message.. " : "";
 std::cerr
 << "Bad date string: " << sqlDateTime
 << " parsed as "
 << input.year  << " "
 << input.month << " "
 << input.day   << " "
 << input.hour  << " "
 << input.min   << " "
 << input.sec   
 << "\n    Outside range " << lo
 << " to " << hi << last << std::endl;
 }
 }

 input = defaultDate;
 }

 return TimeStamp(input.year,input.month,input.day,
                  input.hour,input.min,input.sec);
}
