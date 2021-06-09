show user
create table test10(a number);
--����Ʈ ���̺����̽����� ����������� ����.

--< sys_user
create table test20(aa number) tablespace system;
--�ý��ۿ� ���̺��� ���� �� ����

--> insauser03

drop table test20;

--������Ʈ ���� �ο��ϴ� ���� �˾ƺ���..
--1. �ý��� ���̺� �����̽��� �ִ� �͵��� �� ������.

--test01, test10, test100
--insauser01�� ����, 02,03���� ���� ��Ų�ٰ� �����غ���.

--����� ����, ������Ʈ�� ���� ���Ѻο�
-- �Դٰ� sysuser�� �� �� �� ����
-- ������ ���ӹ��� �ڵ� �� �� ������.. sys_user�� ���� ����.

--test01 > insauser01���� ���� OK
--       > sysuser���Ե� ���� 

--insauser01�� ������ �������� ��ų���� �ְ� ���� ���� �� ���� �ִ�..
--insauser01�� ���� �ڱ����� �ٸ��Ͽ��� �ִ� �� ����.

--(insauser01.testuser...)

--< insauser01
select * from insauser01.test01;

--> insauser03
grant select on insauser01.test01 to insauser03;

--> insauser03


select * from user_sys_privs; 
/*
INSAUSER02	UNLIMITED TABLESPACE	NO
*/
select * from user_role_privs;  --���� role�� ���� ������?
/*
INSAUSER02	CONNECT	NO	YES	NO
INSAUSER02	RESOURCE	NO	YES	NO
*/

select * from role_sys_privs;   --role�ȿ� �ִ� sys������ ������
/*
RESOURCE	CREATE SEQUENCE 	NO
RESOURCE	CREATE TRIGGER	    NO
RESOURCE	CREATE CLUSTER	    NO
RESOURCE	CREATE PROCEDURE	NO
RESOURCE	CREATE TYPE	        NO
CONNECT	    `CREATE SESSION	    NO
RESOURCE	CREATE OPERATOR 	NO
RESOURCE	CREATE TABLE	    NO
RESOURCE	CREATE INDEXTYPE	NO

resource create~ create~ ....
*/
--���̷�Ʈ�� ���� �� + role�� ������ ���ļ� ���� ���?

select privilege from user_sys_privs
union
select privilege from role_sys_privs;
/*
CREATE CLUSTER
CREATE INDEXTYPE
CREATE OPERATOR
CREATE PROCEDURE
CREATE SEQUENCE
CREATE SESSION
CREATE TABLE
CREATE TRIGGER
CREATE TYPE
UNLIMITED TABLESPACE
*/

select * from user_tab_privs;
/*
INSAUSER03	INSAUSER01	TEST01	INSAUSER02	SELECT	NO	NO
INSAUSER02	INSAUSER01	TEST01	INSAUSER01	SELECT	YES	NO
*/
/*
�����
*/


set role role_mgr;
set role role_clerk;
--default role�� ���� ��������.. union �ߺ� ����
/*
CREATE CLUSTER
CREATE INDEXTYPE
CREATE OPERATOR
CREATE PROCEDURE
CREATE ROLE
CREATE SEQUENCE
CREATE SESSION
CREATE SYNONYM
CREATE TABLE
CREATE TRIGGER
CREATE TYPE
UNLIMITED TABLESPACE
*/

select * from user_role_privs;
/*
INSAUSER02	CONNECT	NO	YES	NO
INSAUSER02	RESOURCE	NO	YES	NO
INSAUSER02	ROLE_CLERK	NO	YES	NO
INSAUSER02	ROLE_MGR	NO	YES	NO
*/

select * from user_tab_privs;
select * from role_tab_privs;

--������Ʈ
select owner, table_name, privilege from user_tab_privs
union
select owner, table_name, privilege from role_tab_privs;
/*
INSAUSER01	TEST01	SELECT
INSAUSER01	TEST01	UPDATE
*/

--< insauser01
commit;

select * from insauser01.test01;
update insauser01.test01
set a = 3
where a = 2;
commit;

-- insauser01 ������ ����

--���̺���� �ʹ� ���.. synonym..!
create synonym test01 for insauser01.test01; --�� ������ ����� �ȳѾ����..
select * from user_objects;
--create synonym �ٲ��̸� for �����̸�;

-- ���� �𸣰�����.. role�� ���ؼ� ���� ����.
--<sys_user

desc user_synonyms
select * from user_synonyms;
select * from test99; --���� �Ǿ���..

create public synonym test99 for insauser01.test01;
select * from test99;
select * from test01;

select * 
from
test99;

-- ROLE set �κп��� ���̴� �� ���ʿ� ROLE�� ��� Ȯ������ �ڿ� �۾��� ���� �ó���� ����� ���� �۵���.
-- < insauser01

set role role_clerk;
insert into test01 values(insauser01.testno.nextval);
select * from test01;
--testno�� �� ���� �ƴϴϱ�..
--������ �ַ��� ����� synonym�� ��������.

create synonym testno for insauser01.testno;
--express ������ �����ε�..
--set role mgr > create synonym > set role clerk > ���

select testno.currval from dual; --���� ��
commit;

-- <<<sys_user