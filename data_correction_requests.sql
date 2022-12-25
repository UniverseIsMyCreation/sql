create table supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title varchar(50),
    author varchar(30),
    price decimal(8,2),
    amount int
);

insert into supply (title,author,price,amount) values
('Лирика','Пастернак Б.Л.',518.99,2),
('Черный человек','Есенин С.А.',570.20,6),
('Белая гвардия','Булгаков М.А.',540.50,7),
('Идиот','Достоевский Ф.М.',360.80,3);

insert into book (title,author,price,amount)
select title,author,price,amount from supply
where author not in ('Булгаков М.А.','Достоевский Ф.М.');

insert into book (title,author,price,amount)
select title,author,price,amount from supply
where author not in (
    select author from book
);

update book
set price=0.9*price
where amount between 5 and 10;

update book
set price = round(if(buy=0,price*0.9,price),2),buy = if(buy>amount,amount,buy);

update book,supply
set book.amount=book.amount+supply.amount,book.price=round((book.price+supply.price)/2,2)
where book.title = supply.title;

delete from supply 
where author in (
    select
        author
    from book
    group by author
    having sum(amount) > 10
);

create table ordering as
select
    author,
    title,
    (
        select
            round(avg(amount),2)
        from book
    ) as amount
from book
where amount < (
    select
        round(avg(amount),2)
    from book
);
