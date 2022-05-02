TRIGGERS
----------

A trigger is a named database Program object that is associated with a table, and that activates when a particular "event" occurs for the table.

A trigger is defined to activate when a statement inserts, updates, or deletes rows in the associated table. 

These row operations are trigger events.

BASIC Trigger Syntax

CREATE 
    TRIGGER <trigger_name>
    <BEFORE | AFTER >  -- trigger_timing
	<INSERT | UPDATE | DELETE >  -- trigger_event
    ON tbl_name  -- Table on which event will be observed
	FOR EACH ROW -- Trigger must be invoked for each row impacted by 
	             -- the event
    [FOLLOWS | PRECEDES <another_trigger_name>]
    trigger_body
	
Note: In MySQL You cannot associate a trigger with a TEMPORARY table or a view

Note: In Oracle trigger can be created on complex views which are called as instead of triggers

Within the trigger body, you can refer to columns and its value in the subject table (the table associated with the trigger) by using the aliases OLD and NEW.

OLD.col_name refers to a column of an existing row before it is updated or deleted.

NEW.col_name refers to the column of a new row to be inserted or an existing row after it is updated.

Limitations on code in Trigger Body:
------------------------------------------
1. The trigger cannot use the CALL statement to invoke stored procedures that return data to the client or that use dynamic SQL. (Stored procedures are permitted to return data to the trigger through OUT or INOUT parameters.)

2. The trigger cannot use statements that explicitly or implicitly end a transaction, such as COMMIT or ROLLBACK. (ROLLBACK to SAVEPOINT is permitted because it does not end a transaction.).

Trigger Metadata
---------------------
show create trigger <>;

select * from information_schema.triggers;

SHOW TRIGGERS LIKE 'acc%';


Problem Statement
============================
delete from emp
where deptno=10;

-- Business require that the data must be automatically copied
-- to emp_backup if deleted from emp table
	
CREATE TABLE emp_backup
LIKE emp;

INSERT INTO emp_backup
SELECT * FROM emp WHERE deptno=10;

DELETE FROM emp
where deptno=10;

-- Hence our requirement is to 
-- 1. Watch the delete operation on emp table
-- 2. If delete happened then copy the deleted
-- 3. records to emp_backup table in the backgroud

-- Trigger as one of the type of stored program is best suited for this requirement
-- as we need to trigger a program automatically to do this job

Our Target command : delete
Our Target Table : emp

-- Basic Program STRUCTURE
CREATE TRIGGER <nameOfProgram>
BEFORE / AFTER -- timing of trigger's code execution 
DELETE / INSERT / UPDATE -- target event. In mysql target event can only be DML statement
ON <target> -- target table. Only one table can be listed at a time
[FOR EACH ROW] -- It will help to trigger this logic for each record, affected by target DML command
BEGIN
    -- Trigger Coding section
END#

-- eg:

DELIMITER #
CREATE TRIGGER emp_del_trig
BEFORE -- timing of trigger execution. We want trigger to copy take back BEFORE delete operation
DELETE -- target operation. It means that this trigger will execute only when DELETE is fired
ON emp -- target table. This trigger will obeserve DELETE command on EMP table.
FOR EACH ROW -- The code written below will be executed for each record in emp table.
BEGIN
    INSERT INTO emp_backup
    SELECT * FROM emp WHERE empno= OLD.empno;
END#

delete from emp where job='CLERK';
delete from emp where ename='SCOTT';
-- Do we have a trigger on this table
-- Is the trigger created for DELETE operation
-- Do we need to process the trigger first or the 
   command first
-- information about trigger is stored in DD


Scenario 2
==================
-- Modify the data which is inserted by given user
-- Implement restriction which can't be achieve by constraints
-- Auditing of the work done by used on given table


-- Modify the data which is inserted by given user

-- Such triggers need access to the record which is inserted by users
-- We can refer to the record value using NEW.column_name option
-- For eg : If DEPT table has 3 columns(deptno,dname,loc)
-- then we will be able to refer the record values of inserted record 
-- using NEW.deptno NEW.dname  NEW.loc

-- In Trigger we will also be able to modify the inserted row value using 
-- set NEW.dname = UPPER(NEW.dname);

dept : INSERT : BEFORE

DELIMITER #
CREATE TRIGGER dept_ins_trig
BEFORE INSERT ON dept
FOR EACH ROW
BEGIN
     DECLARE v_deptno INTEGER;
     
      IF NEW.deptno IS NULL THEN
         SELECT max(deptno)+10 INTO v_deptno FROM dept;
         SET NEW.DEPTNO = v_deptno;
	  END IF;
      
      SET NEW.dname = TRIM(UPPER(NEW.dname));
      IF NEW.loc  IS NULL THEN 
         SET NEW.LOC='PUNE';
	  ELSE 
         SET NEW.LOC = UPPER(NEW.LOC);
      END IF;   
END#

select * from dept;

INSERT INTO dept VALUEs(NULL,'Sales ',NULL);
select * from dept;

DELIMITER #
CREATE TRIGGER emp_ins_trig
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
     IF NEW.sal < 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative';
	 END IF;
     If NEW.SAL < NEW.COMM THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be less then comm';
	 END IF;
END#

INSERT INTO emp(empno,sal) values(9876,2000);
INSERT INTO emp(empno,sal) values(9876,-2000);

Error Code: 1644. Salary cannot be negative	0.000 sec
