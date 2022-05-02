DDL : Data Definition Language
---------------------------------
Structure of data (Designing of tables)
- Name of table
- Name and types of columns
- Other table specification

CREATE
ALTER
DROP
TRUNCATE

Note: DDL commands are rarely used commands

Other objects in database
CREATE TABLE (Focus of todays session )
CREATE INDEX
CREATE VIEW
......

use dac_2021;

select * from emp;

show create table emp;
-- Information about existing constraint on top of our table.

CREATE TABLE emp_new
  -- Naming of table/column: Names may start with number / character / Special ($ _)
  -- We can make table name as case sensitive and introduce space using ""
  -- Length of name must not be > 64 characters
   (
   `EMPNO` int unsigned,
   -- <columnname>  <DataType>
   -- Data Types : numeric / date and time / string
   `ENAME` varchar(10) NOT NULL,
   `JOB` varchar(9) DEFAULT 'NA',
   `MGR` int unsigned ,
   HIREDATE date ,
   SAL float ,
   COMM float ,
   DEPTNO int unsigned,
   -- [CONSTRAINT <anyName>] PRIMARY KEY(column_name),
   CONSTRAINT pk_emp_empno PRIMARY KEY (empno),
   CONSTRAINT chk_job CHECK (job IN ('ANALYST','MANAGER','CLERK')),
   CONSTRAINT chk_hiredate CHECK ( hiredate <= SYSDATE()),
   CONSTRAINT chk_sal CHECK (sal > 1000),
   CONSTRAINT chk_comm CHECK (comm < sal),
   CONSTRAINT fk_deptno FOREIGN KEY(deptno) REFERENCES dept(deptno)
 );
 
 select * from emp_new;
 
 INSERT INTO emp_new VALUES(7788,'SCOTT','MANAGER',NULL,'2021-01-01',2000,200,20);
 
 delete from dept where deptno=30;
 
 Cannot delete or update a parent row: a foreign key constraint fails (`dac_2021`.`emp_new`, CONSTRAINT `fk_deptno` FOREIGN KEY (`DEPTNO`) REFERENCES `dept` (`DEPTNO`))	0.000 sec
 Check constraint 'chk_job' is violated
 Cannot add or update a child row: a foreign key constraint fails (`dac_2021`.`emp_new`, CONSTRAINT `fk_deptno` FOREIGN KEY (`DEPTNO`) REFERENCES `dept` (`DEPTNO`))	0.000 sec
 
 
 select * from dept;
 ALTER TABLE dept
 ADD CONSTRAINT pk_dept_deptno PRIMARY KEY (deptno);
 
 select * from salgrade;
 
ALTER TABLE salgrade
 ADD PRIMARY KEY (grade);
 
show create table salgrade;

CREATE TABLE `salgrade` (
   `GRADE` int NOT NULL,
   `LOSAL` int DEFAULT NULL,
   `HISAL` int DEFAULT NULL,
   PRIMARY KEY (`GRADE`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
 
 Alter table salgrade
 drop primary key;
 
 select * from emp;
 
 ALTER TABLE emp
 ADD CONSTRAINT pk_empno PRIMARY KEY (empno);
 
   CONSTRAINT chk_emp_job CHECK (job IN ('ANALYST','MANAGER','CLERK','PRESIDENT','SALESMAN')),
   CONSTRAINT chk_hiredate CHECK ( hiredate <= SYSDATE()),
   CONSTRAINT chk_sal CHECK (sal > 1000),
   CONSTRAINT chk_comm CHECK (comm < sal),
   
   select * from dept;
   
   INSERT INTO dept VALUES(30,'SALES','CHICAGO',NULL)
   
   
   
    ALTER TABLE emp
   ADD FOREIGN KEY(deptno) REFERENCES dept(deptno)
   ON DELETE CASCADE -- delete child table records if parent record is deleted
   -- ON DELETE SET NULL -- set the deptno value to NULL for child records in case parent rec is deleted 
   -- ON DELETE RESTRICT*  -- don't allow deletion of parent table record in case child exists
   ON UPDATE CASCADE -- if parent row deptno is updated then make same change to child rows
   -- ON UPDATE SET NULL
   -- ON UPDATE RESTRICT* -- default consideration
   
   select * from emp where deptno=10;
   
   delete from dept where deptno=10; -- child records in emp table for deptno 30
   
   CREATE TABLE grade1 (
   `GRADE` int NOT NULL AUTO_INCREMENT,
   -- Auto increment can only be applied on Primary key
   -- It will help automatica generation of sequential values for grade column
   `LOSAL` int DEFAULT NULL,
   `HISAL` int DEFAULT NULL
 );
 
CREATE TABLE grade1 (
    `GRADE` int NOT NULL AUTO_INCREMENT,
    -- Auto increment can only be applied on Primary key
    -- It will help automatica generation of sequential values for grade column
    `LOSAL` int DEFAULT NULL,
    `HISAL` int DEFAULT NULL,
    PRIMARY KEY(grade)
    )
  
  -- Incorrect table definition; 
  -- there can be only one auto column and it must be defined as a key	
   
select * from grade;

INSERT INTO grade(losal,hisal) VALUE(1000,2000);

INSERT INTO grade(losal,hisal) VALUE(2001,3000);

INSERT INTO grade(grade,losal,hisal) VALUE(5,3001,4000);

INSERT INTO grade(losal,hisal) VALUE(4001,5000);