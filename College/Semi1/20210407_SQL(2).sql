
/*
ex6-3
모든 부서에 대해 emp의 sal이 salgrade의 어떤 grade에 해당되는지
deptno, dname, ename, job, sal, grade을 부서별로 job별로 높은순 출력
*/
select d.deptno,d.dname,e.ename,e.job,e.sal,s.grade
from dept d left outer join emp e on d.deptno = e.deptno
left outer join salgrade s
on e.sal between s.losal and s.hisal;
--salgrade에 모든 dept에 해당하는 값이 나오도록 하자.

--ex6-4
select d.deptno,d.dname,e.ename,e.job,e.sal,s.grade
from dept d left outer join emp e on d.deptno = e.deptno
left outer join salgrade s
on e.sal between s.losal and s.hisal;


--ex8)
select d.deptno,d.dname, e.ename, e.job, e.sal, e.comm, e.sal+e.sal*nvl(comm,0), 
decode(s.grade,null,'***',s.grade) as grade 
from  emp e right join dept d on e.deptno = d.deptno 
left join salgrade s on (sal+sal*nvl(comm,0) >= s.losal and sal+sal*nvl(comm,0) <= s.hisal);

--모든 부서에 대해 emp의 sal+sal *comm이 salgrade의 어떤 grade에 해당되는지
--deptno, dname, ename, job, sal, sal+sal*comm, grade를 출력하되 없는 grade는 '***'
--어떤 프로그램이든지 항상 짧게 항상 쉽게


--ex9) 셀프조인
--매니저사번, 매니저명, 부하직원사번, 부하직원명을 매니저사번별로 출력하라. <<role name
select e1.mgr 매니저사번, e2.ename 매니저명, e1.empno 부하직원사번, e1.ename 부하직원명
from emp e1 join emp e2 on e1.mgr = e2.empno
order by 1;

--SMITH의 매니저 > FORD
--생산관리시스템 같은 부분.
--mgr을 무결성을 걸어서
--매니저를 확인할 수 있는 recursive relationship(재귀관계)

--매니저명을 모르는 상태; 같은 행이 아닌 같은 테이블에서 찾을 수 있음.

--7566	JONES	7788	SCOTT
--7566	JONES	7902	FORD
--7698	BLAKE	7654	MARTIN
--7698	BLAKE	7521	WARD
--7698	BLAKE	7844	TURNER
--7698	BLAKE	7900	JAMES
--7698	BLAKE	7499	ALLEN
--7782	CLARK	7934	MILLER
--7788	SCOTT	7876	ADAMS
--7839	KING	7782	CLARK
--7839	KING	7698	BLAKE
--7839	KING	7566	JONES
--7902	FORD	7369	SMITH
--PRESIDENT는 메니저가 없어서 칸에 존재하지 않음


--2
--7주차에는 실습을 해서 수시평가를 볼 것임. 집단지성은 안되오.
--8주차에 중간고사. 

--ER다이어그램에 대한 해석!
--7개의 테이블 <hr 그림 참고>
--Relationship: 사원과 관련된 관계만 5개.

--사이클에 대한 것을 허용하게 됨
--1:다, 다:1

--지역번호 foreign key
--국가번호 foreign key
--지역>국가>위치 (대중소)

--부서번호에 FK > 부서테이블에 있는 PK를 참고했을 것.
--비식별관계 > 점선, 식별관계 > 실선 etc..

--두 개의 테이블간의 S O V를 만들어야 <Relationship Type>
--다:1 자식:부서 부서(번호)는 사원을 포함한다. 사원은 부서(번호)에 소속된다. <수동> (소속,릴레이션 타입) fk:부서번호
--1:다 부모:자식 사원은 부서를 관리한다. 부서장사(번)원은 부서를 관리한다.   <관리> fk:부서장사번

--job:사원 1:다 사원은 job을 소유한다. job은 사원에 의해 소유되어진다.      <소유> fk:job번호
--job이력: 사번에 있던 job번호가 바뀔 때.. [사건] fk:job이력.사번 <<부서,job테이블에서 job번호, 부서번호가 바뀜.
--job이력에 사건이 생겨서 바뀔 때 쓰이는 job이력. 그게 새로운 것일수도 아닐 수도...
--사건 하나로는 이력을 설명할 수 없기에 시작 날짜까지 포함시켜서 pk로 둘 수 있음.
--사원은 job이력을 소유한다. job이력은 사원에 의해 소유된다.
--사람, 장소, 사건, 컨셉

--job:job이력 부모:자식<자식이 부모를 참조,사람이 아니라면 참조>
--job이력이 job을 참조한다.
--부서:job이력 부모:자식
--job이력이 부서를 참조한다.

--recursive relationship 재귀관계
--사원:사원
--/*직속상사 사원이 관계를 통한 pk가 된다.*/
--사번은 직속상사에 의해 관리된다. 직속상사는 사번을 관리한다. <관리>
--부서장사번과 직속상사사번은 관계가 없다.

--재귀관계 특)
--직속상사사번이 null이 아닐 수 없다. (null이 하나는 있어야, 그래야 루프가 깨짐)

--nn : not null > oracle에선 nn을 check constraint로 취급
--ck 시작날짜는 종료날짜보다 작아야한다.
--ck >0 급여는 0보다 커야한다.
--column이 갖는 값에 validation value 타당한 값에 대한 domain을 정의

--number(8,2) : 숫자만 와야
--도메인 무결성을 유지하기 위해
--ck > 0 : 0 이상이어야함.

--unique: 식별자를 찾을 때
--최소성과 유일성을 갖고 찾아라.
--자주 검색하는 메일이기에 unique를 걸음 :alternate key : ak
--hiredate : 고용날짜
--manager_id / manager_id > 원래 컬럼명에는 큰 의미가 없었다.
--한 테이블 안에서는 같은 컬럼명을 쓸 수 없음.
--테이블이 다르다면 가능.
--role name을 하게 되면 또 달라지기 때문에..
--fk는 [도메인]:migration<이주>이 같아야 한다.
--이름을 가져올 필요는 없다.

--단, 데이터 타입은 반드시 같아야 / 이름은 다를 수 있더라도..
--validation value


--sys_user

desc dba_users;
select username, account_status
from dba_users;

--초기화 시켰기에 HR이 LOCK 상태임
--hr 해금

alter user hr 
IDENTIFIED by hr
account unlock;

--이제 테스트할 때마다 hr_user세션을 붙여서하자.


show user
desc user_objects
desc user_tables
desc user_constraints
desc user_columns

--어려울 때 가장 어려울 만한 지점?
--관계가 많아지면서 다른 관계를 써야할 필요가 생길때가 있다.


desc jobs;
desc job_history;
desc employees; --First Name, Last Name

--1-1
select employee_id, first_name, last_name from employees
where UPPER(last_name) = 'SMITH' or UPPER(first_name) = 'SMITH';

select employee_id, first_name, last_name from employees
where UPPER(last_name) like '%SMITH%'
;
--1-2
select employee_id, first_name, last_name, hire_date--, to_char(hire_date,'day') 
from employees--, dual
where to_char(SYSDATE,'month') = to_char(hire_date,'month') and
to_char(hire_date,'day') in ('월요일', '금요일')
order by hire_date desc;

--1-3
select e.department_id, d.department_name, d.manager_id, count(*)  
from departments d join employees e 
on d.department_id = e.department_id
group by e.department_id, d.department_name, d.manager_id
having count(*) > 5;
--order by e.hire_date asc;

select e.department_id, d.department_name, d.manager_id, count(*) as 인원수 
from departments d join employees e on d.department_id = e.department_id
group by e.department_id, d.department_name, d.manager_id
having count(*) >= 5
order by count(*);
--어떤 부서에 사원이 몇 명인가?, <소속>
--1:다 관계에선 다 쪽에 맞추어진다.
--department id > 킴벌리는 null

--1-4
select e.employee_id,  d.department_name, e.salary, count(*), sum(e.salary), trunc((sysdate-e.hire_date)/365)--, to_char(e.hire_date,'yyyy')
from departments d join employees e on d.department_id = e.department_id
where trunc((sysdate-e.hire_date)/365) >= 15 
group by  e.employee_id,  d.department_name, e.salary, trunc((sysdate-e.hire_date)/365)
having count(*) >= 3
order by employee_id, sum(e.salary) desc;

select department_id, sum(salary)--, to_char(e.hire_date,'yyyy')
from employees  
where (sysdate-hire_date)/365 >= 15 
group by  department_id 
having count(*) >= 3
order by 2 desc;

--스토리를 만들어나가며 풀어나가자.

--1-5
select  ememployee_id, salary, cocommission_pct, sasalary*commission
from employees;

select * from employees;

--1-7
select e.employee_id, e.first_name, e.last_name, count(j.employee_id),
--decode(count(*) = 1, 'one','zero',count(*) = 2,'two','many')
case 
    when count(j.employee_id) = 2 then 'two'
    when count(j.employee_id) = 1 then 'one'
    when count(j.employee_id) = 0 then 'zero'
    else 'many'
end as job이력
from job_history j  right outer join employees e
on j.employee_id = e.employee_id
--where j.employee_id is NOT NULL
group by e.employee_id, e.first_name, e.last_name
order by 5;

select e.employee_id, e.first_name, e.last_name,
count(h.start_date) as "job이력의 횟수",
decode(count(h.start_date),0,'zero',1,'one',2,'two','many') as 등급
from employees e left outer join job_history h on e.employee_id = h.employee_id --기본키라서 거는거임 ㅋㅋ
group by e.employee_id, e.first_name, e.last_name --레벨은 같습니다만 사람별로 헤쳐모여
order by 5; 
 
--모든 사원에 대한 내역이 중요, 모든 사람이 job이력이 있는 건 아니기에
--1:다 사원(100건):사건(10건) 부모:자식 사건(자식,다)쪽에 포커스가 맞추어짐. 
--교집합은 최대 10개
--count(*) 교집합일 때에 성격이 맞기 때문에..
--교집합에 부어진 사람들에 대한 데이터들에 대한 값을 세기 때문..
--현재상황에서 * 찍으면 사람 수 밖에 못 샘. (사건이 아니라)
--이때에는 기본키에 있는 PK로 셈을 하세요. / Not Null도 괜찮.
--start_date나 employee_id를 이용해서 세자.


--집합연산자(union, union all, intersect, minus)
--1. 모든 사원의 현재 및 이전의 job 이력정보를 출력!
select employee_id, job_id
FROM employees
union --같은 것이 있으면 하나만 찍어줌.
select employee_id, job_id
FROM job_history;

--select ~ union select ~

select employee_id, job_id
FROM employees
union all 
select employee_id, job_id
FROM job_history
order by 1, 2;   --order by는 한 번만
--개수 순서 타입만 같아도 가능.
--salesman이 manager했다가 다시 salesman 하는 느낌.
--2. job이 변경된 적이 있는 사람?
select employee_id
from employees
intersect
select employee_id
from job_history;
--3. 두 번 이상 같은 job을 수행한 적이 있는 사람?
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;
--4. 한 번도 job이 변경된 적이 없는 사람?
select employee_id
from employees
minus
select employee_id
from job_history;

--1-8
select e.employee_id, e.first_name, e.last_name, j.job_id, j.job_title, d.department_id, d.department_name
from departments d 
right join employees e on e.department_id = d.department_id
left join jobs j on e.job_id= j.job_id 
left join job_history h on e.employee_id = h.employee_id
where h.employee_id is NULL; 
--group by e.employee_id, e.first_name, e.last_name, j.job_id, j.job_title, d.department_id, d.department_name


select * from jobs;
select * from employees;
select * from departments;
select * from job_history;

