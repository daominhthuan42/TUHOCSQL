USE NORTHWND
GO

-- DISTINCT: LẤY RA DỮ LIỆU RIÊNG BIỆT, KHÔNG TRÙNG LẶP

-- LẤY RA TÊN CÁC QUỐC GIA KHÁC NHAU TỪ BẢNG KHÁCH HÀNG
SELECT CU.Country FROM dbo.Customers AS CU
SELECT DISTINCT CU.Country FROM dbo.Customers AS CU

-- LẤY RA TÊN CÁC MÃ BƯU ĐIỆN (POSTALCODE) KHÁC NHAY TỪ BẢNG SUPPLIERS
SELECT SU.PostalCode FROM dbo.Suppliers AS SU
SELECT DISTINCT SU.PostalCode FROM dbo.Suppliers AS SU

-- LẤY RA HỌ CỦA NHÂN VIÊN (LastName) VÀ CÁCH GỌI DANH HIỆU LỊCH SỰ (TitleOfCourtesy) TỪ BẢNG Employee.
SELECT DISTINCT EM.LastName FROM dbo.Employees AS EM
SELECT DISTINCT EM.TitleOfCourtesy FROM dbo.Employees AS EM

-- VIẾT CÂU LỆNH SQL LẤY RA MÃ ĐƠN VỊ VẬN CHUYỂN (ShipVia) KHÁC NHAU CỦA CÁC ĐƠN HÀNG - ORDERS
SELECT O.ShipVia FROM dbo.Orders AS O -- CHECK
SELECT DISTINCT O.ShipVia FROM dbo.Orders AS O
