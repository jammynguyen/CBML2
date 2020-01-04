echo off

rem *****************************************************************************
rem *
rem * Script for creating database dumps from online node
rem *
rem *
rem *****************************************************************************

echo ----------------------------------------------------------------------------
rem SET THE FOLLOWING ENVIRONMENT VARIABLES ACCORDING TO THE SYSTEM

rem set the absolut local path where the dump files will be places
set dump_path="F:\Dumps"
rem the path to the zipping application
set zip_path="C:\Program Files\7-Zip"
rem destination directory for zipped dump files in the standby server
rem set destination="\\172.18.40.123\F$\Dumps"

set parFile="D:\na\project\bat\jobs\02_Server\DatabaseSynch\exp_l2db.par"

rem Create dump of the online database
echo DMP BEGIN: %date% %time%
  For /f "tokens=1,2,3 delims=/. " %%a in ('date/T') do set CDate=%%c_%%b_%%a
  For /f "tokens=1,2 delims=: " %%f in ('time /t') do set CTime=%%f_%%g
  set datetime=%CDate%_%CTime%
  set FILENAME=%dump_path%\exp_bsw_l2db_%datetime%
  set LOGNAME=%dump_path%\exp_bsw_l2db_%datetime%
  echo expBegin
  exp 'SYS/bsw09oly4Amin AS SYSDBA' PARFILE=%parFile% FILE=%FILENAME%.dmp LOG=%LOGNAME%.log
  echo expEnd
echo DMP END: %date% %time%

echo .

rem zip dump and log file
echo zip BEGIN: %date% %time%
  set actual_path=%cd%
  echo %zip_path%
  cd %zip_path%
  call %zip_path%\7z a -tzip %FILENAME%.zip %FILENAME%.dmp %LOGNAME%.log
  cd %actual_path%
echo zip END: %date% %time%

echo .

rem copy zipped dump file to standby server
rem echo zip BEGIN: %date% %time%
rem  xcopy %FILENAME%.zip %destination% 
rem echo zip END: %date% %time% /F /L /Y