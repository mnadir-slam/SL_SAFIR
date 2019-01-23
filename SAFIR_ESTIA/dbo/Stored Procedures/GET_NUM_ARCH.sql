-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_NUM_ARCH 
(
	@NB_ARCH INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @CPT INT,
		@LAST_IDENT INT

SET @CPT = 1
SET @LAST_IDENT = (SELECT CAST(RIGHT(MAX(NUM_ARCH), 6) AS NUMERIC(6,0)) FROM MASTER_ESTIA..HIST_ARCH)

TRUNCATE TABLE MASTER_ESTIA..WRK_ARCH

WHILE @CPT <= @NB_ARCH
BEGIN
	INSERT INTO MASTER_ESTIA..WRK_ARCH(NUM_ARCH) VALUES ('ARCH' + DBO.LPAD(ISNULL(@LAST_IDENT, 0)+@CPT, 6, '0'))
	IF @CPT > @NB_ARCH
	  BREAK;
	ELSE SET @CPT = @CPT+1
END

INSERT INTO MASTER_ESTIA..HIST_ARCH(NUM_ARCH)
SELECT * FROM MASTER_ESTIA..WRK_ARCH

SELECT * FROM MASTER_ESTIA..WRK_ARCH

END