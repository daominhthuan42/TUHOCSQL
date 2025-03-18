USE NORTHWND
GO

-- HÃY LIỆT KÊ TẤT CẢ SẢN PHẨM CÓ SỐ LƯỢNG TRONG KHO (UnitslnStock) THUỘC KHOẢNG NHỎ HƠN 50 HOẶC LỚN HƠN 100.
-- SẮP XẾP TĂNG DẦN
SELECT * 
FROM dbo.Products AS P
WHERE P.UnitsInStock < 50 OR P.UnitsInStock > 100
ORDER BY P.UnitsInStock ASC

-- HÃY LIỆT KÊ TẤT CẢ ĐƠN HÀNG ĐƯỢC GIAO TỪ BRAZIL ĐÃ BỊ GIAO MUỘN, BIẾT RẰNG NGÀY CẦN GIAO HÀNG LÀ REQUIREDDATE, NGÀY GIAO HÀNG THỰC TẾ LÀ SHIPPEDDATE.
SELECT *
FROM dbo.Orders AS O
WHERE O.ShippedDate > O.RequiredDate AND O.ShipCountry = 'Brazil'

--	LẤY RA TẤT CẢ SẢN PHẦM CÓ GIÁ DƯỚI 100$ VÃ MÃ THỂ LOẠI KHÁC 1.
SELECT *
FROM dbo.Products AS P
WHERE P.UnitPrice < 100 AND P.CategoryID <> 1

-- DÙNG NOT
SELECT *
FROM dbo.Products AS P
WHERE NOT (P.UnitPrice >= 100 OR P.CategoryID = 1)

-- LIỆT KÊ CÁC ĐƠN HÀNG CÓ GIÁ VẬN CHUYỂN Freight TRONG KHOẢNG [50,100] ĐÔ LA.
SELECT *
FROM dbo.Orders AS O
WHERE O.Freight >= 50 AND O.Freight <= 100

-- LIỆT KÊ CÁC SẢN PHẨM CÓ SỐ LƯỢNG HÀNG TRONG KHO UnitslnStock LỚN HƠN 20 VÀ SỐ LƯỢNG HÀNG TRONG ĐƠN HÀNG UnitsOnOrder NHỎ HƠN 20.
SELECT * 
FROM dbo.Products AS P
WHERE P.UnitsInStock > 20 AND P.UnitsOnOrder < 20
