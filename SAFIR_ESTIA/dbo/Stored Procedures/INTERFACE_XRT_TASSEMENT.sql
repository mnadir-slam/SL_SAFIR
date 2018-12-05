-- =============================================
-- Author:		François DUONG
-- Create date: 2017-04-05
-- Description:	Traitement pour tasser les mouvements Interface XRT/SAP
-- =============================================
CREATE PROCEDURE [dbo].[INTERFACE_XRT_TASSEMENT] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		[Colonne 0], 
		[Colonne 1], 
		[Colonne 2], 
		[Colonne 3], 
		[Colonne 4], 
		[Colonne 5], 
		[Colonne 6], 
		[Colonne 7], 
		[Colonne 8], 
		sum(cast(replace([Colonne 9], ',', '.') as decimal(18,2))) as [Colonne 9], 
		[Colonne 10], 
		[Colonne 11], 
		[Colonne 12], 
		[Colonne 13], 
		[Colonne 14], 
		[Colonne 15], 
		[Colonne 16], 
		[Colonne 17], 
		[Colonne 18], 
		[Colonne 19], 
		[Colonne 20], [Colonne 21], [Colonne 22], [Colonne 23], [Colonne 24], [Colonne 25], [Colonne 26], [Colonne 27], [Colonne 28], [Colonne 29], [Colonne 30], [Colonne 31], [Colonne 32], [Colonne 33], [Colonne 34], [Colonne 35], [Colonne 36], [Colonne 37], [Colonne 38], [Colonne 39], [Colonne 40], [Colonne 41], [Colonne 42], [Colonne 43]
	from  [dbo].[SAP000357473]
	group by
		[Colonne 0], 		[Colonne 1], 		[Colonne 2], 		[Colonne 3], 		[Colonne 4], 		[Colonne 5], 		[Colonne 6], 		[Colonne 7], 		[Colonne 8], 
		[Colonne 10], 		[Colonne 11], 		[Colonne 12], 		[Colonne 13], 		[Colonne 14], 		[Colonne 15], 		[Colonne 16], 		[Colonne 17], 		[Colonne 18], 		[Colonne 19], 
		[Colonne 20], [Colonne 21], [Colonne 22], [Colonne 23], [Colonne 24], [Colonne 25], [Colonne 26], [Colonne 27], [Colonne 28], [Colonne 29], [Colonne 30], [Colonne 31], [Colonne 32], [Colonne 33], [Colonne 34], [Colonne 35], [Colonne 36], [Colonne 37], [Colonne 38], [Colonne 39], [Colonne 40], [Colonne 41], [Colonne 42], [Colonne 43]

END