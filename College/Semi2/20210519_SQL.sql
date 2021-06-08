--(1)
create table testemp
as select empno, ename, sal, deptno
    from emp;
alter table testemp add grade number(1);
alter table testemp add sumsal number(10);

select * from testemp;


--sumsal
--grade
--조건은 많고 다른 칼럼들의 영향을 받아 값이 채워져야하지만 무결성도 챙겨야하는 상황.
--PL/SQL을 쓸 수 밖에 없는 상황..

/*
is
begin
exception
end;
(exception) 비정상종료 막기 + 정확한 오류 파악
/
*/

--실행은 exec 사용
--안경집에 가서 다시 고쳐놓자..

--insert
create or replace procedure p_insert01(v_empno testemp.empno%type,
                                       v_ename testemp.ename%type,
                                       v_sal testemp.sal%type,
                                       v_deptno testemp.deptno%type)
is
begin
    insert into testemp
    values(v_empno,v_ename,v_sal,v_deptno,null,null); --유도 에트리뷰트는 사용자에게 입력받는 것이 아니기에
    --sumsal이 항상 무결해야하나 계산해야만 할 것은 아님..
    
    update testemp
    set sumsal=(select sum(sal)
                from testemp
                where deptno = v_deptno)
    where deptno = v_deptno;
    commit;
exception
    when others then
            dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
    rollback; --이전 단계로 돌아가겠다는 뜻.
end;
/

--8. procedure p_delete01 이름으로 testemp 테이블에
--delete하는 프로시저를 만들어라.
--단, 부서번호가 10이면 sumsal을 0으로 갱신하고
--(sumsal이 10000이상이면 사용자정의 exception인 invalid_sumsal을 일으키고
--'10000 over!'라는 에러메세지를 출력하라)

--delete
create or replace procedure p_delete01(v_empno testemp.empno%type)
is
    v_deptno testemp.deptno%type; --로컬 변수
    v_sumsal testemp.sumsal%type;
    invalid_sumsal exception; --1. 오류선언
begin
    select deptno
    into v_deptno   --변수로 가져옴.
    from testemp
    where empno = v_empno;
    --곧 사라질 친구의 deptno를 빼와야
    
    delete from testemp
    where empno = v_empno;
    
    select sum(sal)
    into v_sumsal   --저장
    from testemp
    where deptno=v_deptno;
    
    if v_deptno = 10 then v_sumsal:=0;
    end if;
    if v_sumsal >= 100000 then 
        raise invalid_sumsal;   --2. 실행!
    end if;
    
    update testemp 
    set sumsal = v_sumsal --조건들로 인해 sumasal을 저장할 필요가 있음.
    where deptno = v_deptno;
    --이 사람이 30번인지 아닌지 알 수 없는 상황에서는..?
    --delete하기 전에 미리 부서가 몇 인지 알 필요가 있다..!
    commit; --완료시 마무리.
exception
    when invalid_sumsal then --3. exception
        dbms_output.put_line('10000 over!');
        rollback;
    when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/

/*
시험은 오픈북으로 잘 돌아가는지 확인하며 진행.
*/

/*
예외처리;exception

1) 미리 정의된 오라클 서버 오류
:선언X, 발생시에 자동 트랩
2) 미리 정의되지 않은 오라클 서버 오류
:선언o, 발생시에 자동 트랩
3) 사용자 정의 오류
:선언o, 실행부에서 raise문으로 발생시킴
*/


select * from testemp;
exec p_delete10(9999);
exec p_insert01(9998,'KIM',2000,20);
--10000을 넘어가는 것이라 exception 처리로 바뀌기 때문에..
--정상적종료?

--(2)
/*
명시적인 커서
프로그래머에 의해 선언되어 이름이 있는 커서
속성은 커서명에 %rowcount, %found, %notfound, %open을 붙여 사용

1. 선언(선언부) / 2. OPEN(실행부) / 3. FETCH(실행부) / 4. CLOSE(실행부)
*/

--10. procedure p_sum02 명으로 부서별 급여합계(sumsal)를 한 번에 갱신하라
--(단, 부서별 급여합계(sumsal)가 10이하이면 사용자정의 exception invalid_sumsal을 일으키고
--deptno, sumsal을 출력하고 작업 취소하라.)
create or replace procedure p_sum02 --input X
is
    v_deptno testemp.deptno%type;
    v_sumsal testemp.sumsal%type;
    invalid_sumsal exception;
begin
    select deptno, sum(sal) --그룹별 sum(sal)
    into v_deptno, v_sumsal                       
    from testemp
    group by deptno;   
        
    if v_sumsal <= 10 then
        raise invalid_sumsal;
    end if;
    
    update testemp
    set sumsal = v_sumsal --correlated subquery 하기엔 조건이 많음..
    where deptno = v_deptno;
    commit;
exception
 when invalid_sumsal then
        dbms_output.put_line(v_deptno||v_sumsal);
        rollback;
 when too_many_rows then
        dbms_output.put_line('Try again!');
       rollback;
 when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/ 
--한 라인에 하나. 실행 명령어

select * from testemp;
exec p_sum02;

/*
커서:cursor:pricate SQL의 작업영역
1)암시적인 커서
모든 DML과 PL/SQL SELECT문에 대해 선언된다.
속성은 sql%rwocount, sql%found, sql%notfound, sql%open을 사용

2)명시적인 커서
:프로그래머에 의해 선언되어 이름이 있는 커서
속성은 커서명에 %rowcount, %found, %notfound, %open을 붙여 사용

순서
1. 선언;실행부 / 2.OPEN 실행부 /3. FETCH 실행부 / 4. CLOSE 실행부
*/

create or replace procedure p_sum02 --input X
is
    v_deptno testemp.deptno%type;
    v_sumsal testemp.sumsal%type;
    invalid_sumsal exception;
    
    cursor testemp_cur is       --1. 커서 선언
        select deptno, sum(sal) --그룹별 sum(sal)
                                --커서 선언시 into절은 사용 불가
        from testemp
        group by deptno;   
begin
    open testemp_cur;           --2. 커서 오픈
    loop
        fetch testemp_cur into v_deptno, v_sumsal; --3. 커서를 읽음.
        exit when testemp_cur %notfound; --End Of File
        --% (속성)
        if v_sumsal <= 10 then
            raise invalid_sumsal;
        end if;
        
        update testemp
        set sumsal = v_sumsal --correlated subquery 하기엔 조건이 많음..
        where deptno = v_deptno;
    end loop; 
    --해당 과정을 반복(하나씩 꺼내와서 넣고 반복;many rows...)
    --따로 끝내는 조건 필요없음.
    close testemp_cur; --loop 끝나기 전에 닫기. 4.커서 닫기.
    commit;
    
exception
 when invalid_sumsal then
        dbms_output.put_line(v_deptno||' '||v_sumsal);
        --(||' '||to_char(v_sumsal))
        rollback;
 when too_many_rows then
        dbms_output.put_line('Try again!');
       rollback;
 when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/ 

select * from testemp;
exec p_sum02;
exec p_insert01(9997,'LEE',5,40);
--기말고사 직전 주에 총 4개의 과제를 제출..!

--(3)
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

--9.testemp 테이블에 egender의 not null 제약조건을 삭제하고 다시 추가하라
--위에 있음.. ㄷㄷ

--(4)
--10. 사원이 없는 부서만 조회할 수 있도록 v_testdept 뷰테이블을 생성하라.
--사원이 없는 뷰 테이블을 만들어라..?!
create view v_testdept
as select *
    from testdept
    where dcount = 0;
    --에러 발생, "insufficient privileges"
    --scott은 뷰에 관한 권한이 없음..
    
--sys_user로 이동
--sys.oracle
grant create view to scott;
--grant 핻동 to 사용자;
--권한을 받고 나면 위의 뷰가 잘 생성됨..!

select * from v_testdept;

/* default가 0라서 0
10	ACCOUNTING	0
20	RESEARCH	0
30	SALES	    0
40	OPERATIONS	0
*/

--11. testdept테이블에 dcount값을 생성하라. 단, 커서(dept_cur)를 사용하라 .
--(+프로시저명은? p_dcount01)
--(+10 이상이 넘어가면 10 over!)
select * from testemp;
--10:3, 20:5, 30:6
--부서별 인원수를 반영 dcount로..

create or replace procedure p_dcount01
is
    cursor dept_cur is
        select deptno, count(*)
        from testemp
        group by deptno;
      
    v_deptno testemp.deptno%type;
    v_dcount testdept.dcount%type;
    
    invalid_dcount exception;
begin
    open dept_cur;
    loop --여러 개의 데이터가 존재하기에
        fetch dept_cur into v_deptno, v_dcount;
       --중간에 private한 것들을 작업하는 공간이 필요하다..
        exit when dept_cur %notfound;
       
        if v_dcount >= 10 then
            raise invalid_dcount;
        end if;
       
        update testdept
        set dcount= v_dcount
        where deptno = v_deptno;
    end loop;   
    close dept_cur;
    commit;
exception
    when invalid_dcount then
        dbms_output.put_line('10 over! '||v_deptno||' '||v_dcount);
        rollback;
    when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/
exec p_dcount01;

select * from testemp;
select * from testdept;

update testdept
set dcount = 0;

select * from v_testdept;

--12. testemp테이블에 INSERT 하면 testdept테이블에 같은 부서번호의 사원수(dcount)가    
--    1 증가하는 UPDATE가 되도록 stored procedure를 작성하시오
--    단, testemp테이블에 INSERT 자료는 (9999,‘LEE’,1000,10,‘9999-9999’,‘f’)

create or replace procedure p_insert10(v_empno testemp.empno%type, 
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
select * from testemp;
select * from testdept;
exec p_insert10(9999,'LEE',1000,10,'9999-9999','f');

--15. 12번과 세트인데 트리거임.
create or replace trigger t_insert10 
before insert on testemp for each row
--헤더라인에 죽 쓰면 되는 친구.
--트리거는 선언부가 필요없엉. is X
begin --나는 insert할테니 알아서 update 해줘..
    update testdept
    set dcount = dcount+1
    where deptno = :new.deptno;
    --new:외부변수
    --외부변수는 외부변수임을 알려주기 위해 :(콜론) 붙이기
    --트리거엔 commit 하는 거 아님.
exception
  when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/
--실행할 때 자동으로 실행되는 것..!
--유도 애트리뷰트= dirved(계산된) 애트리뷰트!
--부분만 트리거로 돌리면 된다.

select * from testemp;
select * from testdept;

insert into testemp values(9998,'KIM',900,10,'9998-9998','f');

--delete에선
--old.deptno 삭제하기 전에 미리 기억을 해놓는다고..

--update에선
--이전부서 -1
--뒤부서 +1


--13. testemp테이블에 DELETE 하면 testdept테이블에 같은 부서번호의 사원수(dcount)가       
--    1 감소하는 UPDATE가 되도록 stored procedure를 작성하시오.
--    단, testemp테이블에 DELETE 자료는 empno=9999 이다.

create or replace procedure p_delete10(v_empno testemp.empno%type)
is
    v_deptno testemp.deptno%type;
begin
    select deptno
    into v_deptno
    from testemp
    where empno = v_empno; --미리 저장
    
    delete from testemp
    where empno = v_empno;
    
    update testdept
    set dcount = dcount - 1
    where deptno = v_deptno;
    commit;
    
exception
    when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/

exec p_delete10(9999);
select * from testemp;
select * from testdept;

delete from testemp
where empno = '9999';
commit;

--16.
create or replace trigger t_delete10
before delete on testemp for each row
begin
    update testdept
    set dcount = dcount - 1
    where deptno = :old.deptno; --:!!!!
    --전역변수: 현재는 없어진 그 변수(commit은 아직 안했지만..) old!
exception
    when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/
select * from testdept;
delete from testemp
where empno = 9998;
commit;

desc user_source --내가 만든 프로시저, 트리거

select line, text
from user_source
where name='T_DELETE10';

--db모든 것 db_
--user모든 것 user_
desc user_objects

select object_name, object_type
from user_objects
where object_type = 'TRIGGER';

desc user_procedures

select * from user_procedures;
--primary, unique는 알아서 인덱스가 걸린다..!

--14.
select * from testemp;

create or replace procedure p_update10(
v_empno testemp.empno%type, 
v_ename testemp.ename%type,
v_sal testemp.sal%type,
v_deptno testemp.deptno%type,
v_enumber testemp.enumber%type,
v_egender testemp.egender%type)
is
    v_old testdept.deptno%type;
begin
    select deptno
    into v_old
    from testemp
    where empno = v_empno; --v_old를 가져온다.
    
    
    
    if v_old != v_deptno then
        update testemp
        set deptno = v_deptno
        where empno = v_empno;

        update testdept 
        set dcount = dcount-1
        where deptno = v_old;
        
        update testdept
        set dcount = dcount+1
        where deptno = v_deptno;
    end if;
    commit;    
exception
  when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/
exec p_update10(9999,'LEE',1000,20,'9999-9999','f');
exec p_update10(3939,'MIKU',3000,40,'3939-3939','f');
insert into testemp values(3939,'MIKU',3000,10,'3939-3939','f');
select * from testemp;
select * from testdept;

--17.
create or replace trigger t_update10 
before update on testemp for each row
--헤더라인에 죽 쓰면 되는 친구.
--트리거는 선언부가 필요없엉. is X
begin --나는 insert할테니 알아서 update 해줘..
    update testdept
    set dcount = dcount+1
    where deptno = :new.deptno;
    
    update testdept
    set dcount = dcount-1
    where deptno = :old.deptno;
    --new:외부변수
    --외부변수는 외부변수임을 알려주기 위해 :(콜론) 붙이기
    --트리거엔 commit 하는 거 아님.
exception
  when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/

select * from testemp;

update testemp
set deptno = 40
where empno = 9999;

select * from testdept;
select * from testemp;
