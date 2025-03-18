USE NORTHWND
GO

/*
SELECT coloumn_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

TOÁN TỬ BETWEEN CHỌN CÁC GIÁ TRỊ TRONG MỘT PHAM VI NHẤT ĐỊNH. CÁC GIÁ TRỊ CÓ THỂ LÀ SỐ, VĂN BẢN HOẶC NGÀY THÁNG.
*/

-- LẤY DANH SÁCH SẢN PHẨM CÓ GIÁ TRONG KHOẢNG 10 ĐẾN 20 ĐÔ.
SELECT *
FROM dbo.Products AS P
WHERE P.UnitPrice BETWEEN 10 AND 20;

-- LẤY DANH SÁCH CÁC ĐƠN ĐẶT HÀNG TRONG KHOẢNG THỜI GIAN TỪ 1996-07-01 ĐẾN 1996-07-31
SELECT *
FROM dbo.Orders AS O
WHERE O.OrderDate BETWEEN '1996-07-01' AND '1996-07-31'

-- TÍNH TỔNG SỐ TIỀN VẬN CHUYỂN (Freight) CỦA CÁC ĐƠN ĐẶT HÀNG ĐƯỢC ĐẶT TRONG KHOẢNG THỜI GIAN
-- TỪ NGÀY 1996-07-01 ĐẾN 1996-07-31.
SELECT SUM(O.Freight) AS [TỔNG SỐ TIỀN VẬN CHUYỂN TRONG THÁNG 7]
FROM dbo.Orders AS O
WHERE O.OrderDate BETWEEN '1996-07-01' AND '1996-07-31'

-- LẤY DANH SÁCH CÁC ĐƠN ĐẶT HÀNG CÓ NGÀY ĐẶT HÀNG TRONG KHOẢNG TỪ NGÀY 01/01/1997 ĐẾN NGÀY 31/12/1997 VÀ ĐƯỢC VẬN CHUYỂN BẰNG ĐƯỜNG TÀU THỦY (SHIPVIA = 3)
SELECT *
FROM dbo.Orders AS O
WHERE O.OrderDate BETWEEN '1997-01-01' AND '1997-12-31'
AND O.ShipVia = 3

-- lấy ds nhân viên có ngày sinh từ đầu năm 1948 đến cuối năm 1960, Danh xưng là Dr. hoặc Mr., sắp xếp theo số năm làm việc từ ít đến nhiều
SELECT *
FROM dbo.Employees AS EM
WHERE EM.BirthDate BETWEEN '1948-01-01' AND '1960-12-31'
AND EM.TitleOfCourtesy IN ('Dr.', 'Mr.')
ORDER BY EM.HireDate DESC
