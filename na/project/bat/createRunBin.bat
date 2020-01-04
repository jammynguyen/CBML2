@echo off
echo copies all needed dlls for HMI to runbin (usually in mt_hmi_pa_msm\projectPM\jobs)
del %projectHmiLpDir%\runbin\*.*
echo ... deleted
echo now copying (please press a key) ...
pause
copy %cisHmiPaDir%\bin\%BUILD%\*.* %projectHmiLpDir%\runbin
copy %cisHmiPaCoreDir%\bin\%BUILD%\*.* %projectHmiLpDir%\runbin
REM copy %cisHmiPaFrameDir%\bin\%BUILD%\*.* %projectHmiLpDir%\runbin
copy %projectHmiLpDir%\bin\%BUILD%\*.* %projectHmiLpDir%\runbin
copy %productHmiDir%\redist\*.* %projectHmiLpDir%\runbin
copy %mtHmiPaBaseDir%\bin\%BUILD%\*.* %projectHmiLpDir%\runbin
REM copy %projectHmiPfcDir%\fixSqlServer\*.* %projectHmiPfcDir%\runbin
copy %subsysDir%\bin\%BUILD%\*.* %projectHmiLpDir%\runbin

rem echo copies L2 exes to runbin (for wdog)
rem copy %PROJECT_DIR%\bin\%BUILD%\pfcNC.* %PROJECT_DIR%\runbin\

pause
