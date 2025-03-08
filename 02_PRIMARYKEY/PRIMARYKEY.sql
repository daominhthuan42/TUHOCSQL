-- Chỉ có duy nhất 1 khóa chính
-- UNIQUE: Duy nhất trong toàn bộ bảng. Trường hợp nào có từ khóa UNIQUE thì không thể có 2 giá trị trùng nhau.
-- NOT NULL: Trường đó không được phép NULL.
-- DEFAULT: Giá trị mặc định của trường đó nếu không gán giá trị khi insert.
CREATE TABLE SQLTestPrimaryKey
(
	ID INT UNIQUE NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Đào Minh Thuấn'
)
GO

-- Khi đã tạo bảng muốn sửa thành primary key.
ALTER TABLE dbo.SQLTestPrimaryKey ADD PRIMARY KEY (ID)

-- Tạo primary key trong bảng không phải ngay khi khai báo
CREATE TABLE SQLTestPrimaryKey2
(
	ID INT NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Pham Thi Hoa'

	PRIMARY KEY(ID)
)
GO

-- Tạo primary key ngay trong bảng mà đặt tên cho key đó.
CREATE TABLE SQLTestPrimaryKey3
(
	ID INT NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Pham Thi Hoa'

	CONSTRAINT PK_Test3 -- Để sau này xóa key cho dễ.
	PRIMARY KEY(ID)
)
GO

-- Tạo primary key sau khi tạo bảng và đặt tên cho key đó.
CREATE TABLE SQLTestPrimaryKey4
(
	ID INT NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Pham Thi Hoa'
)
GO

ALTER TABLE dbo.SQLTestPrimaryKey4 ADD CONSTRAINT PK_Test4 PRIMARY KEY (ID)


-- Khóa chính có 2 trường
CREATE TABLE SQLTestPrimaryKey5
(
	ID1 INT NOT NULL,
	ID2 INT NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Pham Thi Hoa'

	PRIMARY KEY(ID1, ID2)
)
GO