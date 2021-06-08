alter user hr IDENTIFIED by hr
account unlock;
--sys_user에서
/*이번부터가 기말고사 범위..!
테이블 스페이스 : 테이블의 상위 개념
RDBMS에 따라 기준이 달라질 수 있음.

*테이블 스페이스<이미 만들어져 있음>
시스템     :system, sysaux
비시스템   :일반-users, example, 사용자정의 tablespace
           임시-temp
           언두-undotbs1
           
11g express edition(무료)에선 example이 없음.
언두> undo(취소), 롤백 했던 것들을 불러들이는 친구...

*시스템뷰(데이터 딕셔너리 + 동적 성능 뷰(Dynamic Performance View))
:dba_tablespaces, dba_data_file, dba_temp_file, dba_users, database_properties, <오브젝트 용, 서버 용 이렇게 확실히 쪼갤 수 없는 부분도 존재>
v$tablespace, v$datafile, v$tempfile<이름 규칙 자체가 이럼.. 동적성능뷰/ 11g 이상은 v$_... 로 표기>
*/
desc dba_tablespaces
select tablespace_name
from dba_tablespaces;

/*
SYSTEM
SYSAUX--시스템
UNDOTBS1--언두
TEMP--임시
USERS--사용자
*/

desc v$tablespace
select name
from v$tablespace;
desc dba_users

select username, default_tablespace,temporary_tablespace
from dba_users
order by 1;

--default tal~ 테이블 생성 시 기본으로 해당 사항이 적혀지는 곳
/*
DIP	        SYSTEM	TEMP
FLOWS_FILES	SYSAUX	TEMP
HR	        USERS	TEMP
MDSYS	    SYSAUX	TEMP
*/

desc database_properties
select *
from database_properties;

/*
DEFAULT_TEMP_TABLESPACE     	TEMP
DEFAULT_PERMANENT_TABLESPACE	SYSTEM
*/
--이런 부분들을 바꾸어서 다르게 사용할 수도 있고..

desc dba_data_files --물리
select file_name, tablespace_name
from dba_data_files
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	    USERS
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	SYSAUX
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	UNDOTBS1
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	SYSTEM
temp는 물리적으로 볼 때 따로 작동
*/
UNION --전부확인
--desc dba_temp_files
select file_name, tablespace_name
from dba_temp_files;
--C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TEMP.DBF    TEMP

select name, ts#
from v$datafile
UNION
select name, ts#
from v$tempfile;
--이름 대신 번호가 나오는 시스템?
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	1
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	0
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TEMP.DBF	    3
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	2
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	    4
인스턴스 생성시 만들어지는 새로운 CONTROL.DBF도 만들어진다고..
*/

/*
*저장 단위
논리 - tablespace < object(table, index, procedure, trigger..)
(논리적인 공간)
물리 - datafile01,...02.. < segement < extent < block
(물리적인 공간)
하나의 테이블 스페이스엔 명령의 규칙에 따라 여러개의 데이터파일이 들어있을 수도 있다.
*/

--1.사용자 테이블 스페이스
--droptbs1(droptbs1.dbf)
--oraclexe폴더에 testb폴더 생성
create tablespace droptbs1
datafile 'c:\oraclexe\testb\droptbs101.dbf' size 5m autoextend on next 1m maxsize 10m;
--:자동확장 초기 extent 5m, 1m씩 증가, 최대 10m
--계속해서 데이터 파일이 확장하는 경향이 있기에 사용자가 만드는 파일은 그 끝에 따로 숫자를 붙여줌.
--확인 방법..? 위에 있는 UNION 이용하기 OR 직접 경로 들어가서 확인하기

--droptbs2_including(droptbs2_including01.dbf)
--droptbs3_datafile(droptbs3_datafile01.dbf)
--droptbs4_cascade(droptbs4_cascade01.dbf)

--2. " 사이즈 추가
alter tablespace droptbs1
add datafile 'c:\oraclexe\testb\droptbs102.dbf'
size 5m autoextend on next 1m maxsize 10m;
--확장자를 따로 주지 않아도 데이터파일이지만.. 규칙은 지켜주세요
--테이블 스페이스는 그대로 / 그러나 데이터 파일은 하나 추가 (1대다 관계, 1테이블스페이스 : 다 데이타파일

--3. " 이동;위치/이름변경
--다른 곳으로 옮기거나, 이름을 바꾼다거나..
--1) alter tablespace tbs명 offline; --작업을 할 수 없게 만들기;offline
alter tablespace droptbs1 offline;

--2) 물리적으로 원하는 위치/ 이름으로 복사
/*파일 탐색기에서 직접 02를 복사한 후 03으로 이름 변경*/

--3) alter tablespace tbs명 rename
--datafile '기존dbf명' to '신규dbf명';
alter tablespace droptbs1 rename
datafile 'c:\oraclexe\testb\droptbs102.dbf' to 'c:\oraclexe\testb\droptbs103.dbf';

--4) alter tablespace tbs명 online;
alter tablespace droptbs1 online;
--물리적인 데이터 파일만 변화

--5) 물리적으로 기존데이터 파일은 삭제
--파일 탐색기에서 직접 2를 없애면 됨.

--4. " 삭제
--5. 임시 테이블 스페이스 생성 후ㅡ 디폴트 임시 테이블 스페이스로 변경
--6. 언두 테이블 스페이스 생성 후-- 디폴트 언두 테이블 스페이스로 변경

--[문제]
--사용자테이블스페이스 droptbs1의 데이터파일 droptbs103.dbf를 원래 이름(droptbs102.dbf)으로 변경하세요.
