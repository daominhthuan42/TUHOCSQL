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
RIGHT JOIN dbo.Customers AS CU
ON CU.CustomerID = O.CustomerID

SELECT O.OrderID, CU.CompanyName
FROM dbo.Orders AS O
RIGHT JOIN dbo.Customers AS CU
ON CU.CustomerID = O.CustomerID
