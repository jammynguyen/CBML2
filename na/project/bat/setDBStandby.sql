connect / as sysdba
startup mount
alter database noarchivelog;
alter system set log_archive_dest = '' scope = spfile;
alter system set log_archive_dest_1 = 'LOCATION=c:\archiveLogs';
alter system set LOG_ARCHIVE_FORMAT = 'arch_%t_%s_%r.arc' scope = spfile;
--alter database open;
--alter system archive log stop;
quit