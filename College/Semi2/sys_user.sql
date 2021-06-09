select file_name, tablespace_name
from dba_data_files
UNION
--desc dba_temp_files
select file_name, tablespace_name
from dba_temp_files;

--테이블스페이스
create tablespace checktbs datafile 'c:\app\test\checktbs01.dbf' size 5m autoextend on;

--사용자 생성
create user u_owner identified by oracle default tablespace checktbs quota 0m on system;
create user u_insert identified by oracle default tablespace checktbs quota 0m on system;
create user u_query identified by oracle default tablespace checktbs quota 0m on system;

grant create session, create table to u_owner
with admin option;

grant unlimited tablespace to u_owner;

/*1. sys사용자로 접속하여 테이블 스페이스, 사용자, 시스템 권한을 갖는 롤인 
r_owner와 r_guest를 생성한 후   롤에 명시된 시스템 권한을 부여하고 
u_owner사용자에게 r_owner롤을, 나머지 사용자에게는 r_quest롤을 
  부여하시오. 이때 생성한 모든 object를 시스템 뷰로 확인하시오.*/

create role r_owner;
create role r_guest;

grant create session, create table, create sequence, create public synonym, create role to r_owner;
grant create session, create synonym to r_guest;

grant r_owner to u_owner;
grant r_guest to u_insert, u_query;
select * from user_objects;
  
--u_owner


select owner, table_name, privilege from user_tab_privs
union
select owner, table_name, privilege from role_tab_privs;

alter tablespace checktbs offline;
alter tablespace checktbs online;

drop tablespace checktbs including contents and datafiles cascade constraints;

select * from dba_users;

drop user u_owner cascade;
drop user u_insert cascade;
drop user u_query cascade;

select * from dba_roles;
drop role r_owner;
drop role r_guest;
drop role r_insert;
drop role r_query;

drop public synonym s_item;

desc dba_roles
select * from dba_roles order by 2;

DESC DBA_SEQUENCES
select * from dba_sequences order by 2;

desc dba_synonyms
select * from dba_synonyms where synonym_name like 'TEST%' order by 2;
