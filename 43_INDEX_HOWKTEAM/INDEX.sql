USE HowKteam
GO

--DECLARE @i INT = 1
--WHILE (@i < 1000000)
--BEGIN
--	INSERT [dbo].[NGUOITHAN] (MAGV, TEN, NGSINH, PHAI)
--	VALUES (
--			N'001',
--			N'TEST' + CAST(@i AS NCHAR(12)),
--			GETDATE(),
--			N'NAM'
--			)
--	SET @i += 1
--END

SELECT * FROM [dbo].[NGUOITHAN]

-- Tạo index trên bảng giáo viên
-- Tăng tốc độ tìm kím <> Chậm tốc độ thêm, xóa, sưa
-- Cho phép các trường trùng nhau
CREATE INDEX IndexName ON dbo.NGUOITHAN(MaGV)

-- Không Cho phép các trường trùng nhau
CREATE UNIQUE INDEX IndexNameUnique ON dbo.GIAOVIEN(MaGV)

SELECT * FROM dbo.NGUOITHAN
WHERE MAGV = '001' AND TEN = 'TEST999999'
