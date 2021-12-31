#селектира цялата информация + общата заплата на всеки служител

select * ,
(select sum(salary) from employees) as 'Total Sum'
from soft_uni.employees;

-- 1. Departments Info

select department_id,count(*) as 'Number of employees' 
from employees
group by department_id
order by department_id asc, 'Number of employees';

-- 2. Average Salary

select department_id, round(avg(salary),2)as 'AVG'
from employees
group by department_id
order by department_id asc; 

-- 3. Minimum Salary

select department_id,min(salary)as 'Minimum'
from employees
group by department_id
having min(salary) > 800;


-- 4. Appetizers Count

select count(*)from products
where category_id = 2 and price > 8;


-- 5. Menu Prices

select category_id ,
round(avg(price),2),
round(min(price),2),
round(max(price),2)
from products
group by category_id;