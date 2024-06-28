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
	[DiscountPrice] DECIMAL,
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
	[DateOfBirth] DATETIME,
	[UserPhone] varCHAR(10),
	[UserIDCard] varCHAR(15),
	PRIMARY KEY([UserID])
);
GO

CREATE TABLE [Booking] (
	[BookingID] INT NOT NULL IDENTITY UNIQUE,
	[StartDate] DATETIME,
	[EndDate] DATETIME,
	[BookingStatus] NVARCHAR(255),
	[BookingPaid] DECIMAL,
	[BookingPrice] DECIMAL,
	[BookingDiscount] DECIMAL,
	[UserID] int references [User]([UserID]),
	[RoomID] int references [Room]([RoomID]),
	[BookingDate] DATETIME
	PRIMARY KEY([BookingID])
);
GO

CREATE TABLE [Order] (
	[OrderID] INT NOT NULL IDENTITY UNIQUE,
	[OrderDate] DATETIME,
	[OrderPrice] DECIMAL,
	[RoomID] INT,
	[UserID] INT,
	[BookingID] INT,
	PRIMARY KEY([OrderID])
);
GO

CREATE TABLE [Favorite] (
	[RoomID] int references [Room]([RoomID]),
	[UserID] int references [User]([UserID]),
	[Date] date,
	Primary key([RoomID], [UserID])
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
insert into [User] ([UserGmail], [UserPassword], [UserName], [DateOfBirth], [UserPhone], [UserIDCard]) values ('test@stumbleupon.com', 'Test2k3.', 'Janet Test', '2003-08-10', '3521854967', '4042373880');

insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Isoniazid', N'0452 Londonderry Drive', N'Yufa', '9592821236');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Enalapril Maleate', N'7827 Weeping Birch Road', N'Benito Juarez', '8857456362');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Erythromycin', N'9 Bobwhite Point', N'Perrelos', '1754865888');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Extra-Virt Plus DHA', N'6734 Mccormick Avenue', N'Brusartsi', '2605147325');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'LORTAB', N'31 Myrtle Avenue', N'Tyachiv', '3392599364');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Lipitor', N'39 Longview Lane', N'Choca do Mar', '4751967418');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Lisinopril', N'4 Wayridge Center', N'Sulęcin', '4773627628');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'CENTUSSIN DHC', N'963 Aberg Road', N'Benito Juarez', '2187029602');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Fenofibrate', N'6801 Fisk Point', N'Yantian', '7821634123');
insert into [Hotel] ([HotelName], [HotelAddress], [HotelCity], [HotelPhone]) values (N'Integrilin', N'88 Eliot Trail', N'Błędów', '7549067103');

insert into [Room] values (N'Thoáng mát sạch sẽ', 4, 250000, 250000, 'hotel.jpg', 1, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 6, 500000, 500000, 'hotel2.jpg', 1, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 7, 760000, 760000, 'hotel.jpg', 2, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 4, 220000, 220000, 'hotel2.jpg', 2, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 6, 250000, 250000, 'hotel.jpg', 3, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 8, 280000, 280000, 'hotel2.jpg', 3, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 4, 300000, 300000, 'hotel.jpg', 3, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 6, 350000, 350000, 'hotel.jpg', 4, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 8, 250000, 250000, 'hotel2.jpg', 4, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 4, 630000, 630000, 'hotel.jpg', 4, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 6, 120000, 120000, 'hotel.jpg', 4, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 8, 120000, 120000, 'hotel2.jpg', 5, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 2, 120000, 120000, 'hotel.jpg', 6, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 4, 160000, 160000, 'hotel.jpg', 7, 1);
insert into [Room] values (N'Thoáng mát sạch sẽ', 6, 180000, 180000, 'hotel2.jpg', 8, 1);

insert into [Favorite] values (1, 1, getdate())
insert into [Favorite] values (1, 2, getdate())
insert into [Favorite] values (1, 3, getdate())
insert into [Favorite] values (1, 4, getdate())
insert into [Favorite] values (2, 1, getdate())
insert into [Favorite] values (2, 2, getdate())
insert into [Favorite] values (3, 1, getdate())
insert into [Favorite] values (3, 2, getdate())
insert into [Favorite] values (3, 3, getdate())
insert into [Favorite] values (4, 5, getdate())
insert into [Favorite] values (4, 6, getdate())
insert into [Favorite] values (4, 7, getdate())
 
select * from room

SELECT h.HotelCity, h.HotelName, h.HotelAddress, h.HotelPhone,  r.roomId, r.roomDescription	, r.numberPeople, r.price, r.discountPrice, r.roomImage, r.hotelId, r.roomValid  
FROM Hotel h
inner join (select * from Room where Room.RoomId = 1) as r
on r.HotelId = h.HotelId

update Room
set DiscountPrice = 200000
where RoomID = 1

select * from Booking

Select * from [Favorite]

-- Lấy ra các phòng và lượt thích
SELECT 
    r.RoomID,
    r.RoomDescription,
    r.NumberPeople,
    r.Price,
    r.DiscountPrice,
    r.RoomImage,
    r.HotelID,
    r.RoomValid,
    COUNT(f.UserID) AS NumberOfLikes
FROM 
    Room r
LEFT JOIN 
    Favorite f ON r.RoomID = f.RoomID
GROUP BY 
    r.RoomID,
    r.RoomDescription,
    r.NumberPeople,
    r.Price,
    r.DiscountPrice,
    r.RoomImage,
    r.HotelID,
    r.RoomValid;

-- Mỗi hotel lấy ra một Room có nhiều lượt like nhất
WITH RankedRooms AS (
    SELECT 
        r.RoomID,
        r.HotelID,
        r.RoomDescription,
        r.NumberPeople,
        r.Price,
        r.DiscountPrice,
        r.RoomImage,
        r.RoomValid,
        COUNT(f.UserID) AS NumberOfLikes,
        ROW_NUMBER() OVER(PARTITION BY r.HotelID ORDER BY COUNT(f.UserID) DESC) AS RoomRank
    FROM 
        Room r
    LEFT JOIN 
        Favorite f ON r.RoomID = f.RoomID
    GROUP BY 
        r.RoomID,
        r.HotelID,
        r.RoomDescription,
        r.NumberPeople,
        r.Price,
        r.DiscountPrice,
        r.RoomImage,
        r.RoomValid
)
SELECT 
    RoomID,
    HotelID,
    RoomDescription,
    NumberPeople,
    Price,
    DiscountPrice,
    RoomImage,
    RoomValid,
    NumberOfLikes
FROM 
    RankedRooms
WHERE 
    RoomRank = 1;

select r.RoomID, h.HotelID, COUNT(f.RoomID)
from Room r, Favorite f, Hotel h
where r.RoomID = f.RoomID
and r.HotelID = h.HotelID
group by r.RoomID, h.HotelID, f.RoomID;

SELECT r.RoomID, h.HotelID, COUNT(f.RoomID) AS LikeCount
FROM Room r
LEFT JOIN Favorite f ON r.RoomID = f.RoomID
JOIN Hotel h ON r.HotelID = h.HotelID
GROUP BY r.RoomID, h.HotelID;

WITH RankedRooms AS (
    SELECT 
        r.RoomID,
    r.HotelID,
    r.RoomDescription,
    r.NumberPeople,
    r.Price,
    r.DiscountPrice,
    r.RoomImage,
    r.RoomValid,
        COUNT(f.RoomID) AS LikeCount,
        ROW_NUMBER() OVER(PARTITION BY r.HotelID ORDER BY COUNT(f.RoomID) DESC) AS Rank
    FROM Room r
    LEFT JOIN Favorite f ON r.RoomID = f.RoomID
    GROUP BY r.RoomID,
    r.HotelID,
    r.RoomDescription,
    r.NumberPeople,
    r.Price,
    r.DiscountPrice,
    r.RoomImage,
    r.RoomValid
)
SELECT RoomID,
    HotelID,
    RoomDescription,
    NumberPeople,
    Price,
    DiscountPrice,
    RoomImage,
    RoomValid, LikeCount
FROM RankedRooms
WHERE Rank = 1;