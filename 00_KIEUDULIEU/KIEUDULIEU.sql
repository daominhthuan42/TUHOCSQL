-- Các kiểu dữ liệu

-- int: Kiểu số nguyên, tập hợp N. Ví dụ: -9, 8, -6,...
-- float: Kiểu số thực, tập hợp R. Ví dụ: -0.5, 0.9,...
-- char: Kiểu ký tự. Không viết tiếng Việt được. Bộ nhớ cấp phát cứng. Ví dụ: A, a, b, f,... char(10) -> 10 ô nhớ cấp phát cứng
-- varchar: Kiểu ký tự. Không viết tiếng Việt được. Bộ nhớ cấp phát động.varchar(10) -> 10 ô nhớ chỉ được chứa khi có dữ liệu.
-- nchar: Kiểu ký tự cấp phát cứng có thể lưu tiếng Viêt.
-- nvarchar: Kiểu ký tự cấp phát động có thể lưu tiếng Viêt.
-- date: Lưu trữ ngày tháng, năm, giờ.
-- bit: lưu giá trị 0 và 1.
-- text: Lưu văn bản lớn
-- ntext: Lưu văn bản có tiếng Việt

CREATE TABLE Test
(
	Doc NVARCHAR(50), -- Khai báo trường Doc kiểu nvarchar cấp phát động 50 ô nhớ.
	MaSV CHAR(10), -- Khai báo trường MaSV char cấp phát 10 ô nhớ cứng.
	Birthday DATE, -- Khai báo trường Date.
	Sex BIT -- Lưu giá trị 0 or 1.
)
GO
