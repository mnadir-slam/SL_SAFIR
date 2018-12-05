CREATE FUNCTION dbo.LPAD
(
    @string NVARCHAR(MAX), -- Initial string
    @length INT,           -- Size of final string
    @pad NVARCHAR(MAX)     -- Pad string
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    RETURN SUBSTRING(REPLICATE(@pad, @length),1,@length - LEN(@string)) + @string;
END