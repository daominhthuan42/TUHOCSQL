USE NORTHWND
GO

-- TÍNH SỐ LƯỢNG HÀNG CÒN LẠI TRONG KHO (UnitslnStock) SAU KHI BÁN HẾT CÁC SẢN PHẨM ĐÃ ĐƯỢC ĐẶT HÀNG (UnitsOnOrder)
-- stockRemaining = UnitslnStock - UnitOnOrder
SELECT P.ProductID, P.ProductName, (P.UnitsInStock - P.UnitsOnOrder) AS [SO LUONG HANG CON LAI]
FROM dbo.Products AS P

-- TÍNH GIÁ TRỊ ĐƠN HÀNG CHI TIẾT CHO TẤT CẢ SẢN PHẨM TRONG BẢNG ORDER DETAIL
-- ORDERDTAILVALUE = UNITPRICE * QUANTITY
SELECT *, (OD.UnitPrice * OD.Quantity) AS [ORDERDTAILVALUE]
FROM dbo.[Order Details] AS OD

-- TÍNH TỶ LỆ GIÁ VẬN CHUYỂN ĐƠN ĐẶT HÀNG (FREIGHT) TRUNG BÌNH CỦA CÁC ĐƠN HÀNG TRONG BẢNG ORDERS SO VỚI GIÁ TRỊ VẬN CHUYỂN CỦA ĐƠN HÀNG LỚN NHẤT (MAXFREIGHT)
SELECT (AVG(O.Freight) / MAX(O.Freight)) AS [FREIGHT RAITO]
FROM dbo.Orders AS O

/*
LIỆT KÊ DANH SÁCH CÁC SẢN PHẨM VÀ GIÁ (UnitPrice) CỦA TỪNG SẢN PHẨM SẼ ĐƯỢC GIẢM ĐI 10%
C1: DÙNG PHÉP NHÂN VÀ PHÉP CHIA.
C2: CHỈ DÙNG PHÉP NHÂN
*/
SELECT *, (P.UnitPrice * 0.9) AS [GIA SAN PHAM GIAM 10%]
FROM dbo.Products AS P
