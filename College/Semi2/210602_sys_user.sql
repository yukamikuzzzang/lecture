/*
�ý��� ������ ���ᰡ ����� ������..
hr >> ����������� ���� �ȵǴ� ���� ��.
����ڿ��� ��� ������ ���ٸ� � �͵� �� �� ����.
*/
select *
from database_properties;

--desc dba_data_files --����
select file_name, tablespace_name
from dba_data_files
UNION
--desc dba_temp_files
select file_name, tablespace_name
from dba_temp_files;

/*
*����� ����
1. ���̺����̽� ����
2. ����� ����
3. ���� �ο�
    -1 ����ڿ��� �ý��� ���� �ο�(�ý��� ����, create view .. etc)
    :grant �ý��۱��� to ����ڸ� [with admin option];
    -2 ����ڿ��� ������Ʈ ���� �ο�
    :grant ������Ʈ���� to ����ڸ� [with grant option];
    ��, revoke ~ from ����ڸ�; �ý��۱����� �ش� ����ڸ� revoke/     
                               ������Ʈ������ �̾ӹ��� ��� ����ڿ��Լ� revoke
                               <<� ���̺� ���Ͽ� ������ �ο��ϴ� ��.>>
4. ��(role)�� �̿��� ���� �ο�            
(������ ������ �ִ� ���� ����ڿ��� ���� �ο�)
1)�ѻ���
2)�ѿ��� �ý��� ���� �ο�
3)�ѿ��� ������Ʈ ���� �ο�
4)����ڿ��� �� �ο�

�ý��۷�: connect, resource(unlimited tablespace���� �ڵ����� �־���.) 
11g ���ķ� ����� ������ ����

*/

--sys_user
--express �������� ���ǰ� �ʿ�.

desc dba_tablespaces
select tablespace_name
from dba_tablespaces;

create tablespace droptbs1 datafile 'c:\oraclexe\testb\droptbs101.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs2 datafile 'c:\oraclexe\testb\droptbs102.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs2_including datafile 'c:\oraclexe\testb\droptbs2_including01.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs3_datafile datafile 'c:\oraclexe\testb\droptbs3_datafile01.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs4_cascade datafile 'c:\oraclexe\testb\droptbs4_cascade01.dbf' size 5m autoextend on next 1m maxsize 10m;

--��ȭ�� �ְ� ���� �� ���������� ������ ���� �̸��� ������ �� �����ϴ� ������ ����־�� �Ѵ�.

alter tablespace droptbs2 offline;

alter tablespace droptbs2 rename
datafile 'c:\oraclexe\testb\droptbs102.dbf' to 'c:\oraclexe\testb\droptbs103.dbf';

alter tablespace droptbs2 online;

--4. ��������̺����̽� ����
drop tablespace droptbs1;
--1�� ����..
--1) drop tablespace droptbs1; (droptbs101.dbf, droptbs102.dbf)
--�ش� ���̺� �����̽��� contents�� ������ drop���� �ʰ�
--�����̺����̽� drop�ø� �����ǳ� ���������� dbf������ �������� ����
--�ش��۾��� ��ģ �� �� ���ϸ��� ���������� ���� ������ ��.

--2)drop tablespace droptbs2_including including contents; (droptbs2_including01.dbf)
--�ش� ���̺����̽��� �ִ� ��� contents�� �����ǳ� ���������� dbf������ �������� ����!!

--����� ����
create user drop_user identified by oracle
quota 1m on droptbs2_including;
--default edition���� system_tablespace�� ������ �Ǿ�����. (Ư�� oracle���� �۵�)
--droptbs2~ �� 1m�� ����� �� �ֵ��� �Ҳ���.
--quota ����

grant connect, resource to drop_user;
--�ý��� role(connect, resource) �̷��� �ظ��� �� �� �� ����.
conn drop_user/oracle
show user
--���� �������� �� ������ ��� ���ѵ� �ο����� ���� ���� ������
--connct ������ �� �� ����.

--����Ŭ ��ü �ý������� ���ο� ���� drop_user�� ���� �κ��� �����.


--<<<<drop_user

drop tablespace droptbs2_including including contents;
--���� ���� �Է��ϸ� �ȿ� �ִ� �����͵��� �� �����..

--3)drop tablespace droptbs3_datafile including and datafiles; (droptbs3_datafile01.dbf)
--���������� dbf������ �����ȴ�.

--4)drop tablespace droptbs4_cascade including contents and datafiles cascade constraints; (droptbs4_cascade01.dbf)
--�ٸ� ���̺����̽��� ���̺��� �ش� ���̺����̽��� �����ϸ�
--�ٸ� ���̺����̽��� ���̺��� �״�� �����ϳ� ���������� �������� ������ ������.

alter user drop_user
quota 1m on droptbs4_cascade;
--�ش� ������ droptbs4�� ���� ������ ������ ��.

--<<<<drop_user

drop tablespace droptbs4_cascade including contents and datafiles; --cascade constraints;
--����.. �������̱� ����

--drop_user���� ������ ����<��������>, ������� Ŀ�����ּ���..
drop tablespace droptbs4_cascade including contents and datafiles cascade constraints;

--<<drop_user

drop tablespace droptbs3_datafile including contents and datafiles cascade constraints;
--�ƹ��͵� ��� ���� ����� ��.

show parameter;
--undo_management                      string      AUTO                                                            
--undo_retention                       integer     900                                                             
--undo_tablespace  

--5)�ӽ����̺����̽� ���� �� ����Ʈ �ӽ����̺����̽��� ����
    --1)create temporary 


--6)������̺����̽� ���� �� ����Ʈ �������̺����̽��� ����
    --1)create undo tablespace ���ο� ������̺����̽��� ����
    --2)alter system set undo_tablespace = ���ο� ������̺� �����̽���
    
/*
����:
���� ..>
11�� ������(SEQUENCE), �ó��(SYNONYM)�� ���� �����ϰ� ������ �Ѿư��⿡ �� ���캻�ٰ�..
*/
--�ֱٿ� ���� ��ħ���� ���������� �޶��� �� ����.

--����� ����? / ���̺����̽� ������ ������� 
--�������� �� �õ����ּ���
drop user drop_user cascade;
--drop_user�� ���� ���̺��� �ִ��� Ȯ��
desc dba_tables
select owner, table_name, tablespace_name
from dba_tables
where table_name like 'TSET%';


--sys_user                                                   insauser01              insauser02              insauser03
-- ------------------------------------------------------------------------------------------------
create tablespace insatbs
datafile 'c:\oraclexe\testa\insatbs01.dbf'
size 1m autoextend on;

create user insauser&no identified by oracle
default tablespace insatbs
quota 0m on system; --�ý��ۿ��� �۾��� ����.
--01, 02, 03 input ���� �ο��Ͽ� 3���� ������ ����.

--�۾��� �� �ִ� ������ �־��.. (����)
grant create session, create table to insauser01
with admin option; --�ٸ� ����ڿ��� �̾� ����

conn insauser01/oracle --������ �Ǵ� ���� -- �����������־��..

--> insauser01

grant unlimited tablespace to insauser01;
--��� ���̺����̽��� ���Ѿ��� ��� ������ �ο��ϴ� ��.
--�ý��۷�: connect, resource(unlimited tablespace���� �ڵ����� �־���.)

-->> insauser01

grant connect, resource to insauser02;
--connect + resource = unlimited

-->> insauser02

-- create session + create table + with grant option �� ������ �ִ� insauser01

--> insauser01

alter user insauser03
    quota unlimited on insatbs;
--insauser03 << insauser01 �ý��� ����  + sys_user quota�� ���������� ������.

--insauser03�� insatbs�� ���ؼ��� unlimited�� ����

-->> insauser03

revoke create table from insauser01;
--�̰� �Ѵٰ� �ص� 01�� 03���� �� (������Ʈ) ���Ѹ��� ������� �ʴ´�.

--> insauser01, 03 �ϰ� ���ƿ���

create role role_mgr;
grant create role, create synonym, create sequence, create table to role_mgr;
grant role_mgr to insauser01; --with admin option;

grant role_mgr to insauser02; 
-->insauser02

--�� > ��, �� > ��� ����!

--> insauser01

grant create public synonym to role_mgr; --��ü����

--�ϴ� ����ϱ� ���� �̸� �������� �س���.

drop tablespace insatbs including contents and datafiles cascade constraints; 
--���̺����̽��� ������� ����ڴ� ��������.
select username from dba_users;

drop user insauser&no cascade;
--01, 02, 03 ����� ������
--���̺� ���ư��� ������..

desc dba_synonyms
select * from dba_synonyms where synonym_name like 'TEST%' order by 2;
--PRIVATE SYNONYM�� ���������.. PUBLIC SYNONYM�� ��������.
--�������� �������� ������ ����..

DESC DBA_SEQUENCES
select * from dba_sequences order by 2;

desc dba_roles
select * from dba_roles order by 2;
--���� ���� �����ֳ�..
--OWNER���� ������ �ʴ� ���� �� �� ����
--ROLE�� ����� �׳� �ִ�.
--�ٸ� ����ڿ��Ե� �ο��� �� �ֵ��� �ϱ� ���� �׷���.. ����

drop role role_mgr cascade;
drop role role_clerk;
--�� ����

drop public synonym test99;
--public synonym ����

--�������� ���� ���� �������..

-- +10
--public synonym ���ֱ�..
--�̷а� �Բ� �۾��ߴ� �͵��� ���÷�����.