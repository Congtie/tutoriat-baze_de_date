-- SQL Subqueries

-- link where you can find more exercises: 
-- https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php 


-- name of the employees which do not work
-- in Shipping or IT departments
SELECT first_name || ' ' || last_name as "Name"
FROM employees
WHERE employee_id NOT IN
(SELECT employee_id
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id
    WHERE d.department_name = 'Shipping' OR d.department_name = 'IT');
    
    
-- ex 11 
SELECT first_name || ' ' || last_name as "Name" 
FROM employees
WHERE employee_id NOT IN
(SELECT employee_id
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id
    WHERE d.manager_id BETWEEN 100 AND 200);

--ex 13    
SELECT first_name || ' ' || last_name as "Name" , hire_date
FROM employees
WHERE first_name <> 'Clara' AND department_id = 
(SELECT department_id from
employees WHERE first_name = 'Clara');
    
-- commit, rollback
-- we use a commit after a DML operation (INSERT, UPDATE, DELETE) to make the changes permanent
-- if we did not use commit, we can undo the changes by using the rollback command
SELECT * FROM employees WHERE employee_id = 206;
    
DELETE FROM employees
    WHERE employee_id = 206;
ROLLBACK; 