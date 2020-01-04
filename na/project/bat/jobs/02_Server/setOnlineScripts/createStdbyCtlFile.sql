-- the first parameter of the call to this must be pathToSharedFolder
ALTER DATABASE CREATE STANDBY CONTROLFILE AS '&1\controlFile\standby_ctl_file.ctl';
quit