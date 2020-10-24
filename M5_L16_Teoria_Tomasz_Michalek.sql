--1
drop schema if exists dml_exercises;
create schema dml_exercises;

--2
drop table if exists dml_exercises.sales;

create table dml_exercises.sales
(
   id           serial primary key,
   sales_date   timestamp not null,
   sales_amount numeric(38,2),
   sales_qty    numeric(10,2),
   added_by     text default 'admin',
   constraint sales_less check(sales_amount<=1000)
);

--3
insert into dml_exercises.sales (sales_date,sales_amount,sales_qty,added_by) 
values
    (now(), 1134.44, 242.78, default),
    (now(), 523.44, 300.78, 'user3'),
    (now(), 125.44, 600.78, default),
    (now(), 34.44, 20.78, 'user1');

--4
INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
VALUES ('20/11/2019', 101, 50, NULL);
-- Po wykonaniu insertu -00:00:00

--5
INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
VALUES ('04/04/2020', 101, 50, NULL);
--uzyje polecenia (ponizej), wynik DMY
show datestyle;

--6
INSERT INTO dml_exercises.sales (sales_date, sales_amount, sales_qty,added_by)
SELECT NOW() + (random() * (interval '90 days')) + '30 days',
random() * 500 + 1,
random() * 100 + 1,
NULL
FROM generate_series(1, 20000) s(i);

--7
update dml_exercises.sales set added_by ='sales_over_200' where sales_amount >=200;

--8
delete from dml_exercises.sales where added_by is null;
--przy warunku =null wierszy nie usunieto poniewaz null nie jest wartoscia operator = w tym wypadku nie zadziala

--9
TRUNCATE dml_exercises.sales RESTART IDENTITY;

--10
INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
VALUES ('20/11/2019', 101, 50, NULL);


drop table dml_exercises.sales;
--kopie schematu i tabeli wykonane w IDE


