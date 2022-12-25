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

select author,title,price from book where amount<10

select title,author,price,amount from book
where price*amount>=5000 and (price<=500 or price >= 600)

select title,author from book
where price between 540.50 and 800 and amount in (2,3,5,7)

select author,title from book
where amount between 2 and 14
order by author desc,title asc

select title,author from book 
where author like '%С.%'
and title like '_% _%'
order by title asc

select 'Донцова Дарья' as author,
concat('Евлампия романова и ',title) as title,
round(price*1.42,2) as price
from book
order by price desc, title desc

select 
    author,title, 
    price as real_price,
    amount,
    round(if(price*amount>5000,price*1.2,price*0.8),2) as new_price,
    case
        when price<500 then 99.99
        when amount<5 then 149.99
        else 0.00
    end as delivery_price
from book 
where author in ('Булгаков М.А.','Есенин С.А.') and
amount between 3 and 14
order by author asc,title desc,delivery_price asc
