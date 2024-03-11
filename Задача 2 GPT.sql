-- Задача 2 создаем и заполняем таблицы

CREATE TABLE users ( 
    id_user serial primary key,
    user_name varchar(255) not null,
    user_surname varchar(255) not null,
    user_wigth decimal(10, 2) not null,
    age int not null
);

insert into users (id_user, user_name, user_surname, user_wigth, age)
values
	(1, 'Anna', 'Ivanov', 56.00, 18),
	(2, 'Igor', 'Bulik', 75.00, 45),
	(3, 'Max', 'Nikolsky', 67.00, 16),
	(5, 'Kate', 'Svet', 66.00, 30);
	
create table visits (
	id_visit serial primary key,
	id_user int not null,
	hours_spent decimal(2, 1) not null,
	class_name varchar(255) not null,
	date date not null
);
insert into visits(
	id_visit, id_user, hours_spent, class_name, date
)
values
	(1, 1, 1.0, 'Zumba', '2023-06-30'),
	(2, 3, 2.0, 'Swiming pool', '2023-07-04'),
	(3, 5, 1.0, 'Flex', '2023-07-09'),
	(4, 1, 3.0, 'Flex', '2023-07-15'),
	(5, 5, 2.0, 'Step', '2023-07-20'),
	(6, 2, 1.5, 'Football', '2023-07-22');
	
-- Задача 2 - Список уникальных классов. Вывести только название.

select distinct class_name
from visits;

-- Количество часов, проведенных на занятиях, ля каждого пользователя. Вывести фамилию, имя и количество часов.

select 
	users.user_surname,
	users.user_name,
	sum(hours_spent) as total_hours
from visits join users on users.id_user = visits.id_user
group by
	users.user_surname,
	users.user_name;
	
-- Средний возраст пользователей, посещающих класс Flex.

select avg(users.age) as avg_age
from visits join users on users.id_user = visits.id_user
where 
	class_name = 'Flex';