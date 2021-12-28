CREATE DATABASE `minions`;
USE `minions`;
CREATE TABLE `minions`(
`id`INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50)NOT NULL,
`age` INT 
);
CREATE TABLE `towns`(
`town_id`INT PRIMARY KEY AUTO_INCREMENT,
`name`VARCHAR(30) NOT NULL
);

ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY `minions`(`town_id`)
REFERENCES `towns`(`id`);

-- p03  Insert Records in Both Tables 
INSERT INTO `towns`
VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');

INSERT INTO `minions`
VALUES 
(1,'Kevin',22,1),
(2,'Bob',15,3),
(3,'Steward',NULL,2);
-- P04 TRUNKATE  
TRUNCATE `minions`;

-- p05 Drop All Tables 
DROP TABLE `minions`;
DROP TABLE `towns`;

-- P06 Create Table People
CREATE TABLE `people`(
`id`INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height`FLOAT(5,2),
`weight`FLOAT(3,2),
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT

);
INSERT INTO `minions`.`people` (`id`, `name`, `height`, `weight`, `gender`, `birthdate`, `biography`) 
VALUES
('1', 'Vesi', '1.69', '55.0', 'f', '1978.03.24', 'Zdar'),
('2', 'Nia', '1.72', '59.2', 'f', '1965.08.23', 'Zdar'),
('3', 'Mona', '1.65', '55.4', 'm', '1983-12-31', 'Zdar'),
('4', 'Don', '1.86', '85.6', 'm','2011.03.19', 'Zdar'),
('5', 'Ken', '1.76', '87.6', 'm', '2000.06.15', 'Zdar');

SELECT * FROM `people`; 


-- P07  Create Table Users
CREATE TABLE `users`(
`id` int primary key auto_increment,
`username`varchar(30) not null,
`password`varchar(30) not null,
`profile_picture`blob,
`last_login_time`datetime,
`is_deleted`boolean
);
INSERT INTO `users`
VALUES
(1, 'Dan', 'password', NULL, '2021-06-10 12-05-10', true),
(2, 'Nia', 'password1', NULL, '2021-06-10 09-15-10', false),
(3, 'Nela', 'password2', NULL, '2021-06-10 01-05-10', true),
(4, 'Don', 'password3', NULL, '2020-09-10 04-35-10', false),
(5, 'Vit', 'password4', NULL, '2020-12-10 03-15-10', true);

-- -- p 08 Change Primary Key

ALTER TABLE `users`
drop primary key,
add constraint pk_users
primary key(`id`,`username`);

-- -- P09
 ALTER TABLE `minions`.`people` 
 CHANGE COLUMN `height` `height` FLOAT(5,2) NULL DEFAULT 0 ;

-- -- P10 
alter table `users`
drop primary key,
add constraint pk_users
primary key (`id`),
add constraint unique (`username`);

-- -- P11
create database `Movies`;
use `Movies`;

CREATE DATABASE `Movies`;
USE `Movies`;
CREATE TABLE `directors`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `director_name` VARCHAR(50) NOT NULL,
    `notes` TEXT
);

INSERT INTO `directors` (`director_name`)
VALUES 
('Jan'),
('Steve'),
('Nia'),
('Ana'),
('Dan');


create table`genres`(
`id`int primary key auto_increment,
`genres_name` varchar(40) not null,
`notes` text
);
INSERT INTO `genres`(`genres_name`)
VALUE
('Comedy'),
('Drama'),
('Action'),
('Romance'),
('History');


create table `categories`(
`id`int primary key auto_increment,
`category_name`varchar(39),
`notes`text
);


INSERT INTO `categories` (`category_name`)
VALUE
('Documentary'),
('Triler'),
('Criminal'),
('Love Story'),
('True Story');

create table `movies`(
`id`int primary key auto_increment,
`title`varchar(30) not null,
`director_id`int,
`copyright_year`int not null,
`length`int,
`genre_id`int,
`category_id`int,
`rating`float,
`notes`text
);

insert into `movies`
values
(1, 'Movie1', 3, 2010, 116, 1, 2, 4.5, 'text'),
(2, 'Movie2', 3, 2010, 116, 1, 2, 4.5, 'text'),
(3, 'Movie3', 3, 2010, 116, 1, 2, 4.5, 'text'),
(4, 'Movie4', 3, 2010, 116, 1, 2, 4.5, 'text'),
(5, 'Movie5', 3, 2010, 116, 1, 2, 4.5, 'text');

-- -- P12
create database `car_rental`;
use `car_rental`;

create table `categories`(
`id`int primary key auto_increment,
`category`varchar(30),
`daily_rate`float(5,2),
`weekly_rate`float(5,2),
`monthly_rate`float(5,2),
`weekend_rate`float(5,2)
);

insert into `categories`
values
(1,'Economy',1.3,4.5,7.7,2.3),
(2,'Buiseness',1.3,4.5,7.7,2.3),
(3,'Luxury',1.3,4.5,7.7,2.3);

create table `cars`(
`id` int primary key auto_increment,
`plate_number`varchar(30) not null,
`make`varchar(30)not null,
`model` varchar(30)not null,
`car_year`datetime not null,
`category_id`int not null,
`doors`int not null,
`picture`blob,
`car_condition`varchar(30),
`available`boolean
);

insert into `cars`
values
(1,'AB2034CH','MERCEDES','E','2022-12-11',1,4,NULL,'good',true),
(2,'AB2034lm','SKODA','OKTAVIA','2022-12-25',1,4,NULL,'bad',true),
(3,'AB2034CH','TOYOTA','CAMRY','2022-12-03',1,4,NULL,'excelent',false);

create table `employees`(
`id`int primary key auto_increment,
`first_name`varchar(30),
`last_name`varchar(30),
`title`varchar(30),
`notes`text
);
insert into `employees`
values
(1,'Elena','Yaneva','Engineer','text'),
(2,'Mona','Novak','Intern','text'),
(3,'David','Green','HR','text');

create table `customers`(
`id`int primary key auto_increment,
`driver_licence`varchar(30),
`full_name`varchar(30),
`address`varchar(30),
`city`varchar(30),
`zip_code`int not null,
`notes`text
);

insert into `customers`
values
(1,'vs432nk','Emil Ness','address39','Praga','11000','text'),
(2,'fss432nk','Dan Kozak','address49','Praga','11000','text'),
(3,'vs4sf43nk','Linda Niyl','address36','Praga','11000','text');

CREATE TABLE `rental_orders` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `car_id` INT NOT NULL,
    `car_condition` VARCHAR(30),
    `tank_level` INT NOT NULL,
    `kilometrage_start` FLOAT(5 , 2 ),
    `kilometrage_end` FLOAT(5 , 2 ),
    `total_kilometrage` FLOAT(5 , 2 ),
    `start_date` DATE,
    `end_date` DATE,
    `total_days` INT,
    `rate_applied` VARCHAR(20),
    `tax_rate` INT,
    `order_status` VARCHAR(50),
    `notes` TEXT
);

insert into `rental_orders`
values
(1,2,32,13,'excelent',60,123.32,421.32,298.43,'2021.12.21','2021.12.23',2,'rate',3,'order','text'),
(2,2,42,13,'excelent',56,123.32,421.32,298.43,'2021.12.21','2021.12.13',2,'rate',3,'order','text'),
(3,4,22,13,'excelent',65,123.32,421.32,298.43,'2021.11.11','2021.11.23',2,'rate',3,'order','text');
-- --  Basic Insert

CREATE DATABASE `soft_uni`;
USE `soft_uni`;
CREATE TABLE `towns`(
`id`INT PRIMARY KEY AUTO_INCREMENT,
`name`VARCHAR(30) NOT NULL
);

CREATE TABLE `addresses`(
`id`INT PRIMARY KEY auto_increment,
`address_text`varchar(100) not null,
`town_id` int not null,
constraint fk_addresses_towns
foreign key (`town_id`) references `towns`(`id`)
);

CREATE TABLE `departmens`(
	`id` int primary key auto_increment,
    `name` varchar(30) not null
);

CREATE TABLE `employees` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(30) NOT NULL,
    `middle_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `job_title` VARCHAR(20),
    `salary` DECIMAL(10 , 2 ),
    `department_id` INT,
    `hire_date` DATE,
    `address_id` INT
);
ALTER TABLE `employees`
    ADD CONSTRAINT fk_employees_address FOREIGN KEY (`address_id`)
        REFERENCES addresses (`id`);

ALTER TABLE `employees`
  ADD CONSTRAINT fk_employees_departments FOREIGN KEY (`department_id`)
        REFERENCES departments (`id`);
        

 INSERT INTO `towns`(`name`)
 VALUES
 ('Sofia'),
 ('Plovdiv'),
 ('Varna'),
 ('Burgaz');

  INSERT INTO `departments`(`name`)
  VALUES
  ('Engineering'),
  ('Sales'),
  ('Marketing'),
  ('Sofware'),
  ('Development'),
  ('Quality Assurance');
  
  INSERT  INTO `employees` (`first_name`,`middle_name`,`last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
   VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

-- 14. Basic Select All Fields 

SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

-- 15. Basic Select All Fields and Order Them

SELECT * FROM `towns`
ORDER BY `name`;

SELECT * FROM `departments`
ORDER BY `name`;

SELECT * FROM `employees`
ORDER BY `salary` DESC;

-- 16. Basic Select Some Fields

SELECT * FROM `towns`
ORDER BY `name`;

SELECT * FROM `departments`
ORDER BY `name`;

SELECT * FROM `employees`
ORDER BY `salary` DESC;

-- 17. Increase Employees Salary

UPDATE `employees`
SET `salary` = `salary` * 1.1;

SELECT * FROM `employees`
ORDER BY `salary` DESC;

-- 18. Delete All Records

DELETE FROM occupancies;