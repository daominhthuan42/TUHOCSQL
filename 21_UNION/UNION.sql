USE NORTHWND
GO

/*
TRUY VẤN 1: 22
TỬ BẢNG ORDER DETAIL HÃY LIỆT KÊ CÁC ĐƠN HÀNG CÓ UNIT PRICE NẰM TRONG PHẠM VI 100 ĐẾN 200
*/
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE OD.UnitPrice BETWEEN 100 AND 200;

/*
TRUY VẤN 2: 433
TỬ BẢNG ORDER DETAIL HÃY LIỆT KÊ CÁC ĐƠN HÀNG CÓ QUANTITY NẰM TRONG PHẠM VI 10 HOẶC 20
*/
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE OD.Quantity IN (10, 20)

/*
TRUY VẤN 3 = TRUY VẤN 1 AND TRUY VẤN 2 (7 ROWS)
TỬ BẢNG ORDER DETAIL HÃY LIỆT KÊ CÁC ĐƠN HÀNG CÓ UNIT PRICE NẰM TRONG PHẠM VI 100 ĐẾN 200
VÀ CÁC ĐƠN HÀNG CÓ QUANTITY NẰM TRONG PHẠM VI 10 HOẶC 20
*/
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE (OD.Quantity IN (10, 20)) AND (OD.UnitPrice BETWEEN 100 AND 200);

/*
TRUY VẤN 4 = TRUY VẤN 1 OR TRUY VẤN 2 (448 ROWS)
TỬ BẢNG ORDER DETAIL HÃY LIỆT KÊ CÁC ĐƠN HÀNG CÓ UNIT PRICE NẰM TRONG PHẠM VI 100 ĐẾN 200
HOẶC CÁC ĐƠN HÀNG CÓ QUANTITY NẰM TRONG PHẠM VI 10 HOẶC 20
*/
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE (OD.Quantity IN (10, 20)) OR (OD.UnitPrice BETWEEN 100 AND 200);

/*
TRUY VẤN 5 = DISTINCT + TRUY VẤN 4 (360)
TỬ BẢNG ORDER DETAIL HÃY LIỆT KÊ CÁC ĐƠN HÀNG CÓ UNIT PRICE NẰM TRONG PHẠM VI 100 ĐẾN 200
HOẶC CÁC ĐƠN HÀNG CÓ QUANTITY NẰM TRONG PHẠM VI 10 HOẶC 20
DÙNG DISTINCT
*/
SELECT DISTINCT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE (OD.Quantity IN (10, 20)) OR (OD.UnitPrice BETWEEN 100 AND 200);

/*
Cú pháp của UNION:
SELECT tên cột FROM bảng1
UNION
SELECT tên cột FROM bảng2

Cú pháp của UNION ALL:
SELECT tên cột FROM bảng1
UNION ALL
SELECT tên cột FROM bảng2

Toán tử UNION được sử dụng để kết hợp tập hợp kết quả của hai hoặc nhiều câu lệnh SELECT.
Mỗi câu lệnh SELECT với UNION phải có cùng số lượng cột, các cột phải có cùng kiểu dữ liệu, các cột trong mỗi câu lệnh SELECT phải có cùng trật tự.
*/

-- TRUY VẤN 5
-- V = I OR II = 360 ROWS (BỎ PHẦN GIAO)
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE OD.UnitPrice BETWEEN 100 AND 200
UNION
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE OD.Quantity IN (10, 20)

-- TRUY VẤN 4
-- V = I OR II = 455 ROWS (CHẤP NHẬN TRÙNG LẶP 2 LẦN, KO BỎ TRÙNG LẶP).
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE OD.UnitPrice BETWEEN 100 AND 200
UNION ALL
SELECT OD.OrderID
FROM dbo.[Order Details] AS OD
WHERE OD.Quantity IN (10, 20)

-- HÃY LIỆT KÊ TOÀN BỘ THÀNH PHỐ VÀ QUỐC GIA TỒN TÀI TRONG 2 TABLE SUPPLIER VÀ CUSTOMER  VỚI 2 TÌNH HƯỚNG UNION VÀ UNION ALL.
-- UNION ALL THÌ CHẤP NHẬN SỰ TRUNG LẶP CÒN UNION THÌ KHÔNG.
SELECT DISTINCT SU.Country
FROM dbo.Suppliers AS SU
UNION
SELECT DISTINCT CU.Country
FROM dbo.Customers AS CU

SELECT DISTINCT SU.Country
FROM dbo.Suppliers AS SU
UNION ALL
SELECT DISTINCT CU.Country
FROM dbo.Customers AS CU                          
