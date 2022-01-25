
#01. Table Design

create table pictures(
id int primary key auto_increment,
url varchar(100) not null,
added_on datetime not null
);

create table categories(
id int primary key auto_increment,
name varchar(40) not null unique
);

create table products(
id int primary key auto_increment,
name varchar(40) not null unique,
best_before date ,
price decimal (10,2)not null,
`description` text,
category_id int not null,
picture_id int not null,
constraint fk_product_category foreign key (category_id) references categories(id),
constraint fk_product_pictures foreign key (picture_id) references pictures(id)
);

create table towns(
id int primary key auto_increment,
name varchar(20) not null unique
);

create table addresses(
id int primary key auto_increment,
name varchar(50) not null unique,
town_id int not null,
constraint fk_addresses_towns foreign key (town_id) references towns(id)
);

create table stores(
id int primary key auto_increment,
name varchar(20) not null unique,
rating float not null,
has_parking boolean default false,
address_id int not null,
constraint fk_stores_addresses foreign key(address_id) references addresses(id)
);

create table products_stores(
product_id int not null,
store_id int not null,
constraint pk_products_stores primary key (product_id,store_id),
constraint fk_product_stores_products foreign key (product_id ) references products(id),
constraint fk_product_stores_stores foreign key (store_id) references stores(id)
);

create table employees(
id int primary key auto_increment,
first_name varchar(15) not null ,
middle_name char(1) ,
last_name varchar(20) not null ,
salary decimal(19,2) default 0 not null,
hire_date date not null,
manager_id int ,
store_id int not null,
constraint sr_employees_employees foreign key (manager_id) references employees(id),
constraint fk_employees_stores foreign key (store_id) references stores(id)
);

#02. Insert

insert into products_stores
select p.id,1 from products as p 
where p.id not in (select product_id  from products_stores  as ps);

# 03. Update

UPDATE employees AS e 
SET 
    e.manager_id = 3,
    e.salary = e.salary - 500
WHERE
    YEAR(e.hire_date) > 2003
        AND e.store_id NOT IN (SELECT 
            s.id
        FROM
            stores AS s
        WHERE
            s.name = 'Cardguard'
                OR s.name = 'Veribet')
;


-- 04. Delete

DELETE FROM employees 
WHERE
    salary >= 6000
    AND manager_id IS NOT NULL;


-- 05. Employees

SELECT 
    first_name, middle_name, last_name, salary, hire_date
FROM
    employees
ORDER BY hire_date DESC;


-- 06. Products with old pictures

SELECT 
    p.name AS product_name,
    p.price,
    p.best_before,
    CONCAT(SUBSTRING(p.description, 1, 10), '...') AS short_description,
    ps.url
FROM
    products AS p
        JOIN
    pictures AS ps USING (id)
WHERE
    p.price > 20
        AND YEAR(ps.added_on) > 2019
        AND LENGTH(p.description) > 100
ORDER BY p.price DESC;

-- 07. Counts of products in stores

SELECT 
    s.name,
    COUNT(p.id) AS product_count,
    ROUND(AVG(p.price), 2) AS `avg`
FROM
    stores AS s
        LEFT JOIN
    products_stores AS ps ON s.id = ps.store_id
        LEFT JOIN
    products AS p ON ps.product_id = p.id
GROUP BY (s.id)
ORDER BY product_count DESC , `avg` DESC , s.id
;

-- 08. Specific employee

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    s.`name`,
    a.`name`,
    e.salary
FROM
    employees AS e
        JOIN
    stores AS s ON s.id = e.store_id
        JOIN
    addresses AS a ON a.id = s.address_id
WHERE
    e.salary < 4000
        AND a.`name` LIKE ('%5%')
        AND CHAR_LENGTH(s.`name`) > 8
        AND RIGHT(e.last_name, 1) = 'n';

-- 09. Find all information of stores
# WITH NESTED QUERY

select reverse(s.name) as store_name,
concat(upper(t.name),'-',a.name) as full_address,(select count(e.id) from employees as e where e.store_id = s.id)as employee_count 
from stores as s
join addresses as a on s.address_id = a.id
join towns as t on  t.id = a.town_id
 where (select count(e.id) from employees as e where e.store_id = s.id) > 0
 order by full_address	
 ;
-- 09. Find all information of stores
#WITH GROUP BY...
select reverse(s.name) as store_name,
concat(upper(t.name),'-',a.name) as full_address,count(e.id) employee_count 
from stores as s
join addresses as a on s.address_id = a.id
join towns as t on  t.id = a.town_id
join employees as e on e.store_id = s.id
group by s.id
having employee_count > 0 
order by full_address;	


-- 10. Find name of top paid employee by store name

delimiter $$
CREATE FUNCTION udf_top_paid_employee_by_store(store_name VARCHAR(50))
RETURNS varchar(100)
	deterministic
BEGIN

RETURN (select concat(e.first_name,' ',e.middle_name,'. ',e.last_name,' works in store for ',
2020 - year(hire_date),' years') from  employees as e
join stores as s on e.store_id = s.id
where s.name = store_name
order by e.salary desc limit 1);
END $$
select  udf_top_paid_employee_by_store('Stronghold') as 'full_info';


-- 11. Update product price by address



delimiter &&
CREATE PROCEDURE udp_update_product_price (address_name VARCHAR (50))
	BEGIN 
		UPDATE products AS p
		JOIN products_stores AS ps
		ON ps.product_id = p.id
		JOIN stores AS s
		ON ps.store_id = s.id
		JOIN addresses AS a
		ON a.id = s.address_id
			SET p.price = IF (a.name like '0%', p.price + 100, p.price + 200)
			WHERE a.name = address_name;
    END &&












