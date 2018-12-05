CREATE function [RPAD]
(
	@pad_value varchar(500),
	@pad_length int,
	@pad_with varchar(10)
)
returns varchar(5000)
as
BEGIN
	Declare @valueResult varchar(5000)
	select @valueResult=@pad_value+replace(replace(str(@pad_value,@pad_length),' ',@pad_with),@pad_value,'')
	return @valueResult
END