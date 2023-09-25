select name
from sys.tables


create database book
----------------------------

create table Author_Table
(Author_id int primary key,
Author_Name varchar(40),
Phone_No varchar(15),
Email varchar(50),
Address varchar(100),
City varchar(20)
)

insert into Author_Table(Author_id,Author_Name,Phone_No,City) values (101,'Chetan bhagat',9876543210,'Pune')--Making India Awesome
insert into Author_Table(Author_id,Author_Name,Phone_No,City) values (102,'A.P.J. Abdul Kalam',8876543123,'Delhi')--Ignited Minds 
insert into Author_Table(Author_id,Author_Name,Phone_No,City) values (103,'Romila Thapar',7076548596,'Mumbai')--History of India 	
insert into Author_Table(Author_id,Author_Name,Phone_No,City) values (104,'Sunil Gavaskar',9476547410,'Nashik')--idols
insert into Author_Table(Author_id,Author_Name,Phone_No,City) values (105,'Sharad Tandale',8547547410,'Ahemednagar')--Ravan
-------------=============================================================================----------------------------------------
create table Awards_Master_Table
(
Award_type_id int primary key,
Award_Name varchar(50),
Award_Price numeric(10,2)
)
insert into Awards_Master_Table values (10,'Yuva Award',50000)
insert into Awards_Master_Table values (20,'Padma Bhushan Award',65000)
insert into Awards_Master_Table values (30,'Nobel Award',80000)
insert into Awards_Master_Table values (40,'Padma shri Award',70000)
insert into Awards_Master_Table values (50,'Jananpith Award',78596)
--=================================================================================-----------
create table Books
(Book_id int primary key,
Book_Name varchar(25),
Author_id int,
constraint fk_Author_Table foreign key (Author_id) references Author_Table(Author_id),
Price numeric(10,2)
)
insert into Books values (1,'Making India Awesome',101,699)
insert into Books values (2,'Ignited Minds ',102,999)
insert into Books values (3,'History of India',103,799)
insert into Books values (4,'idols',104,899)
insert into Books values (5,'Ravan',105,599)
-----=================================================================================-------
create table Award_Table
(
Award_id int primary key,
Award_Type_id int,
constraint fk_Awards_Master_Table1 foreign key (Award_Type_id) references Awards_Master_Table(Award_Type_id),
Author_id int,
constraint fk_Author_Table1 foreign key (Author_id) references Author_Table(Author_id),
Book_id int,
constraint fk_Books1 foreign key (Book_id) references Books(Book_id),
Year int,
)
insert into Award_Table values (111,10,101,1,2019)
insert into Award_Table values (222,20,102,2,1999)
insert into Award_Table values (333,20,103,3,1990)
insert into Award_Table values (444,30,104,4,2012)
insert into Award_Table values (555,40,105,5,2015)
insert into Award_Table values (666,50,101,2,2000)
-----------------------------------------------------------------
sp_help Award_Table

Select* from Books
select * from Author_Table
select * from Award_Table
select * from Awards_Master_Table
----------------------------------------------------------------
--************************************************************--

--1)Find the book which is writter by 'sharad tandale'

select Book_Name from Books b inner join
Author_Table a on b.Author_id=a.Author_id
where Author_Name='Sharad tandale'

--2)Find authod name fro book 'idols'
select b.book_name,a.author_name from author_table a inner join
books b on a.Author_id=b.Author_id 
where b.book_name='idols'

--3)Find author name who got an award in 2015
select Author_Name from Author_Table a 
inner join Award_Table 
d on a.Author_id=d.author_id
where d.year=2015

--4)Find the Book Got an award
select b.book_name from books b
inner join Award_Table a 
on b.Book_id=a.Book_id

--5)Find out the author wise Book count
select Author_name from Author_Table a
inner join books b
on a.Author_id=b.Author_id
group by a.Author_Name

--6)Find author Name who got only one award -->1/2
select au.author_name, count(aw.award_id) as 'cnt' from Author_Table au
inner join Award_Table aw
on au.Author_id=aw.Author_id
group by au.author_name having count(aw.award_id)= 2

--7)Find the authorNmae who got oscar award
select author_name from Author_Table au
inner join Award_Table aw 
on au.Author_id=aw.Author_id
inner join Awards_Master_Table am 
on  aw.Award_type_id=am.Award_type_id
where am.Award_Name='Yuva Award'

--8)Find the author who got awardPrice more than 70000
select au.author_name,awm.Award_Price from Author_Table au
inner join Award_Table aw
on au.Author_id=aw.Author_id
inner join Awards_Master_Table awm
on aw.Award_type_id=awm.Award_type_id
where Award_Price > 70000


--9)Find the author who got max awards
select top 3 au.Author_Name,count(*) as'count'
from Author_Table au
join Award_Table aw
on au.Author_id=aw.Author_id
group by (au.Author_Name)
order by count(*) desc
