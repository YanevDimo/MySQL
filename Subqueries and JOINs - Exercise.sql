-- 01. Employee Address

select e.employee_id , e.job_title , a .address_id , a.address_text 
from employees as e
join addresses as a 
on e.address_id = a.address_id #  using(address_id); он кондишан може да се замeни с using ако имената на fk савпадат с pk
order by e.address_id limit 5;

-- 02. Addresses with Towns

select e.first_name,e.last_name,t.`name`,a.address_text from employees as e
join addresses as a
on e.address_id = a.address_id
join towns as t
on a.town_id = t.town_id
order by e.first_name,e.last_name
limit 5;

-- 03. Sales Employee

select e.employee_id , e.first_name , e.last_name , d.`name`
from employees as e
join departments as d
using(department_id)
where d.name = 'Sales'
order by e. employee_id desc;

-- 04. Employee Departments

select e.employee_id,e.first_name,e.salary,d.name 	          	 		
from employees as e 
join departments as d
on e.department_id = d.department_id
where salary > 15000
order by d.department_id desc
limit 5; 


-- 05. Employees Without Project

select e. employee_id ,e.first_name from employees as e
left join employees_projects as ep
on e.employee_id = ep.employee_id
where ep.project_id is null
order by e.employee_id desc
limit 3;

-- 06. Employees Hired After

select e.first_name,e.last_name,e.hire_date,d.`name` from employees as e
join departments as d
on e.department_id = d.department_id 
where date(e.hire_date) > '1999-01-01'	
and d.`name` in ('Sales','Finance') 
order by e.hire_date	;

-- 07. Employees with Projec

select e.employee_id ,e.first_name,p.`name` from employees as e
join employees_projects as ep
on e.employee_id = ep. employee_id
join projects as p
using (project_id)
where date (p.start_date) > '2002-08-13' and end_date is null
order by e.first_name,p.name
limit 5;

-- 08. Employee 24

select e.employee_id,first_name, if(year(p.`start_date`) > 2004, null , p.`name`) as p_name
from employees as e
join employees_projects as ep
on ep.employee_id = e. employee_id
join projects as p
on p.project_id = ep.project_id
where e.employee_id = 24
order by p_name;


-- 09. Employee Manager

select e.employee_id,e.first_name,m.employee_id,m.first_name
from employees as e
join employees as m
on e.manager_id  = m.employee_id
where e.manager_id in(3,7)
order by e.first_name
;

-- 10. Employee Summary

select e.employee_id,
concat_ws(' ',e.first_name,e.last_name) as employee_name,
concat_ws(' ',m.first_name,m.last_name)as manager_name,
d.name
from employees as e
join employees as m
on e.manager_id = m. employee_id
join departments as d
on e.department_id = d.department_id
order by e.employee_id
limit 5;

-- 11. Min Average Salary

select  avg(salary) from employees
group by department_id
order by avg (salary)
limit 1;

-- 12. Highest Peaks in Bulgaria

select c.country_code , m.mountain_range , p.peak_name , p.elevation 
from countries as c
join mountains_countries as mc
using(country_code) 
join mountains as m
on mc.mountain_id = m.id
join peaks as p
on p.mountain_id = m.id
where c.country_code = 'BG' and p.elevation > 2835
order by elevation desc;

-- 13. Count Mountain Ranges

select mc.country_code,count(m.id) as m_count from mountains as m
join mountains_countries as mc
on  mc.mountain_id = m.id
where mc.country_code in ('BG','RU','US')
group by mc.country_code
order by m_count desc;

-- 14. Countries with Rivers

select c.country_name,r.river_name from rivers as r
right join countries_rivers as cr on r.id = cr.river_id
right join countries as c using(country_code)
where c.continent_code = 'AF'
order by country_name
limit 5
;

-- 15. *Continents and Currencies (not included in final score)

select continent_code , currency_code , count(country_name) as currency_usage
from countries as c
group by continent_code,currency_code
having currency_usage  = (
select count(country_code)as coun
from countries as contr
where contr.continent_code = c. continent_code
group by currency_code 
order by coun desc
limit 1
) and currency_usage > 1
order by continent_code , currency_code;

-- 16. Countries without any Mountains

select count(*) from countries as c
where c.country_code  not in
(select country_code from mountains_countries);

-- 17. Highest Peak and Longest River by Country

select c.country_name  ,max(p.elevation)as m_elevation ,max(r.length)as m_length
from  countries as c
join countries_rivers as cr using(country_code) 
join rivers as r on cr.river_id = r.id
join mountains_countries as mc using (country_code)
join mountains as m on mc.mountain_id = m.id
join peaks as p on p.mountain_id = m.id
group by c. country_code
order by m_elevation desc , m_length desc , country_name
limit 5;