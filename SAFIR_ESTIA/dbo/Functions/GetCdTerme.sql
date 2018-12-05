
CREATE FUNCTION GetCdTerme(@freq varchar(2), @dt_terme date) 
RETURNS varchar(50)
AS
BEGIN

	RETURN case @freq
		when '01' then DATENAME ( m , @dt_terme ) + '-' + cast(DATEPART(yy, @dt_terme) as varchar(4))
		when '03' then cast(DATEPART(q, @dt_terme) as varchar(2)) + 'T' + cast(DATEPART(yy, @dt_terme) as varchar(4))
		when '06' then cast((DATEPART(q, @dt_terme)+1)/2 as varchar(2)) + 'S' + cast(DATEPART(yy, @dt_terme) as varchar(4)) 
		when '12' then cast(DATEPART(yy, @dt_terme) as varchar(4)) end

END