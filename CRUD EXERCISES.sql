-- 01. Find All Information About Departments

SELECT * FROM departments
order by`department_id`;

-- 02. Find all Department Names

select name from departments
order by `department_id`;

-- 03. Find Salary of Each Employee

select `first_name`,`last_name`,`salary`
 from employees;
 
--  04. Find Full Name of Each Employee

select first_name, middle_name, last_name
from employees;

-- 05. Find Email Address of Each Employee

select concat(first_name,'.',last_name, '@softuni.bg')
as 'full_email_address'
from employees;

-- 06. Find All Different Employee’s Salaries

select distinct salary  from employees;

-- 07. Find all Information About Employees

select * from employees
where `job_title` = 'Sales Representative'
order by `employee_id`;

-- 08. Find Names of All Employees by Salary in Range

select `first_name`,`last_name`,`job_title`
from `employees`
where `salary` between 20000 and 30000
order by `employee_id`;

# ИЛИ
-- select `first_name`,`last_name`,`job_title`
-- from `employees`
-- where `salary` >= 20000 and `salary`<= 30000
-- order by `employee_id`;

-- 9. Find Names of All Employees

select concat_ws(' 'first_name,middle_namecre,last_name)as 'Full Name' 
from employees
where salary in (25000,14000,12500,23600); 

-- 10. Find All Employees Without Manager

select first_name,last_name from employees
where manager_id is null;

-- 11. Find All Employees with Salary More Than

select first_name,last_name,salary from employees
where salary > 50000
order by salary desc;

-- 12. Find 5 Best Paid Employees

select first_name,last_name from employees
order by salary desc
limit 5;

-- 13. Find All Employees Except Marketing

select first_name,last_name
 from employees
where department_id != 4;

-- 14. Sort Employees Table

select * from employees
order by salary desc,first_name asc,last_name desc,middle_name asc;

-- 15. Create View Employees with Salaries

create view `v_employees_salaries`as
select first_name,last_name,salary
from employees;
select * from v_employees_salaries;

-- 16. Create View Employees with Job Titles

create view v_employees_job_titles as
select concat_ws(' ',first_name,middle_name,last_name)as 'full_name',job_title
from employees;
select * from v_employees_job_titles;

-- 17. Distinct Job Titles

select distinct job_title from employees
order by  job_title ;

-- 18. Find First 10 Started Projects

select * from projects
order by `start_date`,`name`
limit 10;


-- 19. Last 7 Hired Employees

select first_name,last_name,hire_date from employees
order by hire_date desc
limit 7 ;

-- 20. Increase Salaries
select * from employees;
update employees
set salary = salary * 1.12
where department_id  in (1,2,4,11) ;
select salary
from employees;

-- 21. All Mountain Peaks

select peak_name from peaks
order by peak_name;

-- 22. Biggest Countries by Population

select country_name,continent_code,population from countries
where continent_code = 'EU'
order by  population desc,country_name
limit 30;

-- 23. Countries and Currency (Euro / Not Euro

select country_name,country_code,
if(currency_code = 'EUR','Euro','Not Euro')as currency 
from countries
order by country_name;

-- 24. All Diablo Characters

select `name` from characters
order by name;