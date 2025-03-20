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

-- Liệt kê tất cả các sản phẩm (ProductName)
-- mà không có đơn đặt hàng nào đặt mua chúng.

-- Lấy thông tin về các đơn hàng, và tên các sản phẩm 
-- thuộc các đơn hàng chưa được giao cho khách.

-- Lấy thông tin về các sản phẩm có số lượng tồn kho 
--- ít hơn số lượng tồn kho trung bình của tất cả các sản phẩm

-- Lấy thông tin về các khách hàng có tổng giá trị đơn hàng lớn nhất