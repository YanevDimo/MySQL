
-- 01. Find Book Titles

select title from books
where substring(title,1,3) = 'The'
order by id;

-- 02. Replace Titles

select replace(`title`,'The','***') as 'Title'
from `books`
where substring(`title`,1,3) = 'The';

# ИЛИ
-- select insert(`title`,1,3,'***') as 'Title'
-- from `books`
-- where substring(`title`,1,3) = 'The';

-- 03. Sum Cost of All Books

select round(sum(`cost`),2)as 'Total Cost' 
from `books`;

-- 04. Days Lived

select concat(first_name,' ',last_name)AS 'NAME',
timestampdiff(DAY,born,died)as 'Days Lived'from authors;

     # Lived Years
select concat(first_name,' ',last_name)AS 'NAME',
timestampdiff(year,born,died)as 'Years Lived'from authors;

       # Lved till NOW
select concat(first_name,' ',last_name)AS 'NAME',
timestampdiff(year,born,ifnull(died,now()))as 'Actual Years'from authors;

select concat(first_name,' ',last_name)AS 'NAME',
date_format(born,'%b %D, %Y')as 'Born',
date_format(died,'%b %D, %Y')as'Died',
timestampdiff(year,born,ifnull(died,now()))as 'Actual Years'
from authors;

 
-- 05. Harry Potter Books
 
 select title from books
 where title like 'Harry Potter%';
