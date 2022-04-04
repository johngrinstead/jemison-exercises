-- 1) Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

-- 2) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya');
	-- First result: Vidya Awdeh
	-- Last result: Maya Melter

-- 3) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name, last_name;
	-- First result: Irena Acton
	-- Last result: Vidya Zweizig

-- 4) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by last_name, first_name;
	-- First result: Irena Acton
	-- Last result: Maya Zyda

-- 5) Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

select *
from employees
where last_name like 'E%'
and last_name like '%e'
order by emp_no;
	-- Returns 899 rows
	-- First result: Ramzi Erde #10021
	-- Last result: Tadahiro Erde #499648

-- 6) Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.

select *
from employees
where last_name like 'E%'
and last_name like '%e'
order by hire_date desc;
	-- Returns 899 rows
	-- Most recent hire: Teiji Eldridge
	-- Oldest hire: Sergi Erde

-- 7) Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.

select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by birth_date, hire_date desc;
	-- Returns 362 rows
	-- Oldest employee most recently hired: Khun Bernini
	-- Youngest employee hired earliest: Douadi Pettis
    
