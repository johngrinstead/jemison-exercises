-- 1) Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

use easley_1269;

create temporary table employees_with_departments as
select emp.emp_no, emp.first_name, emp.last_name, dep.dept_name, dep.dept_no
From employees.employees as emp
join employees.dept_emp as de using(emp_no)
join employees.departments as dep using(dept_no)
where de.to_date > curdate();

select *
from employees_with_departments;

    -- A) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
    
ALTER TABLE employees_with_departments 
ADD full_name VARCHAR(100);

select *
from employees_with_departments;
    
    -- B) Update the table so that full name column contains the correct data
    
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

select *
from employees_with_departments;

    -- C) Remove the first_name and last_name columns from the table.
    
    
ALTER TABLE employees_with_departments 
DROP COLUMN first_name;

ALTER TABLE employees_with_departments 
DROP COLUMN last_name;

select *
from employees_with_departments;

    -- D) What is another way you could have ended up with this same table?
    
create temporary table alt_employees_with_departments as
select emp.emp_no, concat(emp.first_name, ' ', emp.last_name) as full_name, dep.dept_name, dep.dept_no
From employees.employees as emp
join employees.dept_emp as de using(emp_no)
join employees.departments as dep using(dept_no)
where de.to_date > curdate();

select *
from alt_employees_with_departments;

-- 2) Create a temporary table based on the payment table from the sakila database.

create temporary table sakila_payment as
select *
from sakila.payment;

select *
from sakila_payment;

    -- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
    
alter table sakila_payment
add amount_in_cents INT UNSIGNED;

update sakila_payment
set amount_in_cents = amount * 100;

alter table sakila_payment
modify amount int;

update sakila_payment
set amount = amount_in_cents;

select *
from sakila_payment;

-- 3) Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

	-- Find current avg
create temporary table current_avg as 
select dept_no, avg(salary) as current_avg
from employees.salaries
join employees.dept_emp using(emp_no)
where employees.salaries.to_date > curdate()
group by dept_no;

select *
from current_avg;

	-- Find historic average 
create temporary table historic_avg as
select dept_no, avg(salary) as historical_avg
from employees.salaries
join employees.dept_emp using(emp_no)
group by dept_no;

select *
from historic_avg;

	-- Combine tables
create temporary table all_avg as
select *
from current_avg
join historic_avg using(dept_no);

select *
from all_avg;