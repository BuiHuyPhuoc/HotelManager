use master
go

if exists (select* from sysdatabases where name = 'DB_BookingHotel')
	drop database DB_BookingHotel
go

create database DB_BookingHotel
go

use DB_BookingHotel
go

CREATE TABLE [Hotel] (
	[HotelID] INT NOT NULL IDENTITY UNIQUE,
	[HotelName] TEXT,
	[HotelAddress] NVARCHAR(255),
	[HotelCity] NVARCHAR(255),
	[HotelPhone] varCHAR(10),
	PRIMARY KEY([HotelID])
);
GO

CREATE TABLE [Room] (
	[RoomID] INT NOT NULL IDENTITY UNIQUE,
	[RoomDescription] NVARCHAR(255),
	[NumberPeople] SMALLINT,
	[Price] DECIMAL,
	[RoomImage] NVARCHAR(255),
	[HotelID] INT,
	[RoomValid] BIT,
	PRIMARY KEY([RoomID])
);
GO

CREATE TABLE [User] (
	[UserID] INT NOT NULL IDENTITY UNIQUE,
	[UserGmail] varCHAR(100),
	[UserPassword] varCHAR(100),
	[UserName] NVARCHAR(100),
	[DateOfBirth] DATE,
	[UserPhone] varCHAR(10),
	[UserIDCard] varCHAR(15),
	PRIMARY KEY([UserID])
);
GO

CREATE TABLE [Booking] (
	[BookingID] INT NOT NULL IDENTITY UNIQUE,
	[StartDate] DATE,
	[EndDate] DATE,
	[BookingStatus] NVARCHAR(255),
	[BookingPaid] DECIMAL,
	[BookingPrice] DECIMAL,
	PRIMARY KEY([BookingID])
);
GO

CREATE TABLE [Order] (
	[OrderID] INT NOT NULL IDENTITY UNIQUE,
	[OrderDate] DATE,
	[OrderPrice] DECIMAL,
	[RoomID] INT,
	[UserID] INT,
	[BookingID] INT,
	PRIMARY KEY([OrderID])
);
GO

insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('lgarnam0@hao123.com', '12345', 'Layton Garnam', '2024-05-31', '2539509557', '4041378208');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('pcounter1@reverbnation.com', '12345', 'Prissie Counter', '2023-07-29', '3458218615', '4017956125');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('jfounds2@prnewswire.com', '12345', 'Jeanette Founds', '2024-01-19', '5696515310', '4041376931');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('sgodmer3@msn.com', '12345', 'Sonya Godmer', '2024-05-19', '9318898239', '4041371976');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('rmacginlay4@amazonaws.com', '12345', 'Riobard MacGinlay', '2023-07-22', '2341779554', '4017956572');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('cscane5@foxnews.com', '12345', 'Cristiano Scane', '2023-12-07', '7027396922', '4017959797');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('dhaddy6@wisc.edu', '12345', 'Dal Haddy', '2024-01-22', '6015154968', '4041376882');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('gknatt7@cam.ac.uk', '12345', 'Gloria Knatt', '2023-10-04', '3661940507', '4041371800');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('cdendle8@japanpost.jp', '12345', 'Clarette Dendle', '2024-03-13', '5432004346', '4017957548');
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('jbinny9@stumbleupon.com', '12345', 'Janet Binny', '2023-08-10', '3521854977', '4041373880');

insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Isoniazid', '0452 Londonderry Drive', 'Yufa', '9592821236');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Enalapril Maleate', '7827 Weeping Birch Road', 'Benito Juarez', '8857456362');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Erythromycin', '9 Bobwhite Point', 'Perrelos', '1754865888');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Extra-Virt Plus DHA', '6734 Mccormick Avenue', 'Brusartsi', '2605147325');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('LORTAB', '31 Myrtle Avenue', 'Tyachiv', '3392599364');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Lipitor', '39 Longview Lane', 'Choca do Mar', '4751967418');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Lisinopril', '4 Wayridge Center', 'Sulęcin', '4773627628');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('CENTUSSIN DHC', '963 Aberg Road', 'Benito Juarez', '2187029602');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Fenofibrate', '6801 Fisk Point', 'Yantian', '7821634123');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values ('Integrilin', '88 Eliot Trail', 'Błędów', '7549067103');

insert into [Room]