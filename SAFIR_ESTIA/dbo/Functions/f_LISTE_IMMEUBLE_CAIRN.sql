﻿CREATE FUNCTION dbo.f_LISTE_IMMEUBLE_CAIRN 
(
	@PK_PROPRIETAIRE NVARCHAR(MAX)
)
RETURNS @retLISTE_IMMEUBLE_CAIRN TABLE   
(  
	PK_PROPRIETAIRE int NULL,
	CD_MANDAT varchar(20) NULL,
	PK_IMMEUBLE int NULL,
	CD_IMMEUBLE varchar(4) NULL,
	NM_IMMEUBLE int NULL,
	ADRLGN1 varchar(64) NULL,
	NOM_IMMEUBLE varchar(100) NULL,
	IND_MANDAT_ACTIF bit NULL
)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN 
WITH LISTE_IMMEUBLE_CAIRN_cte(PK_PROPRIETAIRE, CD_MANDAT, PK_IMMEUBLE, CD_IMMEUBLE, NM_IMMEUBLE, ADRLGN1, NOM_IMMEUBLE, IND_MANDAT_ACTIF)
AS
(
	
	 SELECT
	    D_MANDAT_GERANCE.FK_PROPRIETAIRE AS PK_PROPRIETAIRE
	  , D_MANDAT_GERANCE.CD_MANDAT + ' - ' + GROUPE.LGROUPE AS CD_MANDAT
	  , GROUPE.PK_GROUPE AS PK_IMMEUBLE
	  , REPLACE(STR(GROUPE.CGROUPE, 4, 0), ' ', '0') AS CD_IMMEUBLE
	  , GROUPE.CGROUPE AS NM_IMMEUBLE
	  , GROUPE.LGROUPE AS ADRLGN1
	  , UPPER(CONCAT(CAST(REPLACE(STR(GROUPE.CGROUPE, 4, 0), ' ', '0') AS VARCHAR(4)) + ' - ', GROUPE.LGROUPE)) as NOM_IMMEUBLE
	  , D_MANDAT_GERANCE.IND_MANDAT_ACTIF
	FROM
	  D_MANDAT_GERANCE
	  INNER JOIN MASTER_ESTIA..ESTIA_GROUPE GROUPE
	  on GROUPE.PK_GROUPE = D_MANDAT_GERANCE.FK_IMMEUBLE
	  INNER JOIN D_PROPRIETAIRE
		ON D_MANDAT_GERANCE.FK_PROPRIETAIRE = D_PROPRIETAIRE.PK_PROPRIETAIRE
	WHERE
	  D_MANDAT_GERANCE.IND_MANDAT_ACTIF LIKE N'O'
	  AND D_MANDAT_GERANCE.FK_PROPRIETAIRE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_PROPRIETAIRE,','))
)

-- copy the required columns to the result of the function   
   INSERT @retLISTE_IMMEUBLE_CAIRN  
   SELECT PK_PROPRIETAIRE, CD_MANDAT, PK_IMMEUBLE, CD_IMMEUBLE, NM_IMMEUBLE, ADRLGN1, NOM_IMMEUBLE, IND_MANDAT_ACTIF
   FROM LISTE_IMMEUBLE_CAIRN_cte   
   RETURN  
END;