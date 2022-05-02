use dac_2021;

JOIN : View data from multiple tables

NATURAL JOIN
OUTER JOIN : LEFT | RIGHT | FULL
INNER JOIN | JOIN

EQUI JOIN | NON EQUI JOIN

SELF JOIN

Syntax:
   SELECT <list of columns>
    FROM <tab1, tab2, tab3,.....>
   WHERE <relation cond.>;
   
   SELECT <list of columns>
    FROM tab1 JOIN tab2 ON <relation Cond.>
     JOIN  tab3 ON <relation Cond.>.......;
   
SELECT e.ename,d.dname
FROM emp e, dept d
WHERE e.deptno=d.deptno;  -- Inner join | equi join

SELECT e.ename,d.dname
FROM emp e NATURAL JOIN dept d; -- e.deptno=d.deptno;  -- e.id = d.id 
   
SELECT e.ename,d.dname
FROM emp e JOIN dept d USING(deptno); -- e.deptno=d.deptno;
									-- equals to condition
                                    -- name of column must be same in both tables 
SELECT e.ename,d.dname
FROM emp e JOIN dept d ON e.deptno=d.deptno; -- use any comparison operator
										     -- use columns with different names
                                             
SELECT * FROM emp;

SELECT e.ename Emp_Name,e.sal e_sal, m.ename,m.sal Mgr_Name
FROM emp e JOIN emp m ON e.mgr = m.empno
ORDER BY e_sal; -- matching data

SELECT e.ename Emp_Name,e.sal e_sal, m.ename,m.sal Mgr_Name
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno
ORDER BY e_sal; -- matching data + extra

Table has column referring to another column of same table

---------------------------------------------------------
Sub Queries / Nested Queries
-------------------------------

SELECT *
FROM emp
WHERE deptno = ANY (select deptno from dept where dname='SALES')
      --2nd     --first / Inner
      Outer
                -- single value returning sub query
SELECT ename, (select count(*) from emp WHERE deptno=10) emp_count
FROM emp;
                      -- Correlated Query (Sub Query)
                      -- Inner query will be executed several times
SELECT ename,deptno, (select count(*) from emp WHERE deptno=e.deptno) emp_count
FROM emp e;

SELECT ename,deptno, (select ename from emp WHERE empno=e.mgr) Mgr_Name
FROM emp e;

 7698
select * from emp;


-- Inline Views (Sub Query)
SELECT dname,loc, emp_count,dept_total_sal
FROM (SELECT deptno,count(*) emp_count, sum(sal) dept_total_sal
		FROM emp
		GROUP BY deptno
		ORDER BY deptno) d JOIN dept USING(deptno);
        
        A JOIN B ON a.col=b.col
        A JOIN B USING (col)

Sub Query
1. Single Row
2. Multiple Rows

Sub Query
1. Nested Query
2. Correlated Query
3. Inline View (sub query in from clause)

SELECT dname,loc, (SELECT count(*) FROM emp WHERE deptno = dept.deptno) emp_count,
       (SELECT sum(sal) FROM emp WHERE deptno = dept.deptno) sum_sal
FROM  dept;

------------------------------------------------------------------------
-- List of department in which employees are working

SELECT *
FROM dept
WHERE deptno IN (SELECT DISTINCT deptno FROM emp); -- Sub Query

SELECT *
FROM dept d
WHERE EXISTS (SELECT empno FROM emp WHERE deptno=d.deptno); -- Sub Query
        --Correlated query                        -- 10
        -- Exists Clause                         -- 20
              Verify if inner query has given any result for provided input          
              In case if result is provided then display the record for which value has been provided
              
              ------------------------------------------------------------------------------
              Set Operators
              ---------------------
              Union
              Intersect
              Minus
              
              CREATE TABLE emp10
              AS SELECT * FROM emp where deptno=10;
              
              CREATE TABLE emp20
              AS SELECT * FROM emp where deptno=20;
              
              CREATE TABLE emp30
              AS SELECT * FROM emp where deptno=30;
              
              
select empno Emp_no,ename,sal from emp10  -- 2
UNION
select empno emp_number,ename emp_name,sal from emp20 -- 3
UNION
select empno,ename,sal from emp30; -- 3 

-- Union 
  -- Column heading is displayed from first query
  -- Number of column and there type must match in all queries
       -- Error. The used SELECT statements have a different number of columns
   -- Sorting / Order By : Must be added to the last query in the set operation
   
select empno Emp_no,ename,sal from emp10  
UNION
select empno emp_number,ename emp_name,deptno from emp20 -- 3
UNION
select empno,ename,mgr from emp30
ORDER BY empno; -- 3 
  
  -- Union will elimite duplicate rows
  
select empno Emp_no,ename,sal from emp10  
UNION ALL
select empno emp_number,ename emp_name,deptno from emp20 -- 3
UNION ALL
select empno,ename,mgr from emp30
ORDER BY empno; -- 3 
  -- UNION ALL will not eliminate duplicate rows
  
Customer : Customer_east
          Customer_west
          Customer_North
          Customer_South
              
              
-- INTERSECT
              
select job from emp10  
UNION ALL
select job FROM emp20 -- 3

select job from emp10  
UNION
select job FROM emp20 -- 3              
              
select job from emp10  
INTERSECT   -- Not supported in MySQL
select job FROM emp20 -- 3

select job from emp20  
INTERSECT   -- Not supported in MySQL
select job FROM emp10 -- 3

MINUS
---------------
We get exclusive data from first query.
Position of query is important as it will change the result

select job from emp20  
MINUS   -- Not supported in MySQL
select job FROM emp10 -- 3

select job from emp10  
MINUS   -- Not supported in MySQL
select job FROM emp20 -- 3

select ename from emp10
union 
select dname from dept;

-- Optimizer : If a query written as JOIN can be executed faster as Nested query
-- Then optimizer can rewrite the query in background

select ename,empno
from emp
where deptno IN (select deptno from dept WHERE dname='SALES');

select ename,empno
from emp JOIN dept -- 1. Load the data 
ON emp.deptno=dept.deptno
WHERE dname='SALES'; -- 2. Apply filter

-- Note: How will we know what apporach(Execution PLan) optimizer has used to execute query

select sum(sal)  -- group function
from emp;  

Other function : Single Row function

select ename,sal, IFNULL(comm,0)
FROM emp;

select ename,sal, COALESCE(comm,0)
FROM emp;

SQL Standard : SELECT <> FROM <>

select ABS(2-4);

SELECT MOD(4,3);

select ROUND(avg(comm),10) from emp;


select sysdate();


select current_date();
select curdate();

Helps in migration
----------------------

MySQL DAtabase (6 years) --migration---> Oracle Database
       select curdate                      select sysdate                     


SELECT ROUND(399.45, -3); -->82 > 50 = 200