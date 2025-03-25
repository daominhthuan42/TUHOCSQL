USE NORTHWND
GO

-- LIỆT KÊ TOÀN BỘ SẢN PHẨM
SELECT *
FROM [dbo].[Products] AS PR

-- TÌM GIÁ TRỊ TRUNG BÌNH CỦA CÁC SẢN PHẨM.
SELECT AVG(PR.UnitPrice)
FROM [dbo].[Products] AS PR

-- LỌC NHỮNG SẢN PHẨM CÓ GIÁ > GIÁ TRUNG BÌNH.
SELECT *
FROM [dbo].[Products] AS PR
WHERE PR.UnitPrice > 28.5411

-- DÙNG TRUY VẤN LỒNG
SELECT *
FROM [dbo].[Products] AS PR
WHERE PR.UnitPrice > (
	SELECT AVG(UnitPrice)
	FROM [dbo].[Products]
);

-- LỌC KHÁCH HÀNG CÓ SỐ ĐƠN HÀNG > 10.
SELECT CU.ContactName,
       COUNT(O.OrderID) AS [TotalOrder]
FROM [dbo].[Customers] AS CU
LEFT JOIN [dbo].[Orders] AS O ON O.CustomerID = CU.CustomerID -- CÓ NHỮNG KHÁCH HÀNG KHÔNG CÓ ĐƠN HÀNG NÀO.
GROUP BY CU.ContactName
HAVING COUNT(O.OrderID) > 10

-- DÙNG SUB QUERY
SELECT CU.ContactName
FROM [dbo].[Customers] AS CU
WHERE CU.CustomerID IN (
	SELECT O.CustomerID
	FROM [dbo].[Orders] AS O
	GROUP BY O.CustomerID
	HAVING COUNT(O.OrderID) > 10
);

-- TÍNH TỔNG SỐ TIỀN CHO TỪNG ĐƠN HÀNG
SELECT O.*, (
	   SELECT SUM(OD.UnitPrice * OD.Quantity)
	   FROM [dbo].[Order Details] AS OD
	   WHERE OD.OrderID = O.OrderID
) AS [SumPrice]
FROM [dbo].[Orders] AS O

-- LỌC RA TÊN SẢN PHẨM VÀ TỔNG SỐ ĐƠN HÀNG CỦA SẢN PHẨM.
SELECT PR.ProductID, PR.ProductName,
       COUNT(OD.OrderID) AS [TotalOrder]
FROM [dbo].[Products] AS PR
RIGHT JOIN [dbo].[Order Details] AS OD ON OD.ProductID = PR.ProductID
GROUP BY PR.ProductID, PR.ProductName
ORDER BY PR.ProductID ASC

-- DÙNG SUB QUERY
SELECT PR.ProductID, PR.ProductName, (
	   SELECT COUNT(*)
	   FROM [dbo].[Order Details] AS OD
	   WHERE OD.ProductID = PR.ProductID
) AS [TotalOrder]
FROM [dbo].[Products] AS PR

-- IN RA MÃ ĐƠN HÀNG VÀ TỔNG GIÁ TRỊ CỦA ĐƠN HÀNG ĐÓ.
-- KHÔNG DÙNG SUB QUERY
SELECT O.OrderID,
       SUM(OD.UnitPrice * OD.Quantity) AS [SumOrder]
FROM [dbo].[Orders] AS O
LEFT JOIN [dbo].[Order Details] AS OD ON OD.OrderID = O.OrderID
GROUP BY O.OrderID

-- DÙNG SUB QUERY
SELECT O.OrderID, (
	   SELECT SUM(OD.UnitPrice * OD.Quantity)
	   FROM [dbo].[Order Details] AS OD
	   WHERE OD.OrderID = O.OrderID
) AS [SumOrder]
FROM [dbo].[Orders] AS O

-- Liet ke cac don hang co 
-- ngay dat hang gan nhat
SELECT *
FROM [dbo].[Orders] AS O
WHERE O.OrderDate = (
	SELECT MAX(OrderDate)
	FROM [dbo].[Orders]
);

-- Liệt kê tất cả các sản phẩm (ProductName)
-- mà không có đơn đặt hàng nào đặt mua chúng.

-- KO DÙNG SUB QUERY
SELECT PR.ProductID, PR.ProductName, OD.OrderID
FROM [dbo].[Products] AS PR
LEFT JOIN [dbo].[Order Details] AS OD ON OD.ProductID = PR.ProductID
WHERE OD.OrderID IS NULL

-- DÙNG SUB QUERY
SELECT PR.ProductID, PR.ProductName
FROM [dbo].[Products] AS PR
WHERE PR.ProductID NOT IN (
	SELECT DISTINCT ProductID
	FROM [dbo].[Order Details]
);
 
-- Lấy thông tin về các đơn hàng, và tên các sản phẩm 
-- thuộc các đơn hàng chưa được giao cho khách.
SELECT O.OrderID, PR.ProductName
FROM [dbo].[Orders] AS O, [dbo].[Order Details] AS OD, [dbo].[Products] AS PR
WHERE O.OrderID = OD.OrderID AND OD.ProductID = PR.ProductID AND O.OrderID NOT IN (
	  SELECT [OrderID]
	  FROM [dbo].[Orders]
	  WHERE [ShippedDate] IS NOT NULL
)
ORDER BY O.OrderID 

-- KO DÙNG SUB QUERY
SELECT O.OrderID, PR.ProductName
FROM [dbo].[Orders] AS O
LEFT JOIN [dbo].[Order Details] AS OD ON O.OrderID = OD.OrderID
LEFT JOIN [dbo].[Products] AS PR ON OD.ProductID = PR.ProductID
WHERE O.ShippedDate IS NULL

-- Lấy thông tin về các sản phẩm có số lượng tồn kho 
--- ít hơn số lượng tồn kho trung bình của tất cả các sản phẩm
SELECT *
FROM [dbo].[Products] AS PR
WHERE PR.UnitsInStock < (
	SELECT AVG(UnitsInStock)
	FROM [dbo].[Products]
);

-- Lấy thông tin về các khách hàng có tổng giá trị đơn hàng lớn nhất.

SELECT TOP 1 CU.CustomerID, CU.ContactName, O.OrderID,  SUM([UnitPrice] * [Quantity]) AS [SumPrice]
FROM [dbo].[Orders] AS O, [dbo].[Customers] AS CU, [dbo].[Order Details] AS OD
WHERE O.OrderID = OD.OrderID AND O.CustomerID = CU.CustomerID
GROUP BY CU.CustomerID, CU.ContactName, O.OrderID
ORDER BY SUM([UnitPrice] * [Quantity]) DESC

SELECT CU.CustomerID, CU.ContactName, O.OrderID, SUM(Quantity * UnitPrice)
FROM [dbo].[Customers] AS CU
INNER JOIN [dbo].[Orders] AS O ON O.CustomerID = CU.CustomerID
INNER JOIN [dbo].[Order Details] AS OD ON OD.OrderID = O.OrderID
GROUP BY CU.CustomerID, CU.ContactName, O.OrderID
HAVING SUM(Quantity * UnitPrice) = (
       SELECT TOP 1 SUM(Quantity * UnitPrice)
	   FROM [dbo].[Order Details]
	   GROUP BY OrderID
	   ORDER BY SUM(Quantity * UnitPrice) DESC
	   );
