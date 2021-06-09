/*
시스템 권한의 종료가 상당히 많은데..
hr >> 계정잠금으로 인해 안되는 것일 뿐.
사용자에게 어떠한 권한이 없다면 어떤 것도 할 수 없음.
*/
select *
from database_properties;

--desc dba_data_files --물리
select file_name, tablespace_name
from dba_data_files
UNION
--desc dba_temp_files
select file_name, tablespace_name
from dba_temp_files;

/*
*사용자 관리
1. 테이블스페이스 생성
2. 사용자 생성
3. 권한 부여
    -1 사용자에게 시스템 권한 부여(시스템 권한, create view .. etc)
    :grant 시스템권한 to 사용자명 [with admin option];
    -2 사용자에게 오브젝트 권한 부여
    :grant 오브젝트권한 to 사용자명 [with grant option];
    단, revoke ~ from 사용자명; 시스템권한은 해당 사용자만 revoke/     
                               오브젝트권한은 이앙받은 모든 사용자에게서 revoke
                               <<어떤 테이블에 대하여 권한을 부여하는 것.>>
4. 롤(role)을 이용한 권한 부여            
(역할을 가지고 있는 여러 사용자에게 권한 부여)
1)롤생성
2)롤에게 시스템 권한 부여
3)롤에게 오브젝트 권한 부여
4)사용자에게 롤 부여

시스템롤: connect, resource(unlimited tablespace권한 자동으로 주어짐.) 
11g 이후로 변경된 내용이 있음

*/

--sys_user
--express 버전에선 유의가 필요.

desc dba_tablespaces
select tablespace_name
from dba_tablespaces;

create tablespace droptbs1 datafile 'c:\oraclexe\testb\droptbs101.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs2 datafile 'c:\oraclexe\testb\droptbs102.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs2_including datafile 'c:\oraclexe\testb\droptbs2_including01.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs3_datafile datafile 'c:\oraclexe\testb\droptbs3_datafile01.dbf' size 5m autoextend on next 1m maxsize 10m;
create tablespace droptbs4_cascade datafile 'c:\oraclexe\testb\droptbs4_cascade01.dbf' size 5m autoextend on next 1m maxsize 10m;

--변화를 주고 싶을 때 물리적으로 복사한 이후 이름을 변경한 후 삭제하는 과정을 밟아주어야 한다.

alter tablespace droptbs2 offline;

alter tablespace droptbs2 rename
datafile 'c:\oraclexe\testb\droptbs102.dbf' to 'c:\oraclexe\testb\droptbs103.dbf';

alter tablespace droptbs2 online;

--4. 사용자테이블스페이스 삭제
drop tablespace droptbs1;
--1개 삭제..
--1) drop tablespace droptbs1; (droptbs101.dbf, droptbs102.dbf)
--해당 테이블 스페이스에 contents가 있으면 drop되지 않고
--빈테이블스페이스 drop시만 삭제되나 물리적으로 dbf파일은 삭제되지 않음
--해당작업을 마친 후 그 파일만을 물리적으로 직접 삭제할 것.

--2)drop tablespace droptbs2_including including contents; (droptbs2_including01.dbf)
--해당 테이블스페이스에 있는 모든 contents는 삭제되나 물리적으로 dbf파일은 삭제되지 않음!!

--사용자 생성
create user drop_user identified by oracle
quota 1m on droptbs2_including;
--default edition에선 system_tablespace로 설정이 되어있음. (특정 oracle에서 작동)
--droptbs2~ 중 1m를 사용할 수 있도록 할꺼임.
--quota 단위

grant connect, resource to drop_user;
--시스템 role(connect, resource) 이러면 왠만한 건 할 수 있음.
conn drop_user/oracle
show user
--지금 만들어놓은 이 계정은 어떠한 권한도 부여받은 것이 없기 때문에
--connct 조차도 할 수 없음.

--오라클 자체 시스템으로 새로운 계정 drop_user에 대한 부분을 만들기.


--<<<<drop_user

drop tablespace droptbs2_including including contents;
--위와 같은 입력하면 안에 있던 데이터들이 다 사라짐..

--3)drop tablespace droptbs3_datafile including and datafiles; (droptbs3_datafile01.dbf)
--물리적으로 dbf파일은 삭제된다.

--4)drop tablespace droptbs4_cascade including contents and datafiles cascade constraints; (droptbs4_cascade01.dbf)
--다른 테이블스페이스의 테이블이 해당 테이블스페이스를 참조하면
--다른 테이블스페이스의 테이블은 그대로 존재하나 제약조건은 없어지고 실행은 성공함.

alter user drop_user
quota 1m on droptbs4_cascade;
--해당 유저가 droptbs4에 대한 지분을 가지게 됨.

--<<<<drop_user

drop tablespace droptbs4_cascade including contents and datafiles; --cascade constraints;
--에러.. 참조중이기 때문

--drop_user에서 세션을 끊고<접속해제>, 변경사항 커밋해주세요..
drop tablespace droptbs4_cascade including contents and datafiles cascade constraints;

--<<drop_user

drop tablespace droptbs3_datafile including contents and datafiles cascade constraints;
--아무것도 없어서 그저 사라질 뿐.

show parameter;
--undo_management                      string      AUTO                                                            
--undo_retention                       integer     900                                                             
--undo_tablespace  

--5)임시테이블스페이스 생성 후 디폴트 임시테이블스페이스로 변경
    --1)create temporary 


--6)언두테이블스페이스 생성 후 디폴트 연두테이블스페이스로 변경
    --1)create undo tablespace 새로운 언두테이블스페이스로 변경
    --2)alter system set undo_tablespace = 새로운 언두테이블 스페이스명
    
/*
교재:
강의 ..>
11장 시퀀스(SEQUENCE), 시노님(SYNONYM)에 대해 간략하게 지나고 넘아가기에 잘 살펴본다고..
*/
--최근에 기존 방침과는 수업내용이 달라질 수 있음.

--사용자 삭제? / 테이블스페이스 삭제와 관계없음 
--세션해제 후 시도해주세요
drop user drop_user cascade;
--drop_user가 만든 테이블이 있는지 확인
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
quota 0m on system; --시스템에서 작업을 못함.
--01, 02, 03 input 값을 부여하여 3명의 유저를 만듬.

--작업할 수 있는 권한을 주어야.. (세션)
grant create session, create table to insauser01
with admin option; --다른 사용자에게 이양 가능

conn insauser01/oracle --접속이 되는 상태 -- 유저생성해주어야..

--> insauser01

grant unlimited tablespace to insauser01;
--모든 테이블스페이스에 제한없이 모든 조건을 부여하는 것.
--시스템롤: connect, resource(unlimited tablespace권한 자동으로 주어짐.)

-->> insauser01

grant connect, resource to insauser02;
--connect + resource = unlimited

-->> insauser02

-- create session + create table + with grant option 을 가지고 있는 insauser01

--> insauser01

alter user insauser03
    quota unlimited on insatbs;
--insauser03 << insauser01 시스템 권한  + sys_user quota를 무제한으로 열어줌.

--insauser03는 insatbs에 대해서만 unlimited한 상태

-->> insauser03

revoke create table from insauser01;
--이걸 한다고 해도 01이 03한테 준 (오브젝트) 권한마저 사라지진 않는다.

--> insauser01, 03 하고 돌아오기

create role role_mgr;
grant create role, create synonym, create sequence, create table to role_mgr;
grant role_mgr to insauser01; --with admin option;

grant role_mgr to insauser02; 
-->insauser02

--롤 > 롤, 롤 > 사람 가능!

--> insauser01

grant create public synonym to role_mgr; --전체적용

--일단 사용하기 전에 미리 접속해제 해놓자.

drop tablespace insatbs including contents and datafiles cascade constraints; 
--테이블스페이스와 상관없이 사용자는 남아있음.
select username from dba_users;

drop user insauser&no cascade;
--01, 02, 03 사용자 날리기
--테이블도 날아가긴 하지만..

desc dba_synonyms
select * from dba_synonyms where synonym_name like 'TEST%' order by 2;
--PRIVATE SYNONYM은 사라졌으나.. PUBLIC SYNONYM은 남아있음.
--시퀀스도 없어졌을 것으로 추정..

DESC DBA_SEQUENCES
select * from dba_sequences order by 2;

desc dba_roles
select * from dba_roles order by 2;
--롤은 아직 남아있네..
--OWNER명이 나오지 않는 것을 알 수 있음
--ROLE은 만들면 그냥 있다.
--다른 사용자에게도 부여할 수 있도록 하기 위해 그런가.. 싶음

drop role role_mgr cascade;
drop role role_clerk;
--롤 삭제

drop public synonym test99;
--public synonym 삭제

--물리적인 공간 또한 사라졌다..

-- +10
--public synonym 없애기..
--이론과 함께 작업했던 것들을 떠올려보자.