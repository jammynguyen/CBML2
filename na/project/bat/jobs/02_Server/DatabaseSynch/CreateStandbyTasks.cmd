set workingDir="D:\na\project\bat\jobs\02_Server\DatabaseSynch"
set archiveLogFolder="F:\archiveLogs"
set reportFolder="D:\mt_hmi_pa_lp\projectLP\dat\print_outs"

rem delete old redologs
schtasks /create /tn deleteArchiveLogsStandby /tr "%workingDir%\delete_files_older_than.cmd %archiveLogFolder% 2 *.*" /sc DAILY /st 04:30:00

rem apply redologs
schtasks /create /tn applyRedoLogs /tr "%workingDir%\apply_archive_logs.cmd" /sc MINUTE /mo 5

rem delete report files
schtasks /create /tn deleteReports /tr "%workingDir%\delete_files_older_than.cmd %reportFolder% 60 *.xlsx" /sc DAILY /st 04:50:00