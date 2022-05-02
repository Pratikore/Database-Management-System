Generic Commands to interact with MySQL database
=====================================================

show databases;
use scott;
show tables like '%emp%';
use test;
Error Code: 1049. Unknown database 'test'	0.000 sec
show tables;
use information_schema;
show tables like '%table%';
drop database test;
--------------------------------------

Database Server Configuration in MySQL is controlled through variables defined in initialization file
======================================================================================================
show variables like '%port%';

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --defaults-file="C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" MySQL80

The my.ini is a text files which contain list of variables. It will be read at the server startup time and define the behavior of database server.


DQL : Data Query Language 
======================================
SELECT Command

/*
This command is used to read data from table. Data is stored permanently in database tables. Hence SELECT command will interact with tables to fetch the information.
*/

show tables;

select * from emp;
dept
salgrade

/*
SELECT command has two mandatory clauses

SELECT : This clause in select command is used for PROJECTION of data. In other words it help us to decide the columns that we would like to view in query result.
FROM   : This clause is used to mention the name of tables from which data is fetched.

eg:
*/

select ename,sal,deptno
from emp;

select ename EmployeeName,sal,sal*12 AnnualSAL, sal
from emp;

/*
-- Aliases : Alternate headings displayed in query
-- Aliases is used to display meaningfull heading on the screen. It is mostly used for cases where calculation is performed which make the heading appear quite complex.
-- They are not preserved in database. Hence next query without aliases will show usual headings.
*/
select ename AS EmployeeName,sal,sal*12 AnnualSAL, sal
from emp;

select ename from emp;

select ename,sal,sal*12 AS "Annual Sal"
from emp;

select ename,sal,comm,sal*12 AS "Annual Sal"
	   ,(sal + IFNULL(comm,0)) * 12
from emp;

-- Note: IFNULL is a treatment provided for null
-- values by MySQL. It is an inbuilt program
-- for eg: in Oracle this program is given with the
-- name as NVL
select ename,sal,comm,sal*12 AS "Annual Sal"
	   ,(sal + COALESCE(comm,0)) * 12
from emp;

select * from emp; -- * is read as ALL

-- Using literals in query
select ename,
       sal,
	   IFNULL(comm,0) Commission,
       1000*12 Bonus,
	   'Happy new year' Greeting
from emp;

select ename,'IS WORKING AS',job
from emp;

select deptno,sal,empno
from emp;

select distinct deptno
from emp;

select distinct deptno, job
from emp;
-- Always use distinct just after select keyword
-- Works on list of column (identify duplicates based
-- on combination of values)
select distinct *
from emp;  -- avoid this

select deptno,ename
from emp;

-- restriction in select command
-- WHERE clause in select query help to perform 
-- restiction on records

SELECT *
FROM emp              -- 1. Load the table in memory
WHERE ename='SCOTT'   -- 2. Compare each row with cond.
-- It help us to perform search operation in table
-- Usually a condition is provided in where clause

SELECT *
FROM emp            -- all rows of emp is loaded in mem
WHERE deptno=20;   -- each row is compared for this cond

-- string and date values must be enclosed in single quotes

select *
from emp
where ename='SCOTT';

select *
from emp
where hiredate='1982-12-09';

Error Code: 1525. Incorrect DATE value: '1982/DEC/09'	0.015 sec

select *
from emp
where hiredate= str_to_date('1982/09/12','%Y/%d/%m');


select *
from customer
where custid=?;

-- working as clerk in department 10

select *
from emp
where job='CLERK' AND deptno=20;

desc emp;

select *
from emp
where sal > 1000 AND sal < 2000; -- range search

select *
from emp
where hiredate >= '1981-01-01' 
AND HIREDATE <= '1981-12-31'

Comparison
>
<
>=
<=
=
<>  !=

AND 
OR
NOT

select * 
from emp
where deptno=10;

select * 
from emp
where deptno<>10;

select * 
from emp
where deptno!=10;

select * 
from emp
where NOT deptno = 10;

select *
from emp
where (deptno=10 OR deptno =20) AND job='CLERK'
-- AND operator has higher precedence then OR


select * from emp where comm = NULL;

                





