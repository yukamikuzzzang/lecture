/*
���Ἲ�� customizing
client <---> dbms <---> server

6. DCL��
    1. DDL��:�������� ���;table, view,...
    2. DML��:transaction +���α׷��ֹ�� <<������ �����Ͱ� ��� �Դٰ���..
    
    3. SP(Stored Procedure) <<�������� ��� �ذ� �� Ŭ���̾�Ʈ���� ����.(3,4,5)
        :���α׷��ֹ��
        :����+, �ڵ�X
    4. trigger; ��Ƽ�
        :���α׷��� ���
        :����-, �ڵ�O
    5. index
        :�˻�����+, ���ż���-
    
*PL/SQL
����Ŭ���� �����ϴ�.. Procedural(������) Language

Primary Key, Unique ���� �� ���� �ڵ����� �����ٰ� ��.

���� ������ ����� Ȯ���� ��..
å�� ���� ���κ� 14���� Ȯ���غ��� PL/SQL�� ���� ������ �� ���� �� ����.
�����ֿ� PL/SQL�� ���������� PL/SQL�κп� ���� ���÷� �Ѵٰ� ��.
*/

show user --scott--
show serveroutput --off ����, on�ÿ� ȭ�鿡 ������.--
set serveroutput on

--�⺻ ����
--begin
--end;
--/  --�����Ų�ٴ� �ǹ�(�� �ֱ�)

--<1> 1���� 10���� ���ϱ�
declare --�����
    v_num int;
    v_sum int:=0;   --�Ľ�Į, ������ etc..
begin --������
    v_num:=1;
    while v_num <= 10
        loop
         v_sum:=v_sum + v_num;
         v_num:=v_num+1;
        end loop;
    --��ü�δ� while�� ����.
    --�پ��� �ڷᱸ������ ��ü�� while�� �̿�.
    dbms_output.put_line(v_sum); --print
exception
    when others then --�ٸ� ������ ���ٸ� ������ exception���� ��.
       dbms_output.put_line(sqlcode||sqlerrm); --concat! ||
end;
/

--����ó���� ��𼭳� �׻� �صα�.
--exception�̶�� �ɼǵ鵵 �߰��������� ��� ���α׷�..! 
--������ ���� �� ���������ϱ� ���ؼ�..

declare --�����
    v_num int;
    v_sum int:=0;   --�Ľ�Į, ������ etc..
begin --������
    v_num:=1;
    loop        --while ��� loop
    v_sum:=v_sum + v_num;
    if v_num >= 10 then --if, elsif, else
        exit;           --������ while ��� exit(break) ����
    else       
         v_num:=v_num+1;
    end if;
  end loop;
    dbms_output.put_line(v_sum); --print
exception
    when others then --�ٸ� ������ ���ٸ� ������ exception���� ��.
       dbms_output.put_line(sqlcode||sqlerrm);
end;
/

--<2> 1~20���� �ڿ��� ��� 3�� ����� �հ踦 ���ϰ� ����� 'total: '�� �հ踦 ���ϰ� 'last number: '�� ������ ���ڸ� ����϶�.
-- +�پ��� exception ����
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
        v_sum:=v_sum/0; --���� ���� > exception���� ��.
        --1476 ORA-01476: divisor is equal to zero
        exit;
    else
        v_num:=v_num+1;
    end if;
    end loop;
    DBMS_OUTPUT.put_line('total : '||v_sum||' last number : '||v_num);  --���� ���ٸ� �̹� ������ ����ȯ�� �Ϸ�Ǿ��ٴ� ��.
    --double quot ���� ����..
exception
    when zero_divide then--�̸� ���ǵǾ��ִ� exception
        dbms_output.put_line('Try again! divider is 0!'); --�����ڰ� ���� �־��ִ� ģ���� ���� ����
        --���򸻷� ã�ƺ� �� ����.
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
/

--<3> deptno�� dname�� ����ϴ� ��������� �Լ� �ۼ��ϱ�(get_dept_name)
/*
Function vs Procedure
PL/SQL�� �����ϸ� ���� �����ϴ� �� ���� ���� ��.
*/
create or replace function get_dept_name(v_deptno dept.deptno%type)  --���� �����ÿ��� ������ ��.
--dept.deptno%type SQL�� �ִ� Ÿ�԰� ����;reference type(=��Į�� Ÿ��?)
return dept.dname%type                                               --function���� return type �ʿ�.
is                                                                   --�̸� �ִ� function���� declare ��� is�� �ּ���.
    v_dname dept.dname%type; --v_name�� dept.dname�� type�� ������..!
begin
    select dname
    into v_dname --��������            --ȣ��Ʈ�� ȣȯ������ Ÿ������ �־��ָ� ����.
    from dept
    where deptno=v_deptno;
    
    dbms_output.put_line(v_dname);    --�ٷ� ������ �νĸ��� ���� �ִٰ� ��..
    return v_dname;
exception
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm);
    return 0;
end;
/

--�Լ� �۵�
select get_dept_name(10)
from dual;
--function�� �� function�ȿ��ٰ� RETURN�� ���ּ���.

select deptno, dname, get_dept_name(deptno)
from dept;

desc user_objects   --<<�ڽ��� �����μ� ����� ���� �Լ��� �������

select object_name, object_type
from user_objects
order by 2;

desc user_source

select line, text
from user_source
where name='GET_DEPT_NAME'; --�Լ� ������ �״�� ����, �ּ��� �ٳ�����..

/*
    �Լ�ȣ���� 3����
    1 select�� ����
    2 �ٸ� ��⿡��
    3 sql*plus����
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
   -- :v_dname �տ� �ݷ� ���̴� ���� �ܺκ������ ��.
print v_dname

--<4> emp ���̺��� ename���� sal�� ����ϴ� function�� f_sal�� �ۼ��ϰ� ȣ���϶�
--(��, ename�� �ƴµ������� �Է��Ͽ� ã�� ���� ������ like�� ���)

create or replace function f_sal(v_ename emp.ename%type)
    return emp.sal%type
is    
   v_sal emp.sal%type; --Ÿ�� ����
   
   v_job emp.job%type; --job�� Ÿ�� ��������
begin
    select sal, job
    into v_sal, v_job --�������� is�� ����
    from emp
    where ename like '%'||v_ename||'%';
    --<4-1> 
    if v_job='MANAGER' then
        v_sal:=v_sal+v_sal*0.05;
    elsif v_job='SALESMAN' then
        v_sal:=v_sal+v_sal*0.1;
    end if;
    return v_sal;--����Ÿ�� ����
exception
    when TOO_MANY_ROWS then --���� �� ���� �� ���� �����͸� �������� ���. 
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
-- 0? exception���� ����..
-- S�ϳ��� �Է��ϸ� �������� �����Ͱ� ���� ��.
-- ���Ͻý��۰� DB���� ����� �ٸ��⿡..
-- private�� �������� ���� �۾��� �� �� �ִ� ������ �����ؾ���.

--�ٸ����?
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

--<5> salgrade���̺��� grade�� �Է��ϸ� �ش� grade�� �߰��� sal�� ���ϵǵ��� f_midsal �Լ��� �ۼ��ϰ� ȣ���϶�!
--(��, �߰��� sal�� �Ҽ�ù°�ڸ����� �ݿø�)
select * from salgrade;

create or replace function f_midsal(v_grade salgrade.grade%type) 
    return salgrade.losal%type
is
   --v_grade salgrade.grade%type; --Ÿ�� ����
   v_sal salgrade.hisal%type;
begin
    select round((losal+hisal)/2,1)
    into v_sal  --�������� is�� ����
    from salgrade
    where grade = v_grade;
    --<4-1>
    return v_sal;--����Ÿ�� ����
exception
    when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm error message
    return 0;
end;
/

create or replace function f_midsal(v_grade salgrade.grade%type)--output param, input param�� �پ��� ����� ���� �ִ�.
return salgrade.losal%type --Ÿ�Ը� �����ָ� ��.
is
    v_midsal salgrade.losal%type; --losal�̵� hisal�̵� Ÿ�Ը� ���߸� �̻� ��.
begin
    select round((losal+hisal)/2)
    into v_midsal
    from salgrade
    where grade=v_grade; --����ڰ� �䱸�� �� grade
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

--fucntion ���� Ÿ���� �־ ����.
--���ν���? ó���ϴ� ���� �� �߿�. / �߰����� ����ϴ� �� dbms..!

--<5.1> 5�� ������ grade�� �߰��� sal�� ''���''�ϴ� ���ν��� p_midsal�� �ۼ��϶�.
create or replace procedure p_midsal(v_grade salgrade.grade%type)--output param, input param�� �پ��� ����� ���� �ִ�.
is
    v_midsal salgrade.losal%type; 
begin
    select round((losal+hisal)/2)
    into v_midsal
    from salgrade
    where grade=v_grade; --����ڰ� �䱸�� �� grade
    dbms_output.put_line(v_midsal);
exception
  when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
end;
/

--���ν��� ȣ����?
select p_midsal(1) --ERROR
exec p_midsal(1) --SUCCESS..!

--�̸����� ���? ��ϸӽ� �����?
--�ٸ� ���ν������� �θ� �� ���� ���..!
begin
    p_midsal(4)
end;
/

/*
    ���ν��� ȣ����
    
    select �ȵ�.
    �ٸ� ��⿡�� ���� << ��ϸӽ�
    sql*plus���� exec�� ���..!
*/


--<6 ready> CTAS create table as select
--������� testemp ���̺��� �����
--�÷� �ΰ��� �߰��Ͻÿ�.
create table testemp
as select empno, ename, sal, deptno from emp;

select * from testemp;

alter table testemp 
add grade number(1);

alter table testemp
add sumsal number(10);

--<6> procedure p_sum01�̸����� �μ���ȣ �ϳ��� �޿��հ�(sumsal)�� update�϶�.
--*��, �μ���ȣ�� 10�̸� sumsal�� 0���� ����
--sumsal�� 10000�̻��̸� '10000 over!'��� �ż��� ���

--���� �Ӽ�? --�����ͺ��̽� ����� �ظ��ϸ� �׷��� ������ ��..
--���� ��Ʈ����Ʈ = �����Ӽ�
--���� Į���� ������ �ٲ�� ��� �����Ӽ��� �ݿ��� ���� ���� ���� ���Ἲ�� ����
--���� �׻� �ش� Į���� �����־�� ��.

--�μ� �ϳ� �� �޿� �հ踦 ����.

--corleated subquery ���� update, set�����ε� �Ǵµ� ��°��..
--update testemp t
--set sumsal = (select sum(sal) 
--              from testemp 
--             where t.deptno = deptno);

--�� �μ��� �ϴ� ���
update testemp t
set sumsal = (select sum(sal)
                from testemp
                where deptno=10)
where deptno = 10;
--10�� �μ����� �����.

--�䱸������ ���Ƽ�..
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
    commit; --�����ͺ��̽��� �ݿ��ϰڴٴ� ��.
exception
 when others then
        dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
    rollback; --���� �ܰ�� ���ư��ڴٴ� ��.
end;
/
--��°� ������Ʈ�� ���ÿ�.
--�μ���ȣ�� �Ѳ����� ó���� ���� ������..
--���Ἲ�� ���߱� ����
--sumsal�� Į���� ���� ���Ἲ�� ����� ���� �����ϰ� ����.

--Ŀ�Ծ��ϰ� rollback�� ��� �տ��ߴ� �͵��� ���ư� �� ����.
exec p_sum01(30)

select * from testemp;
--<7> >>>02�� 01�̶� ��ġ�� �ٲ�..
--procedure p_insert01 �̸����� testemp ���̺� insert�ϴ� ���ν����� ������.

create or replace procedure p_insert02(v_empno testemp.empno%type,
                                       v_ename testemp.ename%type,
                                       v_sal testemp.sal%type,
                                       v_deptno testemp.deptno%type)
is
    v_sumsal testemp.sumsal%type;
begin
    insert into testemp
    values(v_empno,v_ename,v_sal,v_deptno,null,null); --���� ��Ʈ����Ʈ�� ����ڿ��� �Է¹޴� ���� �ƴϱ⿡
    --sumsal�� �׻� �����ؾ��ϳ� ����ؾ߸� �� ���� �ƴ�..
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
    rollback; --���� �ܰ�� ���ư��ڴٴ� ��.
end;
/

exec p_insert01(9998,'KIM',2000,20);

select * from testemp;
--������ Ŭ���̾�Ʈ�� ���ؼ� ó���ϴ� �� ����
--�������� ó���� �ڿ� ������ ���� ���ϰ� ���ƿ�

--<7-1> 7���� �������� p_insert02 ����
--��, �μ���ȣ�� 10���̸� sumsal�� 0���� ����
--sumsal�� 10000�̻��̸� '10000 over!'��� �޼��� ���
create or replace procedure p_insert01(v_empno testemp.empno%type,
                                       v_ename testemp.ename%type,
                                       v_sal testemp.sal%type,
                                       v_deptno testemp.deptno%type)
is
begin
    insert into testemp
    values(v_empno,v_ename,v_sal,v_deptno,null,null); --���� ��Ʈ����Ʈ�� ����ڿ��� �Է¹޴� ���� �ƴϱ⿡
    --sumsal�� �׻� �����ؾ��ϳ� ����ؾ߸� �� ���� �ƴ�..
    
    update testemp
    set sumsal=(select sum(sal)
                from testemp
                where deptno = v_deptno)
    where deptno = v_deptno;
    commit;
exception
    when others then
            dbms_output.put_line(sqlcode||' '||sqlerrm); --errm: error message
    rollback; --���� �ܰ�� ���ư��ڴٴ� ��.
end;
/

select * from testemp;
exec p_insert02(9996,'PARK',50,10);
exec p_insert02(9995,'PARK',50,10);

--PL/SQL�� �뵵?
--�������� �� ���� �۾������� �����ϴ� ���� Ʈ�����
--������� �䱸������ �� �ݿ��ϱ� ���ؼ� ���� ģ����� �� �� �ִ�.
