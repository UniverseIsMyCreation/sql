create table author(
    author_id int primary key auto_increment,
    name_author varchar(50)
);

insert into author (name_author) values ('Булгаков М.А.'),('Достоевский Ф.М.'),('Есенин С.А.'),('Пастернак Б.Л.');

create table book(
    book_id int primary key auto_increment,
    title varchar(50),
    author_id int not Null,
    genre_id int,
    price decimal(8,2),
    amount int,
    foreign key (author_id) references author (author_id),
    foreign key (genre_id) references genre (genre_id)
);

create table book(
    book_id int primary key auto_increment,
    title varchar(50),
    author_id int not Null,
    genre_id int,
    price decimal(8,2),
    amount int,
    foreign key (author_id) references author (author_id) on delete cascade,
    foreign key (genre_id) references genre (genre_id) on delete set Null
);

insert into book (title,author_id,genre_id,price,amount) 
values 
('Стихотворения и поэмы',3,2,650.00,15),
('Черный человек',3,2,570.20,6),
('Лирика',4,2,518.99,2);

///////////////////////////////////////////////////////////////////////////////////

CREATE TABLE author
    (
        author_id serial
            PRIMARY KEY,
        name_author VARCHAR(50)
    );

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.');

CREATE TABLE genre
    (
        genre_id serial
            PRIMARY KEY,
        name_genre varchar(30)
    );

INSERT INTO genre (name_genre)
VALUES ('Роман'),
       ('Поэзия'),
       ('Приключения');

CREATE TABLE book
    (
        book_id serial
            PRIMARY KEY,
        title VARCHAR(50),
        author_id INT,
        genre_id int,
        price DECIMAL(8, 2),
        amount INT,
        FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
        FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL
    );

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES ('Мастер и Маргарита', 1, 1, 670.99, 3),
       ('Белая гвардия ', 1, 1, 540.50, 5),
       ('Идиот', 2, 1, 460.00, 10),
       ('Братья Карамазовы', 2, 1, 799.01, 3),
       ('Игрок', 2, 1, 480.50, 10),
       ('Стихотворения и поэмы', 3, 2, 650.00, 15),
       ('Черный человек', 3, 2, 570.20, 6),
       ('Лирика', 4, 2, 518.99, 2);

select title, name_genre, price
from 
    genre inner join book
    on genre.genre_id = book.genre_id
where amount > 8
order by price desc;

select name_genre from genre
where name_genre not in
(
    select distinct name_genre from
    book inner join genre
    on book.genre_id = genre.genre_id
)

{
  select distinct name_genre from
  (
      select title,name_genre from
      book right join genre
      on book.genre_id = genre.genre_id
  ) as temp
where title is Null
}
;

select name_city, name_author, (DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY)) as Дата
from city cross join author
order by name_city asc, Дата desc;

select name_genre,title,name_author
from
    genre
    inner join book on book.genre_id = genre.genre_id
    inner join author on book.author_id = author.author_id
where genre.name_genre = 'Роман'
order by title asc;

select name_author,if(sum(amount) is Null,0,sum(amount)) as Количество
from
    book right join author on book.author_id = author.author_id
group by name_author
having Количество < 10 or sum(amount) is Null
order by Количество asc;

select name_author
from book inner join author on book.author_id = author.author_id
group by name_author
having max(genre_id) = min(genre_id);

select title,name_author,name_genre,price,amount
from
    genre
    inner join book on book.genre_id = genre.genre_id
    inner join author on book.author_id = author.author_id
where name_genre in (
    select name_genre from
    (
        select name_genre,count(title) 
        from 
            book inner join genre on book.genre_id = genre.genre_id
        group by name_genre
        order by 2 desc
        limit 2
    ) as temp
)
order by title asc;

select title as Название, name_author as Автор, sum(book.amount + supply.amount) as Количество
from 
    supply 
    inner join book using(price,title)
    inner join author on author.name_author = supply.author
group by author.name_author, book.title;
