-- Задача 1 создаем и заполняем таблицы

CREATE TABLE Status ( 
    id SERIAL primary key,
    name VARCHAR(255) not NULL
);

create table Destination (
	id SERIAL primary key,
	name varchar(255) not null,
	id_status INT,
	foreign key (id_status) references Status(id)
);

CREATE TABLE Tickets (
    id SERIAL primary key,
    id_destination INT,
    lowest_price DECIMAL(10, 2) not null,
    highest_price DECIMAL(10, 2) not null,
    foreign key (id_destination) references Destination(id)
); 

insert into Status (name)
values
	('Без визы'),
	('С визой'),
	('В ожидании визы');
	
insert into Destination (name, id_status)
values
	('Париж', 1),
	('Лондон', 2),
	('Рим', 1),
	('Нью-Йорк', 2),
	('Токио', 1);
	
insert into Tickets (id_destination, lowest_price, highest_price)
values
	(1, 200.00, 300.00),
	(2, 250.00, 350.00),
	(3, 180.00, 280.00),
	(4, 300.00, 400.00),
	(5, 220.00, 320.00);
	
-- Задача 1 Уникальные названия маршрутов (destionation.name), для которых существуют билеты (есть запись в tickets)

select distinct destination.name
from tickets
join destination on destination.id = tickets.id_destination 

-- Задача 1 Дополните предыдущий запрос: ограничьте маршруты статусом "Без визы", 1 вариант

select distinct destination.name 
from tickets
	join destination on destination.id = tickets.id_destination 
	join status on status.id = destination.id_status 
where
	status."name" = 'Без визы'
	
-- Задача 1 Дополните предыдущий запрос: ограничьте маршруты статусом "Без визы", 2 вариант
	
select
distinct destination.name 
from tickets join destination on destination.id = tickets.id_destination 
where
 destination.id_status = (select id from status where name = 'Без визы')
 
 -- Задача 1 Найдите маршруты, максимальная цена коорых выше общей средней. Общая средняя находится как среднее значение lowest_price и highest_price. Вывести название и высшую цену.
 
 select destination.name as destination_name, Tickets.highest_price 
 from tickets
 join destination on tickets.id_destination = destination.id 
 where
 	tickets.highest_price > (select AVG(lowest_price + highest_price)/ 2 from tickets)
