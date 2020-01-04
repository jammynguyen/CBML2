@echo off


SET PROJECT_ID=projectLP

call setaimenv

subst %rootDir% /D
subst %rootDir% %sourceDir%


rem take care to call this only after the substitution !
call %projectHmiLPDir%\ini\CIS_HMI_PA_env.cmd


REM %rootDir%
REM cd %projectsDir%\bat
rem start "MT L2LP release" cmd /K "set BUILD=release&& set PATH=%PATH%;%binDir%\release;"
REM start "MT L2LP debug"   cmd /K "set BUILD=debug&& set PATH=%PATH%;%binDir%\debug;"
rem start "MT L2LP HMI"     %projectHmiPfcDir%\ini\CIS_HMI_PA_env.cmd

CLOSE
rem devenv
rem devenv "%projectsDir%\src\proxies\pfcNc\mde2008\TestPFC.sln"