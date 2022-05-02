Functions
--------------------------

CREATE FUNCTION function_name(
    param1,
    param2,…
)

RETURNS datatype
[NOT] DETERMINISTIC
BEGIN
 -- statements
 -- RETURN clause
END $$


Difference between FUNCTION and PROCEDURE
--------------------------------------------------


Procedure
  -- Are not callable in select or any other SQL commands
      select test_cur();
      FUNCTION scott.test_cur does not exist
  
  -- Are used to perform DML and DDL operations
      select func();
            -- insert / update /delete
            
  If a function is created with DML commands then it is not at all callable in Queries
  -- Function is mostly used to perform calculation
  -- Function must always return a result back to calling program
  -- We have additional clause which is called  as RETURN (use it to return result to calling program)
  
  DELIMITER $
  CREATE FUNCTION total_sal
  (
  p_sal INTEGER,  -- Functions can have only IN type of parameter
  p_comm INTEGER
  )
  RETURNS INTEGER -- defining the result data type
  DETERMINISTIC -- for a specific input value the result will always be same
  BEGIN
      DECLARE v_result INTEGER;
      SET v_result = ((p_sal + ifnull(p_comm,0)) * 12);
      RETURN (v_result); -- we can't skip this clause in function
						-- execution of program will stop at RETURN Clause
	  
  END$
  
  select empno,ename,sal,comm,total_sal(sal,comm) Total_sal from emp; -- 1440
  
  select sysdate();
  
  
DELIMITER #
CREATE FUNCTION getsum(
  p_val1 INTEGER,  -- IN / OUT and INOUT parameter declaration is not allowed in func
  p_val2 INTEGER
)
RETURNS INTEGER  -- specifying the return data type of result
DETERMINISTIC
BEGIN
   /*
   Single Function may have multiple return commands. 
   Only first RETURN clause will be executed and any command
   written after first occurence will be ignored (unreachable code)
   */

   
   IF p_val1 IS NULL AND p_val2 IS NOT NULL THEN
      RETURN p_val2;
   ELSEIF p_val2 IS NULL AND p_val1 IS NOT NULL THEN
      RETURN p_val1;
   END IF;
   
   RETURN p_val1 + p_val2;
   -- No code must be written after last RETURN clause
END#