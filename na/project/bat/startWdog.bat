rem start the watchdog
start /min wdog -name wdogPFC
rem start as service: subsys\bin\wdog_starter -i -name wdogPFC -delay 40

start %subsysDir%\bin\acc.bat
echo start the ProcessExplorer via Link

REM: in the current dir (<projectsDir>/bat or subsysDir/bin a file parfile.tfp) saves the filter log settings
