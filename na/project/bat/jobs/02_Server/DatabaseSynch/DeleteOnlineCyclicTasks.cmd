rem In case new scheduled tasks are defined for online database, please add the stop sentence in here
schtasks /Delete /TN createDump /F 
schtasks /Delete /TN deleteDumps /F
schtasks /Delete /TN deleteRedoLogs /F
schtasks /Delete /TN deleteReports /F 