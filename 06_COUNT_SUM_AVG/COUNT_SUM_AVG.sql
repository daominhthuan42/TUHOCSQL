USE [NORTHWND]
GO
/*
AVG()	Returns the average value
COUNT()	Returns the number of rows
FIRST()	Returns the first value
LAST()	Returns the last value
MAX()	Returns the largest value
MIN()	Returns the smallest value
ROUND()	Rounds a numeric field to the number of decimals specified
SUM()	Returns the sum
*/

/*
string function

CHARINDEX	Searches an expression in a string expression and returns its starting position if found
CONCAT()	 
LEFT()	 
LEN() / LENGTH()	Returns the length of the value in a text field
LOWER() / LCASE()	Converts character data to lower case
LTRIM()	 
SUBSTRING() / MID()	Extract characters from a text field
PATINDEX()	 
REPLACE()	 
RIGHT()	 
RTRIM()	 
UPPER() / UCASE()	Converts character data to upper case
*/

-- HÃY ĐẾM SỐ LƯỢNG KHÁCH HÀNG TRONG BẢNG CUSTOMER
SELECT COUNT(*) AS [SO LUONG KHACH HANG] FROM dbo.Customers AS CU

-- TÍNH TỔNG SỐ TIỀN VẬN CHUYỂN (FREIGHT) CỦA TẤT CẢ ĐƠN HÀNG.
SELECT SUM(O.Freight) AS [TONG SO TIEN] FROM dbo.Orders AS O

-- TÍNH TRUNG BÌNH SỐ LƯỢNG ĐẶT HÀNG (QUANTITY) CỦA TẤT CẢ SẢN PHẨM TRONG BẢNG [ORDER DETAIL]
SELECT AVG(OD.Quantity) AS [AvgQUANTITY] FROM dbo.[Order Details] AS OD

-- ĐẾM SỐ LƯỢNG, TỔNG SỐ LƯỢNG HÀNG TỒN KHO VÀ TRUNG BÌNH CỦA CÁC SẢN PHẨM CÓ TRONG BẢNG PRODUCT.
SELECT COUNT(P.UnitsInStock - P.UnitsOnOrder) AS [SO LUONG], SUM(P.UnitsInStock - P.UnitsOnOrder) AS [TONG SO LUONG HANG TON KHO], AVG(P.UnitsInStock - P.UnitsOnOrder) AS [TRUNG BINH HANG TON KHO]
FROM dbo.Products AS P

-- HÃY ĐẾM SỐ LƯỢNG ĐƠN HÀNG TỪ BẢNG ORDER VỚI 2 CÁCH:
-- DÙNG DẦU *
-- DÙNG MÃ ĐƠN HÀNG.
SELECT COUNT(*) AS [SO LUONG DON HANG]
FROM dbo.Orders AS O

SELECT COUNT(O.OrderID) AS [COUNTODERID]
FROM dbo.Orders AS O

-- TỪ BẢNG [ORDER DETAILS] HÃY TÍNH TRUNG BÌNH CHO CỘT UNITPRICE VÀ TÌNH TỐNG CHO CỘT QUANTITY.
SELECT AVG(OD.UnitPrice) AS [AvgUnitprice], SUM(OD.Quantity) AS [SumQuantity] FROM dbo.[Order Details] AS OD
