﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_LOCATAIRE_ETAT_LOC_SALEFORCE] 
(
	@PK_TEMPS DATETIME,
	--@PK_IMMEUBLE NVARCHAR(MAX)
	@CD_IMMEUBLE_DREAM NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--(
  SELECT DISTINCT
   FEL.FK_LOCATAIRE AS PK_LOCATAIRE
  ,D_LOCATAIRE.CD_LOCATAIRE
  --,CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN 88888 ELSE ISNULL(D_LOCATAIRE.NM_LOCATAIRE, 99999) END AS NM_LOCATAIRE
  , CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN '88888' ELSE CAST(ISNULL(D_LOCATAIRE.NM_LOCATAIRE, 99999) AS VARCHAR(14)) END + ' - ' + CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN 'Gardien' ELSE dbo.InitCap(ISNULL(D_LOCATAIRE.NOM_LOCATAIRE, 'VACANT')) END AS NOM_LOCATAIRE
FROM
  D_LOCATAIRE
  INNER JOIN D_BAIL 
    ON D_BAIL.FK_LOCATAIRE = D_LOCATAIRE.PK_LOCATAIRE
  INNER JOIN D_IMMEUBLE
    ON D_IMMEUBLE.PK_IMMEUBLE = D_BAIL.FK_IMMEUBLE
  --LEFT JOIN MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
    --ON D_IMMEUBLE.NM_IMMEUBLE = P.NM_IMMEUBLE_ESTIA
  RIGHT JOIN 
  (
	SELECT DISTINCT F_ETAT_LOCATIF.FK_IMMEUBLE, P.CD_IMMEUBLE_DREAM, ISNULL(F_ETAT_LOCATIF.FK_LOCATAIRE, 99999) AS FK_LOCATAIRE 
	FROM F_ETAT_LOCATIF 
	LEFT JOIN D_IMMEUBLE
	ON D_IMMEUBLE.PK_IMMEUBLE = F_ETAT_LOCATIF.FK_IMMEUBLE
	LEFT JOIN MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
    ON D_IMMEUBLE.NM_IMMEUBLE = P.NM_IMMEUBLE_ESTIA	
	WHERE F_ETAT_LOCATIF.PK_TEMPS = (@PK_TEMPS)
 )FEL
    ON FEL.FK_IMMEUBLE = D_IMMEUBLE.PK_IMMEUBLE AND FEL.FK_LOCATAIRE = D_LOCATAIRE.PK_LOCATAIRE
WHERE
  --FEL.FK_IMMEUBLE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
  FEL.CD_IMMEUBLE_DREAM IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@CD_IMMEUBLE_DREAM,','))
--)
--UNION
--(
--	  SELECT DISTINCT
--	   FEL.FK_LOCATAIRE AS PK_LOCATAIRE
--	  ,LOCATAIRE.CD_LOCATAIRE
--	  --,CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN 88888 ELSE ISNULL(LOCATAIRE.CD_LOCATAIRE, 99999) END AS NM_LOCATAIRE
--	  , CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN '88888' ELSE ISNULL(LOCATAIRE.CD_LOCATAIRE, '99999') END + ' - ' + CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN 'Gardien' ELSE dbo.InitCap(ISNULL(LOCATAIRE.NOM, 'VACANT')) END AS NOM_LOCATAIRE
--	FROM
--	  PROPERTY_ETL.DBO.LOCATAIRE LOCATAIRE
--	  INNER JOIN PROPERTY_ETL.DBO.BAIL BAIL 
--		ON BAIL.CD_LOCATAIRE = LOCATAIRE.CD_LOCATAIRE
--	  INNER JOIN PROPERTY_ETL.DBO.IMMEUBLE IMMEUBLE
--		ON IMMEUBLE.CD_IMMEUBLE = BAIL.CD_IMMEUBLE
--	  RIGHT JOIN 
--	  (
--		SELECT DISTINCT FK_IMMEUBLE, ISNULL(FK_LOCATAIRE, 99999) AS FK_LOCATAIRE 
--		FROM PROPERTY_ETL.DBO.V_F_SITUATION_LOT WHERE CONVERT(VARCHAR(10), PK_TEMPS, 103) = (@PK_TEMPS)
--	 )FEL
--		ON FEL.FK_IMMEUBLE = IMMEUBLE.PK_IMMEUBLE AND FEL.FK_LOCATAIRE = LOCATAIRE.PK_LOCATAIRE
--	WHERE
--	  --FEL.FK_IMMEUBLE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
--	  P.CD_IMMEUBLE_DREAM IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@CD_IMMEUBLE_DREAM,','))
--)

/*SELECT DISTINCT
   FEL.FK_LOCATAIRE AS PK_LOCATAIRE
  ,D_LOCATAIRE.CD_LOCATAIRE
  ,CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN 88888 ELSE ISNULL(D_LOCATAIRE.NM_LOCATAIRE, 99999) END AS NM_LOCATAIRE
  , CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN '88888' ELSE CAST(ISNULL(D_LOCATAIRE.NM_LOCATAIRE, 99999) AS VARCHAR(14)) END + ' - ' + CASE WHEN FEL.FK_LOCATAIRE = '-88888' THEN 'Gardien' ELSE dbo.InitCap(ISNULL(D_LOCATAIRE.NOM_LOCATAIRE, 'VACANT')) END AS NOM_LOCATAIRE
FROM
  D_LOCATAIRE
  INNER JOIN D_BAIL 
    ON D_BAIL.FK_LOCATAIRE = D_LOCATAIRE.PK_LOCATAIRE
  INNER JOIN D_IMMEUBLE
    ON D_IMMEUBLE.PK_IMMEUBLE = D_BAIL.FK_IMMEUBLE
  RIGHT JOIN 
  (
	SELECT DISTINCT F_ETAT_LOCATIF.FK_IMMEUBLE, ISNULL(F_ETAT_LOCATIF.FK_LOCATAIRE, 99999) AS FK_LOCATAIRE 
	FROM F_ETAT_LOCATIF WHERE F_ETAT_LOCATIF.PK_TEMPS = (@PK_TEMPS)
 )FEL
    ON FEL.FK_IMMEUBLE = D_IMMEUBLE.PK_IMMEUBLE AND FEL.FK_LOCATAIRE = D_LOCATAIRE.PK_LOCATAIRE
WHERE
  FEL.FK_IMMEUBLE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))--(@PK_IMMEUBLE)*/

END