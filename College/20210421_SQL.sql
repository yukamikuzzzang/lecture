/*hr_user*/
--2-8. 부서명이 ‘Marketing’인 사원 중에서 그 부서의 평균 급여보다 더 높은 급여를 받는 사원의 first_name과 급여를 출력하라.

select first_name,salary
from employees e
where department_id = (select department_id from departments where department_name = 'Marketing')
and salary > (select avg(salary) from employees where department_id = e.department_id);

--사원 중에서 그 부서의 평균 급여보다 더 높은 급여를 받는 사원
/*
서브쿼리를 배우기 전에 기본골격을 그대로 적용하고나서 해보자.
무조건 좋은 건 아니지만..
*/

select e.first_name, e.salary
from employees e join departments d
    on e.department_id = d.department_id
where d.department_name = 'Marketing' and e.salary > (select avg(salary) 
                                                            from employees 
                                                            where d.department_id = department_id); --correlated query, 연관있는 쿼리
--부서 테이블 필요
--부서의 소속된다! 

--2-9. 모든 부서별로 각 부서의 사원이 받는 평균 급여보다 더 높은 급여를 받는 사원의 부서번호, 부서명, first_name과 급여를 출력하라.
select d.department_id, d.department_name, e.first_name, e.salary
from employees e join departments d
    on e.department_id = d.department_id
where e.salary > (select avg(salary)
                    from employees
                    where d.department_id = department_id); --corrleated..
--모든 부서별로 각~ 급여를 받는 사원의..
--내 급여가 상대보다 큰가?

select d.department_id, d.department_name, e.first_name, e.salary
from departments d join employees e
on d.department_id = e.department_id
where salary > 
(select avg(salary) from employees 
where d.department_id = department_id 
group by department_id)
order by 1;

--12 직속상사가 없는 사원을 포함하여 모든 사원의 직속상사가 나오도록 하고 싶다. 
--사번(employee_id), first_name, 직속상사사번(manager_id), 직속상사 first_name을 
--사번순으로 출력하라. (인라인뷰 이용)
--**3가지 유형으로 풀었기에 꼭 한 번 풀어보셈.. join, sub query etc..
create table testemp8
as select * from employees;
alter table testemp8
add sumsalary number(10,2); --not null이면 안됨.
select * from testemp8; --sum
/*
PL/SQL이나 사용자 정의 등등을 해볼 예정
SUB QUERY..
*/

--부서별 합계를 보아라.
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
--(select ~ ) 뷰
--위아래의 파싱순서를 바꿈
--complex 뷰를 생각하면 머리 아프니 가상의 뷰를 만들어 해결하자.

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
실제 서술형도 빈칸 채우기 느낌인듯.
*/
        
        