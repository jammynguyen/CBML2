@echo off
rem ############################################################################
rem keep consistent with  <projectsDir>\ini\ProjectSL_env.cmd
rem ############################################################################

rem #############################################################################
rem The following entries should be adapted!
rem #############################################################################

set rootDir=E:\FHTCOM
set sourceDir=E:\FHTCOM
set PROJECT=project

set SIROLLLIBSDIR=E:\SIROLLLIBRARIES

set subsysDir=%SIROLLLIBSDIR%\subsys_V10.00.00\subsys
set ACE_ROOT=%SIROLLLIBSDIR%\subsys_V10.00.00\ACE_wrappers


rem #### use the right visual studio versio here ####
if defined VS100COMNTOOLS call "%VS100COMNTOOLS%vsvars32.bat"

rem #### set ORADIR=D:\oracle\product\10.2.0\client_1
rem #### set JAVA_DIR=D:\svn\JAVA
set JRE_HOME=%subsysDir%\jre
set OFFICE_DIR=C:\Program Files\Microsoft Office\OFFICE11

set projectsDir=%rootDir%\na\%PROJECT%
set laptopDir=%rootDir%\laptop
set KDLOG=%projectsDir%\log

REM -------------- laptop plant ------
rem set aimOpt=-f %laptopDir%\aim\aimfile.aim -multinc
REM -------------- real plant ------
set aimOpt=-f %projectsDir%\aim\aimfile.aim -multinc

rem #############################################################################
rem Only change the flowing lines if you know what you're doing
rem #############################################################################

set aimDir=%KDLOG%\aimTemp
set binDir=%projectsDir%\bin
set DAT_DIR=%projectsDir%\dat
set HOSTTYPE=wnt_pc
set TAO_VERSION=1_3
set ORB=TAO
set Path=%Path%;%ACE_ROOT%\bin;%subSysDir%\appl\bin;%subSysDir%\aim\bin;%subSysDir%\sina\lib;%subSysDir%\bin;
set SINA_MAP_PATH=%projectsDir%\dat\shm
set USE_PCH_SWITCH=""
set NAME_SERVICE_DIR=%projectsDir%\dat

 set NLS_LANG= AMERICAN_AMERICA.WE8MSWIN1252
rem set NLS_LANG=SPANISH_ARGENTINA.WE8MSWIN1252

rem until in <subsysDir>/aim/inc/<HOSTTYPE>.aim a empty LOCAL {} is provided, the only way to allow calling vars_LOCAL.aiminc or vars.aiminc
rem from the very same aimfiles is to have a vars_PLANT.aiminc and a vars_LOCAL.aiminc depending on the shell variable LOCAL
rem for the cooling section right now a variable LOCAL=_PLANT or LOCAL=_LOCAL is needed
set LOCAL=_LOCAL


rem #### additional sirol variables -> to be merged with ini\ProjectSL_env.cmd ####
set projectsDirSRC=%projectsDir%

rem #### for HMI ####
SET projectHmiLPDir=%rootDir%\MT_HMI_PA_LP\projectLP
SET productHmiLPDir=%rootDir%\MT_HMI_PA_LP\MT
rem see startView: call %projectHmiLPDir%\ini\CIS_HMI_PA_env.cmd

rem #### for dataeditor ####
if not defined DBLOGIN set DBLOGIN=cis_hmi_pa/cis_hmi_pa@fhtcoml2
set PROJECT_DIR=%projectsDir%

rem #### for createAllProject ####
set PATH=%PATH%;%JAVA_DIR%\bin;%JAVA_DIR%\jdk1.3\bin;%projectsDir%\src\tools\dataeditor;%projectsDir%\Generate4Project