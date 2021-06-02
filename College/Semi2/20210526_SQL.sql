--0. SCOTT 유저가 CTAS기법으로 testdept, testemp 두개의 테이블을 만들었다. 
--알맞는 테이블 변경, 저장 프로시저 및 트리거를 작성하시오.
drop table testemp;
create table testemp
    as select empno, ename, sal, deptno
    from emp;

create table testdept
    as select deptno, dname
    from dept;
    
--1. 테이블에 pk_testdept명으로 primary key 제약조건 추가하라
desc user_constraints

select constraint_name, constraint_type, table_name, search_condition, r_constraint_name
from user_constraints
where table_name in('TESTDEPT','TESTEMP');
--null보다 default가 있다면 default가 우선순위가 더 높음.
--프라이머리 같은 제약조건이 없다는 것을 확인할 수 있음.

alter table testdept
add constraint pk_testdept_deptno primary key (deptno);
--제약조건명; 타입_테이블명_컬럼명

--2. testemp 테이블에 pk_testemp명으로 primary key 제약조건 추가하라
alter table testemp
add constraint pk_testemp_empno primary key(empno);

--3. testemp 테이블에 fk_deptno2명으로 foreign key 제약조건 추가하라
alter table testemp
add constraint fk_testemp_deptno 
foreign key(deptno) references testdept(deptno);
--parent table과 이를 참조한 컬럼명을 같이 써주기.

--4. testemp 테이블에 uk_enumber명으로 unique 제약조건 추가하라
--enumber도 아직 만들지 않았기 때문에..

alter table testemp
add enumber char(10) constraint uk_testemp_enumber unique;
--컬럼명과 데이터타입은 따라다님
--add enumber char(10) unique; --시스템이 알아서 제약조건 이름을 붙이게 됨.

--5. testemp 테이블의 ename에 nn_ename명으로 not null 제약조건 추가하라
--not null이 제약조건일까?
--오라클에선 제약조건으로 봄. 다른 곳에선 아닐 수도 있음.
--데이터진흥원에서 시험보는 것, 국제공인.

alter table testemp
modify ename varchar2(10)
constraint ck_testemp_ename not null;
--constraint nn_ename not null;
--modify ename varchar2(10) not null -->>sys_...로 자동으로 붙여짐.
--check constraint 중 하나.

--6. testdept 테이블의 dcount에 default를 추가하라
--대개 default는 제약조건이 아니다.

alter table testdept
add dcount number(3) default 0;
--제약조건이 아닌지라 제약조건명을 줄 수 없음.

--7. testemp 테이블의 enumber 크기를 +4 증가시켜라
alter table testemp --수정?
modify enumber char(14);

--8. testemp 테이블의 egender에 여러 가지 제약조건을 추가하라
alter table testemp
add egender char(1) default 'm' 
constraint nn_testemp not null
constraint ck_testemp_egender check (egender in('m','f'));
--check (); --괄호 안에 있는 게 거짓이면 오류 빡..!

alter table testemp
drop constraint NN_TESTEMP;

alter table testemp
add constraint ck_testemp_egender2 check(egender is not null);  
--not null도 check constraint 종류 중 하나이기에..
desc user_tab_columns
--컬럼들의 속성들까지도 확인하는 방법.

select table_name,column_name,data_default --data_default 데이터 디폴트 값 확인.
from user_tab_columns;

--******************
--0번부터 8번까지 실행 (1)
--******************

select table_name
from user_tables
order by 1;
desc user_tab_columns;

select table_name, column_name
from user_tab_columns
where table_name in ('TESTDEPT','TESTEMP')
order by 1;

--12
create or replace procedure p_insert12(v_empno testemp.empno%type, 
v_ename testemp.ename%type,
v_sal testemp.sal%type,
v_deptno testemp.deptno%type,
v_enumber testemp.enumber%type,
v_egender testemp.egender%type)
is
begin
    insert into testemp values(v_empno, v_ename, v_sal, v_deptno, v_enumber, v_egender);
    
    update testdept
    set dcount = dcount + 1
    where deptno = v_deptno;
    commit;    
exception
  when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/

select * from testemp; --14명일 것임.
select * from testdept;
--delete from testemp where empno=9999;
--프로시저를 실행했을 때에도 안에 있던 쿼리가 트리거에 영향을 받기도 함.

--트리거에서는 내가 변수를 직접 조종할 수 없다.
--:new.deptno
--트리거 내에서 commit도 안한다.
--그러니 트리거 끝나면 바로 커밋..!


--트리거 확인 방법
desc user_object_type;
desc user_triggers;
select trigger_name from user_triggers;

--15
create or replace trigger t_update10 
before update on testemp for each row
begin 
if :old.deptno <> :new.deptno then   
    update testdept
    set dcount = dcount+1
    where deptno = :new.deptno;
    
    update testdept
    set dcount = dcount-1
    where deptno = :old.deptno;
end if;   
exception
  when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/

SELECT * FROM testdept;

select object_name, procedure_name, object_type
from user_procedures
order by 3;

select trigger_name
from user_triggers;

desc user_source
select line, text
from user_source
where name = 'T_UPDATE14';
--트리거 내용 확인.

--desc : describe >>에디터 명령어
--해당하는 곳에 들어있는 컬럼명과 데이터 타입만 알려줌 
--단순한 구조파악을 위해서 쓴다.

desc tabs --축약형
desc user_tables
