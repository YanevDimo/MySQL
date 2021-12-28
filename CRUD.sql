-- 01. Select Employee Information

SELECT 
    id, first_name, last_name, job_title
FROM
    employees
ORDER BY id;

-- 02. Select Employees with Filter

SELECT 
    id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    job_title,
    salary
FROM
    employees
WHERE
    salary > 1000;

-- 03. Update Salary and Select
update employees
set salary = salary + 100
where job_title = 'Manager';
select salary
from employees;

-- 04. Top Paid Employee

select * 
from employees
order by salary desc limit 1;

 create view `view_top_paid_employee`
 as(select * from `employees`
 order by `salary` desc limit 1);
 
--  05. Select Employees by Multiple Filters

select * from hotel.employees
where salary > 1000 and department_id = 4
order by id asc;

-- 06. Delete from Table

delete from employees
where department_id in (1,2);
select * 
from employees
order by id ;