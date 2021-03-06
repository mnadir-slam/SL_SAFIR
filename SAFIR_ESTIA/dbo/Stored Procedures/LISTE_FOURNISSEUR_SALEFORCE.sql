﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_FOURNISSEUR_SALEFORCE] 
(
	--@PK_IMMEUBLE NVARCHAR(MAX)
	@CD_IMMEUBLE_DREAM NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT
	   T.PK_TIERS
	,  T.CTIERS AS CD_FOURNISSEUR
	, UPPER(T.LTIERS) AS NOM_FOURNISSEUR
FROM
	MASTER_ESTIA..ESTIA_TIERS T
	RIGHT JOIN MASTER_ESTIA..ESTIA_CTRTIERS CTR
	ON CTR.FK_TIERS = T.PK_TIERS
	LEFT JOIN
	(
		SELECT DISTINCT FK_CTRTIERS, FK_GROUPE AS FK_IMMEUBLE
		FROM MASTER_ESTIA..ESTIA_VENTPCHA
	) VENTPCHA
	ON VENTPCHA.FK_CTRTIERS = CTR.PK_CTRTIERS
	LEFT JOIN MASTER_ESTIA..ESTIA_GROUPE IMMEUBLE
	ON IMMEUBLE.PK_GROUPE = VENTPCHA.FK_IMMEUBLE
	LEFT JOIN MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
    ON IMMEUBLE.CGROUPE = P.NM_IMMEUBLE_ESTIA
	--WHERE VENTPCHA.FK_IMMEUBLE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	WHERE P.CD_IMMEUBLE_DREAM IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@CD_IMMEUBLE_DREAM,','))

END