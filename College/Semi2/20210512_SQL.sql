/*
무결성의 customizing
client <---> dbms <---> server

6. DCL문
    1. DDL문:선언적인 방법;table, view,...
    2. DML문:transaction +프로그래밍방법 <<서버와 데이터가 계속 왔다갔다..
    
    3. SP(Stored Procedure) <<서버에서 모두 해결 후 클라이언트에게 보냄.(3,4,5)
        :프로그래밍방법
        :성능+, 자동X
    4. trigger; 방아쇠
        :프로그래밍 방법
        :성능-, 자동O
    5. index
        :검색성능+, 갱신성능-
    
*PL/SQL
오라클에서 제공하는.. Procedural(절차적) Language

Primary Key, Unique 등을 쓸 때에 자동으로 잡힌다고 함.

수업 내용을 충분히 확인한 후..
책에 가장 끝부분 14장을 확인해보면 PL/SQL에 대한 내용을 더 얻을 수 있음.
다음주에 PL/SQL을 끝내버리고 PL/SQL부분에 대한 수시로 한다고 함.
*/

show user --scott--
show serveroutput --off 상태, on시에 화면에 보여줌.--
set serveroutput on

--기본 포맷
--begin
--end;
--/  --실행시킨다는 의미(꼭 넣기)

--<1> 1부터 10까지 더하기
declare --선언부
    v_num int;
    v_sum int:=0;   --파스칼, 델파이 etc..
begin --구현부
    v_num:=1;
    while v_num <= 10
        loop
         v_sum:=v_sum + v_num;
         v_num:=v_num+1;
        end loop;
    --대체로는 while을 쓴다.
    --다양한 자료구조들은 대체로 while을 이용.
    dbms_output.put_line(v_sum); --print
exception
    when others then --다른 조건이 없다면 무조건 exception으로 옴.
       dbms_output.put_line(sqlcode||sqlerrm); --concat! ||
end;
/

--예외처리는 어디서나 항상 해두기.
--exception이라는 옵션들도 추가해줌으로 고급 프로그램..! 
--에러가 났을 때 정상종료하기 위해서..

declare --선언부
    v_num int;
    v_sum int:=0;   --파스칼, 델파이 etc..
begin --구현부
    v_num:=1;
    loop        --while 대신 loop
    v_sum:=v_sum + v_num;
    if v_num >= 10 then --if, elsif, else
        exit;           --없어진 while 대신 exit(break) 조건
    else       
         v_num:=v_num+1;
    end if;
  end loop;
    dbms_output.put_line(v_sum); --print
exception
    when others then --다른 조건이 없다면 무조건 exception으로 옴.
       dbms_output.put_line(sqlcode||sqlerrm);
end;
/

--<2> 1~20까지 자연수 가운데 3의 배수만 합계를 구하고 출력을 'total: '로 합계를 구하고 'last number: '로 마지막 숫자를 출력하라.
-- +다양한 exception 구현
declare
    v_num int;
    v_sum int:=0;
begin
    v_num:=1;
    loop
    if mod(v_num,3)=0 then --mod() = 0
        v_sum:=v_sum+v_num;
    end if;    
    if v_num >= 20 then
        v_sum:=v_sum/0; --에러 유발 > exception으로 감.
        --1476 ORA-01476: divisor is equal to zero
        exit;
    else
        v_num:=v_num+1;
    end if;
    end loop;
    DBMS_OUTPUT.put_line('total : '||v_sum||' last number : '||v_num);  --별일 없다면 이미 묵시적 형변환이 완료되었다는 뜻.
    --double quot 쓰면 에러..
exception
    when zero_divide then--미리 정의되어있는 exception
        dbms_output.put_line('Try again! divider is 0!'); --개발자가 직접 넣어주는 친절한 에러 설명
        --도움말로 찾아볼 수 있음.
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
/

--<3> deptno로 dname을 출력하는 사용자정의 함수 작성하기(get_dept_name)
/*
Function vs Procedure
PL/SQL을 제외하면 굳이 구분하는 언어가 많이 없는 듯.
*/
create or replace function get_dept_name(v_deptno dept.deptno%type)  --내용 수정시에도 컴파일 됨.
--dept.deptno%type SQL에 있는 타입과 연동;reference type(=스칼라 타입?)
return dept.dname%type                                               --function에선 return type 필요.
is                                                                   --이름 있는 function에선 declare 대신 is를 주세요.
    v_dname dept.dname%type; --v_name은 dept.dname의 type을 참조해..!
begin
    select dname
    into v_dname --지역변수            --호스트와 호환가능한 타입으로 넣어주면 좋음.
    from dept
    where deptno=v_deptno;
    
    dbms_output.put_line(v_dname);    --바로 넣으면 인식못할 수도 있다고 함..
    return v_dname;
exception
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm);
    return 0;
end;
/

--함수 작동
select get_dept_name(10)
from dual;
--function일 땐 function안에다가 RETURN을 써주세요.

select deptno, dname, get_dept_name(deptno)
from dept;

desc user_objects   --<<자신의 소유로서 사용자 정의 함수가 들어있음

select object_name, object_type
from user_objects
order by 2;

desc user_source

select line, text
from user_source
where name='GET_DEPT_NAME'; --함수 내용이 그대로 노출, 주석도 다나오네..

/*
    함수호출방법 3가지
    1 select문 에서
    2 다른 모듈에서
    3 sql*plus에서
*/

declare
    v_dname varchar2(14);
begin
    v_dname:=get_dept_name(30);
    dbms_output.put_line(v_dname);
end;
/

var v_dname varchar2(14)
var
   -- :v_dname 앞에 콜론 붙이는 것은 외부변수라는 뜻.
print v_dname

--<4> emp 테이블에서 ename으로 sal을 출력하는 function명 f_sal을 작성하고 호출하라
--(단, ename은 아는데까지만 입력하여 찾는 패턴 연산자 like를 사용)

create or replace function f_sal(v_ename emp.ename%type)
    return emp.sal%type
is    
   v_sal emp.sal%type; --타입 결정
   
   v_job emp.job%type; --job의 타입 가져오기
begin
    select sal, job
    into v_sal, v_job --지역변수 is에 정의
    from emp
    where ename like '%'||v_ename||'%';
    --<4-1> 
    if v_job='MANAGER' then
        v_sal:=v_sal+v_sal*0.05;
    elsif v_job='SALESMAN' then
        v_sal:=v_sal+v_sal*0.1;
    end if;
    return v_sal;--리턴타입 결정
exception
    when TOO_MANY_ROWS then --인자 수 보다 더 많은 데이터를 가져오는 경우. 
        dbms_output.put_line('Select only one row!');
        return 0;
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm error message
    return 0;
end;
/

select ename,f_sal(ename)
from emp;

select get_ename_to_sal('S')
from dual;
-- 0? exception에서 나옴..
-- S하나만 입력하면 여러개의 데이터가 오게 됨.
-- 파일시스템과 DB구동 방식이 다르기에..
-- private한 공간에서 따로 작업을 할 수 있는 공간을 마련해야함.

--다른모듈?
declare
 v_sal number(10);
begin
 v_sal:=f_sal('SMI');
 dbms_output.put_line(v_sal);
end;
/

var x_sal number
var
exec :x_sal:=f_sal('SMI');
print x_sal

--<5> salgrade테이블에서 grade를 입력하면 해당 grade의 중간값 sal이 리턴되도록 f_midsal 함수를 작성하고 호출하라!
--(단, 중간값 sal은 소수첫째자리에서 반올림)
select * from salgrade;

create or replace function f_midsal(v_grade salgrade.grade%type) 
    return salgrade.losal%type
is
   --v_grade salgrade.grade%type; --타입 결정
   v_sal salgrade.hisal%type;
begin
    select round((losal+hisal)/2,1)
    into v_sal  --지역변수 is에 정의
    from salgrade
    where grade = v_grade;
    --<4-1>
    return v_sal;--리턴타입 결정
exception
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm error message
    return 0;
end;
/

create or replace function f_midsal(v_grade salgrade.grade%type)--output param, input param등 다양한 경우의 수가 있다.
return salgrade.losal%type --타입만 맞춰주면 됨.
is
    v_midsal salgrade.losal%type; --losal이든 hisal이든 타입만 맞추면 이상 무.
begin
    select round((losal+hisal)/2)
    into v_midsal
    from salgrade
    where grade=v_grade; --사용자가 요구한 그 grade
    return v_midsal;
exception
  when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
    return 0;
end;
/

select f_midsal(1)
from dual;

select grade,losal,hisal,f_midsal(grade)
from salgrade;

--fucntion 리턴 타입이 있어서 박힘.
--프로시저? 처리하는 것이 더 중요. / 중간값을 출력하는 것 dbms..!

--<5.1> 5번 문제를 grade의 중간값 sal을 ''출력''하는 프로시저 p_midsal로 작성하라.
create or replace procedure p_midsal(v_grade salgrade.grade%type)--output param, input param등 다양한 경우의 수가 있다.
is
    v_midsal salgrade.losal%type; 
begin
    select round((losal+hisal)/2)
    into v_midsal
    from salgrade
    where grade=v_grade; --사용자가 요구한 그 grade
    dbms_output.put_line(v_midsal);
exception
  when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
end;
/

--프로시저 호출방법?
select p_midsal(1) --ERROR
exec p_midsal(1) --SUCCESS..!

--이름없는 블록? 어나니머스 블록은?
--다른 프로시저에서 부를 때 쓰는 방법..!
begin
    p_midsal(4)
end;
/

/*
    프로시저 호출방법
    
    select 안됨.
    다른 모듈에서 가능 << 어나니머스
    sql*plus에서 exec를 사용..!
*/


--<6 ready> CTAS create table as select
--기법으로 testemp 테이블을 만들고
--컬럼 두개를 추가하시오.
create table testemp
as select empno, ename, sal, deptno from emp;

select * from testemp;

alter table testemp 
add grade number(1);

alter table testemp
add sumsal number(10);

--<6> procedure p_sum01이름으로 부서번호 하나당 급여합계(sumsal)을 update하라.
--*단, 부서번호가 10이면 sumsal을 0으로 갱싱
--sumsal이 10000이상이면 '10000 over!'라는 매세지 출력

--유도 속성? --데이터베이스 설계시 왠만하면 그런거 만들지 마..
--계산된 에트리뷰트 = 유도속성
--내부 칼럼의 내용이 바뀌는 경우 유도속성이 반영을 제때 하지 못해 무결성이 깨짐
--따라서 항상 해당 칼럼을 고쳐주어야 함.

--부서 하나 당 급여 합계를 조절.

--corleated subquery 쓰면 update, set만으로도 되는데 어째서..
--update testemp t
--set sumsal = (select sum(sal) 
--              from testemp 
--             where t.deptno = deptno);

--한 부서만 하는 경우
update testemp t
set sumsal = (select sum(sal)
                from testemp
                where deptno=10)
where deptno = 10;
--10번 부서에만 적용됨.

--요구사항이 많아서..
create or replace procedure p_sum01(v_deptno testemp.deptno%type)
is
    v_sumsal testemp.sumsal%type;
begin
    select sum(sal)
    into v_sumsal
    from testemp
    where deptno = v_deptno;
    
    if v_deptno = 10 then
        v_sumsal:=0;
    end if;
    if v_sumsal >= 10000 then
        dbms_output.put_line('10000 over!');
    end if;
    
    update testemp t
    set sumsal = v_sumsal
    where deptno = v_deptno;
    commit; --데이터베이스에 반영하겠다는 뜻.
exception
 when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
    rollback; --이전 단계로 돌아가겠다는 뜻.
end;
/
--출력과 업데이트를 동시에.
--부서번호를 한꺼번에 처리할 수도 있지만..
--무결성을 갖추기 위해
--sumsal이 칼럼에 의해 무결성이 사라질 것을 염두하고 만듬.

--커밋안하고 rollback된 경우 앞에했던 것들이 날아갈 수 있음.
exec p_sum01(30)

select * from testemp;
--<7> >>>02랑 01이랑 위치가 바뀜..
--procedure p_insert01 이름으로 testemp 테이블에 insert하는 프로시저를 만들어라.

create or replace procedure p_insert02(v_empno testemp.empno%type,
                                       v_ename testemp.ename%type,
                                       v_sal testemp.sal%type,
                                       v_deptno testemp.deptno%type)
is
    v_sumsal testemp.sumsal%type;
begin
    insert into testemp
    values(v_empno,v_ename,v_sal,v_deptno,null,null); --유도 에트리뷰트는 사용자에게 입력받는 것이 아니기에
    --sumsal이 항상 무결해야하나 계산해야만 할 것은 아님..
/*    
    select sum(sal)
    into v_sumsal
    from testemp
    where deptno = v_deptno;

    if v_deptno = 10 then
        v_sumsal:=0;
    end if;
    if v_sumsal >= 10000 then
        dbms_output.put_line('10000 over!');
    end if;
    
    update testemp
    set sumsal=(select sum(sal)
            from testemp
            where deptno = v_deptno)
    where deptno = v_deptno;
*/
    p_sum01(v_deptno);    
    commit;
exception
when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
    rollback; --이전 단계로 돌아가겠다는 뜻.
end;
/

exec p_insert01(9998,'KIM',2000,20);

select * from testemp;
--일일이 클라이언트에 의해서 처리하는 것 보다
--서버에서 처리한 뒤에 보내는 것이 편하고 조아요

--<7-1> 7번을 바탕으로 p_insert02 생성
--단, 부서번호가 10번이면 sumsal을 0으로 갱신
--sumsal이 10000이상이면 '10000 over!'라는 메세지 출력
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

select * from testemp;
exec p_insert02(9996,'PARK',50,10);
exec p_insert02(9995,'PARK',50,10);

--PL/SQL에 용도?
--여러개를 한 번의 작업단위로 인정하는 것이 트랜잭션
--사용자의 요구사항을 다 반영하기 위해서 나온 친구라고 할 수 있다.
