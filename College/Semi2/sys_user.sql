select file_name, tablespace_name
from dba_data_files
UNION
--desc dba_temp_files
select file_name, tablespace_name
from dba_temp_files;

--���̺����̽�
create tablespace checktbs datafile 'c:\app\test\checktbs01.dbf' size 5m autoextend on;

--����� ����
create user u_owner identified by oracle default tablespace checktbs quota 0m on system;
create user u_insert identified by oracle default tablespace checktbs quota 0m on system;
create user u_query identified by oracle default tablespace checktbs quota 0m on system;

grant create session, create table to u_owner
with admin option;

grant unlimited tablespace to u_owner;

/*1. sys����ڷ� �����Ͽ� ���̺� �����̽�, �����, �ý��� ������ ���� ���� 
r_owner�� r_guest�� ������ ��   �ѿ� ��õ� �ý��� ������ �ο��ϰ� 
u_owner����ڿ��� r_owner����, ������ ����ڿ��Դ� r_quest���� 
  �ο��Ͻÿ�. �̶� ������ ��� object�� �ý��� ��� Ȯ���Ͻÿ�.*/

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
