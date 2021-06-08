create table emptbl as select * from employees;
alter table emptbl add salgrade varchar2(10);

--1
create or replace function f_salavg(v_jobid jobs.job_id%type)
    return jobs.min_salary%type
is
    v_minsal jobs.min_salary%type;
    v_maxsal jobs.max_salary%type;
begin
    select min_salary, max_salary
    into v_minsal, v_maxsal
    from jobs
    where job_id = v_jobid;
    return round((v_minsal + v_maxsal)/2);
exception
    when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        return 0;
end;
/

--2~9
select * from emptbl;

create or replace procedure p_grade(v_jobid emptbl.job_id%type)
is
    v_empid emptbl.employee_id%type;
    v_sal emptbl.salary%type;
    v_grade emptbl.salgrade%type;
    v_totcnt number:=0;
    v_badcnt number:=0;
    invalid_jobid exception;
    many_bad exception;
    
    cursor emp_cur is
        select employee_id, v_sal
        from emptbl
        where job_id = v_jobid;
begin
    open emp_cur;
    loop
        fetch emp_cur into v_empid, v_sal;
        exit when emp_cur%notfound;
        
        if v_sal >  f_salavg(v_jobid) then
            v_grade := 'good!';
        elsif v_sal =  f_salavg(v_jobid) then
            v_grade := 'average';
        else
            v_grade := 'bad';
            v_badcnt := v_badcnt + 1;
        end if;    
        update emptbl
        set salgrade = v_grade
        where employee_id = v_empid;
        v_totcnt := v_totcnt + 1;
    end loop;
    close emp_cur;
    if v_totcnt = 0 then raise invalid_jobid;
    elsif v_badcnt >= 5 then raise many_bad;
    end if;
    commit;
    dbms_output.put_line('success!' || to_char(v_totcnt) || 'rows');
exception
    when invalid_jobid then
        dbms_output.put_line('no data!');
        rollback;
    when many_bad then
        dbms_output.put_line('many bad');
        rollback;
    when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/

--show user
--show serveroutput
--set serveroutput on

exec f_salvag('IT_PROG')

--11 값이 딱 한 건만 나오도록 해야
select f_salavg('IT_PROG')
from dual;

--12 
exec p_grade('IT_PROG')
select * from emptbl;

--13 시스템 뷰 명만 쓰면 됨.
--14 트리거




select line, text
from user_source;
where name = 'T_UPDATE14';