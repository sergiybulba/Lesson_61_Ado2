--Task_2------------------------------------------------------------------------------

create database Market;

use Market;


create table Sellers (
	ID int identity (1, 1) not null primary key,
	Name nvarchar (50) not null check (Name !=''),		
	Surname nvarchar (50) not null check (Surname !=''),
);

create table Buyers (
	ID int identity (1, 1) not null primary key,
	Name nvarchar (50) not null check (Name !=''),		
	Surname nvarchar (50) not null check (Surname !=''),
);

create table Sales (
	ID int identity (1, 1) not null primary key,
    SellerID int not null foreign key references Sellers(ID),
    BuyerID int not null foreign key references Buyers(ID),
	Summ int not null,
	Data date not null,
);



--drop database Market;
--drop table Sales;

--Sellers------------------------------------------------------------------------------------
insert into Sellers (Name, Surname) values ('Joe', 'Baiden');
insert into Sellers (Name, Surname) values ('Donald', 'Trump');
insert into Sellers (Name, Surname) values ('Barak', 'Obama');
insert into Sellers (Name, Surname) values ('George', 'Bush');
insert into Sellers (Name, Surname) values ('Bill', 'Clinton');
insert into Sellers (Name, Surname) values ('Ronald', 'Reagan');
insert into Sellers (Name, Surname) values ('Jimmy', 'Carter');

--Buyers------------------------------------------------------------------------------------
insert into Buyers (Name, Surname) values ('Volodymyr', 'Zelenskyi');
insert into Buyers (Name, Surname) values ('Petro', 'Poroshenko');
insert into Buyers (Name, Surname) values ('Victor', 'Yushchenko');
insert into Buyers (Name, Surname) values ('Leonid', 'Kuchma');
insert into Buyers (Name, Surname) values ('Leonid', 'Kravchuk');
insert into Buyers (Name, Surname) values ('Leonid', 'Brezhnev');
insert into Buyers (Name, Surname) values ('Mykyta', 'Hrushchov');

--Sales------------------------------------------------------------------------------------
insert into Sales (SellerID, BuyerID, Summ, Data) values (1, 7, 1250, '07-10-2023');
insert into Sales (SellerID, BuyerID, Summ, Data) values (2, 6, 1100, '10-10-2023');
insert into Sales (SellerID, BuyerID, Summ, Data) values (3, 5, 1400, '08-10-2023');
insert into Sales (SellerID, BuyerID, Summ, Data) values (4, 4, 1050, '11-10-2023');
insert into Sales (SellerID, BuyerID, Summ, Data) values (5, 3, 1300, '12-10-2023');
insert into Sales (SellerID, BuyerID, Summ, Data) values (6, 2, 1200, '09-10-2023');
insert into Sales (SellerID, BuyerID, Summ, Data) values (7, 1, 1150, '13-10-2023');

------------------------------------------------------------------------------------

select (Sellers.Name + ' ' + Sellers.Surname) as Seller_name, 
	   (Buyers.Name + ' ' + Buyers.Surname) as Buyer_name, 
	   Sales.Summ, 
	   Sales.Data
from Sales inner join Sellers on Sellers.ID = Sales.SellerID
		   inner join Buyers on Buyers.ID = Sales.BuyerID;

