-- 1) Create a new SQL script named limit_exercises.sql.

-- 2) MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:


SELECT DISTINCT title FROM titles;
    -- List the first 10 distinct last name sorted in descending order.
    
select distinct last_name
from employees
limit 10;
	-- Facello
	-- Simmel
	-- Bamford
	-- Koblick
	-- Maliniak
	-- Preusig
	-- Zielinkski
	-- Kalloufi
	-- Peac
	-- Piveteau

-- 3) Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by hire_date
limit 5;
	-- Alselm Cappello: 1990-01-01
	-- Utz Mandell: 1990-01-03
	-- Bouchung Schreiter: 1990-01-04
	-- Boacai Kushner: 1990-01-05
	-- Petter Stroustrup: 1990-01-10

-- 4) Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

select *
from employees
where birth_date like '%12-25'
and hire_date like '199%'
order by hire_date
limit 5
offset 45;
	-- Pranay Narwekar: 1990-07-18
	-- Marjo Farrow: 1990-07-18
	-- Ennio Karcich: 1990-08-05
	-- Dines Lubachevsky: 1990-08-06
	-- Ipke Fontan: 1990-08-06

    -- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
    
        -- LIMIT informs the query how many results to disply, OFFSET informs how many rows to skip. To find the results of a desired "page" you should offset by how many results would be in all the pages before it put together
        -- (page_no - 1) * page_size
        
