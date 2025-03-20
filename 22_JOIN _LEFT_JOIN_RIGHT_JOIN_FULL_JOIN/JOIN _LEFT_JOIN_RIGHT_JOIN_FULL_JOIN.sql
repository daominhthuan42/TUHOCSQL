USE NORTHWND
GO

/*
Source:
https://viblo.asia/p/cau-lenh-sql-join-cac-loai-join-trong-sql-07LKXWJp5V4

INNER JOIN: trả về kết quả là các record mà trường được join hai bảng khớp nhau, 
các record chỉ xuất hiện một trong hai bảng sẽ bị loại.

SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

INNER JOIN nhiều table
SELECT column_list
FROM table1
INNER JOIN table2 ON join_condition1
INNER JOIN table3 ON join_condition2
*/

-- SỬ DỤNG INNER JOIN
-- TỪ BẢNG PRODUCTS VÀ CATEGORIES, HÃY TIN RA THÔNG TIN
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM.
SELECT CA.CategoryID, CA.CategoryName, PR.CategoryID, PR.ProductName
FROM dbo.Products AS PR
INNER JOIN dbo.Categories AS CA
ON CA.CategoryID = PR.CategoryID

-- TỪ BẢNG PRODUCTS VÀ CATEGORIES, HÃY TIN RA THÔNG TIN
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI
-- SỐ LƯỢNG SẢN PHẨM.
SELECT CA.CategoryID, CA.CategoryName,
       COUNT(PR.ProductID) AS [Total Product]
FROM dbo.Categories AS CA
INNER JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID
GROUP BY CA.CategoryID, CA.CategoryName

-- TỪ 3 BẢNG ORDER, CUSTOMER, SHIPPER HÃY IN RA CÁC THÔNG TIN
-- MÃ ĐƠN HÀNG
-- TÊN CÔNG TY KHÁCH HÀNG
SELECT O.OrderID, CU.CompanyName
FROM dbo.Orders AS O
INNER JOIN dbo.Customers AS CU
ON CU.CustomerID = O.CustomerID 

/*
LEFT JOIN là từ khóa trả về tất cả các hàng (rows) từ bảng bên trái (table1), với các hàng tương ứng trong bảng bên phải (table2).
Chấp nhận cả dữ liệu NULL ở bảng 2.

Cú pháp:
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;

LEFT JOIN cũng có thể join nhiều table
SELECT column_list
FROM table1
LEFT JOIN table2 ON join_condition1
LEFT JOIN table3 ON join_condition2
*/
-- SỬ DỤNG INNER JOIN
-- TỪ BẢNG PRODUCTS VÀ CATEGORIES, HÃY TIN RA THÔNG TIN
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM.
SELECT CA.CategoryID, CA.CategoryName, PR.CategoryID, PR.ProductName
FROM dbo.Categories AS CA
LEFT JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID

-- TỪ BẢNG PRODUCTS VÀ CATEGORIES, HÃY TIN RA THÔNG TIN
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI
-- SỐ LƯỢNG SẢN PHẨM.
SELECT CA.CategoryID, CA.CategoryName,
       COUNT(PR.ProductID) AS [Total Product]
FROM dbo.Categories AS CA
LEFT JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID
GROUP BY CA.CategoryID, CA.CategoryName

/*
RIGHT JOIN là từ khóa trả về tất cả các hàng (rows) từ bảng bên phải (table1), với các hàng tương ứng trong bảng bên trái (table2).
Chấp nhận cả dữ liệu NULL ở bảng 2.

Cú pháp:
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;

RIGHT JOIN cũng có thể join nhiều table
SELECT column_list
FROM table1
RIGHT JOIN table2 ON join_condition1
RIGHT JOIN table3 ON join_condition2
*/
-- TỪ 3 BẢNG ORDER, CUSTOMER HÃY IN RA CÁC THÔNG TIN
-- MÃ ĐƠN HÀNG
-- TÊN CÔNG TY KHÁCH HÀNG
SELECT O.OrderID, CU.CompanyName
FROM dbo.Orders AS O
INNER JOIN dbo.Customers AS CU
ON CU.CustomerID = O.CustomerID

SELECT O.OrderID, CU.CompanyName
FROM dbo.Orders AS O
RIGHT JOIN dbo.Customers AS CU
ON CU.CustomerID = O.CustomerID


/*
FULL OUTER JOIN (Hoặc OUTER JOIN): Trả về tất cả các dòng đúng với 1 trong các bảng.
*/
-- TỪ BẢNG PRODUCTS VÀ CATEGORIES, HÃY TIN RA THÔNG TIN
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM.
SELECT CA.CategoryID, CA.CategoryName, PR.CategoryID, PR.ProductName
FROM dbo.Categories AS CA
INNER JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID

SELECT CA.CategoryID, CA.CategoryName, PR.CategoryID, PR.ProductName
FROM dbo.Categories AS CA
LEFT JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID

SELECT CA.CategoryID, CA.CategoryName, PR.CategoryID, PR.ProductName
FROM dbo.Categories AS CA
RIGHT JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID

SELECT CA.CategoryID, CA.CategoryName, PR.CategoryID, PR.ProductName
FROM dbo.Categories AS CA
FULL JOIN dbo.Products AS PR
ON CA.CategoryID = PR.CategoryID

-- HÃY LIỆT KÊ TÊN NHÂN VIÊN VÀ TÊN KHÁCH HÀNG CỦA CÁC ĐƠN HÀNG BẢNG "ORDER" (INNER JOIN)
SELECT EM.FirstName, EM.LastName,
       CU.ContactName
FROM [dbo].[Orders] AS O
INNER JOIN [dbo].[Customers] AS CU ON O.CustomerID = CU.CustomerID
INNER JOIN [dbo].[Employees] AS EM ON O.EmployeeID = EM.EmployeeID

-- (LEFT JOIN) HÃY LIỆT KÊ TÊN NHÀ CUNG CẤP VÀ TÊN SẢN PHẨM CỦA CÁC SẢN PHẨM TRONG BẢNG PRODUCT,
-- BAO GỒM TẤT CẢ SẢN PHẨM KHÔNG CÓ NHÀ CUNG CẤP.
SELECT SU.CompanyName,
       PR.ProductName
FROM [dbo].[Products] AS PR
LEFT JOIN [dbo].[Suppliers] AS SU ON PR.SupplierID = SU.SupplierID

-- (RIGHT JOIN), HÃY LIỆT KÊ TÊN KHÁCH HÀNG VÀ TÊN ĐƠN HÀNG CỦA CÁC ĐƠN HÀNG TRONG BẢNG ORDERS
-- BAO GỒM CÁC KHÁCH HÀNG KHÔNG CÓ ĐƠN HÀNG.
SELECT CU.ContactName,
       O.OrderID
FROM [dbo].[Orders] AS O
RIGHT JOIN [dbo].[Customers] AS CU ON O.CustomerID = CU.CustomerID

-- (FULL JOIN) HÃY LIỆT KÊ DANH MỤC (CategoryID) VÀ TÊN NHÀ CUNG CẤP (SupplierID) CỦA CÁC SẢN PHẨM TRONG BẢNG PRODUCT
-- BAO GỒM CÁC DANH MỤC VÀ NHÀ CUNG CẤP KHÔNG CÓ SẢN PHẨM.
SELECT CA.CategoryID, SU.CompanyName
FROM [dbo].[Products] AS PR
FULL JOIN [dbo].[Suppliers] AS SU ON SU.SupplierID = PR.SupplierID
FULL JOIN [dbo].[Categories] AS CA ON CA.CategoryID = PR.CategoryID

--Câu 1: Hãy đưa ra các thông tin sau đây: Product name, Unitprice, và tổng quantity  
--từ 2 bảng Products và order details. và sắp xếp chúng theo thứ tự unitprice giảm dần. với điều kiện chỉ lấy những sản phẩm chung từ 2 bảng.
SELECT PR.ProductName, OD.UnitPrice, SUM(OD.Quantity) AS [SumQuantity]
FROM [dbo].[Products] AS PR
INNER JOIN [dbo].[Order Details] AS OD ON OD.ProductID = PR.ProductID
GROUP BY PR.ProductName, OD.UnitPrice
ORDER BY OD.UnitPrice DESC

--Câu 2: Hãy đưa ra các thông tin sau đây: Employee ID, Customer ID và count Order ID từ 2 bảng employees và orders
--và sắp xếp chúng theo thứ tự count Order ID giảm dần. với điều kiện lấy tất cả những thông tin từ 2 bảng.
SELECT EM.EmployeeID, O.CustomerID,
       COUNT(O.OrderID) AS [TotalOrderID]
FROM [dbo].[Employees] AS EM
FULL JOIN [dbo].[Orders] AS O ON EM.EmployeeID =  O.EmployeeID
GROUP BY EM.EmployeeID, O.CustomerID
ORDER BY COUNT(O.OrderID) DESC

-- BÀI TẬP CÂU LỆNH JOIN
-- Bài tập 1: Liệt kê tên sản phẩm và tên nhà cung cấp
-- của các sản phẩm đã được đặt hàng trong bảng "Order Details". 
-- Sử dụng INNER JOIN để kết hợp bảng "Order Details" với các bảng 
-- liên quan để lấy thông tin sản phẩm và nhà cung cấp.
SELECT DISTINCT OD.ProductID, PR.ProductName, SU.CompanyName -- MỘT SẢN PHẨM CÓ THỂ MUA ĐƯỢC NHIỀU LẦN NÊN PHẢI DÙNG DISTINCT ĐỂ KHỎI BỊ TRÙNG LẶP.
FROM [dbo].[Order Details] AS OD
INNER JOIN [dbo].[Products] AS PR ON OD.ProductID = PR.ProductID
INNER JOIN [dbo].[Suppliers] AS SU ON PR.SupplierID = SU.SupplierID

-- Bài tập 2 (LEFT JOIN): Liệt kê tên khách hàng và tên 
-- nhân viên phụ trách của các "đơn hàng (OrderID)" trong bảng "Orders". 
-- Bao gồm cả các đơn hàng không có nhân viên phụ trách.
-- Sử dụng LEFT JOIN để kết hợp bảng "Orders" với bảng "Employees" 
-- để lấy thông tin về khách hàng và nhân viên phụ trách.
SELECT O.OrderID, EM.FirstName, EM.LastName, CU.ContactName -- MỘT NHÂN VIÊN CÓ THỂ HỖ TRỢ MỘT KHÁCH HÀNG NHIỀU LẦN NÊN DÙNG DISTINCT ĐỂ KHỎI BỊ TRÙNG LẶP.
FROM [dbo].[Orders] AS O
LEFT JOIN [dbo].[Employees] AS EM ON O.EmployeeID = EM.EmployeeID
LEFT JOIN [dbo].[Customers] AS CU ON CU.CustomerID = O.CustomerID

-- Bài tập 3 (RIGHT JOIN): Liệt kê tên khách hàng và tên 
-- nhân viên phụ trách của các đơn hàng trong bảng "Orders". 
-- Bao gồm cả các đơn hàng không có nhân viên phụ trách.
-- Sử dụng RIGHT JOIN để kết hợp bảng "Orders" với bảng "Employees" 
-- để lấy thông tin về khách hàng và nhân viên phụ trách.
SELECT O.OrderID, EM.FirstName, EM.LastName, CU.ContactName -- MỘT NHÂN VIÊN CÓ THỂ HỖ TRỢ MỘT KHÁCH HÀNG NHIỀU LẦN NÊN DÙNG DISTINCT ĐỂ KHỎI BỊ TRÙNG LẶP.
FROM [dbo].[Orders] AS O
RIGHT JOIN [dbo].[Employees] AS EM ON O.EmployeeID = EM.EmployeeID
RIGHT JOIN [dbo].[Customers] AS CU ON CU.CustomerID = O.CustomerID

-- Bài tập 4 (FULL JOIN): Liệt kê tên danh mục và tên 
-- nhà cung cấp của các "sản phẩm (ProductID)" trong bảng "Products". 
-- Bao gồm cả các danh mục và nhà cung cấp không có sản phẩm. 
-- Sử dụng FULL JOIN hoặc kết hợp LEFT JOIN và RIGHT JOIN để lấy  
-- thông tin về danh mục và nhà cung cấp.
SELECT PR.ProductID, PR.ProductName, SU.CompanyName, CA.CategoryID, CA.CategoryName
FROM [dbo].[Products] AS PR
FULL JOIN [dbo].[Categories] AS CA ON PR.CategoryID = CA.CategoryID
FULL JOIN [dbo].[Suppliers] AS SU ON PR.SupplierID = SU.SupplierID

--Bài tập 5 (INNER JOIN): Liệt kê tên khách hàng và tên sản phẩm 
--đã được đặt hàng trong bảng Orders và Order Details.
SELECT O.OrderID,CU.ContactName, PR.ProductName
FROM [dbo].[Orders] AS O
INNER JOIN [dbo].[Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN [dbo].[Customers] AS CU ON O.CustomerID = CU.CustomerID
INNER JOIN [dbo].[Products] AS PR ON PR.ProductID = OD.ProductID

--Bài tập 6 (FULL JOIN): Liệt kê tên nhân viên và tên khách hàng 
--của các đơn hàng trong bảng Orders
--Bao gồm cả đơn hàng không có nhân viên hoặc khách hàng tương ứng.
SELECT O.OrderID, EM.FirstName, EM.LastName, CU.ContactName
FROM [dbo].[Orders] AS O
FULL JOIN [dbo].[Employees] AS EM ON EM.EmployeeID = O.EmployeeID
FULL JOIN [dbo].[Customers] AS CU ON CU.CustomerID = O.CustomerID
