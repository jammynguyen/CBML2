
set workingDir="D:\na\project\bat\jobs\02_Server\setStandbyScripts"

rem we try to kill all active sessions but owr own session keeps alive
rem sqlplus sys/bsw09oly4Amin as sysdba @%workingDir%\killsessions.sql


sqlplus /nolog @%workingDir%\recover.sql
