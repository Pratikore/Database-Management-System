DDL : ALTER, TRUNCATE
DML : INSERT, UPDATE, DELETE
  ( TCL : COMMIT / ROLLBACK)
--------------------------------------
Savepoint
-- Place holder during the active transaction

select * from emp;

set autocommit=0;

delete from emp where job='CLERK'; -- transaction init.
savepoint del_clerk;
delete from emp where job='SALESMAN'; -- same tran cont
savepoint del_sales;
delete from emp WHERE job='MANAGER'; -- same tran cont

rollback to savepoint del_sales;
-- last delete statement has been reverted back
-- savepoint(del_sales) has been released
COMMIT; 

-- Savepoint will be maintained till
-- the tran is active

INSERT cust    -- Transaction t1
   savepoint c; -- tran t1
INSERT kyc     -- tran t1
INSERT payment -- tran t1

rollback to savepoint c; -- revet payment
-- revert kyc
-- release the savepoint c;
-- tran t1 is still active
commit; -- cust data is preserved (end the tran)

-- SOC Compliance

UPDATE emp......
  SAVEPOINT upd1
UPDATE dept
  SAVEPOINT upd2
DELETE FROM emp.....
  SAVEPOINT del
INSERT INTO emp...

COMMIT; -- release all savepoints
ROLLBACK TO SAVEPOINT upd2; -- error

ROLLBACK TO SAVEPOINT upd2;
ROLLBACK TO SAVEPOINT del; -- error


ROLLBACK TO SAVEPOINT upd2;  
commit; -- emp,dept updates are preserved

--------------------------------------------
MERGE :DML Category (Not available in MySQL)
 -- Upsert : Update or Insert
 -- Refresh data in one table by referring to data of another table
 
-- Information management system
 Customer -- live production table (performance issues)
 Customer_arch
 
 CREATE TABLE Customer_arch
 AS SELECT * FROM Customer; -- create and load data
 
-- NoT a Standard SQL command
MERGE INTO emp_archive -- target
USING emp -- data source 
ON (emp.empno = emp_archive.empno) -- identify matching rows
IF MATCHED THEN -- if record is found then update it
  UPDATE set sal=emp.sal,comm=emp.comm,job=emp.job
IF NOT MATCHED THEN
  INSERT(empno,ename,sal)
  VALUEs(emp.empno,emp.ename,emp.sal);




