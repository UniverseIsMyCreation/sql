select distinct amount from book

select 
    author as Автор,
    count(distinct title) as Различных_книг, 
    sum(amount) as Количество_экземпляров
from book 
group by Автор

select 
    author,
    min(price) as Минимальная_цена,
    max(price) as Максимальная_цена,
    avg(price) as Средняя_цена
from book
group by author

select
    author,
    round(sum(price*amount),2) as Стоимость,
    round(sum(price*amount)*0.18/1.18,2) as НДС,
    round(sum(price*amount)/1.18,2) as Стоимость_без_НДС
from book
group by author

select 
    round(min(price),2) as Минимальная_цена,
    round(max(price),2) as Максимальная_цена,
    round(avg(price),2) as Средняя_цена
from book

select 
    round(avg(price),2) as Средняя_цена,
    sum(price*amount) as Стоимость
from book
where amount between 5 and 14

select
    author,
    sum(price*amount) as Стоимость
from book
where title not in ('Идиот','Белая гвардия')
group by author
having sum(price*amount) > 5000
order by Стоимость desc

select
    author,
    count(distinct title) as Количество_произведений,
    min(price) as Минимальная_цена,
    sum(amount) as Число_книг
from book
where price>500 and amount>1
group by author
having count(distinct title)>=2

