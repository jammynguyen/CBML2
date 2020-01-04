connect / as sysdba;
declare
stmt varchar2(120);
begin
for r in (select 'alter system kill session '||''''||sid||','||serial#||''' immediate' as kill_ses from v$session where username is not null) loop
stmt := r.kill_ses;
  begin
    execute immediate stmt;
  exception when others then
    null;
  end;
end loop;
end;
/
disconnect all immediate;
connect / as sysdba;
set autorecovery on;
RECOVER STANDBY DATABASE; 
--RECOVER AUTOMATIC DATABASE; 
alter database open read only;
quit