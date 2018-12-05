
CREATE FUNCTION [dbo].[ufn_SplitMultiValue]
(
 @inputValues NVARCHAR(MAX),
 @delimiter NVARCHAR(255)
)
RETURNS @occurs TABLE (value NVARCHAR(MAX))
AS
BEGIN
 DECLARE @word NVARCHAR(MAX)
 
WHILE (CHARINDEX(@delimiter, @inputValues, 1) > 0)
 BEGIN
 SET @word = SUBSTRING(@inputValues, 1 , CHARINDEX(@delimiter, @inputValues, 1) - 1)
 SET @inputValues = SUBSTRING(@inputValues, CHARINDEX(@delimiter, @inputValues, 1) + 1, LEN(@inputValues))
 INSERT INTO @occurs VALUES(@word)
 END
 
INSERT INTO @occurs SELECT @inputValues
 
RETURN
END