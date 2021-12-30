-- 01. Find Names of All Employees by First Name

select first_name,last_name from employees
where first_name like 'Sa%'
order by employee_id;

--  # 2 начин
-- select first_name,last_name from employees
-- where substring(first_name,1,2) ='Sa'
-- order by employee_id;

-- # 3 начин
-- select first_name,last_name from employees
-- where left(first_name,2) ='Sa'
-- order by employee_id;


-- 02. Find Names of All Employees by Last Name

select first_name,last_name from employees
where last_name like '%ei%'
order by employee_id;


-- 03. Find First Names of All Employess

select first_name from employees
where department_id  in(3,10)
and year (hire_date) between 1995 and 2005
order by employee_id;

-- 04. Find All Employees Except Engineers

select  first_name,last_name from employees
where job_title not like '%engineer%'
order by employee_id;


-- 05. Find Towns with Name Length

select `name` from `towns`
where char_length(`name`)between 5 and 6 
order by `name`;

-- 06. Find Towns Starting With

select `town_id`,`name` from towns
where left(`name`,1) in('M','K','B','E')
order by `name`;

-- 07. Find Towns Not Starting With

select `town_id`,`name` from `towns`
where left(`name`,1) not in ('R','B','D')
order by `name`;

-- 08. Create View Employees Hired After

create view v_employees_hired_after_2000 as
select first_name,last_name from employees
where year (hire_date) > 2000;

select * from v_employees_hired_after_2000;

-- 09. Length of Last Name

select `first_name`,`last_name` from employees
where char_length(last_name) = 5;

-- 10. Countries Holding 'A'

select country_name,iso_code from countries
where country_name like '%A%A%A%'
order by iso_code;


--   11. Mix of Peak and River Names

SELECT 
    p.`peak_name`,
    r.`river_name`,
    LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS 'mix'
FROM
    `peaks` AS p,
    `rivers` AS r
WHERE
    RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;

-- 12. Games From 2011 and 2012 Year 

select `name`,date_format(`start`,'%Y-%m-%d') 
from games
where year(`start`) between 2011 and 2012
order by `start`,`name`
limit 50;

-- 13. User Email Providers

SELECT 
    `user_name`,
    SUBSTRING(`email`,
        LOCATE('@', `email`) + 1) AS 'email_provider'
FROM
    `users`
ORDER BY email_provider , user_name;

-- 14. Get Users with IP Address Like Pattern

select user_name,ip_address from users
where ip_address like '___.1%.%.___'
order by user_name;


-- 15. Show All Games with Duration

SELECT 
    `name`,
    (CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Mornig'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(`start`) BETWEEN 18 AND 23 THEN 'Evning'
    END) AS 'Part of the day',
    (CASE
        WHEN `duration` BETWEEN 0 AND 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN ' Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
    END) AS 'Duration'
FROM
    `games`;
    
--     16. Orders Table


SELECT 
    product_name,
    order_date,
    DATE_ADD(order_date, INTERVAL 3 DAY) AS `pay_day`,
    DATE_ADD(order_date, INTERVAL 1 MONTH) AS delivered_day
FROM
    orders;