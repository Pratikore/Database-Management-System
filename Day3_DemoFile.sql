USE dac_2021;

SELECT DISTINCT 
FROM <table>
WHERE <restriction>
GROUP BY <result set in groups>;


SELECT job, max(sal), min(sal), avg(sal)
FROM emp
GROUP BY job; -- CLERK, SALESMAN, MANAGER, ANALYST;

-- Eliminate those records where avg sal < 2000

SELECT job, max(sal), min(sal), avg(sal) Avg_sal -- 4 show data 
FROM emp                 -- 1. Fetch data / records of emp table
GROUP BY job -- 2. Create groups
HAVING avg(sal) >= 2000   -- 3. add condition for elimination of group

Query ---> SQL Engine (Compiler)

SELECT
FROM
WHERE -- normal conditions (executed before group by)
GROUP BY
HAVING -- group conditions (executed after group by)

-- Database internally use many algorithms to process query
-- sequence of records in result is not guaranteed

-- Use Order by clause to instruct database to display data in given sequence

SELECT job, max(sal), min(sal), avg(sal) Avg_sal -- 4 show data 
FROM emp                 -- 1. Fetch data / records of emp table
GROUP BY job -- 2. Create groups
HAVING avg(sal) >= 2000   -- 3. add condition for elimination of group
ORDER BY job asc;  -- asc keyword is optional (it is default clause for order by)

SELECT job, max(sal), min(sal), avg(sal) Avg_sal -- 4 show data 
FROM emp                 -- 1. Fetch data / records of emp table
GROUP BY job -- 2. Create groups
HAVING avg(sal) >= 2000   -- 3. add condition for elimination of group
ORDER BY job desc;

-- desc
-- 1. It is used to describe a table. 
 -- eg: desc emp;
        describe emp;
-- DESC / DESCRIBE is not a SQL command
-- 2. It is used with ORDER BY clause to instruct data arrangement in descending order
   -- It is SQL standard
        
SELECT job, max(sal), min(sal), avg(sal) Avg_sal -- 4 show data 
FROM emp                 -- 1. Fetch data / records of emp table
GROUP BY job -- 2. Create groups
HAVING avg(sal) >= 2000   -- 3. add condition for elimination of group
ORDER BY Avg_sal desc; -- 5 Arrange the data

-- DAta type support : Date , Number, Strings

ASC : Oldest --> Youngest

select * from emp;

select * from emp
order by job;

select * from emp
order by job,sal;
       -- 1  

select * from emp
order by job asc,comm asc;

select * from emp
order by 3 asc;
-- same
select * from emp
order by job asc;

select empno,job,ename,sal,(sal+IFNULL(comm,0))*12 Total_Ann_sal from emp
order by Total_Ann_sal asc;

SELECT Command
SELECT has many clauses
   -- select, from, where ... order asc desc

SELECT [DISTINCT]
FROM
WHERE
GROUP BY
HAVING
ORDER BY [ASC*|DESC]

SELECT * FROM emp;

SELECT * FROM dept;

select * from dept where dname='SALES';

select * from emp
where deptno = (select deptno from dept WHERE dname='SALES');

list of employees earning more then Smith

select *
from emp
WHERE sal > 800;

select sal from emp where ename='SMITH';



select *
from emp
WHERE sal > (select sal from emp where ename='SMITH');

-- List name of employees working in same department as of SCOTT

select ename -- outer query (data is displayed from outer query)
from emp
where deptno = (select deptno from emp where ename='SCOTT');
                -- inner query

-- Nested queries / Sub queries
-- One query is feeding its output to other query
-- Outer Query
-- Inner Query (sub query)
-- Inner query is exec first, feeding the result to outer query
             emp                     deptno
details of [employees] working in [same department] as of SCOTT
but [earning more] then scott
      sal
      
SELECT *
FROM emp
WHERE deptno IN (select deptno from emp where ename='SMITH')
  AND sal    >= ANY (select sal from emp where ename='SMITH');
--  AND sal    <= ALL (select sal from emp where ename='SMITH');
  
  <comparison operator> + [ANY | ALL]
  
-- Categories of sub query
1. Single row sub query : Comparison operator = >= <= <> < >
2. Multiple rows sub query : ANY / ALL / IN / NOT IN
                                         =    <>
select * from dept;

SELECT *
FROM emp
WHERE deptno IN (select deptno 
                 from dept
                 where dname = 'SALES' or dname = 'ACCOUNTING')

 -- Error Code: 1242. Subquery returns more than 1 row	
UPDATE emp
set comm=NULL
WHERE empno=7844;

SELECT * FROM emp WHERe ename='SMITH';

select * from dept;

select ename, loc
from emp, dept;  -- Cross join / cross product
                    14 emp * 4 dept = 56 combinations

select ename, loc
from emp, dept
where deptno = deptno;

-- Error Code: 1052. Column 'deptno' in where clause is ambiguous	0.000 sec

select ename, loc, dept.deptno
from emp, dept
where emp.deptno = dept.deptno;
-- ambiguous columns or columns with same name must be qualified with table name as prefix
-- join condition is required to get meaningful output

select ename, loc, d.deptno
from emp e, dept d 
where e.deptno = d.deptno;

-- Suugestion : prefix name of column with table
select e.ename, d.loc, d.deptno
from emp e, dept d 
where e.deptno = d.deptno;

-- Concept of fetching data from multiple tables in single query : JOINS
-- We must have a logical relation between two tables to perform a join

select * from  deptx; -- DNO, DNAME, LOC

SELECT ename,dname,deptno
FROM emp, deptx
WHERE deptno = dno;

select * from dept;

SELECT ename,dname,dept.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.ename,d.dname,d.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

select * from salgrade;

select ename,sal,grade
from emp, salgrade
where sal >= losal AND sal<= hisal;

select ename,sal,grade
from emp, salgrade                 -- 1. Load both tables in memory
where sal BETWEEN losal AND hisal; -- 2. Restriction on data

SELECT ename,dname,grade
FROM emp,dept,salgrade
WHERE sal BETWEEN losal and HISAL
AND dept.deptno = emp.deptno;
-- Optimizer (Software component) : Query : Execution Plan

SELECT ename,dname,grade
FROM emp,dept,salgrade
WHERE sal BETWEEN losal and HISAL; -- emp+salgrade
-- If we forgot one join condition (emp + dept) : Cross product


SELECT
FROM x,y,z,r,t,y,u    -- ANSI has noticed this caveat
WHERE 

-- New way to join
select ename,sal,grade
from emp, salgrade                 -- 1. Load both tables in memory
where sal BETWEEN losal AND hisal; -- 2. Restriction on data

select ename,sal,grade
from emp JOIN salgrade ON sal BETWEEN losal AND hisal
WHERE deptno=20;

select ename,sal,grade
from emp JOIN salgrade ON sal BETWEEN losal AND hisal
WHERE deptno=20;

SELECT ename,dname,grade
FROM emp JOIN dept ON dept.deptno = emp.deptno
         JOIN salgrade ON emp.sal BETWEEN salgrade.losal and salgrade.HISAL
		 JOIN dept_audit  ON  dept.deptno= dept_audit.deptno
         JOIN z  ON <>

Joins:
Fetching data from multiple tables and display it together
Types of joins
1. Natural Join : Matching

ANSI : SQL : Adhere to standard

   select ename,dname
   from emp NATURAL JOIN dept; -- ON emp.deptno=dept.deptno;  
   
   -- database will locate columns in both tables with same name
   -- deptno
   -- assume the condition as emp.deptno=dept.deptno

2. Inner Join | Normal Join : Matching, DEFAULT Join. Keyword INNER is assumed with JOIN keyword if not provided
3. Self Join : Matching
4. Outer Join : Matching + Extra Data (Left outer | right outer)

select * from emp;


select ename,dname
from emp JOIN dept ON emp.deptno=dept.deptno;  
-- matching data
-- record of miller is not displayed 
select * from dept;

select * from emp where deptno=40;

select ename,dname
from emp LEFT OUTER JOIN dept ON emp.deptno=dept.deptno;  
-- Matching records
-- Extra records from left side table (emp)

select ename,dname
from emp RIGHT OUTER JOIN dept ON emp.deptno=dept.deptno;  
-- Matching records
-- Extra records from right side table (dept)

select ename,dname
from emp LEFT OUTER JOIN dept ON emp.deptno=dept.deptno;  
-- Matching records
-- Extra records from right side table (dept)
