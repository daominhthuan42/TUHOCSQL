USE NORTHWND
GO

-- TỪ BẢNG PRODUCTS AND CATEGORIES: HÃY IN RA CÁC INFO
-- MÃ THỂ LOẠI.
-- TÊN THỂ LOẠI
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM.

SELECT CA.CategoryID, CA.CategoryName,
       PR.ProductID, PR.ProductName
FROM dbo.Products AS PR, dbo.Categories AS CA
WHERE CA.CategoryID = PR.CategoryID

-- TỪ BẢNG EMPLOYEES VÀ ORDER, HÃY IN RA THÔNG TIN:
-- MÃ NHÂN VIÊN
-- TÊN NHÂN VIÊN (FIRST NAME + LAST NAME)
-- SỐ LƯỢNG ĐƠN HÀNG MÃ NHÂN VIÊN ĐÃ BÁN ĐƯỢC
SELECT O.EmployeeID,
       EM.FirstName,
	   EM.LastName,
	   COUNT(O.OrderID) AS [Total Order]
FROM dbo.Employees AS EM, dbo.Orders AS O
WHERE EM.EmployeeID = O.EmployeeID
GROUP BY O.EmployeeID, EM.FirstName, EM.LastName;

-- TỪ BẢNG CUSTOMERS VÀ ORDER, HÃY IN RA CÁC THÔNG TIN
-- MÃ SỐ KHÁCH HÀNG
-- TÊN CÔNG TY
-- TÊN LIÊN HỆ
-- SỐ LƯỢNG ĐƠN HÀNG ĐÃ MUA
-- VỚI ĐIỀU KIỆN: QUỐC GIA CỦA KHÁCH HÀNG LÀ UK.
SELECT CU.CustomerID,
       CU.CompanyName,
	   CU.ContactName,
	   COUNT(O.OrderID)
FROM dbo.Orders AS O, dbo.Customers AS CU
WHERE CU.CustomerID = O.CustomerID AND CU.Country = 'UK'
GROUP BY CU.CustomerID, CU.CompanyName, CU.ContactName;

-- TỪ BẢNG ORDERS AND SHIPPERS HÃY IN RA CÁC THÔNG TIN
-- MÃ NHÀ VẬN CHUYỂN
-- TÊN CÔNG TY VẬN CHUYỂN
-- TỔNG SỐ TIỀN VẬN CHUYỂN (SUM FREIGHT)
-- VÀ IN RA MÀN HÌNH THỨ TỰ SẮP XẾP TỔNG SỐ TIỀN VẬN CHUYỂN GIẢM DẦN.
-- NOTE
-- TUY CỘT KHÁC NHAU NHƯNG VỀ BẢN CHẤT THÌ SHIPVIA (ORDER) = SHIPPERID (SHIPPER)
SELECT SH.ShipperID, SH.CompanyName,
       SUM(O.Freight) AS [SumFreight]
FROM dbo.Shippers AS SH, dbo.Orders AS O
WHERE SH.ShipperID = O.ShipVia
GROUP BY SH.ShipperID, SH.CompanyName
ORDER BY SUM(O.Freight) DESC

-- TỪ BẢNG PRODUCTS, SUPPLIERS HÃY IN RA CÁC THÔNG TIN
-- MÃ NHÀ CUNG CẤP
-- TÊN CÔNG TY
-- TỐNG SỐ CÁC SẢN PHẨM KHÁC NHAU ĐÃ CUNG CẤP (ProductID).
-- IN RA MÀN HÌNH DUY NHẤT 1 NHÀ CUNG CẤP CÓ SỐ LƯỢNG SẢN PHẨM KHÁC NHAU NHIỀU NHẤT.
SELECT TOP 1 SU.SupplierID, SU.CompanyName,
       COUNT(PR.ProductID) AS [TotalProduct]
FROM dbo.Products AS PR, dbo.Suppliers AS SU
WHERE SU.SupplierID = PR.SupplierID
GROUP BY SU.SupplierID, SU.CompanyName
ORDER BY COUNT(PR.ProductID) DESC

-- TỪ BẢNG ORDER VÀ ORDER DETAILS HÃY IN RA CÁC THÔNG TIN
-- MÃ ĐƠN HÀNG
-- TỔNG SỐ TIỀN SẢN PHẨM CỦA ĐƠN HÀNG
SELECT O.OrderID,
       SUM(OD.UnitPrice * OD.Quantity) AS [TotalUnitPrice]
FROM dbo.Orders AS O, dbo.[Order Details] AS OD
WHERE O.OrderID = OD.OrderID
GROUP BY O.OrderID

-- TỪ 3 BẢNG ORDER DETAI, EMPLOYEES, ORDERS. HÃY IN RA THÔNG TIN
-- MÃ ĐƠN HÀNG
-- TÊN NHÂN VIÊN
-- TỔNG SỐ TIỀN SẢN PHẨM ĐƠN HÀNG
SELECT O.OrderID,
       EM.LastName,
	   EM.FirstName,
	   SUM(OD.UnitPrice * OD.Quantity) AS [TotalUnitPrice]
FROM dbo.[Order Details] AS OD, dbo.Employees AS EM, dbo.Orders AS O
WHERE O.OrderID = OD.OrderID AND O.EmployeeID = EM.EmployeeID
GROUP BY O.OrderID, EM.LastName, EM.FirstName

-- TỪ 3 BẢNG ORDERS, CUSTOMERS, SHIPPERS:
-- MÃ ĐƠN HÀNG.
-- TÊN KHÁCH HÀNG
-- TÊN CÔNG TY VẬN CHUYỂN
-- VÀ CHỈ IN RA CÁC ĐƠN HÀNG GIAO ĐẾN 'UK' TRONG NĂM 1997.
SELECT O.OrderID, CU.ContactName, SH.CompanyName
FROM dbo.Orders AS O, dbo.Customers AS CU, dbo.Shippers AS SH
WHERE O.CustomerID = CU.CustomerID AND O.ShipVia = SH.ShipperID
      AND O.ShipCountry = 'UK' AND YEAR(O.ShippedDate) = 1997

-- TỪ BẢNG PRODUCTS VÀ CATEGORIES, HÃY TÌM SẢN PHẨM THUỘC DANH MỤC 'SEAFOOD' IN RA CÁC THÔNG TIN:
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM
SELECT  CA.CategoryID, CA.CategoryName, PR.ProductID, PR.ProductName
FROM dbo.Products AS PR, dbo.Categories AS CA
WHERE CA.CategoryID = PR.CategoryID AND CA.CategoryID = 8

-- TỪ BẢNG PRODUCTS VÀ SUPPLIERS HÃY TÌM CÁC SẢN PHẨM ĐƯỢC CUNG CẤP TỪ 'Germany'
-- MÃ NHÀ CUNG CẤP
-- QUỐC GIA
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM
SELECT SU.SupplierID, SU.Country, PR.ProductID, PR.ProductName      
FROM dbo.Products AS PR, dbo.Suppliers AS SU
WHERE PR.SupplierID = SU.SupplierID AND SU.Country = 'Germany'

-- TỪ 3 BẢNG ORDER, CUSTOMER, SHIPPERS HÃY IN RA INFOR:
-- MÃ ĐƠN HÀNG
-- TÊN KHÁCH HÀNG.
-- TÊN CÔNG TY VẬN CHUYỂN
-- VÀ CHỈ IN RA ĐƠN HÀNG CỦA KHÁCH HÀNG ĐẾN TỪ THÀNH PHỐ 'London'
SELECT O.OrderID, CU.ContactName, SH.CompanyName      
FROM dbo.Orders AS O, dbo.Customers AS CU, dbo.Shippers AS SH
WHERE O.CustomerID = CU.CustomerID AND O.ShipVia = SH.ShipperID
      AND CU.City = 'London'

-- TỪ 3 BẢNG ORDER, CUSTOMER, SHIPPERS HÃY IN RA INFOR:
-- MÃ ĐƠN HÀNG
-- TÊN KHÁCH HÀNG.
-- TÊN CÔNG TY VẬN CHUYỂN
-- NGÀY YÊU CẦU CHUYỂN HẢNG
-- NGÀY GIAO HÀNG
-- VÀ CHỈ IN RA ĐƠN HÀNG GIAO MUỘN HƠN QUY ĐỊNH
SELECT O.OrderID, CU.ContactName, SH.CompanyName,
       O.RequiredDate, O.ShippedDate
FROM dbo.Orders AS O, dbo.Customers AS CU, dbo.Shippers AS SH
WHERE O.CustomerID = CU.CustomerID AND O.ShipVia = SH.ShipperID
      AND O.ShippedDate > O.RequiredDate

--Exercise : 
--Give these shipcountries for which customers don't come from the united states (Lấy những cái shipcountries của những khách hàng không dến từ USA )
--Select only countries which is over than 100 orders  ( Chỉ chon những nước có hơn (>) 100 đơn hàng ) 
--Display shipcountry and number of orders  ( Hiện thị những nước giao hàng  và số Orders )
SELECT O.ShipCountry,
       COUNT(O.OrderID)
FROM dbo.Orders AS O, dbo.Customers AS CU
WHERE O.CustomerID = CU.CustomerID AND O.ShipCountry <> 'USA'
GROUP BY O.ShipCountry
HAVING COUNT(O.OrderID) > 100
