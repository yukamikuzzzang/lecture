select empno, ename, sal, comm,
        sal+sal*nvl(comm,0) as 지급금액,
        case 
        when sal+sal*nvl(comm,0) >= 1000000  then 'good'
        when sal+sal*nvl(comm,0) >= 5000  then 'average'
        when (sal+sal*nvl(comm,0) >= 1 and sal+sal*nvl(comm,0) < 5000)  
        -- (sal+sal*nvl(comm,0) between 1 and 5000 (1<= x <=5000) 
        then 'bad'
        when sal+sal*nvl(comm,0) = 0   then 'no good'
        end as 평가
from emp;

--decode를 써도 무관
select empno, ename, --nvl(to_char(mgr),'not exists')
       decode(mgr,null,'not exists',mgr)
       --묵시적인 형변환이 잘 이루어지고 있음을 의미
from emp;

desc dept;
--ex1)우리 회사에 부서가 몇 개야?
select count(*) as 부서 from dept;
--count(*) 행 별로 셀 수 있는 유일한 집계함수

select empno, ename, sal, comm
from emp;

select empno, ename,sum(sal),sum(comm)
from emp;
--sum(ename) 불가
--null하나만 들어가도 사칙연산을 하게되면 무조건 null이 나오게 됨.
--단수행 vs 복수행(null이 무조건 제외)

select count(empno), min(ename), min(sal), max(comm)
from emp;
--min,max 아스키코드로 변환했을 때에 크기비교를 시전한다.

select distinct job 
from emp;
--distinct 중복 제거

select count(distinct job), min(ename), min(sal), max(comm)
from emp;

select * from dept;
--ex2)사원이 현재 소속되어 있는 부서는 몇 개야?
select count(distinct deptno) from emp;

select * from emp;
select * from dept;
--ex3)부서별로 사원의 sal이 낮은 순으로 deptno, dname, empno, ename, sal 출력
select e.deptno, d.dname, e.empno, e.ename, e.sal
from emp e
join dept d             --inner join
on e.deptno = d.deptno
order by dname, sal asc;

-----------------------------------1

select d.deptno, d.dname, e.deptno, e.empno, e.ename, e.sal --테이블 별로 찍어둔다면 문제 없음.
from emp e, dept d;
--cross join(교차조인), cartesian product
--내가 필요한 조건을 직접 부여해야한다.

select e.deptno, d.dname, e.empno, e.ename, e.sal
from emp e join dept d             --inner join, 같은 걸 찾았다면 equi join, natrual join
on e.deptno = d.deptno
order by dname, sal asc;
--dnamae에 있는 primary key덕에 order by를 안해도 괜찮아보임.

--ex4) 부서별 사원이 몇 명인지, deptno, dname, 부서별 인원수를 출력
select e.deptno, d.dname, count(*) as "부서별 인원수"
from emp e join dept d
on e.deptno = d.deptno
group by e.deptno, d.dname;
--부서만 있는 상태에서 부서별로 인원수를 샐 수 있는 것.
--group by 하는 대상이 필요
--"집계함수"를 쓰기 위해선 select절에 있는 것들을 group by 에도 써주어야.
--어떤 기준으로 다시 모을 때 쓴다.

--ex4-1) 부서별 사원이 몇 명인지, deptno, dname, 부서별 인원수를 출력하되,
--5명 이상인 부서만 부서별 인원수 높은 순으로 출력하라!
select e.deptno, d.dname, count(*) as "부서별 인원수"
from emp e join dept d
on e.deptno = d.deptno
group by e.deptno, d.dname
having count(*) >= 5
order by count(*) desc;
--select, (into), from, where, group by, having, order by...
--where 조건 : 개별조건
--having 조건: 직계조건(그룹조건, 복수에 대한 조건)

--ex4-2)부서별 사원이 몇명인지 30번 이상인 부서번호만으로 deptno,dename, 부서별 인원수를 출력하되
--5명이상인 부서만 부서별 인원수 높은 순으로 출력하라!
select e.deptno, d.dname, count(*) as "부서별 인원수"
from dept d join emp e
on d.deptno = e.deptno
where e.deptno >= 30
group by e.deptno, d.dname
having count(*) >= 5 --and e.deptno >= 30
order by 3 desc;
--having 그 전체의 그룹이 다 맞거나 그렇지 않거나.

--ex4-3)부서별 사원이 몇명인지 job이 PRESIDENT인 사원을 제외하고 deptno,dename, 부서별 인원수를 출력하되
--5명이상인 부서만 부서별 인원수 높은 순으로 출력하라!
select e.deptno, d.dname, count(*) as "부서별 인원수"
from dept d join emp e
on d.deptno = e.deptno
where job != 'PRESIDENT'    --부서별로 모였지, job별로 모이진 않았기에 
group by e.deptno, d.dname
having count(*) >= 5
order by 3 desc;

select * from emp;
-- != / <>

--ex5)부서별로 각 job별 인원이 몇명인지를 deptno, dname, job, 인원수를 부서별 job별로 정렬하여 출력!
select d.deptno, d.dname, e.job, count(*) as "부서별 인원수"
from dept d join emp e on d.deptno = e.deptno
group by d.deptno, d.dname, e.job
order by d.dname, e.job;

--*집계함수와 같이 쓰는 select list에 있는 나머지 컬럼은 반드시 group by에 와야 한다!!

-----------------------------------2

/*
deptno clerk manager president analyst saleman
10      1       1       1
20      2       1                2
30      1       1                           4
빅데이터, R에서의 스타일.
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

--ex6) emp의 sal이 salgrade의 어떤 grade에 해당되는지 ename, job, sal, grade를 job별로 sal 높은 순으로 출력!
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
--on 뒤에는 조건절이 올 수 있다.

--ex6-1)emp의 sal이 salgrade의 어떤 grade에 해당되는지 ename, job, sal, grade deptno, dname을 job별로 sal 높은 순으로 출력!
select e.ename, e.job, e.sal, s.grade, d.deptno, d.dname
from emp e 
join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
order by 2,3 desc;

/*
 from A join B on ~ join C on ~
 테이블 갯수 - 1 개의 조인조건
 E-S
 E-D
 S!-D
 E-S-D (0)
 S-E-D (0)
 D-S-E (X)
*/

--ex6-1-2)emp의 sal이 salgrade의 어떤 grade에 해당되는지 ename, job, sal, grade deptno, dname을 job별로 sal 높은 순으로 출력!
--단, salgrade emp dept 순으로 조인
select * from salgrade;
select e.ename, e.job, e.sal, s.grade, d.deptno, d.dname
from salgrade s 
join emp e on e.sal >= s.losal and e.sal <= s.hisal
join dept d on d.deptno = e.deptno
order by 2,3;

--ex6-3)모든 부서에 대하여 emp의 sal이 salgrade의 어떤 grade에 해당되는지 deptno, dname, ename, job, sal, grade을 부서별로 job별로 sal 높은 순으로 출력!
--시험을 보지 않은 경우.
--outer join!, 왼쪽/오른쪽 > 여집합까지..
--LEFT, LIGHT, FULL OUTER JOIN
select * from salgrade;
select d.deptno, d.dname, e.ename, e.job, e.sal, s.grade
from emp e 
right join dept d on d.deptno = e.deptno
left join salgrade s on e.sal >= s.losal and e.sal <= s.hisal
order by 1,4,5 desc;

-- emp + dept(모든 부서>>>>(RIGHT))

--ex6-4:6-3참고 salgrade emp dept 순으로 조인
select * from salgrade;
select d.deptno, d.dname, e.ename, e.job, e.sal, s.grade
from salgrade s 
join emp e on e.sal >= s.losal and e.sal <= s.hisal
right join dept d on d.deptno = e.deptno
order by 1,4,5 desc;

/*ex7)모든 부서에 대하여 sal의 합계가 1,000,000이상이면
'good', 5000이상이면 'average', 1이상 5000미만이면 'bad', 0이면 'no pay',
없으면 'not exists'로 평가하되
deptno, dname, 부서별 sal 합계, 평가를 출력!*/

select d.deptno, d.dname, sum(e.sal) as "부서별sal합계",
    case
        when sum(e.sal) >= 1000000 then 'good'
        when sum(e.sal) >= 5000 then 'average'
        when sum(e.sal) < 5000 and sum(e.sal) >= 1 then 'bad'
        when sum(e.sal) = 0 then 'no pay'
        else 'not exists'
        --is null
    end as 평가
from dept d left join emp e
on d.deptno = e.deptno
group by d.deptno, d.dname
order by 3 desc;
--pharsing 속도가 빠르다.


--ex8)모든 부서에 대하여 emp의 sal+sal*comm이 salgrade의 어떤 grade에 해당되는지 deptno, dname, ename, job, sal, sal+sla*comm,grade를 출력하되
--없는 grade는 '***'로 표시하고 부서별로 job별로 sal 높은 순으로 출력!

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
