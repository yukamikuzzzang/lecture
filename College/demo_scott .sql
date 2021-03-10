--
-- Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
-- NAME
-- demobld_scott.sql
--
-- DESCRIPTION
-- This script creates the SQL*Plus demonstration tables.
--
-- USAGE
-- SQL> @demobld_scott.sql
--
-- 
-- scott/tiger 계정 생성

-- system 계정으로 접속한다.
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 999
SET ECHO OFF
SET CONCAT '.'
SET SHOWMODE OFF

-- PROMPT 
-- PROMPT specify password for SYSTEM as parameter 1:
-- DEFINE password_system     = &1

-- CONNECT system/&&password_system
-- 본스크립트는 system 계정에서 실행시켜야한다.
alter session set "_ORACLE_SCRIPT"=true;

DROP USER scott CASCADE;

create user scott identified by tiger default tablespace users temporary tablespace temp profile default;
grant connect, resource to scott;
alter user scott quota unlimited on users;
alter user scott account unlock;

-- 여기서 부터는 scott 계정으로 접속한다.
conn scott/tiger;

SET TERMOUT ON
PROMPT Building demonstration tables. Please wait.
SET TERMOUT OFF

DROP TABLE EMP;
DROP TABLE DEPT;
DROP TABLE BONUS;
DROP TABLE SALGRADE;
DROP TABLE DUMMY;

CREATE TABLE DEPT(
	DEPTNO 		NUMBER(2),
	DNAME 		VARCHAR2(14),
	LOC 		VARCHAR2(13),
  	);

CREATE TABLE EMP (
	EMPNO 		NUMBER(4) NOT NULL,
	ENAME 		VARCHAR2(10),
	JOB 		VARCHAR2(9),
	MGR 		NUMBER(4),
	HIREDATE 	DATE,
	SAL 		NUMBER(7, 2),
	COMM 		NUMBER(7, 2),
	DEPTNO 		NUMBER(2),
   	);

CREATE TABLE SALGRADE(
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER,
    );

CREATE TABLE BONUS(
	ENAME 		VARCHAR2(10),
	JOB 		VARCHAR2(9),
	SAL 		NUMBER,
	COMM 		NUMBER
	);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902,TO_DATE('1980-12-17', 'YYYY-MM-DD'), 800, NULL, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698,TO_DATE('1981-02-20', 'YYYY-MM-DD'), 1600, 300, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698,TO_DATE('1981-02-22', 'YYYY-MM-DD'), 1250, 500, 30);
INSERT INTO EMP VALUES (7566, 'JONES', 'MANAGER', 7839,TO_DATE('1981-04-02', 'YYYY-MM-DD'), 2975, NULL, 20);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698,TO_DATE('1981-09-28', 'YYYY-MM-DD'), 1250, 1400, 30);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839,TO_DATE('1981-05-01', 'YYYY-MM-DD'), 2850, NULL, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839,TO_DATE('1981-06-09', 'YYYY-MM-DD'), 2450, NULL, 10);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('1982-12-09', 'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL,TO_DATE('1981-11-17', 'YYYY-MM-DD'), 5000, NULL, 10);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698,TO_DATE('1981-09-08', 'YYYY-MM-DD'), 1500, 0, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788,TO_DATE('1983-01-12', 'YYYY-MM-DD'), 1100, NULL, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698,TO_DATE('1981-12-03', 'YYYY-MM-DD'), 950, NULL, 30);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7566,TO_DATE('1981-12-03', 'YYYY-MM-DD'), 3000, NULL, 20);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782,TO_DATE('1982-01-23', 'YYYY-MM-DD'), 1300, NULL, 10);

INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

CREATE TABLE DUMMY (DUMMY NUMBER);

INSERT INTO DUMMY VALUES (0);

alter table emp
add constraint pk_emp_empno primary key(empno);

alter table dept
add constraint pk_dept_empno primary key(deptno);

alter table emp
add constraint fk_emp_deptno foreign key(deptno) references dept(deptno);

COMMIT;

SET TERMOUT ON
PROMPT Demonstration table build is complete.
EXIT