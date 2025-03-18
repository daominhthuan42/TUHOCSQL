USE NORTHWND
GO

-- HÃY CHO BIẾT NHỮNG KHÁCH HÀNG NÀO ĐÃ ĐƯỢC ĐẶT NHIỀU HƠN 20 ĐƠN HÀNG, SẮP XẾP TỔNG SỐ ĐƠN HÀNG GIẢM DẦN
SELECT O.CustomerID,
       COUNT(O.OrderID) AS [TotalOrder]
FROM dbo.Orders AS O
GROUP BY O.CustomerID
HAVING COUNT(O.OrderID) < 20
ORDER BY COUNT(O.OrderID) DESC

-- HÃY LỌC RA CÁC NHÂN VIÊN (EMPLOYEEID) CÓ TỔNG SỐ ĐƠN HÀNG LỚN HƠN HOẶC BẰNG 100, SẮP XÉP THEO TỔNG SỐ ĐƠN HÀNG GIẢM DẦN.
SELECT O.EmployeeID,
       COUNT(O.OrderID) AS [TotalOrder]
FROM dbo.Orders AS O 
GROUP BY O.EmployeeID
HAVING COUNT(O.OrderID) >= 100
ORDER BY COUNT(O.OrderID) DESC

-- HÃY CHO BIẾT NHỮNG THỂ LOẠI NÀO (CATEGORY ID) CÓ SỐ SẢN PHẨM KHÁC NHAU LỚN HƠN 11.
SELECT PR.CategoryID,
       COUNT(PR.ProductID) AS [TotalProduct]
FROM dbo.Products AS PR
GROUP BY PR.CategoryID
HAVING COUNT(PR.ProductID) > 11


-- HÃY CHO BIẾT NHỮNG THỂ LOẠI NÀO (CATEGORYID) CÓ TỔNG SỐ LƯỢNG SẢN PHẨM TRONG KHO (UnitslnStock) LỚN HƠN 350.
SELECT PR.CategoryID,
       SUM(PR.UnitsInStock) AS [TotalUnitsInStock]      
FROM dbo.Products AS PR
GROUP BY PR.CategoryID
HAVING SUM(PR.UnitsInStock) > 350

-- HÃY CHO BIẾT NHỮNG QUỐC GIA NÀO CÓ NHIỀU HƠN 7 KHÁCH HÀNG.
SELECT O.ShipCountry,
       COUNT(O.CustomerID) AS [TotalCustomers]
FROM dbo.Orders AS O
GROUP BY O.ShipCountry
HAVING COUNT(O.CustomerID) > 7

-- HÃY CHO BIẾT NHỮNG NGÀY NÀO CÓ NHIỀU HƠN 5 ĐƠN HÀNG ĐƯỢC GIAO, SẮP XẾP TĂNG DẦN THEO NGÀY GIAO HÀNG.
SELECT O.ShippedDate,
       COUNT(O.OrderID) AS [ĐƠN HÀNG]
FROM dbo.Orders AS O
WHERE O.ShippedDate IS NOT NULL
GROUP BY O.ShippedDate
HAVING COUNT(O.OrderID) > 5
ORDER BY O.ShippedDate ASC

-- HÃY LIỆT KÊ NHỮNG QUỐC GIA BẮT ĐẦU BẰNG CHỮ 'A' HOẶC 'G'
-- VÀ CÓ SỐ LƯỢNG ĐƠN HÀNG > 29.
SELECT  O.ShipCountry,
        COUNT(O.OrderID) AS [Total Orders]
FROM dbo.Orders AS O
WHERE O.ShipCountry LIKE '[AG]%'
GROUP BY O.ShipCountry
HAVING COUNT(O.OrderID) > 29

-- HÃY CHO BIẾT NHỮNG THÀNH PHỐ NÀO CÓ SỐ LƯỢNG ĐƠN HÀNG ĐƯỢC GIAO LÀ KHÁC 1 VÀ 2
-- NGÀY ĐẶT HÀNG TỪ NGÀY 1997-04-01 ĐẾN 1997-08-31
SELECT O.ShipCity,
       COUNT(O.OrderID) AS [Total Orders]
FROM dbo.Orders AS O
WHERE O.OrderDate BETWEEN '1997-04-01' AND '1997-08-31'
GROUP BY O.ShipCity
HAVING COUNT(O.OrderID) NOT IN (1, 2)
