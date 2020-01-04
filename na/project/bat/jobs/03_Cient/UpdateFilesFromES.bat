@echo off

rem *** FROM ***
set fromPath_runbin="\\BSWWW2ES03\BSWWW2ES03_D\mt_hmi_pa_lp\projectLP\runbin"
set fromPath_dat="\\BSWWW2ES03\BSWWW2ES03_D\mt_hmi_pa_lp\projectLP\dat"
rem *** TO ***
set toPath_runbin="D:\mt_hmi_pa_lp\projectLP\runbin"
set toPath_dat="D:\mt_hmi_pa_lp\projectLP\dat"

robocopy %fromPath_runbin% %toPath_runbin% /mir
robocopy %fromPath_dat% %toPath_dat% /mir