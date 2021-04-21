/*hr_user*/
--2-8. �μ����� ��Marketing���� ��� �߿��� �� �μ��� ��� �޿����� �� ���� �޿��� �޴� ����� first_name�� �޿��� ����϶�.

select first_name,salary
from employees e
where department_id = (select department_id from departments where department_name = 'Marketing')
and salary > (select avg(salary) from employees where department_id = e.department_id);

--��� �߿��� �� �μ��� ��� �޿����� �� ���� �޿��� �޴� ���
/*
���������� ���� ���� �⺻����� �״�� �����ϰ��� �غ���.
������ ���� �� �ƴ�����..
*/

select e.first_name, e.salary
from employees e join departments d
    on e.department_id = d.department_id
where d.department_name = 'Marketing' and e.salary > (select avg(salary) 
                                                            from employees 
                                                            where d.department_id = department_id); --correlated query, �����ִ� ����
--�μ� ���̺� �ʿ�
--�μ��� �Ҽӵȴ�! 

--2-9. ��� �μ����� �� �μ��� ����� �޴� ��� �޿����� �� ���� �޿��� �޴� ����� �μ���ȣ, �μ���, first_name�� �޿��� ����϶�.
select d.department_id, d.department_name, e.first_name, e.salary
from employees e join departments d
    on e.department_id = d.department_id
where e.salary > (select avg(salary)
                    from employees
                    where d.department_id = department_id); --corrleated..
--��� �μ����� ��~ �޿��� �޴� �����..
--�� �޿��� ��뺸�� ū��?

select d.department_id, d.department_name, e.first_name, e.salary
from departments d join employees e
on d.department_id = e.department_id
where salary > 
(select avg(salary) from employees 
where d.department_id = department_id 
group by department_id)
order by 1;

--12 ���ӻ�簡 ���� ����� �����Ͽ� ��� ����� ���ӻ�簡 �������� �ϰ� �ʹ�. 
--���(employee_id), first_name, ���ӻ����(manager_id), ���ӻ�� first_name�� 
--��������� ����϶�. (�ζ��κ� �̿�)
--**3���� �������� Ǯ���⿡ �� �� �� Ǯ���.. join, sub query etc..
create table testemp8
as select * from employees;
alter table testemp8
add sumsalary number(10,2); --not null�̸� �ȵ�.
select * from testemp8; --sum
/*
PL/SQL�̳� ����� ���� ����� �غ� ����
SUB QUERY..
*/

--�μ��� �հ踦 ���ƶ�.
select department_id, sum(salary)
from employees
group by department_id
order by 1;

update testemp8 t
set sumsalary = (select sum(salary)
                from testemp8
                where t.department+id = department_id);
                
select distinct department_id, sumsalary 
from testemp8
order by 1;

--2-11
--(select ~ ) ��
--���Ʒ��� �Ľ̼����� �ٲ�
--complex �並 �����ϸ� �Ӹ� ������ ������ �並 ����� �ذ�����.

select *
from (select d.department_id, d.department_name, sum(e.salary)
    from employees e join departments d
        on d.department_id = e.department_id
        group by d.department_id, d.department_name
        order by 3 desc)
        where rownum <=3;
        
        
select i.di,i.dn,i.su
from (select d.department_id di,d.department_name dn,sum(e.salary) su
    from employees e join departments d
    on e.department_id=d.department_id
    group by d.department_id,d.department_name
    order by 3 desc) i
    where rownum between 1 and 3;

/*
���� �������� ��ĭ ä��� �����ε�.
*/
        
        