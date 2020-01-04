@echo off
rem prompt $G

rem ***************************************************************
SET DB_USER=SYS
SET DB_PASS=bsw09oly4Amin
SET DB_SID=BSW
SET ORACLE_SID=%DB_SID%

SET workingDirectory=D:\na\project\bat\jobs\02_Server\setOnlineScripts

rem redolog files location
SET arcLogLocation=F:\archiveLogs

rem Absolute path to init.ora file
SET initOraPath=C:\Oracle\product\11.2.0\dbhome_1\dbs

rem Absolute path to the datafile location (*.dbf)
SET datafilesPath=E:\ORADATA\BSW

rem Local path for coldStandby files, which is mirrored between both servers
SET pathToSharedFolder=D:\na\project\bat\ColdStandby

IF NOT exist %arcLogLocation% (
  echo %arcLogLocation% do not exists
  goto error
)
IF NOT exist %initOraPath% (
  echo %initOraPath% do not exists
  goto error
)
IF NOT exist %datafilesPath% (
  echo %datafilesPath% do not exists
  goto error
)
IF NOT exist %pathToSharedFolder% (
  echo %pathToSharedFolder% do not exists
  goto error
)

rem ***************************************************************
@echo on

@echo ---------------------------------------------------------------
@echo ------------------- START MASTER MODE SETUP -------------------
@echo ---------------------------------------------------------------
@echo.
@echo --------------------------- Step 1 ----------------------------
@echo Try to activate the standby database.
@echo IMPORTANT: could throw an error in case we run the script over an online database
@echo ---------------------------------------------------------------
del /Q %pathToSharedFolder%\initOra
del /Q %pathToSharedFolder%\controlFile
del /Q %pathToSharedFolder%\datafiles
del /Q %arcLogLocation%
rem activate the standby database
sqlplus /nolog @%workingDirectory%\activateStandbyDB.sql
@echo.
@echo --------------------------- Step 2 ----------------------------
@echo Stop the database and set the archivelog mode 
@echo and the redolog location.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\shutdownDB.sql
sqlplus /nolog @%workingDirectory%\setDBOnline.sql %arcLogLocation%
@echo.
@echo --------------------------- Step 3 ----------------------------
@echo Clean Local ColdStandby Folders and Redologs folder.
@echo ---------------------------------------------------------------
del /Q %pathToSharedFolder%\initOra
del /Q %pathToSharedFolder%\controlFile
del /Q %pathToSharedFolder%\datafiles
del /Q %arcLogLocation%
@echo.
@echo --------------------------- Step 4 ----------------------------
@echo Display the datafiles to be backuped.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\displayDataFiles.sql
@echo.
@echo --------------------------- Step 5 ----------------------------
@echo Shutdown the database cleanly.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\shutdownDB.sql
@echo.
@echo --------------------------- Step 6 ----------------------------
@echo Create a backup of the datafiles shown in step 3.
@echo ---------------------------------------------------------------
robocopy %datafilesPath% %pathToSharedFolder%\datafiles *.dbf
rem copy /Y %datafilesPath%\*.dbf %pathToSharedFolder%\datafiles
@echo.
@echo --------------------------- Step 7 ----------------------------
@echo Startup database
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\startup.sql
@echo.
@echo --------------------------- Step 8 ----------------------------
@echo Create the control file for the standby database,
@echo and open the primary database to user access.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\createStdbyCtlFile.sql %pathToSharedFolder%
@echo.
@echo --------------------------- Step 9 ----------------------------
@echo Archive the current online redo logs of the online database
@echo This operation ensures consistency among datafiles, 
@echo the control file and the redo log files.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\archiveCurrentRedoLog.sql
@echo.
@echo --------------------------- Step 10 ----------------------------
@echo Create a parameter file for the standby database based on
@echo the parameter file of the online database.
@echo ---------------------------------------------------------------
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\createPfileForStandby.sql %pathToSharedFolder%
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\shutdownDB.sql
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\startupMount.sql
sqlplus %DB_USER%/%DB_PASS% as sysdba @%workingDirectory%\openDatabase.sql

goto end

:error
echo exiting with error
pause

:end

