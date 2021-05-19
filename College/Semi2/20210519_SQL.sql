--(1)
create table testemp
as select empno, ename, sal, deptno
    from emp;
alter table testemp add grade number(1);
alter table testemp add sumsal number(10);

select * from testemp;


--sumsal
--grade
--������ ���� �ٸ� Į������ ������ �޾� ���� ä������������ ���Ἲ�� ì�ܾ��ϴ� ��Ȳ.
--PL/SQL�� �� �� �ۿ� ���� ��Ȳ..

/*
is
begin
exception
end;
(exception) ���������� ���� + ��Ȯ�� ���� �ľ�
/
*/

--������ exec ���
--�Ȱ����� ���� �ٽ� ���ĳ���..

--insert
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

--8. procedure p_delete01 �̸����� testemp ���̺�
--delete�ϴ� ���ν����� ������.
--��, �μ���ȣ�� 10�̸� sumsal�� 0���� �����ϰ�
--(sumsal�� 10000�̻��̸� ��������� exception�� invalid_sumsal�� ����Ű��
--'10000 over!'��� �����޼����� ����϶�)

--delete
create or replace procedure p_delete01(v_empno testemp.empno%type)
is
    v_deptno testemp.deptno%type; --���� ����
    v_sumsal testemp.sumsal%type;
    invalid_sumsal exception; --1. ��������
begin
    select deptno
    into v_deptno   --������ ������.
    from testemp
    where empno = v_empno;
    --�� ����� ģ���� deptno�� ���;�
    
    delete from testemp
    where empno = v_empno;
    
    select sum(sal)
    into v_sumsal   --����
    from testemp
    where deptno=v_deptno;
    
    if v_deptno = 10 then v_sumsal:=0;
    end if;
    if v_sumsal >= 100000 then 
        raise invalid_sumsal;   --2. ����!
    end if;
    
    update testemp 
    set sumsal = v_sumsal --���ǵ�� ���� sumasal�� ������ �ʿ䰡 ����.
    where deptno = v_deptno;
    --�� ����� 30������ �ƴ��� �� �� ���� ��Ȳ������..?
    --delete�ϱ� ���� �̸� �μ��� �� ���� �� �ʿ䰡 �ִ�..!
    commit; --�Ϸ�� ������.
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
������ ���º����� �� ���ư����� Ȯ���ϸ� ����.
*/

/*
����ó��;exception

1) �̸� ���ǵ� ����Ŭ ���� ����
:����X, �߻��ÿ� �ڵ� Ʈ��
2) �̸� ���ǵ��� ���� ����Ŭ ���� ����
:����o, �߻��ÿ� �ڵ� Ʈ��
3) ����� ���� ����
:����o, ����ο��� raise������ �߻���Ŵ
*/


select * from testemp;
exec p_delete10(9999);
exec p_insert01(9998,'KIM',2000,20);
--10000�� �Ѿ�� ���̶� exception ó���� �ٲ�� ������..
--����������?

--(2)
/*
������� Ŀ��
���α׷��ӿ� ���� ����Ǿ� �̸��� �ִ� Ŀ��
�Ӽ��� Ŀ���� %rowcount, %found, %notfound, %open�� �ٿ� ���

1. ����(�����) / 2. OPEN(�����) / 3. FETCH(�����) / 4. CLOSE(�����)
*/

--10. procedure p_sum02 ������ �μ��� �޿��հ�(sumsal)�� �� ���� �����϶�
--(��, �μ��� �޿��հ�(sumsal)�� 10�����̸� ��������� exception invalid_sumsal�� ����Ű��
--deptno, sumsal�� ����ϰ� �۾� ����϶�.)
create or replace procedure p_sum02 --input X
is
    v_deptno testemp.deptno%type;
    v_sumsal testemp.sumsal%type;
    invalid_sumsal exception;
begin
    select deptno, sum(sal) --�׷캰 sum(sal)
    into v_deptno, v_sumsal                       
    from testemp
    group by deptno;   
        
    if v_sumsal <= 10 then
        raise invalid_sumsal;
    end if;
    
    update testemp
    set sumsal = v_sumsal --correlated subquery �ϱ⿣ ������ ����..
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
--�� ���ο� �ϳ�. ���� ��ɾ�

select * from testemp;
exec p_sum02;

/*
Ŀ��:cursor:pricate SQL�� �۾�����
1)�Ͻ����� Ŀ��
��� DML�� PL/SQL SELECT���� ���� ����ȴ�.
�Ӽ��� sql%rwocount, sql%found, sql%notfound, sql%open�� ���

2)������� Ŀ��
:���α׷��ӿ� ���� ����Ǿ� �̸��� �ִ� Ŀ��
�Ӽ��� Ŀ���� %rowcount, %found, %notfound, %open�� �ٿ� ���

����
1. ����;����� / 2.OPEN ����� /3. FETCH ����� / 4. CLOSE �����
*/

create or replace procedure p_sum02 --input X
is
    v_deptno testemp.deptno%type;
    v_sumsal testemp.sumsal%type;
    invalid_sumsal exception;
    
    cursor testemp_cur is       --1. Ŀ�� ����
        select deptno, sum(sal) --�׷캰 sum(sal)
                                --Ŀ�� ����� into���� ��� �Ұ�
        from testemp
        group by deptno;   
begin
    open testemp_cur;           --2. Ŀ�� ����
    loop
        fetch testemp_cur into v_deptno, v_sumsal; --3. Ŀ���� ����.
        exit when testemp_cur %notfound; --End Of File
        --% (�Ӽ�)
        if v_sumsal <= 10 then
            raise invalid_sumsal;
        end if;
        
        update testemp
        set sumsal = v_sumsal --correlated subquery �ϱ⿣ ������ ����..
        where deptno = v_deptno;
    end loop; 
    --�ش� ������ �ݺ�(�ϳ��� �����ͼ� �ְ� �ݺ�;many rows...)
    --���� ������ ���� �ʿ����.
    close testemp_cur; --loop ������ ���� �ݱ�. 4.Ŀ�� �ݱ�.
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
--�⸻��� ���� �ֿ� �� 4���� ������ ����..!

--(3)
--0. SCOTT ������ CTAS������� testdept, testemp �ΰ��� ���̺��� �������. 
--�˸´� ���̺� ����, ���� ���ν��� �� Ʈ���Ÿ� �ۼ��Ͻÿ�.
drop table testemp;
create table testemp
    as select empno, ename, sal, deptno
    from emp;

create table testdept
    as select deptno, dname
    from dept;
    
--1. ���̺� pk_testdept������ primary key �������� �߰��϶�
desc user_constraints

select constraint_name, constraint_type, table_name, search_condition, r_constraint_name
from user_constraints
where table_name in('TESTDEPT','TESTEMP');
--null���� default�� �ִٸ� default�� �켱������ �� ����.
--�����̸Ӹ� ���� ���������� ���ٴ� ���� Ȯ���� �� ����.

alter table testdept
add constraint pk_testdept_deptno primary key (deptno);
--�������Ǹ�; Ÿ��_���̺��_�÷���

--2. testemp ���̺� pk_testemp������ primary key �������� �߰��϶�
alter table testemp
add constraint pk_testemp_empno primary key(empno);

--3. testemp ���̺� fk_deptno2������ foreign key �������� �߰��϶�
alter table testemp
add constraint fk_testemp_deptno 
foreign key(deptno) references testdept(deptno);
--parent table�� �̸� ������ �÷����� ���� ���ֱ�.

--4. testemp ���̺� uk_enumber������ unique �������� �߰��϶�
--enumber�� ���� ������ �ʾұ� ������..

alter table testemp
add enumber char(10) constraint uk_testemp_enumber unique;
--�÷���� ������Ÿ���� ����ٴ�
--add enumber char(10) unique; --�ý����� �˾Ƽ� �������� �̸��� ���̰� ��.

--5. testemp ���̺��� ename�� nn_ename������ not null �������� �߰��϶�
--not null�� ���������ϱ�?
--����Ŭ���� ������������ ��. �ٸ� ������ �ƴ� ���� ����.
--��������������� ���躸�� ��, ��������.

alter table testemp
modify ename varchar2(10)
constraint ck_testemp_ename not null;
--constraint nn_ename not null;
--modify ename varchar2(10) not null -->>sys_...�� �ڵ����� �ٿ���.
--check constraint �� �ϳ�.

--6. testdept ���̺��� dcount�� default�� �߰��϶�
--�밳 default�� ���������� �ƴϴ�.

alter table testdept
add dcount number(3) default 0;
--���������� �ƴ����� �������Ǹ��� �� �� ����.

--7. testemp ���̺��� enumber ũ�⸦ +4 �������Ѷ�
alter table testemp --����?
modify enumber char(14);

--8. testemp ���̺��� egender�� ���� ���� ���������� �߰��϶�
alter table testemp
add egender char(1) default 'm' 
constraint nn_testemp not null
constraint ck_testemp_egender check (egender in('m','f'));
--check (); --��ȣ �ȿ� �ִ� �� �����̸� ���� ��..!

alter table testemp
drop constraint NN_TESTEMP;

alter table testemp
add constraint ck_testemp_egender2 check(egender is not null);  
--not null�� check constraint ���� �� �ϳ��̱⿡..
desc user_tab_columns
--�÷����� �Ӽ�������� Ȯ���ϴ� ���.

select table_name,column_name,data_default --data_default ������ ����Ʈ �� Ȯ��.
from user_tab_columns;

--9.testemp ���̺� egender�� not null ���������� �����ϰ� �ٽ� �߰��϶�
--���� ����.. ����

--(4)
--10. ����� ���� �μ��� ��ȸ�� �� �ֵ��� v_testdept �����̺��� �����϶�.
--����� ���� �� ���̺��� ������..?!
create view v_testdept
as select *
    from testdept
    where dcount = 0;
    --���� �߻�, "insufficient privileges"
    --scott�� �信 ���� ������ ����..
    
--sys_user�� �̵�
--sys.oracle
grant create view to scott;
--grant �P�� to �����;
--������ �ް� ���� ���� �䰡 �� ������..!

select * from v_testdept;

/* default�� 0�� 0
10	ACCOUNTING	0
20	RESEARCH	0
30	SALES	    0
40	OPERATIONS	0
*/

--11. testdept���̺� dcount���� �����϶�. ��, Ŀ��(dept_cur)�� ����϶� .
--(+���ν�������? p_dcount01)
--(+10 �̻��� �Ѿ�� 10 over!)
select * from testemp;
--10:3, 20:5, 30:6
--�μ��� �ο����� �ݿ� dcount��..

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
    loop --���� ���� �����Ͱ� �����ϱ⿡
        fetch dept_cur into v_deptno, v_dcount;
       --�߰��� private�� �͵��� �۾��ϴ� ������ �ʿ��ϴ�..
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

--12. testemp���̺� INSERT �ϸ� testdept���̺� ���� �μ���ȣ�� �����(dcount)��    
--    1 �����ϴ� UPDATE�� �ǵ��� stored procedure�� �ۼ��Ͻÿ�
--    ��, testemp���̺� INSERT �ڷ�� (9999,��LEE��,1000,10,��9999-9999��,��f��)

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

--15. 12���� ��Ʈ�ε� Ʈ������.
create or replace trigger t_insert10 
before insert on testemp for each row
--������ο� �� ���� �Ǵ� ģ��.
--Ʈ���Ŵ� ����ΰ� �ʿ����. is X
begin --���� insert���״� �˾Ƽ� update ����..
    update testdept
    set dcount = dcount+1
    where deptno = :new.deptno;
    --new:�ܺκ���
    --�ܺκ����� �ܺκ������� �˷��ֱ� ���� :(�ݷ�) ���̱�
    --Ʈ���ſ� commit �ϴ� �� �ƴ�.
exception
  when others then
        dbms_output.put_line(sqlcode||sqlerrm);
        rollback;
end;
/
--������ �� �ڵ����� ����Ǵ� ��..!
--���� ��Ʈ����Ʈ= dirved(����) ��Ʈ����Ʈ!
--�κи� Ʈ���ŷ� ������ �ȴ�.

select * from testemp;
select * from testdept;

insert into testemp values(9998,'KIM',900,10,'9998-9998','f');

--delete����
--old.deptno �����ϱ� ���� �̸� ����� �س��´ٰ�..

--update����
--�����μ� -1
--�ںμ� +1


--13. testemp���̺� DELETE �ϸ� testdept���̺� ���� �μ���ȣ�� �����(dcount)��       
--    1 �����ϴ� UPDATE�� �ǵ��� stored procedure�� �ۼ��Ͻÿ�.
--    ��, testemp���̺� DELETE �ڷ�� empno=9999 �̴�.

create or replace procedure p_delete10(v_empno testemp.empno%type)
is
    v_deptno testemp.deptno%type;
begin
    select deptno
    into v_deptno
    from testemp
    where empno = v_empno; --�̸� ����
    
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
    --��������: ����� ������ �� ����(commit�� ���� ��������..) old!
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

desc user_source --���� ���� ���ν���, Ʈ����

select line, text
from user_source
where name='T_DELETE10';

--db��� �� db_
--user��� �� user_
desc user_objects

select object_name, object_type
from user_objects
where object_type = 'TRIGGER';

desc user_procedures

select * from user_procedures;
--primary, unique�� �˾Ƽ� �ε����� �ɸ���..!

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
    where empno = v_empno; --v_old�� �����´�.
    
    
    
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
--������ο� �� ���� �Ǵ� ģ��.
--Ʈ���Ŵ� ����ΰ� �ʿ����. is X
begin --���� insert���״� �˾Ƽ� update ����..
    update testdept
    set dcount = dcount+1
    where deptno = :new.deptno;
    
    update testdept
    set dcount = dcount-1
    where deptno = :old.deptno;
    --new:�ܺκ���
    --�ܺκ����� �ܺκ������� �˷��ֱ� ���� :(�ݷ�) ���̱�
    --Ʈ���ſ� commit �ϴ� �� �ƴ�.
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
