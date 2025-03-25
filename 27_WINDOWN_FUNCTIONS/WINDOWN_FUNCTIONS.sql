USE NORTHWND
GO

-- VÍ DỤ
SELECT PR.ProductID,
       PR.ProductName,
	   PR.UnitPrice,
	   RANK() OVER (ORDER BY PR.UnitPrice DESC) AS RANKING
FROM dbo.Products AS PR

-- XẾP HẠN SẢN PHẨM THEO GIÁ GIẢM DẦN TRÊN THỂ LOẠI
SELECT PR.ProductID,
       PR.ProductName,
	   PR.CategoryID,
	   PR.UnitPrice,
	   RANK() OVER (PARTITION BY PR.CategoryID ORDER BY PR.UnitPrice DESC) AS RANKING
FROM dbo.Products AS PR

-- Chèn 20 dòng dữ liệu thực tế vào bảng
-- Tạo bảng "sinh_vien"
CREATE TABLE [sinh_vien] (
    [ma_sinh_vien] INT PRIMARY KEY,
    [ho_ten] NVARCHAR(255),
    [diem_trung_binh] DECIMAL(3, 2),
    [ma_lop_hoc] INT
);

-- Chèn 20 dòng dữ liệu thực tế vào bảng
INSERT INTO [sinh_vien] ([ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc])
VALUES
    (1, N'Nguyễn Văn A', 3.75, 101),
    (2, N'Trần Thị B', 3.88, 102),
    (3, N'Phạm Văn C', 3.75, 101),
    (4, N'Huỳnh Thị D', 3.92, 103),
    (5, N'Lê Văn E', 3.60, 102),
    (6, N'Ngô Thị F', 3.78, 101),
    (7, N'Trịnh Văn G', 3.65, 102),
    (8, N'Võ Thị H', 3.80, 103),
    (9, N'Đặng Văn I', 3.55, 101),
    (10, N'Hoàng Thị K', 3.95, 102),
    (11, N'Mai Thị L', 3.70, 103),
    (12, N'Lý Thị M', 3.62, 101),
    (13, N'Chu Thị N', 3.85, 102),
    (14, N'Đỗ Thị P', 3.58, 103),
    (15, N'Dương Văn Q', 3.72, 101),
    (16, N'Lâm Thị R', 3.85, 102),
    (17, N'Nguyễn Văn S', 3.68, 101),
    (18, N'Nguyễn Thị T', 3.75, 103),
    (19, N'Nguyễn Văn U', 3.93, 102),
    (20, N'Nguyễn Thị V', 3.67, 101);

-- XẾP HẠNG SINH VIÊN TOÀN TRƯỜNG DỰA TRÊN ĐIỂM TRUNG BÌNH GIẢM DẦN
SELECT SV.ma_sinh_vien,
	   SV.ho_ten,
	   SV.diem_trung_binh,
	   RANK() OVER (ORDER BY SV.diem_trung_binh DESC) AS RANKING
FROM [dbo].[sinh_vien] AS SV

-- XẾP HẠNG SINH VIÊN THEO TỪNG LỚP HỌC DỰA TRÊN ĐIỂM TRUNG BÌNH GIẢM DẦN, KHÔNG NHẢY XẾP HẠNG (DÙNG HÀM DENSE_RANK)
SELECT SV2.ma_sinh_vien,
	   SV2.ho_ten,
	   SV2.diem_trung_binh,
	   SV2.ma_lop_hoc,
	   DENSE_RANK() OVER (PARTITION BY SV2.ma_lop_hoc ORDER BY SV2.diem_trung_binh DESC) AS RANKING
FROM [dbo].[sinh_vien] AS SV2

-- XẾP HẠNG SINH VIÊN THEO TỪNG LỚP HỌC DỰA TRÊN ĐIỂM TRUNG BÌNH GIẢM DẦN, KHÔNG TRÙNG HẠNG
SELECT SV2.ma_sinh_vien,
	   SV2.ho_ten,
	   SV2.diem_trung_binh,
	   SV2.ma_lop_hoc,
	   ROW_NUMBER() OVER (PARTITION BY SV2.ma_lop_hoc ORDER BY SV2.diem_trung_binh DESC) AS RANKING
FROM [dbo].[sinh_vien] AS SV2

-- LẤY THÔNG TIN ĐƠN ĐẶT HÀNG VÀ NGÀY ĐẶT HÀNG CỦA ĐƠN ĐẶT HÀNG TRƯỚC ĐÓ CHO MỖI KHÁCH HÀNG.
SELECT O.CustomerID,
	   O.OrderID,
	   O.OrderDate,
	   LAG(O.OrderDate) OVER (PARTITION BY O.CustomerID ORDER BY O.OrderDate ASC) AS [PREVIOUS_ORDER_DATE]
FROM [dbo].[Orders] AS O;

-- TÍNH TỔNG DOANH SỐ BÁN HÀNG CHO MỖI KHÁCH HÀNG VÀ SẮP XẾP KHÁCH HÀNG DỰA TRÊN QUỐC GIA CỦA HỌ
WITH OD_CTE AS (
	 SELECT [OrderID],
	        SUM(Quantity * UnitPrice) AS [TOTALPRICE]
	 FROM [dbo].[Order Details]
	 GROUP BY OrderID
)
SELECT CU.CustomerID, 
       CU.ContactName,
	   CU.Country,
	   SUM(OC.TOTALPRICE) AS [DOANH_SO],
	   RANK() OVER (PARTITION BY CU.Country ORDER BY SUM(OC.TOTALPRICE) DESC) AS RANKING
FROM dbo.Customers AS CU
JOIN dbo.Orders AS O ON O.CustomerID = CU.CustomerID
JOIN OD_CTE AS OC ON OC.OrderID = O.OrderID
GROUP BY CU.CustomerID, CU.ContactName, CU.Country;

-- TÍNH TỔNG DOANH SỐ BÁN HÀNG HÀNG NĂM CHO MỖI KHÁCH HÀNG VÀ SẮP XẾP KHÁCH HÀNG DỰA TRÊN QUỐC GIA CỦA HỌ
WITH TEM_ORDER AS (
	SELECT OD.OrderID,
	       SUM(OD.Quantity * OD.UnitPrice) AS [TOTALPRICE]
	FROM [dbo].[Order Details] AS OD
	GROUP BY OD.OrderID
)
SELECT YEAR(O.OrderDate) AS [YEAR],
	   SUM(TOR.TOTALPRICE) AS [DOANH SỐ THEO NĂM],
	   CU.Country,
	   RANK() OVER (PARTITION BY CU.Country ORDER BY SUM(TOR.TOTALPRICE) DESC) AS RANKING
FROM dbo.Customers AS CU
JOIN dbo.Orders AS O ON O.CustomerID = CU.CustomerID
JOIN TEM_ORDER AS TOR ON TOR.OrderID = O.OrderID
GROUP BY YEAR(O.OrderDate), CU.Country;
