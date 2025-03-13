USE NORTHWND
GO

-- VIẾT CÂU LỆNH SQL LẤY RA TÊN TẤT CẢ SẢN PHẨM
SELECT * FROM [dbo].[Products]

-- VIẾT CÂU LỆNH SQL LẤY RA TÊN SẢN PHẨM, GIÁ BÁN, SỐ LƯỢNG SẢN PHẦM TRÊN ĐƠN VỊ
SELECT PR.ProductName, PR.QuantityPerUnit, PR.UnitPrice
FROM [dbo].[Products] AS PR

-- VIẾT CÂU LỆNH SQL LẤY RA TÊN CÔNG TY KHÁCH HÀNG VÀ QUỐC GIA KHÁCH HÀNG ĐÓ 
SELECT * FROM [dbo].[Customers] -- CHECK
SELECT CU.CompanyName, CU.Country FROM [dbo].[Customers] AS CU

-- VIẾT CÂU LỆNH SQL LẤY RA TÊN CÔNG TY VÀ SỐ ĐIỆN THOẠI CỦA TẤT CẢ CÁC NHÀ CUNG CẤP HÀNG.
SELECT* FROM dbo.Suppliers -- CHECK
SELECT SU.CompanyName, SU.Phone FROM dbo.Suppliers AS SU
