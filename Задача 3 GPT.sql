-- Создание таблицы
create table book (
	id_book INT primary key,
	title varchar(255) not null,
	id_author int not null,
	pages int not null,
	year_publish date not null
);

create table author (
	id_author int primary key,
	full_name varchar(255) not null,
	century int not null
);

-- Заполнение таблицы book
insert into book (id_book, title, id_author, pages, year_publish)
values
(1, 'Война и мир', 1, 1225, '1869-02-12'),
(2, 'Преступление и наказание', 3, 720, '1866-01-01'),
(3, 'Мастер и маргарита', 3, 720, '1967-03-03'),
(4, 'Лолита', 4, 368, '1955-09-01'),
(5, '1984', 5, 328, '1949-06-08'),
(6, 'Гарри Поттер и философский камень', 6, 320, '1997-06-26'),
(7, 'Гарри поттер и тайная комната', 6, 376, '1998-07-02'),
(8, 'Гарри Поттер и узник Азкабана', 6, 432, '1999-07-08'),
(9, 'Гарри Поттер и Кубок огня', 6, 636, '2000-07-08');

-- Заполнение таблицы author
insert into author (id_author, full_name, century)
values
(1, 'Лев Николачевич Толстой', 19),
(2, 'Федор Михайлович Достоевский', 19),
(3, 'Михаил Афанасьевич Булгаков', 20),
(4, 'Владимир Владимирович Набоков', 20),
(5, 'Джордж Оруэлл', 20),
(6, 'Джоан Роулинг', 20);

-- Уникальные навзания всех книг, опубликованных после 1990 года. Вывести только названия.

select distinct title
from book
where year_publish >= '1991-01-01';

-- или

select distinct title
from book
where to_char(year_publish, 'YYYY') > '1990';

-- Для каждого автора найти сумму напечатанных страниц. Вывести полное имя автора и сумму страниц.

select
	author.full_name,
	sum(book.pages) as total_pages
from book join author on author.id_author = book.id_author
group by author.full_name;

-- Подсчитать количество книг авторов каждого века. Вывести век и количество книг.

select author.century, count(book.id_book) as book_count
from author
join book on author.id_author = book.id_author
group by author.century;
