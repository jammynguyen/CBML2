@echo off

rem *** LOCAL PAHTS ***
set frompath_runbin="D:\mt_hmi_pa_lp\projectLP\runbin"
set frompath_dat="D:\mt_hmi_pa_lp\projectLP\dat"

set clientListpath=D:\na\project\bat\jobs\01_EngineeringStation\ClientList.txt

for /f "eol= tokens=1" %%i in (%clientListpath%) do xcopy /y /e /i /d %frompath_runbin% \\%%i\%%i_d\mt_hmi_pa_lp\projectLP\runbin
for /f "eol= tokens=1" %%i in (%clientListpath%) do xcopy /y /e /i /d %frompath_dat% \\%%i\%%i_d\mt_hmi_pa_lp\projectLP\dat

PAUSE