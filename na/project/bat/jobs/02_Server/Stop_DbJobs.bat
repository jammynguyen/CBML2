set workingDir="D:\na\project\bat\jobs\02_Server"

sqlplus sys/bsw09oly4Amin as sysdba @%workingDir%\stopdbjobs.sql
sqlplus MAIN/MAIN @%workingDir%\stopdbjobs.sql