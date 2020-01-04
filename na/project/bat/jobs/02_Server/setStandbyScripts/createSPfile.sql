-- the first parameter of the call must be pathToSharedFolder
connect / as sysdba
CREATE SPFILE FROM PFILE='&1\initOra\init.ora';
quit