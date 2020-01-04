connect / as sysdba
startup mount
alter database archivelog;
alter system set log_archive_dest = '' scope = spfile;
alter system set log_archive_dest_1 = 'LOCATION=F:\archiveLogs';
alter system set LOG_ARCHIVE_FORMAT = 'arch_%t_%s_%r.arc' scope = spfile;
alter database open;
ALTER SYSTEM SWITCH LOGFILE;
archive log list;
quit
