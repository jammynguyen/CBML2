rem mapping untis for ColdStandby files
NET USE v: \\172.18.40.122\d$ /u:172.18.40.122\Administrator bsw_09!_oly4Amin
NET USE w: \\172.18.40.123\d$ /u:172.18.40.123\Administrator bsw_09!_oly4Amin
rem mapping units for Archive Logs
NET USE x: \\172.18.40.122\f$ /u:172.18.40.122\Administrator bsw_09!_oly4Amin
NET USE y: \\172.18.40.123\f$ /u:172.18.40.123\Administrator bsw_09!_oly4Amin

start "mirror ColdStandby" robocopy V:\na\project\bat\ColdStandby w:\na\project\bat\ColdStandby /mon:1 /mir /mot:1
start "mirror Archive Logs" robocopy x:\ArchiveLogs y:\ArchiveLogs /mon:1 /mir /mot:1
start "mirror Dumps" robocopy x:\Dumps y:\Dumps /mon:1 /mir /mot:1

rem NET USE x: /D
rem NET USE y: /D
rem NET USE z: /D
rem NET USE v: /D