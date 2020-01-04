create tablespace smldata 
       datafile 'E:\oracle\oradata\FHTCOML2\tbsp_smldata_01.dbf'  size 20M
    AUTOEXTEND ON 
extent management local uniform size 64K;

create tablespace smlindx 
       datafile 'E:\oracle\oradata\FHTCOML2\tbsp_smlindx_01.dbf'  size 20M
    AUTOEXTEND ON 
extent management local uniform size 64K;

create tablespace meddata 
       datafile 'E:\oracle\oradata\FHTCOML2\tbsp_meddata_01.dbf'  size 50M
    AUTOEXTEND ON 
extent management local uniform size 256K;

create tablespace medindx 
       datafile 'E:\oracle\oradata\FHTCOML2\tbsp_medindx_01.dbf'  size 50M
    AUTOEXTEND ON 
extent management local uniform size 256K;

create tablespace lrgdata 
       datafile 'E:\oracle\oradata\FHTCOML2\tbsp_lrgdata_01.dbf'  size 100M
    AUTOEXTEND ON 
extent management local uniform size 1M;

create tablespace lrgindx 
       datafile 'E:\oracle\oradata\FHTCOML2\tbsp_lrgindx_01.dbf'  size 100M
    AUTOEXTEND ON 
extent management local uniform size 1M;





