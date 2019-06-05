﻿CREATE PROCEDURE [dbo].[LISTE_CRITERE] 
(
	@PK_IMMEUBLE NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--SELECT CRITDP.CCRITDP
--	 , concat(cast(CRITDP.CCRITDP as varchar(10)), ' - ' + CRITDP.LCRITDP) LCRITDP
--FROM MASTER_ESTIA..ESTIA_CRITDP CRITDP
--ORDER BY CRITDP.CCRITDP
SELECT CGROUPE
	 , CCRITDP
	 , LCRITDP
FROM
(
	SELECT SCRITDP.CGROUPE
		 , SCRITDP.CCRITDP
		 , concat(cast(SCRITDP.CCRITDP as varchar(10)), ' - ' + CRITDP.LCRITDP) LCRITDP
	from MASTER_ESTIA..ESTIA_SCRITDP SCRITDP
	LEFT JOIN MASTER_ESTIA..ESTIA_GROUPE IMMEUBLE
	ON IMMEUBLE.PK_GROUPE = SCRITDP.FK_GROUPE
	LEFT JOIN MASTER_ESTIA..ESTIA_CRITDP CRITDP
	ON CRITDP.CCRITDP = SCRITDP.CCRITDP
	WHERE SCRITDP.CORG = '11'
	AND IMMEUBLE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	GROUP BY SCRITDP.CGROUPE, SCRITDP.CCRITDP, CRITDP.LCRITDP
) SRC
ORDER BY CGROUPE, CCRITDP


END