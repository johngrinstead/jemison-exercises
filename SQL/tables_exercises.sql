-- 1) Open MySQL Workbench and login to the database server

-- 2) Save your work in a file named tables_exercises.sql

-- 3) Use the employees database. Write the SQL code necessary to do this.

use employees;

-- 4) List all the tables in the database. Write the SQL code necessary to accomplish this.

show tables;

-- 5) Explore the employees table. What different data types are present on this table?

describe employees;

-- 6) Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)

    -- All of the tables except departments has numerical type data
    
-- 7) Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)

    -- All of the tables except salaries has string type data
    
-- 8) Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)

    -- All of the tables except departments has date type data
    
-- 9) What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)

    -- The employees table contains data pertaining to the individual employees and the department contains the names and dept no of each department. Using the dept_emp table you can connect which employees belong to which dept by joining the emp_no and the dept_no
    
-- 10) Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.

show create table dept_manager;

