show user;
desc user_tables;

select * from user_tables;
--CUSTOMERS
--PUBLISHERS
--BOOKS
--ORDERS
--ORDERBOOKS

select * from customers;
select * from publishers;
select * from books;
select * from orders;
select * from orderbooks;

desc user_constraints;

--이름                널?       유형            
------------------- -------- ------------- 
--OWNER                      VARCHAR2(120) 
--CONSTRAINT_NAME   NOT NULL VARCHAR2(30)  
--CONSTRAINT_TYPE            VARCHAR2(1)   
--TABLE_NAME        NOT NULL VARCHAR2(30)  
--SEARCH_CONDITION           LONG          
--R_OWNER                    VARCHAR2(120) 
--R_CONSTRAINT_NAME          VARCHAR2(30)  
--DELETE_RULE                VARCHAR2(9)   
--STATUS                     VARCHAR2(8)   
--DEFERRABLE                 VARCHAR2(14)  
--DEFERRED                   VARCHAR2(9)   
--VALIDATED                  VARCHAR2(13)  
--GENERATED                  VARCHAR2(14)  
--BAD                        VARCHAR2(3)   
--RELY                       VARCHAR2(4)   
--LAST_CHANGE                DATE          
--INDEX_OWNER                VARCHAR2(30)  
--INDEX_NAME                 VARCHAR2(30)  
--INVALID                    VARCHAR2(7)   
--VIEW_RELATED               VARCHAR2(14)  

--1
select b.bookid, b.booktitle, b.pubid, p.pubname, sum(r.orderqty) as qty,
    case when sum(nvl(r.orderqty,0))=0 then 'never!'
         when nvl(sum(r.orderqty),0)<=10 then '10under!'
         when sum(r.orderqty)<=100 then '100under!'
         else 'bestseller!' end as evaluation
    from books b left join orderbooks r on b.bookid = r.bookid
        left join publishers p on p.pubid=b.pubid
    group by b.bookid, b.booktitle, b.pubid, p.pubname
    order by 5 desc;
    
--10	JAVA	1	YEONGJIN	11	100under!
--20	ORACLE	1	YEONGJIN	2	10under!

select * from books;
--bookid booktitle bookprice pubid(p~fk)
--10	JAVA	700	    1
--20	ORACLE	1300	1
--30	MYSQL	2200	2
select * from orderbooks;
--orderid(p~fk) bookid(b~fk) orderprice orderqty
--1	10	700	    2 -2
--1	20	1300    1 
--2	10	700	    1 -3
--3	10	700	    2 -5
--4	10	700	    1 -6
--4	20	1300	1
--5	10	700	    5 -11
select * from publishers;
--pubid pubname pubarea
--1	YEONGJIN	SEOUL
--2	HANBIT	    GIMPO

--2번
select c.custid, c.custname, o.orderid, o.orderdate, r.bookid,
(select booktitle from books where bookid = r.bookid) as btitle, r.orderqty
from customers c join orders o on c.custid=o.custid
    join orderbooks r on r.orderid = o.orderid
where 2 <= (select count(*) from orders where o.custid=custid);


--select* from orders o join customers c on o.custid = c.custid;

select *
from (select b.bookid, b.booktitle, sum(r.orderprice * r.orderqty)
    from books b join orderbooks r on b.bookid = r.bookid
        group by b.bookid, b.booktitle
        union
        select b1.bookid,b1.booktitle, nvl(sum(r1.orderprice * r1.orderqty),0) from books b1 left join orderbooks r1 on b1.bookid = r1.bookid
        group by b1.bookid, b1.booktitle
    )
where rownum <= 1;        

select * from books b left join orderbooks r on b.bookid = r.bookid;
select * from books;

desc user_objects

--7
select c.constraint_name, c.table_name, t.column_name, r_constraint_name, c.constraint_type
from user_constraints c join user_tab_columns t
on c.table_name = t.table_name
where UPPER(c.constraint_type) = 'R'
order by 1;



select constraint_type
from user_constraints c
where c.constraint_type like '%r%';

desc constraint_type

desc user_constraints

desc user_tab_columns