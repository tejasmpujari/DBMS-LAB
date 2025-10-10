create database insurance1;
use insurance1;
create table person(
driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
desc person;
create table car(
reg_num varchar(10),
model varchar(10),
year int,
primary key(reg_num)
);
desc car;
create table accident(
report_num int,
accident_date date,
location varchar(20),
primary key(report_num));
desc accident;
create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
desc owns;
create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc participated;
insert into person values('A01','Richard','Srinivas Nagar'),
('A02','Pradeep','Rajaji nagar'),
('A03','Smith','Ashok nagar'),
('A04','Venu','N R Colony'),
('A05','Jhon','Hanumanth nagar');
commit;
select * from person;
insert into car values('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095477','Toyota',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);
commit;
select *from car;
INSERT INTO accident (report_num, accident_date, location) VALUES
(11, '2003-01-01', 'mysore road'),
(12, '2004-02-02', 'South end Circle'),
(13, '2003-01-21', 'Bull temple Road'),
(14, '2008-02-17', 'mysore road'),
(15, '2005-03-04', 'Kanakpura Road');
commit;
select * from accident;
insert into owns values ('A01','KA052250'),
('A02','KA053408'),
('A03','KA031181'),
('A04','KA095477'),
('A05','KA041702');
commit;
select * from owns;
insert into participated values ('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095477',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);
commit;
select * from participated;

SELECT accident_date, location
FROM accident;

SELECT DISTINCT driver_id, name 
FROM person 
WHERE driver_id IN (
    SELECT driver_id 
    FROM participated 
    WHERE damage_amount >= 25000
);

SELECT name, reg_num
FROM person, owns
WHERE person.driver_id = owns.driver_id;

SELECT person.name, car.model
FROM person, owns, car
WHERE person.driver_id = owns.driver_id
AND owns.reg_num = car.reg_num;

SELECT accident.report_num, accident.accident_date, accident.location, person.name, participated.damage_amount
FROM accident, participated, person
WHERE accident.report_num = participated.report_num
AND participated.driver_id = person.driver_id;

SELECT report_num, SUM(damage_amount) AS total_damage
FROM participated
GROUP BY report_num;










