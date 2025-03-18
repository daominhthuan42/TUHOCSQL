USE NORTHWND
GO

/*
%	Represents zero or more characters
_	Represents a single character
^	Represents any character not in the brackets 
{}	Represents any escaped character
*	Represents zero or more characters	                        bl* finds bl, black, blue, and blob
?	Represents a single character	                            h?t finds hot, hat, and hit
[]	Represents any single character within the brackets	        h[oa]t finds hot and hat, but not hit
!	Represents any character not in the brackets	            h[!oa]t finds hit, but not hot and hat
-	Represents any single character within the specified range	c[a-b]t finds cat and cbt
#	Represents any single numeric character	                    2#5 finds 205, 215, 225, 235, 245, 255, 265, 275, 285, and 295

https://www.w3schools.com/sql/sql_wildcards.asp
https://quantrimang.com/hoc/toan-tu-dai-dien-wildcard-trong-sql-162453
*/

-- HÃY LỌC RA KHÁCH HÀNG CÓ TÊN LIÊN HỆ BẮT ĐẦU BẰNG CHỮ 'A'
SELECT *
FROM dbo.Customers AS CU
WHERE CU.ContactName LIKE 'A%'

-- HÃY LỌC RA TẤT CẢ KHÁC HÀNG CÓ TÊN LIÊN HỆ BẮT ĐẦU BẰNG CHỮ 'H', VÀ CÓ CHỮ THỨC 2 LÀ BẤT KỲ KÝ TỰ NÀO.
SELECT *
FROM dbo.Customers AS CU
WHERE CU.ContactName LIKE 'H_%'

-- LỌC RA CÁC ĐƠN HÀNG GỬI ĐẾN THÀNH PHỐ CÓ CHỮ CÁI BẮT ĐẦU LÀ 'L', CHỮ CÁI THỨ 2 LÀ 'u' HOẶC 'o'
SELECT O.OrderID, O.ShipCity
FROM dbo.Orders AS O
WHERE O.ShipCity LIKE 'L[uo]%'

-- LỌC RA CÁC ĐƠN HÀNG GỬI ĐẾN THÀNH PHỐ CÓ CHỮ CÁI BẮT ĐẦU LÀ 'L', CHỮ CÁI THỨ 2 KHÔNG LÀ 'u' HOẶC 'o'
SELECT O.OrderID, O.ShipCity
FROM dbo.Orders AS O
WHERE O.ShipCity LIKE 'L[^uo]%'

-- LỌC RA CÁC ĐƠN HÀNG GỬI ĐẾN THÀNH PHỐ CÓ CHỮ CÁI BẮT ĐẦU LÀ 'L', CHỮ CÁI THỨ 2 LÀ TỪ A ĐẾN E
SELECT O.OrderID, O.ShipCity
FROM dbo.Orders AS O
WHERE O.ShipCity LIKE 'L[a-e]%'

-- HÃY LẤY RA TẤT CẢ CÁC NHÀ CUNG CẤP HÀNG CÓ TÊN CÔNG TY BẮT ĐẦU BẰNG CHỮ 'A' VÀ KHÔNG CHƯA KÝ TỰ 'B'.
SELECT *
FROM dbo.Suppliers AS SU
WHERE SU.CompanyName LIKE 'A%[^b]%'

-- Trong bảng Employees, lấy ra tên các title, bắt đầu bằng chữ "s" và kết thúc bằng chữ "e"
SELECT *
FROM dbo.Employees AS EM
WHERE EM.Title LIKE 's%e'
