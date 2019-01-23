﻿CREATE FUNCTION [dbo].[f_GET_ANNUAL_LEASE_ALLOWANCES] 
(
	@DT_ANALYSE DATETIME,
	@ANNEE_PREV VARCHAR(4),
	@PK_BAIL INT
)
RETURNS @retANNUAL_LEASE_ALLOWANCES TABLE   
(  
	PK_GROUPE					int,
	PK_BAIL						int,
	MT_PALIER					numeric(17,2)
)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN  
WITH ANNUAL_LEASE_ALLOWANCES_cte(PK_GROUPE, PK_BAIL, MT_PALIER)
AS
(
	SELECT PK_GROUPE
		 , PK_BAIL
		 , MT_PALIER
	FROM
	(
		SELECT PK_GROUPE
			 , PK_BAIL
			 , CORG
			 , CAGENCE
			 , CGROUPE
			 , CIMMEUB
			 , CLOCAL
			 , OCC
			 , @ANNEE_PREV ANNEE_PREV
			 , SUM(NB_PRORAT) MT_PALIER
		FROM
		(
			SELECT PK_GROUPE, PK_BAIL, CORG, CAGENCE, CGROUPE, CIMMEUB, CLOCAL, OCC, CRUB, @ANNEE_PREV ANNEE_PREV, DDEB, DFIN
				 , CASE WHEN DATEPART(YEAR, DDEB) = @ANNEE_PREV THEN DDEB ELSE @ANNEE_PREV+'0101' END BORNE_INF
				 , CASE WHEN DATEPART(YEAR, DFIN) = @ANNEE_PREV THEN DFIN ELSE @ANNEE_PREV+'1231' END BORNE_SUP
				 , DATEDIFF(MONTH, CASE WHEN DATEPART(YEAR, DDEB) = @ANNEE_PREV THEN DDEB ELSE @ANNEE_PREV+'0101' END, DATEADD(DAY, 1, CASE WHEN DATEPART(YEAR, DFIN) = @ANNEE_PREV THEN DFIN ELSE @ANNEE_PREV+'1231' END)) ECART
				 , NB
				 , CAST((NB/12) * DATEDIFF(MONTH, CASE WHEN DATEPART(YEAR, DDEB) = @ANNEE_PREV THEN DDEB ELSE @ANNEE_PREV+'0101' END, DATEADD(DAY, 1, CASE WHEN DATEPART(YEAR, DFIN) = @ANNEE_PREV THEN DFIN ELSE @ANNEE_PREV+'1231' END)) AS NUMERIC(18,2)) NB_PRORAT
			FROM
			(
				SELECT GROUPE.PK_GROUPE
					 , LOCATION.PK_LOCATION PK_BAIL
					 , LOCATION.CORG
					 , LOCATION.CAGENCE
					 , LOCATION.CGROUPE
					 , LOCATION.CIMMEUB
					 , LOCATION.CLOCAL
					 , LOCATION.OCC
					 , HQLOCAT.CRUB
					 , HQLOCAT.DDEB
					 , HQLOCAT.DFIN
					 , HQLOCAT.NB
				FROM MASTER_ESTIA..ESTIA_LOCATION LOCATION
					INNER JOIN MASTER_ESTIA..ESTIA_HQLOCAT HQLOCAT
						ON LOCATION.PK_LOCATION = HQLOCAT.FK_BAIL
					INNER JOIN MASTER_ESTIA..ESTIA_GROUPE GROUPE
						ON GROUPE.PK_GROUPE = LOCATION.FK_GROUPE
					INNER JOIN MASTER_ESTIA..P_RUBRIQUE AS P
						ON P.CD_RUBRIQUE = HQLOCAT.CRUB
					INNER JOIN MASTER_ESTIA..ESTIA_RUB AS RUB
						ON RUB.CRUB = HQLOCAT.CRUB
					INNER JOIN MASTER_ESTIA..P_SOUS_REG_ELTFAC AS PSRE
						ON PSRE.CD_SOUS_REG_ELTFAC = P.CD_SOUS_REG_ELTFAC
				WHERE PSRE.IND_CALCUL_PALIER = 'O'
				AND HQLOCAT.DFIN >= @DT_ANALYSE
				AND LOCATION.PK_LOCATION = @PK_BAIL
				AND @ANNEE_PREV BETWEEN DATEPART(YEAR, HQLOCAT.DDEB) AND DATEPART(YEAR, HQLOCAT.DFIN)
			) SRC
		) SRC2
		GROUP BY PK_GROUPE, PK_BAIL, CORG, CAGENCE, CGROUPE, CIMMEUB, CLOCAL, OCC
	) SRC
)

-- copy the required columns to the result of the function   
   INSERT @retANNUAL_LEASE_ALLOWANCES  
   SELECT PK_GROUPE, PK_BAIL, MT_PALIER
   FROM ANNUAL_LEASE_ALLOWANCES_cte   
   RETURN  
END;