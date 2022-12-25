select
    author,
    title,
    price
from book
where price <= (
    select
        avg(price)
    from book
)
order by price desc

select
    author,
    title,
    price
from book
where price - (select min(price) from book) <= 150
order by price asc

select
    author,
    title,
    amount
from book
where amount in (
    select amount
    from book
    group by amount
    having count(title) = 1
)

select
    author,
    title,
    price
from book
where price < any(
    select
        min(price) as price
    from book
    group by author
)

select 
    title,
    author,
    amount,
    (
        select
            max(amount)
        from book
    )-amount as Заказ
from book
where amount <> any(
    select max(amount)
    from book
)
