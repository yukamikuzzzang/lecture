select empno, ename, sal, comm,
        sal+sal*nvl(comm,0) as ���ޱݾ�,
        case 
        when sal+sal*nvl(comm,0) >= 1000000  then 'good'
        when sal+sal*nvl(comm,0) >= 5000  then 'average'
        when (sal+sal*nvl(comm,0) >= 1 and sal+sal*nvl(comm,0) < 5000)  
        -- (sal+sal*nvl(comm,0) between 1 and 5000 (1<= x <=5000) 
        then 'bad'
        when sal+sal*nvl(comm,0) = 0   then 'no good'
        end as ��
from emp;

--decode�� �ᵵ ����
select empno, ename, --nvl(to_char(mgr),'not exists')
       decode(mgr,null,'not exists',mgr)
       --�������� ����ȯ�� �� �̷������ ������ �ǹ�
from emp;

desc dept;
--ex1)�츮 ȸ�翡 �μ��� �� ����?
select count(*) as �μ� from dept;
--count(*) �� ���� �� �� �ִ� ������ �����Լ�

select empno, ename, sal, comm
from emp;

select empno, ename,sum(sal),sum(comm)
from emp;
--sum(ename) �Ұ�
--null�ϳ��� ���� ��Ģ������ �ϰԵǸ� ������ null�� ������ ��.
--�ܼ��� vs ������(null�� ������ ����)

select count(empno), min(ename), min(sal), max(comm)
from emp;
--min,max �ƽ�Ű�ڵ�� ��ȯ���� ���� ũ��񱳸� �����Ѵ�.

select distinct job 
from emp;
--distinct �ߺ� ����

select count(distinct job), min(ename), min(sal), max(comm)
from emp;

select * from dept;
--ex2)����� ���� �ҼӵǾ� �ִ� �μ��� �� ����?
select count(distinct deptno) from emp;

select * from emp;
select * from dept;
--ex3)�μ����� ����� sal�� ���� ������ deptno, dname, empno, ename, sal ���
select e.deptno, d.dname, e.empno, e.ename, e.sal
from emp e
join dept d             --inner join
on e.deptno = d.deptno
order by dname, sal asc;

-----------------------------------1

select d.deptno, d.dname, e.deptno, e.empno, e.ename, e.sal --���̺� ���� ���дٸ� ���� ����.
from emp e, dept d;
--cross join(��������), cartesian product
--���� �ʿ��� ������ ���� �ο��ؾ��Ѵ�.

select e.deptno, d.dname, e.empno, e.ename, e.sal
from emp e join dept d             --inner join, ���� �� ã�Ҵٸ� equi join, natrual join
on e.deptno = d.deptno
order by dname, sal asc;
--dnamae�� �ִ� primary key���� order by�� ���ص� �����ƺ���.

--ex4) �μ��� ����� �� ������, deptno, dname, �μ��� �ο����� ���
select e.deptno, d.dname, count(*) as "�μ��� �ο���"
from emp e join dept d
on e.deptno = d.deptno
group by e.deptno, d.dname;
--�μ��� �ִ� ���¿��� �μ����� �ο����� �� �� �ִ� ��.
--group by �ϴ� ����� �ʿ�
--"�����Լ�"�� ���� ���ؼ� select���� �ִ� �͵��� group by ���� ���־��.
--� �������� �ٽ� ���� �� ����.

--ex4-1) �μ��� ����� �� ������, deptno, dname, �μ��� �ο����� ����ϵ�,
--5�� �̻��� �μ��� �μ��� �ο��� ���� ������ ����϶�!
select e.deptno, d.dname, count(*) as "�μ��� �ο���"
from emp e join dept d
on e.deptno = d.deptno
group by e.deptno, d.dname
having count(*) >= 5
order by count(*) desc;
--select, (into), from, where, group by, having, order by...
--where ���� : ��������
--having ����: ��������(�׷�����, ������ ���� ����)

--ex4-2)�μ��� ����� ������� 30�� �̻��� �μ���ȣ������ deptno,dename, �μ��� �ο����� ����ϵ�
--5���̻��� �μ��� �μ��� �ο��� ���� ������ ����϶�!
select e.deptno, d.dname, count(*) as "�μ��� �ο���"
from dept d join emp e
on d.deptno = e.deptno
where e.deptno >= 30
group by e.deptno, d.dname
having count(*) >= 5 --and e.deptno >= 30
order by 3 desc;
--having �� ��ü�� �׷��� �� �°ų� �׷��� �ʰų�.

--ex4-3)�μ��� ����� ������� job�� PRESIDENT�� ����� �����ϰ� deptno,dename, �μ��� �ο����� ����ϵ�
--5���̻��� �μ��� �μ��� �ο��� ���� ������ ����϶�!
select e.deptno, d.dname, count(*) as "�μ��� �ο���"
from dept d join emp e
on d.deptno = e.deptno
where job != 'PRESIDENT'    --�μ����� ����, job���� ������ �ʾұ⿡ 
group by e.deptno, d.dname
having count(*) >= 5
order by 3 desc;

select * from emp;
-- != / <>

--ex5)�μ����� �� job�� �ο��� ��������� deptno, dname, job, �ο����� �μ��� job���� �����Ͽ� ���!
select d.deptno, d.dname, e.job, count(*) as "�μ��� �ο���"
from dept d join emp e on d.deptno = e.deptno
group by d.deptno, d.dname, e.job
order by d.dname, e.job;

--*�����Լ��� ���� ���� select list�� �ִ� ������ �÷��� �ݵ�� group by�� �;� �Ѵ�!!

-----------------------------------2

/*
deptno clerk manager president analyst saleman
10      1       1       1
20      2       1                2
30      1       1                           4
������, R������ ��Ÿ��.
*/
select * from emp;
/*
select d.deptno, e.job, count(*)
from dept d join emp e on d.deptno = e.deptno
group by d.deptno, e.job
order by d.deptno, e.job;
*/
select deptno, count(decode(job,'CLERK',0)) as CLERK,
               count(decode(job,'MANAGER',0)) as MANAGER,
               count(decode(job,'PRESIDENT',0)) as PRESIDENT,
               count(decode(job,'ANALYST',0)) as ANALYST,
               count(decode(job,'SALESMAN',0)) as SALESMAN
from emp
group by deptno
order by 1;

--ex6) emp�� sal�� salgrade�� � grade�� �ش�Ǵ��� ename, job, sal, grade�� job���� sal ���� ������ ���!
select * from emp;
select * from user_tables;

select * from salgrade;
select * from emp;
select * from dept;

select e.ename, e.job, e.sal, s.grade
from emp e join salgrade s
    --on e.sal >= s.losal and e.sal <= s.hisal
    on e.sal between s.losal and s.hisal
order by 2,3 desc;
--non equi join
--on �ڿ��� �������� �� �� �ִ�.

--ex6-1)emp�� sal�� salgrade�� � grade�� �ش�Ǵ��� ename, job, sal, grade deptno, dname�� job���� sal ���� ������ ���!
select e.ename, e.job, e.sal, s.grade, d.deptno, d.dname
from emp e 
join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
order by 2,3 desc;

/*
 from A join B on ~ join C on ~
 ���̺� ���� - 1 ���� ��������
 E-S
 E-D
 S!-D
 E-S-D (0)
 S-E-D (0)
 D-S-E (X)
*/

--ex6-1-2)emp�� sal�� salgrade�� � grade�� �ش�Ǵ��� ename, job, sal, grade deptno, dname�� job���� sal ���� ������ ���!
--��, salgrade emp dept ������ ����
select * from salgrade;
select e.ename, e.job, e.sal, s.grade, d.deptno, d.dname
from salgrade s 
join emp e on e.sal >= s.losal and e.sal <= s.hisal
join dept d on d.deptno = e.deptno
order by 2,3;

--ex6-3)��� �μ��� ���Ͽ� emp�� sal�� salgrade�� � grade�� �ش�Ǵ��� deptno, dname, ename, job, sal, grade�� �μ����� job���� sal ���� ������ ���!
--������ ���� ���� ���.
--outer join!, ����/������ > �����ձ���..
--LEFT, LIGHT, FULL OUTER JOIN
select * from salgrade;
select d.deptno, d.dname, e.ename, e.job, e.sal, s.grade
from emp e 
right join dept d on d.deptno = e.deptno
left join salgrade s on e.sal >= s.losal and e.sal <= s.hisal
order by 1,4,5 desc;

-- emp + dept(��� �μ�>>>>(RIGHT))

--ex6-4:6-3���� salgrade emp dept ������ ����
select * from salgrade;
select d.deptno, d.dname, e.ename, e.job, e.sal, s.grade
from salgrade s 
join emp e on e.sal >= s.losal and e.sal <= s.hisal
right join dept d on d.deptno = e.deptno
order by 1,4,5 desc;

/*ex7)��� �μ��� ���Ͽ� sal�� �հ谡 1,000,000�̻��̸�
'good', 5000�̻��̸� 'average', 1�̻� 5000�̸��̸� 'bad', 0�̸� 'no pay',
������ 'not exists'�� ���ϵ�
deptno, dname, �μ��� sal �հ�, �򰡸� ���!*/

select d.deptno, d.dname, sum(e.sal) as "�μ���sal�հ�",
    case
        when sum(e.sal) >= 1000000 then 'good'
        when sum(e.sal) >= 5000 then 'average'
        when sum(e.sal) < 5000 and sum(e.sal) >= 1 then 'bad'
        when sum(e.sal) = 0 then 'no pay'
        else 'not exists'
        --is null
    end as ��
from dept d left join emp e
on d.deptno = e.deptno
group by d.deptno, d.dname
order by 3 desc;
--pharsing �ӵ��� ������.


--ex8)��� �μ��� ���Ͽ� emp�� sal+sal*comm�� salgrade�� � grade�� �ش�Ǵ��� deptno, dname, ename, job, sal, sal+sla*comm,grade�� ����ϵ�
--���� grade�� '***'�� ǥ���ϰ� �μ����� job���� sal ���� ������ ���!

select d.deptno, d.dname, e.ename, e.job, e.sal, e.sal+e.sal*nvl(e.comm,0), 
/*
case 
--when s.grade > 9999 then '5'
when s.grade is null then '***'
when s.grade is not null then s.grade
end
*/
decode(s.grade,null,'***',s.grade) 
from dept d left join emp e on d.deptno = e.deptno
left join salgrade s on e.sal+e.sal*nvl(e.comm,0) between s.losal and s.hisal
order by d.deptno, e.job, e.sal desc;


select * from dept;
select * from emp;

select * from salgrade;