-- 1) Create a new file named group_by_exercises.sql

-- 2) In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

select distinct(title)
from titles;
	-- Returns 7 rows

-- 3) Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

select last_name
from employees
where last_name like 'E%'
and last_name like '%e'
group by last_name;

-- 4) Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

select concat(first_name, ' ', last_name) as full_name
from employees
where last_name like 'E%'
and last_name like '%e'
group by full_name;

-- 5) Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

select last_name
from employees
where last_name like '%q%'
and last_name not like '%qu%'
group by last_name;

-- 6) Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

select last_name, count(last_name)
from employees
where last_name like '%q%'
and last_name not like '%qu%'
group by last_name;

-- 7) Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

select first_name, gender, count(gender)
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by first_name, gender;

-- 8) Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

select lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4), '_', substr(birth_date, 6, 2), substr(birth_date, 3, 2))) as username, count(*) as num_of_users
from employees
group by username
order by num_of_users desc;
	-- Yes, there are duplicate users
	
select lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4), '_', substr(birth_date, 6, 2), substr(birth_date, 3, 2))) as username, count(*) as num_of_users
from employees
group by username
having num_of_users > 1
order by num_of_users;
	-- 13251 rows of duplicate usernames returned 

-- 9) More practice with aggregate functions:

    -- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
    
select avg(salary)
from salaries
group by emp_no;
    
    -- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
    
select dept_no, count(emp_no)
from dept_emp
group by dept_no;
    
    -- Determine how many different salaries each employee has had. This includes both historic and current.
    
select emp_no, count(salary)
from salaries
group by emp_no;
    
    -- Find the maximum salary for each employee.
    
select emp_no, max(salary)
from salaries
group by emp_no;
    
    -- Find the minimum salary for each employee.
    
select emp_no, min(salary)
from salaries
group by emp_no;
    
    -- Find the standard deviation of salaries for each employee.
    
select emp_no, std(salary)
from salaries
group by emp_no;
    
    -- Now find the max salary for each employee where that max salary is greater than $150,000.
    
select emp_no, max(salary) as max_salary
from salaries
group by emp_no
having max_salary > 150000;
    
    -- Find the average salary for each employee where that average salary is between $80k and $90k.
    
select emp_no, avg(salary) as avg_salary
from salaries
group by emp_no
having avg_salary between 80000 and 90000;