USE NORTHWND
GO

/*
SELECT column_name AS alias_name
FROM table_name AS alias_name

ĐẶT TÊN THAY THẾ CHO CÁC CỘT/BẢNG
GIÚP CHO VIỆC ĐỌC VÀ HIỂU CÂU LỆNH SQL DỄ DÀNG HƠN.
*/

SELECT CU.CompanyName AS N'CÔNG TY', CU.PostalCode AS N'MÃ BƯU ĐIỆN', CU.City AS "THÀNH PHỐ"
FROM dbo.Customers AS CU

SELECT EM.LastName AS "HO", EM.FirstName AS "TEN" FROM
dbo.Employees AS EM

-- LẤY RA 15 DONG ĐẦU TIÊN TẤT CẢ CÁC CỘT TRONG BẢNG ORDER VÀ ĐẶT TÊN THAY THẾ CHO BẢNG LÀ "O"
SELECT TOP 15 O.* FROM dbo.Orders AS O

SELECT TOP 5 P.ProductName AS [TEN SAN PHAM], P.SupplierID AS [MA NHA CUNG CAP], P.CategoryID AS [MA THE LOAI]
FROM dbo.Products AS P
