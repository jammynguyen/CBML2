echo off
rem ************************************************************************
rem *
rem *  This is the main entry point to set up the server as Online or Standby
rem *
rem ************************************************************************

SET DB_USER=SYS
SET DB_PASS=bsw09oly4Amin
SET DB_SID=BSW
SET DB_CONNECT_STR=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=%DB_SID%)))
goto requestMode

rem ConnectToDB and calls a script file, before comming inside here set the variable back with the corresponding return point and 
rem variable fileToCall with the corresponding file to be called
:connectToDB
set ORACLE_SID=%DB_SID%
rem sqlplus %DB_USER%/%DB_PASS% as sysdba @.\%fileToCall%
sqlplus %DB_USER%/%DB_PASS% as sysdba @%fileToCall%
goto %back%

rem ConnectToDB and calls a script file, before comming inside here set the variable back with the corresponding return point and 
rem variable fileToCall with the corresponding file to be called
:connectDBIdleInstance
set ORACLE_SID=%DB_SID%
rem sqlplus /nolog @.\%fileToCall%
sqlplus /nolog @%fileToCall%
goto %back%

rem --------------- Ask for mode input ---------------------
:wronginput
echo wrong input, only ONLINE/STANDBY is valid
goto askagain
:requestMode
echo "Please, input the mode you want to set up for this server. ONLINE/STANDBY:"
:askagain
SET /P mode=
IF /I "%mode%"=="ONLINE" goto onlineMode
IF /I "%mode%"=="STANDBY" goto standbyMode
goto wronginput

rem ----------------- ONLINE MODE SETUP ---------------------
:onlineMode
set fileToCall=shutdownDB.sql
set back=connnectedForOnline
goto connectToDB
:connnectedForOnline

echo ---> startup mounted 
set fileToCall=setDBOnline.sql
set back=connnectedForOnline2
goto connectDBIdleInstance
:connnectedForOnline2

echo Database setup finished!



rem TODO: continue with the rest of the task to set the server ONLINE
goto end


rem ----------------- STANDBY MODE SETUP ---------------------
:standbyMode
set fileToCall=shutdownDB.sql
set back=connnectedForStandby
goto connectToDB
:connnectedForStandby

echo ---> startup mounted 
set fileToCall=setDBStandby.sql
set back=connnectedForStandby2
goto connectDBIdleInstance
:connnectedForStandby2
echo Database setup finished!

rem TODO: continue with the rest of the task to set the server STANDBY
goto end




:end
echo CONFIGURATION AS %mode% DONE!