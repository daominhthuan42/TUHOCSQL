USE NORTHWND
GO

CREATE VIEW MonthlySales AS
SELECT YEAR([OrderDate]) AS [YEAR],
	   MONTH([OrderDate]) AS [MONTH],
	   COUNT([OrderID]) AS [SO LUONG DON HANG]
FROM [dbo].[Orders]
GROUP BY YEAR([OrderDate]), MONTH([OrderDate]);

-- TRUY VẤN ĐẾN VIEW
SELECT * FROM [dbo].[MonthlySales]

-- TẠO VIEW KẾT HỢP THÔNG TIN VỀ KHÁCH HÀNG VÀ ĐƠN HÀNG.
CREATE VIEW view_CustomerOrder AS
SELECT CU.CustomerID,
	   CU.CompanyName,
	   CU.ContactName,
	   O.OrderID,
	   O.OrderDate,
	   O.ShipCountry
FROM [dbo].[Customers] AS CU
JOIN [dbo].[Orders] AS O ON O.CustomerID = CU.CustomerID

-- TẠO VIEW HIỂN THỊ TỔNG GIÁ TRỊ TỪNG ĐƠN HÀNG CỦA KHÁCH HÀNG TƯƠNG ỨNG.
CREATE VIEW view_OrderTotalValue AS
SELECT OD.OrderID,
	   O.[CustomerID],
	   O.[OrderDate],
       SUM(OD.Quantity * OD.UnitPrice) AS [OrderTotalValue]
FROM [dbo].[Order Details] AS OD
JOIN [dbo].[Orders] AS O ON O.OrderID = OD.OrderID
GROUP BY OD.OrderID, O.[CustomerID], O.[OrderDate]
