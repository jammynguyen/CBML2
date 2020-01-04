

SET DB_USER=SYS
SET DB_PASS=Siemens248
SET DB_SID=BSW
SET DB_CONNECT_STR=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=%DB_SID%)))
goto confirmation

rem --------------- CONFIRMATION ---------------------
:wronginput
echo wrong input, only Y/N is valid
goto askagain
:confirmation
echo "Are you sure you want to activate the standby database?. Y/N:"
:askagain
SET /P confirm=
IF /I "%confirm%"=="Y" goto activate
IF /I "%confirm%"=="N" goto end
goto wronginput

rem -------------- ACTIVATION -----------------------
:activate

rem stop cyclic tasks
call .\DatabaseSynch\stopStandbyCyclicTasks.cmd

rem shutdown database and mount it in exclusive mode
set ORACLE_SID=%DB_SID%
sqlplus %DB_USER%/%DB_PASS% as sysdba @.\shutdownDB.sql
sqlplus /nolog @.\DatabaseSynch\mountExclusiveMode.sql
rem activate the standby database
sqlplus /nolog @.\DatabaseSynch\activateStandbyDB.sql
sqlplus %DB_USER%/%DB_PASS% as sysdba @.\shutdownDB.sql

rem switch ip address
call setIPAdress.cmd ONLINE

rem activate archive log mode
sqlplus %DB_USER%/%DB_PASS% as sysdba @.\shutdownDB.sql
sqlplus /nolog @.\setDBOnline.sql

rem create db dump
call .\DatabaseSynch\create_dmp.cmd


:end
