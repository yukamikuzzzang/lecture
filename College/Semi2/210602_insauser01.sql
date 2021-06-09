show user
--create table test01(a number);

--����Ʈ ���̺����̽� ������ �λ� ���̺����̽��� �ο�����.
--�׷��� quota�� ���� ������ ERROR!

-- << sys_user

create table test01(a number); --OK

-- << sys_user

grant create session, create table to insauser03;
-- ������ �� �� ����..!
-- But �뷮�� ���� ������ ���� �ʾұ⿡ �ȵ�..

--<< sys_user

create table test02(aa number) tablespace system;
--�ý��� ���̺� �����̽��� ������.

--> insauser02

drop table test02; --���� ����� ���� ����.

--> insauser02

grant select on insauser01.test01 to insauser02
with grant option;

--> insauser02

desc user_sys_privs
select * from user_sys_privs;   --���� �ý��� ����
/*
username    privilege               admin_option
INSAUSER01	UNLIMITED TABLESPACE	NO
INSAUSER01	CREATE SESSION	        YES
INSAUSER01	CREATE TABLE	        YES
*/
select * from user_tab_privs;   --grantee ������� --grantor �� ���
/*
grantee     owner       table_name  grantor     privlege g..  h..
INSAUSER03	INSAUSER01	TEST01	    INSAUSER02	SELECT	NO	NO
INSAUSER02	INSAUSER01	TEST01	    INSAUSER01	SELECT	YES	NO
*/

--> insauser02,03 ������ sys���� tab���� Ȯ��

select * from user_sys_privs; 
select * from user_tab_privs;

-- revoke �ѹ��� �׵��� ����� ���Ѻο��� ������� ȯ��..
revoke select on test01 from insauser02;

--> insauser02, 03���� ���ѿ��� Ȯ��..

--< sys_user�� ��

set role role_mgr; --�� ����

select privilege from user_sys_privs
union
select privilege from role_sys_privs;
/*
CREATE ROLE
CREATE SEQUENCE
CREATE SESSION
CREATE SYNONYM
CREATE TABLE
UNLIMITED TABLESPACE

���̷�Ʈ + role�� ���� �͵�
*/
create role role_clerk;
grant select, update on test01 to role_clerk;
grant role_clerk to insauser02;
--���� ���ؼ� �ο�
grant role_mgr to insauser02;
--role >> with grant option ������.. �����Ե� �� �� ����.

--> insauser02

insert into test01 values(1);
insert into test01 values(2);
commit;
select * from test01; --���� �����ϱ�..


--> insauser02

create sequence testno
increment by 1 start with 1 maxvalue 100 nocache nocycle; --1�� ����
--������ ����

select * from test01;
insert into test01 values(testno.nextval);
--testno��� ������ nextval:�������� �߰�..!

select testno.currval from dual; --���簪�� �� �� ����.

--insauser02�� �Ͽ���.. ��Ű���� �Ѵ�.
--role���ٰ� �߰� + testno�� select �� �� �־���Ѵ�. 
--select on SEQUENCE

grant insert on test01 to role_clerk;
grant select on testno to role_clerk;
--DCL ����� Ŀ���� ����.
--> insauser02�� �̵�
