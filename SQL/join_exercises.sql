                                -- Join Example Database

-- 1) Use the join_example_db. Select all the records from both the users and roles tables.

use join_example_db;

select *
from roles;

select *
from users;

-- 2) Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

select *
from users
join roles on users.role_id = roles.id;

select *
from users
left join roles on users.role_id = roles.id;

select *
from users
right join roles on users.role_id = roles.id;

-- 3) Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

select roles.name, count(users.name)
from users
right join roles on users.role_id = roles.id
group by roles.name;



                                    -- Employees Database
                                    
-- 1) Use the employees database.

use employees;

-- 2) Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

select d.dept_name, concat(emp.first_name, ' ', emp.last_name) as Dept_Manager
from employees as emp
join dept_manager as dm using(emp_no)
join departments as d using(dept_no)
where dm.to_date > curdate();

'''
  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
'''

-- 3) Find the name of all departments currently managed by women.

select d.dept_name, concat(emp.first_name, ' ', emp.last_name) as Dept_Manager
from employees as emp
join dept_manager as dm using(emp_no)
join departments as d using(dept_no)
where dm.to_date > curdate()
and emp.gender = 'F';

'''
Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
'''

-- 4) Find the current titles of employees currently working in the Customer Service department.

select t.title, count(t.title)
from titles as t
join dept_emp as dp using(emp_no)
where t.to_date > curdate()
and dp.to_date > curdate()
and dept_no = 'd009'
group by t.title;

'''
Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
'''

-- 5) Find the current salary of all current managers.

select d.dept_name, concat(emp.first_name, ' ', emp.last_name) as Dept_Manager, s.salary
from employees as emp
join dept_manager as dm using(emp_no)
join departments as d using(dept_no)
join salaries as s using(emp_no)
where dm.to_date > curdate()
and s.to_date > curdate();

'''
Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
'''

-- 6) Find the number of current employees in each department.

select dept_no, d.dept_name, count(emp_no) as num_employees
from dept_emp as de
join departments as d using(dept_no)
where de.to_date > curdate()
group by dept_no
order by dept_no;

'''
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
'''

-- 7) Which department has the highest average salary? Hint: Use current not historic information.

select d.dept_name, avg(s.salary) as avg_salary
from salaries as s
join dept_emp as de using(emp_no)
join departments as d using(dept_no)
where de.to_date > curdate()
and s.to_date > curdate()
group by d.dept_name
order by avg_salary desc
limit 1;

'''
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
'''

-- 8) Who is the highest paid employee in the Marketing department?

select emp.first_name, emp.last_name, s.salary
from employees as emp
join dept_emp as de using(emp_no)
join salaries as s using(emp_no)
where de.to_date > curdate()
and s.to_date > curdate()
and de.dept_no = 'd001'
order by s.salary desc
limit 1;

'''
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
'''

-- 9) Which current department manager has the highest salary?

select d.dept_name, concat(emp.first_name, ' ', emp.last_name) as Dept_Manager, s.salary
from employees as emp
join dept_manager as dm using(emp_no)
join departments as d using(dept_no)
join salaries as s using(emp_no)
where dm.to_date > curdate()
and s.to_date > curdate()
order by s.salary desc
limit 1;

'''
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
'''

-- 10) Determine the average salary for each department. Use all salary information and round your results.

select d.dept_name, round(avg(s.salary)) as avg_salary
from dept_emp as de
join departments as d using(dept_no)
join salaries as s using(emp_no)
group by d.dept_name;

'''
+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+
'''

-- Bonus Find the names of all current employees, their department name, and their current manager's name.

'''
240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
 '''
 
-- Bonus Who is the highest paid employee within each department.