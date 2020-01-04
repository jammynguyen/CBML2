echo off
rem This scrips set the IP address of the server to the online or standby one depending on the given parameter

set ONLINE_IP=172.18.40.122
set STANDBY_IP=172.18.40.123
set MASK=255.255.128.0
set GATEWAY=172.18.20.250

if "%1"=="ONLINE" goto setOnline
if "%1"=="STANDBY" goto setStandby

echo *****************************************************************
echo *
echo *  Usage: setIPAdress [ONLINE or STANDBY]
echo * 
echo *****************************************************************
goto end

:setOnline
set IP=%ONLINE_IP%
set MODE=ONLINE
goto confirm

:setStandby
set IP=%STANDBY_IP%
set MODE=STANDBY
goto confirm

:wronginput
echo wrong input, only y/n
goto askagain

:confirm
echo *****************************************************************
echo * SETTING SERVER IP ADDRESS TO %MODE%
echo *****************************************************************
echo "Are you sure you you want to set up the IP address to %IP%? y/n:"
:askagain
SET /P confirmation=
IF /I "%confirmation%"=="n" goto cancel
IF /I "%confirmation%"=="y" goto setup
goto wronginput

:setup
echo SETTING IP ADDRESS TO %IP%
netsh int ip set address name="LAN-Verbindung" source=static addr=%IP% mask=%MASK% gateway=%GATEWAY%
goto end

:cancel
echo Changing IP address canceled by user!

:end
echo *****************************************************************
echo * SETTING SERVER IP ADDRESS FINISHED
echo *****************************************************************
