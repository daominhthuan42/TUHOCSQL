USE NORTHWND
GO

/*
SELECT cot1, cot2,.... cotn
FROM ten_bang
WHERE ten_cot LIKE [mẫu so sánh];

Có 2 ký tự đại diện được sử dụng trong toán tử LIKE, những ký tự này có thể được sử dụng kết hợp cùng với nhau:
Phần trăm (%): Đại diện cho một chuỗi kí tự với độ dài bất kì (bao gồm cả độ dài 0).
Dấu gạch dưới (_): Đại diện cho 1 ký tự đơn lẻ.

VÍ DỤ:
LIKE 'qtm%'	
Tìm giá trị bắt đầu bằng "qtm"

LIKE '%qtm'	
Tìm giá trị kết thúc bằng "qtm"

LIKE '%qtm%'	
Tìm giá trị có "qtm" ở bất kỳ vị trí nào

LIKE '_qtm%'	
Tìm giá trị có "qtm" ở vị trí thứ hai

LIKE 'q_%'	
Tìm giá trị bắt đầu bằng "q" và có ít nhất 2 ký tự

LIKE 'q__%'	
Tìm giá trị bắt đầu bằng "q" và có độ dài ít nhất 3 ký tự

LIKE 'q%q'	
Tìm giá trị bắt đầu bằng "q" và kết thúc bằng "q"
*/

-- HÃY LỌC RA TẤT CẢ KHÁCH HÀNG ĐẾN TỪ QUỐC GIA BẮT ĐẦU BẰNG CHỮ A
SELECT *
FROM dbo.Customers AS CU
WHERE CU.Country LIKE 'A%'

-- LẤY DANH SÁCH CÁC ĐƠN ĐẶT HÀNG GỬI TỪ THÀNH PHỐ CÓ CHỨA CHỮ 'a'.
SELECT *
FROM dbo.Orders AS O
WHERE O.ShipCity LIKE '%a%'

-- LẤY TẤT CẢ CÁC ĐƠN HÀNG VỚI ĐIỀU KIỆN:
-- ShipCountry LIKE 'U_'
SELECT *
FROM dbo.Orders AS O
WHERE O.ShipCountry LIKE 'U_'  -- LỌC RA DANH SÁCH CHỈ CÓ 2 KÝ TỰ CHẲNG HẠN LÀ UK VÌ _ LÀ 1 KÝ TỰ ĐƠN LẺ
-- ShipCountry LIKE 'U%'
SELECT *
FROM dbo.Orders AS O
WHERE O.ShipCountry LIKE 'U%' -- LỌC RA DANH SÁCH BẮT ĐẦU BẰNG CHỮ U

-- LẤY TẤT CẢ CÁC NHÀ CUNG CẤP HÀNG CÓ CHỮ "b" TRONG TÊN CÔNG TY.
SELECT *
FROM dbo.Suppliers AS SU
WHERE SU.CompanyName LIKE '%b%'

--Challenge1: Write an SQL statement to list information employees with the letter "e" in the last name 
--and born from 1952-01-01 to 1962-12-31, 
--arrange in A-Z order by first Name
--taking only the first 5 lines -- Không cần thiết
SELECT TOP 5*
FROM dbo.Employees AS EM
WHERE EM.LastName LIKE '%e%' 
AND EM.BirthDate BETWEEN '1952-01-01' AND '1962-12-31'
ORDER BY EM.FirstName ASC

--Challenge 2: Write an SQL statement to list employees information with 'U__' (two underscores) in the [Country]
-- and start working from 1992-03-23 to 1994-12-31
-- agrange in Z-A order by the last name
--taking only the first 4 lines
SELECT TOP 4 *
FROM dbo.Employees AS EM
WHERE EM.HireDate BETWEEN '1992-03-23' AND '1994-12-31'
AND EM.Country LIKE 'U__'
ORDER BY EM.LastName DESC
