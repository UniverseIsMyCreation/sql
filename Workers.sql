create table trip
(
    trip_id INT PRIMARY KEY Identity(1,1),
    [name] varchar(30),
    city varchar(25),
    per_diem decimal(8,2),
    date_first date,
    date_last date
)

insert into trip ([name],city,per_diem,date_first,date_last) 
values
('Баранов П.Е.','Москва',700 , '2020-01-12', '2020-01-17'),
('Абрамова К.А.','Владивосток',450 , '2020-01-14', '2020-01-27'),
('Семенов И.В.','Москва',700 , '2020-01-23', '2020-01-31'),
('Ильиных Г.Р.','Владивосток', 450, '2020-01-12', '2020-02-02'),
('Колесов С.П.','Москва',700 , '2020-02-01', '2020-02-06'),
('Баранов П.Е.','Москва', 700, '2020-02-14', '2020-02-22'),
('Абрамова К.А.','Москва', 700, '2020-02-23', '2020-03-01'),
('Лебедев Т.К.','Москва', 700, '2020-03-03', '2020-03-06'),
('Колесов С.П.','Новосибирск',450 , '2020-02-27', '2020-03-12'),
('Семенов И.В.','Санкт-Петербург',700 , '2020-03-29', '2020-04-05'),
('Абрамова К.А.','Москва',700 , '2020-04-06', '2020-04-14'),
('Баранов П.Е.','Новосибирск',450 , '2020-04-18', '2020-05-04'),
('Лебедев Т.К.','Томск',450 , '2020-05-20', '2020-05-31'),
('Семенов И.В.','Санкт-Петербург',700 , '2020-06-01', '2020-06-03'),
('Абрамова К.А.','Санкт-Петербург', 700, '2020-05-28', '2020-06-04'),
('Федорова А.Ю.','Новосибирск',450 , '2020-05-25', '2020-06-04'),
('Колесов С.П.','Новосибирск', 450, '2020-06-03', '2020-06-12'),
('Федорова А.Ю.','Томск', 450, '2020-06-20', '2020-06-26'),
('Абрамова К.А.','Владивосток', 450, '2020-07-02', '2020-07-13'),
('Баранов П.Е.','Воронеж', 450, '2020-07-19', '2020-07-25');

select
     name,
     city,
     per_diem,
     date_first,
     date_last
from trip
where name like '%а %'
order by date_last desc;

select
    distinct name 
from trip
where city = 'Москва'
order by name asc;

select 
     city,
     count(name) as Количество
from trip
group by city
order by city asc;

select 
     city,
     count(name) as Количество
from trip
group by city
order by Количество desc
limit 2;

select
    name,
    city,
    datediff(date_last, date_first) + 1 as Длительность
from trip
where city not in (
    select
        distinct city
    from trip
    where city = 'Москва' or
    city = 'Санкт-Петербург'
)
order by Длительность desc, city desc;

select
    name,
    city,
    date_first,
    date_last
from trip
where datediff(date_last, date_first) = (
    select
        min(datediff(date_last, date_first))
    from trip
);

select 
    name,
    city,
    date_first,
    date_last
from trip
where month(date_first) = month(date_last)
order by city asc, name asc;

select
    monthname(date_first) as Месяц,
    count(date_first) as Количество
from trip
group by Месяц
order by Количество desc, Месяц asc;

select
    name,
    city,
    date_first,
    round(per_diem * (datediff(date_last, date_first) + 1),2) as Сумма
from trip
where month(date_first) in (2, 3) and year(date_first) = 2020
order by name asc, Сумма desc;

select
    name,
    round(sum(per_diem * (datediff(date_last, date_first) + 1)),2) as Сумма
from trip
group by name
having count(date_first) > 3
order by Сумма desc;
