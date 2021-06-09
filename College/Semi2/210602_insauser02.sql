show user
create table test10(a number);
--디폴트 테이블스페이스에서 만들어지도록 만듬.

--< sys_user
create table test20(aa number) tablespace system;
--시스템에 테이블을 만들 수 있음

--> insauser03

drop table test20;

--오브젝트 권한 부여하는 법을 알아보자..
--1. 시스템 테이블 스페이스에 있던 것들은 다 없앴음.

--test01, test10, test100
--insauser01이 리더, 02,03에게 일을 시킨다고 생각해보자.

--사용자 권한, 오브젝트에 대한 권한부여
-- 게다가 sysuser도 다 줄 수 있음
-- 권한을 위임받은 자도 줄 수 있지만.. sys_user의 힘이 강함.

--test01 > insauser01에게 있음 OK
--       > sysuser에게도 있음 

--insauser01이 각각의 유저에게 시킬수도 있고 직접 일을 줄 수도 있다..
--insauser01이 직접 자기일을 다른일에게 주는 걸 보자.

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
select * from user_role_privs;  --내가 role로 받은 권한은?
/*
INSAUSER02	CONNECT	NO	YES	NO
INSAUSER02	RESOURCE	NO	YES	NO
*/

select * from role_sys_privs;   --role안에 있는 sys권한을 보여줘
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
--다이렉트로 받은 거 + role로 받은거 합쳐서 보는 방법?

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
사라짐
*/


set role role_mgr;
set role role_clerk;
--default role을 받은 상태지만.. union 중복 제거
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

--오브젝트
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

-- insauser01 에서도 동일

--테이블명이 너무 길어.. synonym..!
create synonym test01 for insauser01.test01; --왜 권한이 제대로 안넘어간거지..
select * from user_objects;
--create synonym 바꿀이름 for 원래이름;

-- 왠진 모르겠지만.. role에 대해서 직접 주자.
--<sys_user

desc user_synonyms
select * from user_synonyms;
select * from test99; --원래 되야함..

create public synonym test99 for insauser01.test01;
select * from test99;
select * from test01;

select * 
from
test99;

-- ROLE set 부분에서 꼬이는 듯 양쪽에 ROLE을 모두 확정지은 뒤에 작업을 들어가야 시노님이 제대로 들어가고 작동함.
-- < insauser01

set role role_clerk;
insert into test01 values(insauser01.testno.nextval);
select * from test01;
--testno는 내 것이 아니니까..
--저렇게 주려면 힘드니 synonym을 적용하자.

create synonym testno for insauser01.testno;
--express 버전의 문제인듯..
--set role mgr > create synonym > set role clerk > 사용

select testno.currval from dual; --현재 값
commit;

-- <<<sys_user