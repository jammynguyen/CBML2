@echo off
taskkill /f /im ProcessExplorerForm.exe

set from_path_debug="D:\mt_hmi_pa_lp\projectLP\bin\Debug"
set from_path_redist="D:\mt_hmi_pa_lp\MT\redist"
set to_path_runbin="D:\mt_hmi_pa_lp\projectLP\runbin"

xcopy /d /y /e /i %from_path_debug% %to_path_runbin%
xcopy /d /y /e /i %from_path_redist% %to_path_runbin%
@echo on

start D:\mt_hmi_pa_lp\projectLP\runbin\ProcessExplorerForm.exe  -user=Administrator -pwd=duplo12 -facility=MwProjectLP