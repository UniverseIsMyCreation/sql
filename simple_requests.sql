create table book(
    book_id int primary key auto_increment,
    title varchar(50),
    author varchar(30),
    price decimal(8,2),
    amount int
)

insert into book(title,author,price,amount) values('Мастер и Маргарита','Булгаков М.А.',670.99,3);
insert into book(title,author,price,amount) values('Белая гвардия','Булгаков М.А.',540.50,5); 
insert into book(title,author,price,amount) values('Идиот','Достоевский Ф.М.',460.00,10);
insert into book(title,author,price,amount) values('Братья Карамазовы','Достоевский Ф.М.',799.01,2);

select * from book
select author,title,price from book
select title as Название,author as Автор from book
select title,amount,amount*1.65 as pack from book
select title,author,amount,round(price*0.7,2) as new_price from book

select author,title,
    if(author='Есенин С.А.',round(price*1.05,2),if(author='Булгаков М.А.',round(price*1.1,2),price)) as new_price
from book
select author, title, 
round(case author
    when "Булгаков М.А." then price * 1.1
    when "Есенин С.А." then price * 1.05
    else price end, 2) as new_price
from book

