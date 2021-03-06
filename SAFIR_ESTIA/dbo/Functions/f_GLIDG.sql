﻿CREATE FUNCTION [dbo].[f_GLIDG] 
(
	@DT_DEBUT DATETIME,
	@DT_FIN DATETIME,
	@PK_PROPRIETAIRE INT,
	@PK_IMMEUBLE NVARCHAR(MAX)
)
RETURNS @retGLIDG TABLE   
(  
	FK_TIERS int,
	FK_GROUPE int,
	CMANDAT varchar(16) NULL,
	CGROUPE int NULL,
	CCOMPTE varchar(22) NULL,
	TERME int NULL,
	PERIOD int NULL,
	TVA varchar(3) NULL,
	CJOURNAL varchar(6) NULL,
	CRUB varchar(3) NULL,
	LIB varchar(80) NULL,
	DATEC date,
	LETTRAGE varchar(18) NULL,
	SENS varchar(2) NULL, 
	MONTANT numeric(17, 2) NULL
)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN  
WITH GLIDG_cte(FK_TIERS, FK_GROUPE, CMANDAT, CGROUPE, CCOMPTE, TERME, PERIOD, TVA, CJOURNAL, CRUB, lIB, DATEC, LETTRAGE, SENS, MONTANT)
AS
(
	SELECT    WGM.FK_TIERS
			, CPTGLOB.FK_GROUPE
			, WGM.CMANDAT
			, GROUPE.CGROUPE
			, CPTGLOB.CCOMPTE
			, LOCATION.TERME
			, RIGHT(REPLICATE('0',2) + CAST(LOCATION.PERIOD AS VARCHAR(2)), 2) PERIOD
			, CASE LOCATION.LTVA WHEN 1 THEN 'OUI' WHEN 0 THEN 'NON' END TVA
			, CPTGLOB.CJOURNAL
			, RIGHT(REPLICATE('0',3) + CAST(CASE WHEN CPTGLOB.CRUB <> 0 THEN CPTGLOB.CRUB ELSE CASE WHEN CPTGLOB.CTASS <> 0 THEN CPTGLOB.CTASS ELSE CAST(CASE WHEN ISNUMERIC(RIGHT(LETTRAGE, 3)) = 1 THEN RIGHT(LETTRAGE, 3) ELSE 0 END AS NUMERIC) END END AS VARCHAR(3)), 3) CRUB
			, CPTGLOB.LIB
			, CPTGLOB.DATEC
			, CPTGLOB.LETTRAGE
			, CPTGLOB.SENS
			, CPTGLOB.MONTANT
	FROM MASTER_ESTIA..ESTIA_CPTGLOB CPTGLOB
	LEFT JOIN MASTER_ESTIA..ESTIA_LOCATION LOCATION
	ON LOCATION.PK_LOCATION = CPTGLOB.FK_BAIL
	LEFT JOIN MASTER_ESTIA..ESTIA_GROUPE GROUPE 
	ON GROUPE.PK_GROUPE = CPTGLOB.FK_GROUPE
	LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
	ON WGM.CORG = GROUPE.CORG AND WGM.CAGENCE = GROUPE.CAGENCE AND WGM.CGROUPE = GROUPE.CGROUPE
	WHERE CPTGLOB.CORG = '11' 
	AND WGM.FK_TIERS = @PK_PROPRIETAIRE
	AND CPTGLOB.FK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	AND CPTGLOB.DATEC BETWEEN @DT_DEBUT AND @DT_FIN
	AND CPTGLOB.TYPCPTA = 'LD'
)

-- copy the required columns to the result of the function   
   INSERT @retGLIDG 
   SELECT FK_TIERS, FK_GROUPE, CMANDAT, CGROUPE, CCOMPTE, TERME, PERIOD, TVA, CJOURNAL, CRUB, lIB, DATEC, LETTRAGE, SENS, MONTANT 
   FROM GLIDG_cte   
   RETURN  
END;