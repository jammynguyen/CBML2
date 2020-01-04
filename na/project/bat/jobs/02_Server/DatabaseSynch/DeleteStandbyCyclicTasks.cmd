rem In case new scheduled tasks are defined for standby database, please add the stop sentence in here
schtasks /Delete /TN deleteArchiveLogsStandby  /F
schtasks /Delete /TN applyRedoLogs /F
schtasks /Delete /TN deleteReports /F 