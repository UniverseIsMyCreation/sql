CREATE TABLE fine
    (
        fine_id serial
            PRIMARY KEY,
        name varchar(30),
        number_plate varchar(6),
        violation varchar(50),
        sum_fine decimal(8, 2),
        date_violation date,
        date_payment date
    );

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14 ', NULL),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL),
       ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', 500.00, '2020-01-12', '2020-01-17'),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', 1000.00, '2020-01-14', '2020-02-27'),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Превышение скорости(от 20 до 40)', 500.00, '2020-01-23', '2020-02-23'),
       ('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
       ('Колесов С.П.', 'К892АХ', 'Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL);

CREATE TABLE traffic_violation
    (
        violation_id serial
            PRIMARY KEY,
        violation varchar(50),
        sum_fine decimal(8, 2)
    );

INSERT INTO traffic_violation (violation, sum_fine)
VALUES ('Превышение скорости(от 20 до 40)', 500),
       ('Превышение скорости(от 40 до 60)', 1000),
       ('Проезд на запрещающий сигнал', 1000);

create table fine(
    fine_id int primary key auto_increment,
    name varchar(30),
    number_plate varchar(6),
    violation varchar(50),
    sum_fine decimal(8,2),
    date_violation date,
    date_payment date
);

insert into fine (name,number_plate,violation,sum_fine,date_violation,date_payment) 
values ('Баранов П.Е.','Р523ВТ','Превышение скорости(от 40 до 60)',Null,'2020-02-14',Null),
('Абрамова К.А.','О111АВ','Проезд на запрещающий сигнал',Null,'2020-02-23',Null),
('Яковлев Г.Р.','Т330ТТ','Проезд на запрещающий сигнал',Null,'2020-03-03',Null);

update fine f, traffic_violation tv
    set f.sum_fine = if(f.sum_fine is Null,
                        (select sum_fine from traffic_violation tv where tv.violation = f.violation),
                       f.sum_fine);

update fine f, traffic_violation tv
    set f.sum_fine = tv.sum_fine
where tv.violation = f.violation and f.sum_fine is Null;

select
    name,
    number_plate,
    violation
from fine
group by name,number_plate,violation
having count(*) > 1
order by name asc, number_plate asc, violation asc;

update fine f,
    (
        select
            name,
            number_plate,
            violation
        from fine
        group by name,number_plate,violation
        having count(*) > 1
        order by name asc, number_plate asc, violation asc
    ) as temp
set 
    f.sum_fine = f.sum_fine * 2
where 
    f.name = temp.name and
    f.sum_fine is not Null and
    f.number_plate = temp.number_plate and
    f.violation = temp.violation and 
    f.date_payment is Null;
    
update 
    fine f, payment p
set
    f.date_payment = p.date_payment,
    f.sum_fine = if(datediff(p.date_payment,p.date_violation) < 21,f.sum_fine/2,f.sum_fine)
where
    f.name = p.name and
    f.number_plate = p.number_plate and
    f.violation = p.violation and
    f.date_payment is Null;

create table back_payment as
select * from fine
where date_payment is Null;

alter table back_payment
drop column date_payment,
drop column fine_id;

delete from fine
where month(date_violation) < 2 and year(date_violation) < 2021;
