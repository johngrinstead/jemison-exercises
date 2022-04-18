-- 1) Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

select emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, de.dept_no, emp.hire_date, de.to_date,
	CASE 
        WHEN de.to_date > curdate() THEN 1
        ELSE 0
    END AS is_current_employee
from employees as emp
join dept_emp as de using(emp_no);

-- 2) Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

select emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, de.dept_no, emp.hire_date, de.to_date,
	CASE 
        WHEN substr(emp.last_name, 1, 1) between 'a' and 'h' THEN 'A-H'
		WHEN substr(emp.last_name, 1, 1) between 'i' and 'q' THEN 'I-Q'
        ELSE 'R-Z'
    END AS alpha_group
from employees as emp
join dept_emp as de using(emp_no);

-- 3) How many employees (current or previous) were born in each decade?


	-- Find earliest birthdate
select min(birth_date)
from employees;
		-- 1952-02-01
	
	-- Find most recent birthdate
select max(birth_date)
from employees;
		-- 1965-02-01
		
	-- Make case statement for each decade
select emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, de.dept_no, emp.hire_date, de.to_date, emp.birth_date,
	CASE 
        WHEN emp.birth_date like '195%' THEN 1
        ELSE 0
    END AS born_in_50s,
	CASE 
        WHEN emp.birth_date like '196%' THEN 1
        ELSE 0
    END AS born_in_60s
from employees as emp
join dept_emp as de using(emp_no);

	-- Query for each decade
select sum(born_in_50s) as num_of_50s_babies, sum(born_in_60s) as num_of_60s_babies
from(
select emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, de.dept_no, emp.hire_date, de.to_date, emp.birth_date,
	CASE 
        WHEN emp.birth_date like '195%' THEN 1
        ELSE 0
    END AS born_in_50s,
	CASE 
        WHEN emp.birth_date like '196%' THEN 1
        ELSE 0
    END AS born_in_60s
from employees as emp
join dept_emp as de using(emp_no)
) as query_table;

-- 4) What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

	-- Make a case for dept
	
select emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, de.dept_no, emp.hire_date, de.to_date, s.salary,
	CASE 
        WHEN de.dept_no in ('d008', 'd005') THEN 'R & D'
		WHEN de.dept_no in ('d007', 'd001') THEN 'Sales & Marketing'
		WHEN de.dept_no in ('d004', 'd006') THEN 'Prod & QM'
		WHEN de.dept_no in ('d002', 'd003') THEN 'Finance & HR'
        ELSE 'Customer Service'
    END AS dept_group
from employees as emp
join dept_emp as de using(emp_no)
join salaries as s using(emp_no)
where s.to_date > curdate();

	-- Group by new column to aggregate salary

select dept_group, avg(salary)
from(
select emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, de.dept_no, emp.hire_date, de.to_date, s.salary,
	CASE 
        WHEN de.dept_no in ('d008', 'd005') THEN 'R & D'
		WHEN de.dept_no in ('d007', 'd001') THEN 'Sales & Marketing'
		WHEN de.dept_no in ('d004', 'd006') THEN 'Prod & QM'
		WHEN de.dept_no in ('d002', 'd003') THEN 'Finance & HR'
        ELSE 'Customer Service'
    END AS dept_group
from employees as emp
join dept_emp as de using(emp_no)
join salaries as s using(emp_no)
where s.to_date > curdate()
) as query_table
group by dept_group;