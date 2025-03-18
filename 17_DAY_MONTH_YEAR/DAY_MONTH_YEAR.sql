USE NORTHWND
GO

/*
LINK: https://quantrimang.com/hoc/ham-xu-ly-date-time-trong-sql-phan-1-162457
*/
-- HÃY TÍNH SỐ LƯỢNG ĐƠN ĐẶT HÀNG (ORDER ID) TRONG NĂM 1997 CỦA "TỪNG KHÁCH HÀNG" -> PHẢI DÙNG GROUP BY
SELECT O.CustomerID,
       COUNT(*) AS [TotalOder],
	   YEAR(O.OrderDate) AS [YEAR]
FROM dbo.Orders AS O
WHERE YEAR(O.OrderDate) = '1997'
GROUP BY O.CustomerID, YEAR(O.OrderDate)

-- HÃY LỌC RA CÁC ĐƠN HÀNG ĐƯỢC ĐẶT HÀNG VÀO THÁNG 5 NĂM 1997.
SELECT O.OrderID,
       O.OrderDate
FROM dbo.Orders AS O
WHERE YEAR(O.OrderDate) = '1997' AND MONTH(O.OrderDate) = '5'

-- LẤY RA DANH SÁCH KHÁCH HÀNG ĐẶT HÀNG TRONG NĂM 1998 VÀ SỐ ĐƠN HÀNG MỖI THÁNG, SẮP XẾP THÁNG TĂNG DẦN.
SELECT O.CustomerID, 
       COUNT(O.OrderID) AS [SỐ ĐƠN HÀNG MỖI THÁNG],
	   MONTH(O.OrderDate) AS [MONTH]
FROM dbo.Orders AS O
WHERE YEAR(O.OrderDate) = 1998
GROUP BY O.CustomerID, MONTH(O.OrderDate)
ORDER BY MONTH(O.OrderDate) ASC

-- HÃY LỌC CÁC ĐƠN ĐẶT HÀNG ĐÃ ĐƯỢC GIAO VÀO THÁNG 5 VÀ SẮP XẾP TĂNG DẦN THEO NĂM.
SELECT O.OrderID,
       MONTH(O.ShippedDate) AS [MONTH],
	   YEAR(O.ShippedDate) AS [YEAR]
FROM dbo.Orders AS O
WHERE MONTH(O.ShippedDate) = 5
ORDER BY YEAR(O.ShippedDate) ASC
