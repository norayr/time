MODULE time;
IMPORT SYSTEM;

PROCEDURE -Aincludesystime  '#include <sys/time.h>';  (* for gettimeofday *)
PROCEDURE -Aincludetime     '#include <time.h>';      (* for localtime *)
PROCEDURE -Aincludesystypes '#include <sys/types.h>';

PROCEDURE -gettimeval "struct timeval tv; gettimeofday(&tv,0)";
PROCEDURE -tvsec():  LONGINT   "tv.tv_sec";
PROCEDURE -tvusec(): LONGINT   "tv.tv_usec";
PROCEDURE -sectotm(s: LONGINT) "struct tm *time = localtime((time_t*)&s)";
PROCEDURE -tmsec():  LONGINT   "(LONGINT)time->tm_sec";
PROCEDURE -tmmin():  LONGINT   "(LONGINT)time->tm_min";
PROCEDURE -tmhour(): LONGINT   "(LONGINT)time->tm_hour";
PROCEDURE -tmmday(): LONGINT   "(LONGINT)time->tm_mday";
PROCEDURE -tmmon():  LONGINT   "(LONGINT)time->tm_mon";
PROCEDURE -tmyear(): LONGINT   "(LONGINT)time->tm_year";

PROCEDURE -unixtime(VAR tmtype: HUGEINT)   "time(tmtype)";
PROCEDURE -unixtimediff(endtime, starttime: HUGEINT):   LONGREAL   "(LONGREAL)difftime(endtime, starttime)";

PROCEDURE Now*(VAR year, month, day, hour, min, sec: LONGINT);
BEGIN
  gettimeval; sectotm(tvsec());
  year := tmyear() + 1900;
  month := tmmon();
  day := tmmday();
  hour := tmhour();
  min := tmmin();
  sec := tmsec();
END Now;

PROCEDURE unixTime*(VAR t: HUGEINT);
BEGIN
  unixtime(t);
END unixTime;

PROCEDURE unixTimeDiff*(endTime, startTime: HUGEINT): LONGREAL;
BEGIN
  RETURN unixtimediff(endTime, startTime)
END unixTimeDiff;

END time.
