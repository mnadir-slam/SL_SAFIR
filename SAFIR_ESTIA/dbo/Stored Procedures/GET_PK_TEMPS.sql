-- =============================================
-- Author:		Mario NADIR
-- Create date: 2016-10-24
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_PK_TEMPS] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT distinct pk_temps from f_etat_locatif;
END