@echo off
prompt $G

rem ***************************************************************
SET DB_USER=SYS
SET DB_PASS=bsw09oly4Amin
SET DB_SID=BSW
SET ORACLE_SID=%DB_SID%

rem redolog files location in the standby server
SET arcLogLocation=F:\archiveLogs

rem Path to the local folder containing the datafiles
SET datafilesPath=E:\ORADATA\BSW

rem Path to the local folder containing the main control file
SET controlfilePath=E:\ORADATA\BSW

rem Path to the local folder containing the flash recovery control file
SET flashcontrolfilePath=C:\Oracle\fast_recovery_area\BSW

rem The name of the control files, as many as necessary
SET controlFileName1=CONTROL01.CTL
SET controlFileName2=CONTROL02.CTL
SET controlFileName3=CONTROL03.CTL
SET flashControlFileName1=CONTROL02.CTL

rem Local path for coldStandby files, which is mirrored between both servers
SET pathToSharedFolder=D:\na\project\bat\ColdStandby

IF NOT exist %arcLogLocation% (
  echo %arcLogLocation% do not exists
  goto error
)
IF NOT exist %datafilesPath% (
  echo %datafilesPath% do not exists
  goto error
)
IF NOT exist %controlfilePath% (
  echo %controlfilePath% do not exists
  goto error
)
IF NOT exist %flashcontrolfilePath% (
  echo %flashcontrolfilePath% do not exists
  goto error
)
IF NOT exist %pathToSharedFolder%\controlFile\standby_ctl_file.ctl (
  echo %pathToSharedFolder%\controlFile\standby_ctl_file.ctl do not exists
  goto error
)


rem ***************************************************************
@echo on

@echo ---------------------------------------------------------------
@echo ------------------- START STANDBY MODE SETUP ------------------
@echo ---------------------------------------------------------------
@echo.
@echo --------------------------- Step 1 ----------------------------
@echo Change the archive log mode.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @shutdownDB.sql
sqlplus /nolog @setDBStandby.sql %arcLogLocation%
@echo.
@echo --------------------------- Step 2 ----------------------------
@echo Shutdown database.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @shutdownDB.sql
@echo.
@echo --------------------------- Step 3 ----------------------------
@echo Replace the datafiles by the ones from othe online database.
@echo ---------------------------------------------------------------
rem copy /Y %pathToSharedFolder%\datafiles\*.* %datafilesPath%
robocopy %pathToSharedFolder%\datafiles\ %datafilesPath% *.* /mir
@echo.
@echo --------------------------- Step 4 ----------------------------
@echo Replace the control files by the ones generated from the online DB.
@echo Both, primary and flash recovery control files
@echo must be replaced to make them consistent.
@echo ---------------------------------------------------------------
copy /Y %pathToSharedFolder%\controlFile\standby_ctl_file.ctl %controlfilePath%\%controlFileName1%
copy /Y %pathToSharedFolder%\controlFile\standby_ctl_file.ctl %controlfilePath%\%controlFileName2%
copy /Y %pathToSharedFolder%\controlFile\standby_ctl_file.ctl %controlfilePath%\%controlFileName3%
copy /Y %pathToSharedFolder%\controlFile\standby_ctl_file.ctl %flashcontrolfilePath%\%flashControlFileName1%
@echo.
@echo --------------------------- Step 5 ----------------------------
@echo Create a new SPFILE for the standby database
@echo by using the PFILE created on the online database.
@echo ---------------------------------------------------------------
sqlplus /nolog @createSPfile.sql %pathToSharedFolder%
@echo.
@echo --------------------------- Step 6 ----------------------------
@echo Statup the database.
@echo ---------------------------------------------------------------
sqlplus /nolog @startupStandby.sql
@echo.
@echo --------------------------- Step 7 ----------------------------
@echo Recover.
@echo ---------------------------------------------------------------
sqlplus /nolog @recover.sql

goto end

:error
echo finished with error
pause

:end