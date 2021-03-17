select sysdate from dual;
desc user_objects;

select object_name, object_type
from user_objects
order by 2,1;

desc user_constraints;

select constraint_name, constraint_type, table_name,search_condition,
r_constraint_name from user_constraints
order by 2, 1;
show recyclebin;
purge recyclebin;   
desc user_cons_columns;

select constraint_name, tabale_name, column,constraint_tpye, search_condition,
constraint_type,search_condition, r_constraint_name
from user_cons_column a join user_constraints b
    on a.constraint_name = b.constraint_name;
order by 4;


select sysdate from dual;

select to_char(sysdate,'dd-month,yy') 
from dual;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss day')
from dual;

select to_char(to_date('80/03/17','yy/mm/dd'),'yyyy')
from dual;

select ename, hiredate, to_char(hiredate,'day') as "요 일"
from emp
where to_char(hiredate,'day') in ('수요일','금요일'); 

select ename, hiredate, to_char(hiredate,'mon') as "월"
from emp
where rtrim(to_char(hiredate,'mon')) in ('2월', '12월');

select trunc((sysdate-hiredate)/365)
from emp;

select to_char(1234567.89,'000,000,000.00')
from dual;

select to_char(-1234567.89,'000,000,000.00s')
from dual;

select to_number(to_char(-1234567.89,'000,000,000.00L'),'999,999,999.99L')
from dual;

select to_number('-$1,234,567.89','$999,999,999.99')
from dual;

select empno, ename, sal, comm, nvl(sal*comm,0) as 지급금액
from emp
where sal*nvl(comm,0) < 1000000;

select empno, ename, sal, lpad(nvl(to_char(comm,'$999,999'),'해당 없음'),10) as 상여금
from emp;

select empno, ename, sal, lpad(decode(comm,null,'해당없음',0,'zero',
    to_char(comm,'999,999')),10) as 상여금
from emp;

select ename, hiredate, to_date(trunc((sysdate-hiredate)/365)) as "근속 연수"
from emp;

select ename, hiredate, trunc((sysdate-hiredate)/365) as "근속 연수" ,
/*decode(trunc((sysdate-hiredate)/365),10,'10돈','20','20돈','30','30돈','40','40돈','*') as "황금열쇠대상자"*/
case   trunc((sysdate-hiredate)/365)
        when  10  then '10돈'
        when  20  then '20돈'
        when  30  then '30돈'
        when  40  then '40돈'
        else '*'
end as 황금열쇠대상자
from emp;

select empno, ename, job, sal, 
/*round(decode(job,'CLERK',sal*1.2,'MANAGER',sal*1.5,sal)) as "인상된 sal"*/
case job
    when 'CLERK' then round(sal*1.2,0)
    when 'MANAGER' then round(sal*1.5,0)
    else sal
end as "인상된 sal"    
from emp;

create table testemp as
select * 
from emp;

select * from testemp;
desc testemp;

select object_name, object_type 
from user_objects;

select constraint_name, constraint_type,
search_condition
from user_constraints
order by 2;

select * from testemp;

select object_name, object_type 
from user_objects;

update testemp
set sal = round(decode(job,'CLERK',sal*1.2,'MANAGER',sal*1.5,sal));


select * from testemp;

select empno, ename, sal, comm,  sal+sal*nvl(comm,1),
case 
    when  sal+sal*nvl(comm,0) >=1000000 then 'good'
    when  sal+sal*nvl(comm,0) >= 5000 then 'average'
    when sal+sal*nvl(comm,0) = 0  then 'no good'
    else 'bad'
end
from emp;

select * from emp;

select empno, ename, 
case 
    when mgr is NULL then 'not exists'
    else to_char(mgr)
end
from emp;
