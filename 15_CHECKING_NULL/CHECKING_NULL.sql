USE NORTHWND
GO

/*
SELECT tên cột
FROM tên bảng
WHERE tên cột IN IS NULL/NOT NULL
*/

-- LẤY RA TẤT CẢ ĐƠN HÀNG CHƯA ĐƯỢC GIAO (ShippedDate = NULL)
SELECT *
FROM dbo.Orders AS O
WHERE O.ShippedDate IS NULL

-- LẤY DANH SÁCH CÁC KHÁCH HÀNG CÓ KHU VỰC (ShipRegion) KHÔNG BỊ NULL
SELECT *
FROM dbo.Customers AS CU
WHERE CU.Region IS NOT NULL

-- LẤY TẤT CẢ ĐƠN HÀNG CHƯA ĐƯỢC GIAO VÀ CÓ KHU VỰC GIAO HÀNG KHÔNG BỊ NULL.
-- CHƯA ĐƯỢC GIAO TỨC LÀ ShippedDate = NULL
SELECT O.OrderID, O.ShippedDate, O.ShipRegion
FROM dbo.Orders AS O
WHERE O.ShipRegion IS NOT NULL
AND O.ShippedDate IS NULL
