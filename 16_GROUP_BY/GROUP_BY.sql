USE NORTHWND
GO

/*
SELECT column1, column2,...columnN
FROM table_name
WHERE condition
GROUP BY column1, column2...columnN
HAVING
ORDER BY column1, column2,...columnN

GROUP BY: DÙNG ĐỂ NHÓM CÁC DÒNG DỮ LIỆU CÓ CÙNG GIÁ TRỊ THƯỜNG ĐƯỢC DÙNG VỚI CÁC HÀM: COUNT(), MAX(), MIN(), SUM(), AVG()
*/

-- HÃY CHO BIẾT MỖI KHÁCH HÀNG ĐÃ ĐẶT BAO NHIÊU ĐƠN HÀNG.
SELECT O.CustomerID, COUNT(O.OrderID) AS [Total Order]
FROM dbo.Orders AS O
GROUP BY O.CustomerID

-- HÃY TÍNH GIÁ TRỊ ĐƠN GIÁ TRUNG BÌNH THEO MỖI NHÀ CUNG CẤP SẢN PHẨM.
-- GROUP BY SẼ NHÓM RECORD LẠI MÀ KHÔNG BỊ TRÙNG LẶP SupplierID
-- TÍNH GIÁ TRỊ TRUNG BÌNH ĐƠN GIÁ THEO MỖI NHÀ CUNG CẤP.
SELECT PR.SupplierID -- CHECK
FROM dbo.Products AS PR
GROUP BY [SupplierID]

SELECT PR.SupplierID, AVG(PR.UnitPrice) AS [AvgUnitPrice]
FROM dbo.Products AS PR
GROUP BY [SupplierID]

-- HÃY CHO BIẾT MỖI THỂ LOẠI (categoryID) CÓ TỔNG SỐ BAO NHIÊU SẢN PHẨM TRONG KHO (UnitsOnStock).
SELECT PR.CategoryID, SUM(PR.UnitsInStock) AS [TotalUnitsInStock]
FROM dbo.Products AS PR
GROUP BY PR.CategoryID

-- HÃY CHO BIẾT GIÁ VẬN CHUYỂN THẤP NHẤT VÀ LỚN NHẤT CỦA CÁC ĐƠN HÀNG THEO TỪNG THÀNH PHỐ VÀ QUỐC GIA KHÁC NHAU.
SELECT O.ShipCity, O.ShipCountry, 
       MIN(O.Freight) AS [MinFreight],
	   MAX(O.Freight) AS [MaxFreight]
FROM dbo.Orders AS O
GROUP BY O.ShipCity, O.ShipCountry

-- HÃY THỐNG KÊ SỐ LƯỢNG NHÂN VIÊN THEO TỪNG QUỐC GIA KHÁC NHAU
SELECT EM.Country, COUNT(*) AS [TotalEmployees]
FROM dbo.Employees AS EM
GROUP BY EM.Country

--Challenges1: Write an SQL statement 
--Thống kê số khách hàng ở từng quốc gia, từng thành phố
--Tìm các khách hàng có CompanyName có chữ a trong tên
--Sắp xếp theo chiều A-Z Country
SELECT CU.Country, CU.City, COUNT(*) AS [TotalCustomer]
FROM dbo.Customers AS CU
WHERE CU.CompanyName LIKE '%a%'
GROUP BY CU.Country, CU.City
ORDER BY CU.Country ASC

--Challenges2: Write an SQL Statment
-- Tính tổng số tiền vận chuyển ở từng thành phố, quốc gia
-- Chỉ lấy những ShipName có có chữ 'b' 
--Sắp xếp theo chiều từ A-Z của ShipCountry
SELECT O.ShipCity, O.ShipCountry, SUM(O.Freight) AS [TotalFreight]
FROM dbo.Orders AS O
WHERE O.ShipName LIKE '%b%'
GROUP BY O.ShipCity, O.ShipCountry
ORDER BY O.ShipCountry ASC

-- câu hỏi: tìm tổng số lượng hàng bán ra, sô lượng lớn nhất và bé nhất theo loại sản phẩm, sắp xếp theo tổng số lượng (lớn đến bé) : ORDER DTAIL
SELECT OD.ProductID,
       SUM(OD.Quantity) AS [SumQuantity],
       MIN(OD.Quantity) AS [MinQuantity],
       MAX(OD.Quantity) AS [MaxQuantity]
FROM [dbo].[Order Details] AS OD
GROUP BY OD.ProductID
ORDER BY SUM(OD.Quantity) ASC
 