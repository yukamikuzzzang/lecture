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

--******************
--0������ 8������ ���� (1)
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

select * from testemp; --14���� ����.
select * from testdept;
--delete from testemp where empno=9999;
--���ν����� �������� ������ �ȿ� �ִ� ������ Ʈ���ſ� ������ �ޱ⵵ ��.

--Ʈ���ſ����� ���� ������ ���� ������ �� ����.
--:new.deptno
--Ʈ���� ������ commit�� ���Ѵ�.
--�׷��� Ʈ���� ������ �ٷ� Ŀ��..!


--Ʈ���� Ȯ�� ���
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
--Ʈ���� ���� Ȯ��.

--desc : describe >>������ ��ɾ�
--�ش��ϴ� ���� ����ִ� �÷���� ������ Ÿ�Ը� �˷��� 
--�ܼ��� �����ľ��� ���ؼ� ����.

desc tabs --�����
desc user_tables
