show user
--create table test01(a number);

--디폴트 테이블스페이스 영역을 인사 테이블스페이스에 부여했음.
--그러나 quota가 없기 때문에 ERROR!

-- << sys_user

create table test01(a number); --OK

-- << sys_user

grant create session, create table to insauser03;
-- 권한을 줄 수 있음..!
-- But 용량에 대한 권한을 주지 않았기에 안됨..

--<< sys_user

create table test02(aa number) tablespace system;
--시스템 테이블 스페이스가 열린다.

--> insauser02

drop table test02; --나의 맘대로 삭제 가능.

--> insauser02

grant select on insauser01.test01 to insauser02
with grant option;

--> insauser02

desc user_sys_privs
select * from user_sys_privs;   --나의 시스템 권한
/*
username    privilege               admin_option
INSAUSER01	UNLIMITED TABLESPACE	NO
INSAUSER01	CREATE SESSION	        YES
INSAUSER01	CREATE TABLE	        YES
*/
select * from user_tab_privs;   --grantee 받은사람 --grantor 준 사람
/*
grantee     owner       table_name  grantor     privlege g..  h..
INSAUSER03	INSAUSER01	TEST01	    INSAUSER02	SELECT	NO	NO
INSAUSER02	INSAUSER01	TEST01	    INSAUSER01	SELECT	YES	NO
*/

--> insauser02,03 에서도 sys권한 tab권한 확인

select * from user_sys_privs; 
select * from user_tab_privs;

-- revoke 한번에 그동안 줬었던 권한부여의 연쇄고리가 환수..
revoke select on test01 from insauser02;

--> insauser02, 03에서 권한여부 확인..

--< sys_user로 감

set role role_mgr; --롤 적용

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

다이렉트 + role로 받은 것들
*/
create role role_clerk;
grant select, update on test01 to role_clerk;
grant role_clerk to insauser02;
--롤을 통해서 부여
grant role_mgr to insauser02;
--role >> with grant option 때문에.. 남에게도 줄 수 있음.

--> insauser02

insert into test01 values(1);
insert into test01 values(2);
commit;
select * from test01; --나의 소유니까..


--> insauser02

create sequence testno
increment by 1 start with 1 maxvalue 100 nocache nocycle; --1씩 증가
--시퀀스 생성

select * from test01;
insert into test01 values(testno.nextval);
--testno라는 시퀀스 nextval:다음값을 추가..!

select testno.currval from dual; --현재값을 알 수 있음.

--insauser02로 하여금.. 시키려고 한다.
--role에다가 추가 + testno를 select 할 수 있어야한다. 
--select on SEQUENCE

grant insert on test01 to role_clerk;
grant select on testno to role_clerk;
--DCL 적용시 커밋을 적용.
--> insauser02로 이동
