USE NORTHWND
GO

/*
Common Table Expression (CTEs) là một tính năng quan trọng trong SQL, cho phép người dùng đặt tên và sử dụng một bảng tạm thời trong phạm vi của một truy vấn cụ thể.
CTEs được sử dụng trong việc xử lý các câu truy vấn phức tạp, thường kết hợp với các câu lệnh SELECT, INSERT, UPDATE hoặc DELETE giúp tăng tính rõ ràng, dễ đọc hiểu và quản lý các đoạn mã SQL.

WITH cte_name (column1, column2, ...)
AS (
    SELECT ...
)
*/

-- LẤY RA 3 CỘT ĐẦU TIÊN TABLE EMPLOYEES.
WITH SHORT_E AS (
	SELECT EM.EmployeeID, EM.LastName, EM.FirstName
	FROM [dbo].[Employees] AS EM
)

SELECT * FROM SHORT_E;

-- LẤY THÔNG TIN SẢN PHẨM (PRODUCTS) CÓ CÙNG THỂ LOẠI VỚI MỘT LOẠI SẢN PHẨM CỤ THỂ.
-- KO DÙNG CTE
SELECT P.CategoryID, P.ProductName
FROM [dbo].[Products] AS P
WHERE P.CategoryID IN (
	SELECT [CategoryID]
	FROM [dbo].[Products]
	WHERE [ProductName] = 'Chai'
);

-- DÙNG CTE
WITH PRODUCT_CTE AS (
	SELECT [CategoryID]
	FROM [dbo].[Products]
	WHERE [ProductName] = 'Chai'
)

SELECT P.CategoryID, P.ProductName
FROM [dbo].[Products] AS P
JOIN PRODUCT_CTE AS TEMP ON TEMP.CategoryID = P.CategoryID

-- LẤY THÔNG TIN ĐƠN HÀNG (ORDERS) CÙNG VỚI TỔNG GIÁ TRỊ ĐƠN HÀNG VÀ TỶ LỆ GIỮA TỔNG GIÁ TRỊ VÀ PHÍ GIAO HÀNG.
-- KO DÙNG CTE
-- C1
SELECT O.OrderID,
       O.OrderDate,
       SUM(OD.UnitPrice * OD.Quantity) AS [TotalPrice],
	   O.Freight,
	   (SUM(OD.UnitPrice * OD.Quantity) / O.Freight) AS [Raito]
FROM [dbo].[Orders] AS O
INNER JOIN [dbo].[Order Details] AS OD ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, O.OrderDate, O.Freight

-- C2
SELECT O.OrderID,
       O.OrderDate,
	   (SELECT SUM([UnitPrice] * [Quantity])
	    FROM [dbo].[Order Details] AS OD
		WHERE O.OrderID = OD.OrderID) AS [TotalPrice],
		O.Freight,
	   (SELECT SUM([UnitPrice] * [Quantity])
	    FROM [dbo].[Order Details] AS OD
		WHERE O.OrderID = OD.OrderID) / O.Freight AS [RAITO]
FROM [dbo].[Orders] AS O;

-- DÙNG CTE
WITH ORDER_CTE AS (
	SELECT [OrderID], SUM([UnitPrice] * [Quantity]) AS [TotalPrice]
	FROM [dbo].[Order Details]
	GROUP BY [OrderID]
)

SELECT O.OrderID,
       O.OrderDate,	   
	   ORDER_TEMP.TotalPrice,
	   O.Freight,
	   ORDER_TEMP.TotalPrice / O.Freight AS [RAITO]
FROM [dbo].[Orders] AS O
JOIN ORDER_CTE AS ORDER_TEMP ON ORDER_TEMP.OrderID =  O.OrderID;

-- TUỲ VÀO NHỮNG BÀI TOÀN THỰC TẾ CHÚNG TA CÓ THỂ TẠO RA RẤT NHIỀU BẢNG TẠM THỜI CTE.

-- SỬ DỤNG CTE ĐỂ TÍNH TỔNG DOANH SỐ BÁN HÀNG CHO TỪNG SẢN PHẨM TỪ HAI BẢNG 'ORDER DETAIL' VÀ
-- 'PRODUCT' TRONG CƠ SỞ DỮ LIỆU NorthWind.
SELECT OD.ProductID, PR. ProductName,
       SUM(OD.Quantity * OD.UnitPrice) AS [DOANH THU TỪNG SẢN PHẨM]
FROM [dbo].[Order Details] AS OD
INNER JOIN [dbo].[Products] AS PR ON PR.ProductID = OD.ProductID
GROUP BY OD.ProductID,  PR. ProductName
ORDER BY OD.ProductID;

-- DÙNG CTE
WITH TEMP_PRODUCT AS (
	SELECT OD.ProductID,
	       SUM(OD.Quantity * OD.UnitPrice) AS [TOTALPRICE]
	FROM [dbo].[Order Details] AS OD
	GROUP BY OD.ProductID
)
SELECT PR.ProductID, PR.ProductName,
       TP.TOTALPRICE AS [DOANH THU TỪNG SẢN PHẨM]
FROM [dbo].[Products] AS PR
INNER JOIN TEMP_PRODUCT AS TP ON TP.ProductID = PR.ProductID
ORDER BY PR.ProductID;

--Sử dụng CTE để tính toán tổng doanh số bán hàng theo từng khách hàng và sau đó sắp xếp danh sách khách hàng theo tổng doanh số giảm dần
SELECT CU.CustomerID, CU.ContactName,
       SUM(OD.Quantity * OD.UnitPrice) AS [TOTALPRICE]
FROM [dbo].[Order Details] AS OD
JOIN [dbo].[Orders] AS O ON O.OrderID = OD.OrderID
JOIN [dbo].[Customers] AS CU ON CU.CustomerID = O.CustomerID
GROUP BY CU.CustomerID, CU.ContactName
ORDER BY SUM(OD.Quantity * OD.UnitPrice) DESC;

-- DÙNG CTE
WITH TEMP_PRODUCT2 AS (
	SELECT OD.OrderID,
	       SUM(OD.Quantity * OD.UnitPrice) AS [TOTALPRICE]
	FROM [dbo].[Order Details] AS OD
	GROUP BY OD.OrderID
)
SELECT CU.CustomerID, CU.ContactName,
       SUM(TP.TOTALPRICE) AS [DOANH THU TỪNG KHÁCH HÀNG]
FROM [dbo].[Customers] AS CU
JOIN [dbo].[Orders] AS O ON O.CustomerID = CU.CustomerID
JOIN TEMP_PRODUCT2 AS TP ON TP.OrderID = O.OrderID
GROUP BY CU.CustomerID, CU.ContactName
ORDER BY SUM(TP.TOTALPRICE) DESC;

-- Sử dụng CTE tính tổng doanh số bán hàng theo năm từ bảng Orders và order details
SELECT YEAR(O.[OrderDate]) AS [YEAR],
	    SUM(OD.[Quantity] * OD.[UnitPrice]) AS [TOTALPRICE]
FROM [dbo].[Orders] AS O
JOIN [dbo].[Order Details] AS OD ON OD.OrderID = O.OrderID
GROUP BY YEAR(O.[OrderDate]);

-- DÙNG CTE
WITH TEM_ORDER AS (
	SELECT OD.OrderID,
	       SUM(OD.Quantity * OD.UnitPrice) AS [TOTALPRICE]
	FROM [dbo].[Order Details] AS OD
	GROUP BY OD.OrderID
)
SELECT YEAR(O.OrderDate) AS [YEAR],
	    SUM(TOR.TOTALPRICE) AS [DOANH SỐ THEO NĂM]
FROM [dbo].[Orders] AS O
JOIN TEM_ORDER AS TOR ON TOR.OrderID = O.OrderID
GROUP BY YEAR(O.OrderDate)
