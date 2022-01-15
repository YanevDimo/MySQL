-- 01. Employees with Salary Above 35000

delimiter $$
create procedure usp_get_employees_salary_above_35000 ()
begin
select first_name,last_name from employees
where salary > 35000
order by first_name,employee_id;
end $$
delimiter ;

call  usp_get_employees_salary_above_35000();

-- 02. Employees with Salary Above Number

	delimiter $$ 
    create procedure usp_get_employees_salary_above(salary_level decimal (19,4))
    begin
     select first_name,last_name from employees
    where salary >= salary_level 
    order by first_name,last_name,employee_id;
    end $$
  delimiter ;
   
   call  ups_get_employees_salary_above(45000);
    

-- 03. Town Names Starting With

delimiter $$
create procedure usp_get_towns_starting_with(start_str varchar(30))
begin
select `name` from towns
where `name` like concat(start_str, '%')
order by `name`;
end $$
delimiter ;
call  usp_get_towns_starting_with('b');



-- 04. Employees from Town

delimiter $$
create procedure usp_get_employees_from_town(town_name varchar(50))
begin
select e.first_name,e.last_name from towns as t
join addresses a on t.town_id = a.town_id
join employees e on e.address_id = a.address_id
where t.name = town_name
order by e.first_name,e.last_name,e.employee_id;
end $$
delimiter ;
call usp_get_employees_from_town('Sofia')

-- 05. Salary Level Function-- 

delimiter $$
create function ufn_get_salary_level(salary decimal)
returns varchar(10)
deterministic
begin
return(case
when salary < 30000 then 'Low'
when salary between 30000 and 50000 then 'Average'
when salary > 50000 then 'High'
end 
);
end $$
delimiter ;
SELECT ufn_get_salary_level(salary);

-- 06. Employees by Salary Level

delimiter $$
create procedure usp_get_employees_by_salary_level(s_level varchar(10))
begin
select first_name,last_name from employees
where ufn_get_salary_level(salary) = s_level
order by first_name desc,last_name desc;

end $$
call usp_get_employees_by_salary_level('High')

-- 07. Define Function

delimiter $$
create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
returns bit
deterministic
begin 
return (select word REGEXP(concat('^[',set_of_letters,']+$')));
end $$
select ufn_is_word_comprised('oistmiahf','asdsdeefs')
delimiter ;

-- 08. Find Full Name

delimiter $$
create procedure usp_get_holders_full_name()
begin
select concat_ws(' ',first_name,last_name )as full_name from account_holders
order by  full_name ,id;
end $$
delimiter ;
 
-- 9. People with Balance Higher Than (not included in final score)

delimiter $$
create procedure usp_get_holders_with_balance_higher_than(balance_higher_than decimal(19,4))
begin
select ah.first_name,ah.last_name from account_holders as ah 

join (select * from accounts a group by a.account_holder_id having sum(balance) > balance_higher_than)as a
on a.account_holder_id = ah.id
order by account_holder_id;
end $$

call usp_get_holders_with_balance_higher_than(7000)
delimiter;

-- 10. Future Value Function

delimiter $$
create function ufn_calculate_future_value(sum decimal(19,4),interest double,years int)
returns decimal (19,4)
deterministic
begin
return sum * pow(1 + interest, years);
end $$
delimiter ;

select ufn_calculate_future_value(1000,0.5,5);

-- 11. Calculating Interest

delimiter $$
create procedure usp_calculate_future_value_for_account(acc_id int,interest double)
begin
select a.id,ah.first_name,ah.last_name,a.balance ,ufn_calculate_future_value(a.balance,0.1,5)
from accounts as a
join account_holders as ah
on a.account_holder_id = ah.id
where a.id = acc_id; 
end $$
delimiter ;

call usp_calculate_future_value_for_account(1,0.1

-- 12. Deposit Money

delimiter $$ 
create procedure usp_deposit_money(account_id int, money_amount decimal (19,4))
begin
 start transaction;
 if(select count(*)from accounts where id = account_id)= 0
 or(money_amount <= 0) then rollback;
else
 update accounts 
 set balance = balance +money_amount
 where id = account_id;
end if;
end $$
delimiter ;
call usp_deposit_money(1,10);

-- 13. Withdraw Money

delimiter $$ 
create procedure usp_withdraw_money(account_id int, money_amount decimal (19,4))
begin
 start transaction;
 if(select count(*)from accounts where id = account_id)= 0
 or(money_amount <= 0)  
 or(select balance from accounts where id = account_id) >= money_amount  
 then rollback;
else
 update accounts 
 set balance = balance - money_amount
 where id = account_id;
end if;
end $$
delimiter ;
call usp_deposit_money(1,1);

-- 14. Money Transfer

delimiter $$
CREATE PROCEDURE `usp_transfer_money`(`from_account_id` INT,`to_account_id` INT, `amount`DECIMAl(19,4)) 
BEGIN
	START TRANSACTION;
		IF((SELECT COUNT(*) FROM `accounts` WHERE `id` = `from_account_id`) = 0
			OR (SELECT COUNT(*) FROM `accounts` WHERE `id` = `to_account_id`) = 0
            OR `amount` <= 0
            OR (SELECT `balance` FROM `accounts` WHERE `id`= `from_account_id`) <= `amount`)
             THEN ROLLBACK;
		ELSE 
			UPDATE `accounts`
            SET `balance` = `balance` - `amount`
            WHERE `id` = `from_account_id`;
            UPDATE `accounts`
            SET `balance` = `balance` + `amount`
            WHERE `id`= `to_account_id`;
		END IF;
END &&
delimiter ;

-- 15. Log Accounts Trigger (not included in final score)

create table `logs`(log_id int primary key auto_increment, account_id int, old_sum decimal(19,4), new_sum decimal(19,4))	
;
delimiter $$
create trigger tr_update_account
after update
on accounts
for each row
begin
insert into `logs`(account_id,old_sum,new_sum)
values (old.id, old.balance, new.balance);
end $$

delimiter;

-- 	16. Emails Trigger (not included in final score)

create table notification_emails(
id int primary key auto_increment,
recipient int,
`subject` varchar (150),
body varchar (150)
 ); 
 
 delimiter $$
 
 create trigger tr_notification
 after update
 on `logs`
 for each row
	begin
		insert into `notification_emails`(`recipient`, `subject`, `body`)
        value (new.`account_id`,
        CONCAT('Balance change for account: ', new.`account_id`),
        CONCAT('On', DATE_FORMAT(NOW(), '%b %d %Y %r'),' your balance was changed from ',
        ROUND(new.old_sum, 2), ' to ', ROUND(new.new_sum, 2), '.'));
    end $$
    delimiter ;
   