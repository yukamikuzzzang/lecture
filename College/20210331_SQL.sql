--scott_user
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

--hr_user
show user
desc user_objects
desc user_tables
desc user_constraints
desc user_columns

--어려울 때 가장 어려울 만한 지점?
--관계가 많아지면서 다른 관계를 써야할 필요가 생길때가 있다.