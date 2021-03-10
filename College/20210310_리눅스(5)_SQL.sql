#scott_user.sql 파일이름

show user;
desc user_objects;

select object_name, object_type
from user_objects;

desc user_tables;

select table_name, tablespace_name
from user_tables;

desc user_constraints;

select owner, constraint_name, 
constraint_type, table_name, search_condition,r_constraint_name
from user_constraints;

alter table emp
add constraint pk_emp_empno primary key(empno);

alter table dept
add constraint pk_dept_empno primary key(deptno);

alter table emp
add constraint fk_emp_deptno foreign key(deptno) references dept(deptno);

desc user_tab_columns;
select table_name, column_name, data_type
from user_tab_columns
order by 1,2;

desc user_cons_columns;
select constraint_name, table_name, column_name
from user_cons_columns
order by 1,2,3;

select user_constraints.constraint_name, user_constraints.constraint_type, 
user_cons_columns.table_name, user_cons_columns.column_name
from user_constraints  
join user_cons_columns  
on user_constraints.table_name = user_cons_columns.table_name;

select b.constraint_name, b.table_name, b.column_name, a.constraint_type
from user_constraints a join user_cons_columns b
	on a.constraint_name=b.constraint_name;

desc user_objects
select object_name, object_type
from user_objects;

select table_name
from user_tables;

show recyclebin;

purge recyclebin; #휴지통비우기

select *
from emp;

desc emp;

select * from dept;

select * from salgrade;

desc bonus;

select concat('abc','defg') from dual;
select 'abc'||'defg' from dual;	 
select substr('abcdef',2,3) from dual;
select lpad('abcdef',10) from dual;
select lpad('abcdef',10,'=') from dual; 
select lpad('abcdef',5) from dual;


select length(rtrim('abce       ')) from dual;
select ltrim('           abcd') from dual;

select * from emp;

select ename, sal
from emp
where upper(ename) = 'SMITH'; 

select empno, lpad(ename,10), rpad('$'||sal,10)
from emp;

select sysdate from dual;
select to_char(sysdate,'yyyy') from dual; 
select to_char(sysdate,'mm') from dual; 
select to_char(sysdate,'dd') from dual; 
select to_char(sysdate,'day') from dual; 
select to_char(sysdate,'month') from dual;
select to_char(to_date('80/12/24','yy/mm/dd'),'yyyy') from dual;

select to_char(sysdate,'dd-mon-yy') from dual;

select ename, hiredate, to_char(hiredate,'day')
from emp
where to_char(hiredate,'day') in ('수요일','금요일');
