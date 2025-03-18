USE NORTHWND
GO

/*
SELECT tên cột
FROM tên bảng
WHERE tên cột IN (giá trị 1, giá trị 2,…);
*/

-- LIỆT KÊ TẤT CẢ ĐƠN HÀNG VỚI ĐIỀU KIỆN:
-- ĐƠN HÀNG ĐƯỢC GIAO ĐẾN GERMANY, UK, BRAZIL.
SELECT O.OrderID, O.ShipCountry
FROM dbo.Orders AS O
WHERE O.ShipCountry IN ('Germany', 'Brazil', 'UK')

-- DÙNG OR
SELECT O.OrderID, O.ShipCountry
FROM dbo.Orders AS O
WHERE O.ShipCountry = 'Germany' OR O.ShipCountry = 'Brazil' OR O.ShipCountry = 'UK'

-- ĐƠN HÀNG ĐƯỢC GIAO ĐẾN CÁC QUỐC GIA KHÁC GERMANY, UK, BRAZIL.
SELECT O.OrderID, O.ShipCountry
FROM dbo.Orders AS O
WHERE O.ShipCountry NOT IN ('Germany', 'Brazil', 'UK')

-- DÙNG OR
SELECT O.OrderID, O.ShipCountry
FROM dbo.Orders AS O
WHERE O.ShipCountry <> 'Germany' OR O.ShipCountry <> 'Brazil' OR O.ShipCountry <> 'UK'

-- LẤY RA CÁC MÃ SẢN PHẨM CÓ MÃ THỂ LOẠI KHÁC VỚI 2, 3 AND 4.
SELECT PR.ProductID, PR.CategoryID
FROM dbo.Products AS PR
WHERE PR.CategoryID NOT IN (2, 3, 4)

-- LIỆT KÊ NHÂN VIÊN KHÔNG PHẢI LÀ NỮ TỪ BẢNG NHÂN VIÊN.
SELECT *
FROM dbo.Employees AS EM
WHERE EM.TitleOfCourtesy IN ('Dr.', 'Mr.')
-- LIỆT KÊ CÁC NHÂN VIÊN LÀ NỮ TỪ BẢNG NHÂN VIÊN.
SELECT *
FROM dbo.Employees AS EM
WHERE EM.TitleOfCourtesy NOT IN ('Dr.', 'Mr.')

-- HÃY LẤY RA TẤT CẢ KHÁCH HÀNG ĐẾN TỪ Berlin, London, Warszawa.
SELECT *
FROM dbo.Customers AS CU
WHERE CU.City IN ('Berlin', 'London', 'Warszawa')

--Thử thách:
--1) Liệt kê DS các đơn hàng được vận chuyển trong khoảng thời gian từ 1996-07-07 đến 1996-07-31 và được vận chuyển bằng tàu thủy (ShipVia = 3) 
SELECT O.OrderID, O.ShippedDate, O.ShipVia
FROM dbo.Orders AS O
WHERE O.ShippedDate BETWEEN '1996-07-07' AND '1996-07-31'
AND O.ShipVia = 3 -- KO CẦN DÙNG IN
--2) LKDS các ĐH được vận chuyển đến các thành phố Genève, Lyon, Oulu
SELECT O.OrderID, O.ShipCity
FROM dbo.Orders AS O
WHERE O.ShipCity IN ('Genève', 'Lyon', 'Oulu')
