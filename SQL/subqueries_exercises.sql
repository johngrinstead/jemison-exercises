-- 1) Find all the current employees with the same hire date as employee 101010 using a sub-query.


	-- Find the start date of employee 101010
select hire_date
from employees
where emp_no = 101010;
		- 1990-10-22

	-- Find employess with the same start date
select *
from employees
where hire_date = (
	select hire_date
	from employees
	where emp_no = 101010
);

-- 2) Find all the titles ever held by all current employees with the first name Aamod.


	-- Find emp_no of all current employees with the first name Aamod
select emp_no
from employees as e
join salaries as s using(emp_no)
where e.first_name = 'Aamod'
and s.to_date > curdate();

	-- Find titles of current employees named Aamod
select distinct(title)
from titles
where to_date > curdate()
and emp_no in (
	select emp_no
	from employees as e
	join salaries as s using(emp_no)
	where e.first_name = 'Aamod'
	and s.to_date > curdate()
);

-- 3) How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.


	-- Find list of people currently on salary
select emp_no
from salaries
where to_date > curdate();

	-- Exclude currently salaried employees
select count(*)
from employees
where emp_no not in (
	select emp_no
	from salaries
	where to_date > curdate()
);

-- 4) Find all the current department managers that are female. List their names in a comment in your code.


	-- make a list of current managers
select emp_no
from dept_manager as dm
join employees as emp using(emp_no)
where dm.to_date > curdate();

	-- Compare to a list of female employees
select *
from employees
where gender = 'F'
and emp_no in (
	select emp_no
	from dept_manager as dm
	join employees as emp using(emp_no)
	where dm.to_date > curdate()
);
		-- Isamu Legleitner
		-- Karsten Sigstam
		-- Leon DasSarma
		-- Hilary Kambil

-- 5) Find all the employees who currently have a higher salary than the companies overall, historical average salary.


	-- Find historic overall salary
select avg(salary)
from salaries;

	-- Find each current employee's current salary, compare to previous query
select *
from employees as emp
join salaries as s using(emp_no)
where s.to_date > curdate()
and s.salary > (
	select avg(salary)
	from salaries
);

-- 6) How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

        -- Hint Number 1 You will likely use a combination of different kinds of subqueries.
        
        --Hint Number 2 Consider that the following code will produce the z score for current salaries.
        

-- # what is the max current salary:
select max(salary) 
from salaries 
where to_date > now();

-- # what is the 1 std for current salary;
select stddev(salary) 
from salaries 
where to_date > now();

-- Count of current salaries > (Max-1 std). (count = 83)
select count(*)
from salaries
where to_date > now()
and salary > (
    (select max(salary) from salaries where to_date > now()) - 
    (select std(salary) from salaries where to_date > now())
);

-- Denominator, count of all current salaries (240,124)
select count(*)
from salaries 
where to_date > now();


-- What percentage of all salaries is this?
-- SELECT (Numerator)/ (Denominator)
select((select count(*)
from salaries
where to_date > now()
and salary > (
    (select max(salary) from salaries where to_date > now()) - 
    (select std(salary) from salaries where to_date > now())
    ))/(select count(*)
from salaries 
where to_date > now())) * 100 as "percentage of salaries within 1 Stdev of Max";