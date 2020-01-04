set workingDir="D:\na\project\bat\jobs\02_Server\DatabaseSynch"
set dumpLogFile="F:\Dumps\logdump.txt"
set dumpFolder="F:\Dumps"
set archiveLogFolder="F:\archiveLogs"
set reportFolder="D:\mt_hmi_pa_lp\projectLP\dat\print_outs"

rem tasks for dump creation
schtasks /create /tn createDump /tr "%workingDir%\create_dmp.cmd > %dumpLogFile%" /sc DAILY /st 05:00:00

rem delete old dump files
schtasks /create /tn deleteDumps /tr "%workingDir%\delete_files_older_than.cmd %dumpFolder% 3 *.*" /sc DAILY /st 04:00:00

rem delete old archived redo log files
schtasks /create /tn deleteRedoLogs /tr "%workingDir%\delete_files_older_than.cmd %archiveLogFolder% 2 *.*" /sc DAILY /st 04:30:00

rem delete report files
schtasks /create /tn deleteReports /tr "%workingDir%\delete_files_older_than.cmd %reportFolder% 60 *.xlsx" /sc DAILY /st 04:50:00
