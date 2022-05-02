Show databases;  -- Schemas
-- User defined database
-- System database

-- Project : Different Software Professional
  -- Database Developers : Design tables, programming, SQL
  -- Database Administrators : How to install MySQL, Configure server, Availability

Use dac_2021;

show tables;

Note: Root user has a access to all schemas.
      dev user (Data Control Language : DCL : GRANT/REVOKE)
      
select database();

show tables;

describe EMP;
describe dept;

EMP : Read DAta from this table
-- SELECT command
-- Just a read only command

SELECT <list of columns>     -- Mandatory
FROM <tableName>             -- Mandatory

eg: 

SELECT empno,ename,job
FROM emp;

SELECT ename,sal
FROM emp;

SELECT empno,ename,sal,job,hiredate,mgr
from emp;

SELECT *  -- Read all columns from this table
FROM emp;


	
    SELECT
	*
	FROM 
	emp;  -- ctrl+enter

Note : /*Comments
Single line comment --

*/

SELECT ename,sal,comm
FROM emp;

select *
from emp;

-- NULL : Blank / Information not available
-- Independent of datatype

select empno as Employee_Name,ename AS Emp_Name,sal * 12 as AnnualSal -- aliases
from emp;



SELECT empno "Emp Number",
       ename AS "Emp Name",
       sal * 12 as "Annual Sal" -- aliases
FROM emp;

select empno,ename from emp;

select empno,
        ename,
        sal,
        comm,
        sal + comm,
        (sal + COALESCE(comm,100)) * 12 "Annual Total Salary"
from emp;

-- remove duplicate values from result

select distinct job -- Fetch the job columns values --> Remove duplicate
from emp;  -- fetch data in RAM

select distinct job,deptno
from emp;

SALESMAN 10 -- 6 people
SALESMAN 20 -- 4 people

select distinct job, deptno
from emp;

select empno,job
from emp; -- bullying database

SELECT <columns | *> -- Projection
FROM <table>

Restricting data in select query

select *
from emp
where ename = 'SMITH';

select *
from emp
where job = 'CLERK';

Comparison operator

= 
>
<
>=
<=
<> !=

select *
from emp
where deptno <> 20;

-- using multiple conditions

deptno 30 as salesman

select *
from emp
where deptno=30 and job='SALESMAN'

AND  (Both cond must return true)
OR
NOT

select * 
from emp
where (deptno=10 
   or deptno=20
   or deptno=30
   or deptno=50)
   AND job='SALESMAN';
   
select *             -- 3. Display required columns
from emp             -- 1. Fetch the data in Server RAM
where sal*12 > 10000; -- 2. Restrict data

select * 
from emp
where sal >= 2000 and sal <= 3000;

select * 
from emp
where sal BETWEEN 2001 AND 2999;
           >=           <=
-- Date, Number

select * 
from emp
where (deptno=10 or deptno=20 or deptno=30 or deptno=50)
   AND job='SALESMAN';

select * 
from emp
where deptno IN (10,20,30,50) 
   AND job='SALESMAN';

select * 
from emp
where job IN ('CLERK','SALESMAN');

-- Operator for null values
select *
from emp
where comm = NULL;  -- will not work

select *
from emp
where comm IS NULL;  -- will work

select *
from emp
where mgr IS NULL;  -- ANSI : Codd Rules
                           NULL values must be supported
                           Special treatment of NULL values

select *
from emp
where ename LIKE '%S'  -- Name starting with SCOT
                          -- It may be followed by n Characters

select *
from emp
where ename LIKE '%S%';  SCOTT/ADAMS/

select *
from emp
where ename like 'F___'; -- _ : There must be one character
                         -- % : 0 or n of characters
                 Fxx

select *
from emp
where ename NOT like 'F___';

select *
from emp
where sal NOT BETWEEN 2000 and 3000;

SELECT *
FROM emp
where deptno NOT IN (10,20);

select *
from emp
where comm IS NOT NULL;

select empno,ename
from emp   -- 1. Load table in RAM
limit 1,4; -- 2. Go to first record (1) and fetch next 4 

ALLEN
WARD
JONES
MARTIN

select empno,ename
from emp   -- 1. Load table in RAM
limit 4,4; -- 2. Go to first record (1) and fetch next 4 

MARTIN
BLAKE
CLARK
SCOTT

SELECT (M)
FROM (M)
WHERE (o)
LIMIT (o)

-- Functions
In built programs : 
Categories (Numeric / String / Date)
Name of program
Input

COALESCE
String Values (Upper / Lower/ trim / Replace)

SELECT ename, LOWER(ename), length(ename)
from emp;

Categories of Programs
1. Single Row functions
       -- It returns one result for each row provided to it
       SELECT lower(ename) from emp;
               14 rows

2. Group functions 
     -- They return one result for each group of records provided to it
     -- All group functions ignore NULL values
     
     SELECT sum(sal),max(sal),min(sal),count(*),avg(sal) FROM emp;
     
     select count(empno),count(comm),count(*),count( COALESCE(comm,0) ) from emp;
     
     select empno,comm, COUNT(coalesce(comm,-1)) from emp;
     
     select count(*) from emp;
     
     
     
     SUM
     MAX
     MIN
     AVG
     COUNT
     
     select count(*)   -- 3 count records provided by where condition
     from emp          -- 1 load rows in RAM
     where deptno=10   -- 2 filter data based on condition deptno=10
     
     select count(*)   -- 3 count records provided by where condition
     from emp          -- 1 load rows in RAM
     where deptno IN (10,20)   -- 2 filter data based on condition deptno IN (10,20)
     
  Note: I want separate count of each department
  
   3
   5

select count(*)   -- 4 count records provided by where condition
     from emp                  -- 1 load rows in RAM
     where deptno IN (10,20)   -- 2 filter data based on condition deptno IN (10,20)
	GROUP BY deptno            -- 3 find distinct values in deptno (2 values)
                                  --  divide the result in 2 group (Group 1 : deptno 10)
                                  --                               (Group 2 : deptno 20)

select count(*)   -- 4 count records provided by where condition
     from emp                  -- 1 load rows in RAM
	GROUP BY deptno            -- 2 find distinct values in deptno (3 values)
                                  --  divide the result in 2 group (Group 1 : deptno 10)
                                  --                               (Group 2 : deptno 20)
								--                                 (Group 3 : deptno 30)
                                
select count(*)   -- 4 count records provided by where condition
     from emp                  -- 1 load rows in RAM
	GROUP BY empno            -- 2 find distinct values in empno (14 values)
                                  --  divide the result in 14 group (Group 1 : deptno 10)
                                  --                               (Group 2 : deptno 20)
								--                                 (Group 3 : deptno 30)
                                
select count(*), deptno -- showing data for each group
from emp
group by deptno;

select count(*), deptno -- showing data for each group
from emp
group by deptno;
