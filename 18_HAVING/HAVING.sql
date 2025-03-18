USE NORTHWND
GO

/*
https://quantrimang.com/hoc/menh-de-having-trong-sql-server-147839
SELECT column_name(s)
FROM Table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s)
*/

-- HÃY CHO BIẾT NHỮNG KHÁCH HÀNG NÀO ĐẶT NHIỀU HƠN 20 ĐƠN HÀNG, SẮP XẾP THEO THỨ TỰ TỔNG SỐ ĐƠN HÀNG GIẢM DẦN.
SELECT O.CustomerID, COUNT(O.OrderID) AS [TotalOrder]
FROM dbo.Orders AS O
GROUP BY O.CustomerID
HAVING COUNT(O.OrderID) >= 20
ORDER BY COUNT(O.OrderID) DESC

-- HÃY LỌC RA NHỮNG NHÀ CUNG CẤP SẢN PHẨM CÓ TỔNG SỐ LƯỢNG HÀNG TRONG KHO (UnitslnStock) LỚN HƠN 30 VÀ 
-- CÓ TRUNG BÌNH ĐƠN GIÁ (UnitPrice) CÓ GIÁ TRỊ DƯỚI 50.
SELECT PR.SupplierID,
       SUM(PR.UnitsInStock) AS [TotalUnitslnStock],
	   AVG(PR.UnitPrice) AS [AvgUnitPrice]
FROM dbo.Products AS PR
GROUP BY PR.SupplierID
HAVING SUM(PR.UnitsInStock) > 30 AND AVG(PR.UnitPrice) < 50

-- HÃY CHO BIẾT TỔNG SỐ TIỀN VẬN CHUYỂN CỦA TỪNG THÁNG,
-- TRONG NỬA NĂM SAU CỦA NĂM 1996, SẮP XẾP THEO THÁNG TĂNG DẦN
-- TỔNG TIỀN VẬN CHUYỂN > 1000
SELECT SUM(O.Freight) AS [TotalFreight],
       MONTH(O.ShippedDate) AS [MONTH]
FROM dbo.Orders AS O
WHERE O.ShippedDate BETWEEN '1996-07-01' AND '1996-12-31'
GROUP BY MONTH(O.ShippedDate)
HAVING SUM(O.Freight) > 1000
ORDER BY MONTH(O.ShippedDate) ASC

-- HÃY LỌC RA NHỮNG THÀNH PHỐ CÓ SỐ LƯỢNG ĐƠN HÀNG > 16 VÀ SẮP XẾP THEO TỔNG SỐ LƯỢN GIẢM DẦN.
SELECT O.ShipCountry,
       COUNT(O.OrderID) AS [TotalOrders]
FROM dbo.Orders AS O
-- WHERE 
GROUP BY O.ShipCountry
HAVING COUNT(O.OrderID) > 16
ORDER BY COUNT(O.OrderID) DESC

-- Thử thách 1: lọc ra thành phố có trung bình phí vận chuyển (freight) > 100 và sắp xếp theo thứ tự giảm dần của  trung bình phí vận chuyển từ bảng orders
SELECT O.ShipCountry,
       AVG(O.Freight) AS [AvgFreight]
FROM dbo.Orders AS O
-- WHERE 
GROUP BY O.ShipCountry
HAVING AVG(O.Freight) > 100
ORDER BY AVG(O.Freight) DESC

-- Thử thách 2: lọc ra mã các nhà cung cấp có số lượng đơn hàng đã được đặt UnitsOnOrder > 100 từ bảng Products.
SELECT PR.SupplierID, PR.UnitsOnOrder
FROM dbo.Products AS PR
WHERE PR.UnitsOnOrder >= 100
-- GROUP BY
-- HAVING COUNT(PR.UnitsOnOrder) >= 100
-- ORDER BY
