show user;

create table test100 (a number);
-- insatbs에 저장되어있을 것임.

-- < insauser01

--insatbs만 quota가 unlimited dlrp..
--insauser03만이 system tablespace에 생성되지 않는다.
--insauser01, 02는 가능

-- < insauser01

select * from test01; --안됨..

-- < insauser02

select  * from insauser01.test01;

/*
시스템뷰(데이터 딕셔너리 뷰)
나에게 부여된 시스템 권한: user_sys_privs, role_sys_privs, user_role_privs         >>롤로 묶어서 부여하면 편안..
나에게 부여된 오브젝트 권한: user_tab_privs, role_tab_privs, user_tab_privs
*/


-- < insauser 01


select * from user_sys_privs; 
/*
INSAUSER03	CREATE SESSION	NO
INSAUSER03	CREATE TABLE	NO
*/
select * from user_role_privs;  --X
select * from role_sys_privs;   --X


select * from user_tab_privs;
/*
INSAUSER03	INSAUSER01	TEST01	INSAUSER02	SELECT	NO	NO
*/
/*
사라짐
*/

/*
권한부여
1) 사용자에게 시스템 권한 부여
:grant 시스템권한 to 사용자명 [with admin option];
2) 사용자에게 오브젝트 권한 부여
:grant 오브젝트권한 to 사용자명 [with grant option];
단, revoke ~ from 사용자명;
시스템권한은 해당 사용자만 revoke,
오브젝트 권한은 이양받은 모든 사용자에게서 revoke!

4.롤;role을 이용한 권한 부여
1)롤 생성
2)롤에게 시스템 권한 부여
3)롤에게 오브젝트 권한 부여
4)사용자에게 롤 부여
단, 롤을 받은 사용자가 롤 set을 해야 적용 
>set role 롤명;
cf. 시스템 롤 connect, resource(unlimited tablespace 권한이 자동적으로 주어짐)

5. 동의어;synonym 생성 (as 같은 거..)   
insauser01.test01 >> test01
6. 시퀀스;sequence 생성; 일련번호로 primary key로 만드는 경우도 꽤 있음.
오늘의 날짜 + 일련번호 같은 느낌으로
사용자에게 입력하게 한다면 사용자가 어디까지 입력했는지 헷갈려할 수도 있음.
이런 일련번호를 자동으로 생성하는 역할을 하는 것이 시퀀스(의미없이 부여할 때..)
7.테이블스페이스 없애기
8.사용자 없애기
9.롤 없애기

그 다음주에도 이런 흐름대로 주욱 준비하면 좋아요.
대신 주관식은 그 안에서 질문하면 맞출 수 있도록..
다음주에 기말고사를 대비한 종이를 줄 것임.

중간고사 단답형은 평소에 하던 것을 잘 참조하며 한다면 문제없음.
(너무 걱정하진 않아도.. 그래도 준비는 해놓자.)

이번엔 권한을 뺏어볼 차례
*/
--전에 쓰여진 것과 이어짐


-- <<insauser01