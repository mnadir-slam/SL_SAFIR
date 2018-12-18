﻿
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_DETAIL_CONTRAT] 
(
	@PK_IMMEUBLE NVARCHAR(MAX),
	@PK_TIERS NVARCHAR(MAX),
	@PK_CTRTIERS NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT CTR.PK_CTRTIERS
		 , T.PK_TIERS
		 , CASE CTR.PK_CTRTIERS WHEN 2009 THEN 184 WHEN 1785 THEN 176 ELSE IMMEUBLE.PK_GROUPE END AS FK_IMMEUBLE
		 ,  CASE CTR.PK_CTRTIERS WHEN 2009 THEN '65 BD GENERAL DE GAULLE - 3406' 
								 WHEN 1785 THEN '85 AV. GENERAL-LECLERC 6141' 
			ELSE UPPER(IMMEUBLE.LGROUPE) END AS NOM_IMMEUBLE
		 , CTR.CORG
		 , CTR.CCONTFRS AS NUM_CONTRAT
		 , UPPER(CTR.LCTRTIERS) AS LB_CONTRAT
		 , CTR.CTIERS AS CD_FOURNISSEUR
		 , UPPER(T.LTIERS) AS NOM_FOURNISSEUR
		 , CONTNAT.MT_CONTRAT AS MT_CONTRAT_INIT
		 , ECRITAUX.DATEC
		 , ECRITAUX.LIBELLE
		 , ECRITAUX.CRITERE
		 , ISNULL(ECRITAUX.MT_CONTRAT_REALISE, 0) AS MT_CONTRAT_REALISE
		 , ECRITAUX.REF
		 , ECRITAUX.NOPIECE
		 , ECRITAUX.NOFACT
		 , ECRITAUX.UTIL
	FROM MASTER_ESTIA..ESTIA_CTRTIERS CTR
	LEFT JOIN MASTER_ESTIA..ESTIA_TIERS T
	ON T.PK_TIERS = CTR.FK_TIERS
	LEFT JOIN
	(
		SELECT DISTINCT FK_CTRTIERS, FK_GROUPE AS FK_IMMEUBLE
		FROM MASTER_ESTIA..ESTIA_VENTPCHA
	) VENTPCHA
	ON VENTPCHA.FK_CTRTIERS = CTR.PK_CTRTIERS
	LEFT JOIN MASTER_ESTIA..ESTIA_GROUPE IMMEUBLE
	ON IMMEUBLE.PK_GROUPE = VENTPCHA.FK_IMMEUBLE
	LEFT JOIN
	(
		SELECT EC.FK_CTRTIERS
			 , EC.FK_TIERS
			 , EC.PK_GROUPE
			 , ECRITAUX.CORG
			 , EC.CEXO
			 , ECRITAUX.DATEC
			 , ECRITAUX.LIBELLE
			 , EC.CCRITDP AS CRITERE
			 , EC.MONTANT AS MT_CONTRAT_REALISE
			 , ECRITAUX.REF
			 , ECRITAUX.NOPIECE
			 , ECRITAUX.NOFACT
			 , UPPER(ECRITAUX.UTIL) AS UTIL
		FROM MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
		LEFT JOIN
		(
			SELECT E.FK_CTRTIERS
			     , E.FK_TIERS
				 , WGM.PK_GROUPE
				 , ECRAC.CORG
				 , EB.CCRITDP
				 , ECRAC.REF
				 , ECRAC.ORD
				 , ISNULL(EB.CEXO, DATEPART(YEAR, GETDATE())) AS CEXO
				 , ECRAC.MONTANT
			FROM MASTER_ESTIA..ESTIA_ECRAC ECRAC
			LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
			ON WGM.CORG = ECRAC.CORG AND WGM.CMANDAT = ECRAC.CMANDAT
			LEFT JOIN
			(
			  SELECT ECRIB.FK_CTRTIERS
				   , ECRITAUX.FK_TIERS
			       , ECRITAUX.CORG
				   , ECRITAUX.REF
			  FROM  MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
			  LEFT JOIN
			  (
				SELECT DISTINCT FK_CTRTIERS, CORG, REF
				FROM MASTER_ESTIA..ESTIA_ECRIB B
			  ) ECRIB
			  ON ECRIB.CORG = ECRITAUX.CORG AND ECRIB.REF = ECRITAUX.REF
			) E
			ON E.CORG  = ECRAC.CORG AND E.REF = ECRAC.REF
			LEFT JOIN
			(
				SELECT DISTINCT B.FK_CTRTIERS
					 , B.FK_TIERS
					 , B.CORG
					 , B.CEXO 
					 , B.REF
					 , B.CCRITDP
					 , B.ORD
				FROM MASTER_ESTIA..ESTIA_ECRIB B
				WHERE B.TYPBON = 'CTR' 
				AND B.CORG = '11'
				AND B.CSTE IN  ('RE')
				AND B.CEXO = DATEPART(YEAR, GETDATE())
			) EB
			ON EB.CORG = ECRAC.CORG AND EB.REF = ECRAC.REF AND EB.ORD = ECRAC.ORD
			WHERE ECRAC.CORG = '11'
			AND ECRAC.SENS = 'D'
			--AND ECRAC.REF = 'M0009257614'
		) EC
		ON EC.CORG = ECRITAUX.CORG AND EC.REF = ECRITAUX.REF
		WHERE ECRITAUX.CTYPECRI = 'FAC'
		AND ECRITAUX.CORG = '11'
		--AND ECRITAUX.REF = 'M0009257614'
	) ECRITAUX
	ON ECRITAUX.CORG = CTR.CORG  AND ECRITAUX.FK_CTRTIERS = CTR.PK_CTRTIERS AND ECRITAUX.FK_TIERS = T.PK_TIERS
	--LEFT JOIN
	--(
	--	SELECT EB.FK_CTRTIERS
	--		 , EB.FK_TIERS
	--		 , EB.FK_GROUPE
	--		 , ECRITAUX.CORG
	--		 , EB.CEXO
	--		 , ECRITAUX.DATEC
	--		 , ECRITAUX.LIBELLE
	--		 , EB.CCRITDP AS CRITERE
	--		 --, CASE ECRITAUX.SENS WHEN 'C' THEN ECRITAUX.MONTANT ELSE -ECRITAUX.MONTANT END AS MT_CONTRAT_REALISE
	--		 , EB.MT_CONTRAT_REALISE
	--		 , ECRITAUX.REF
	--		 , ECRITAUX.NOPIECE
	--		 , ECRITAUX.NOFACT
	--		 , UPPER(ECRITAUX.UTIL) AS UTIL
	--	FROM MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
	--	LEFT JOIN
	--	(
	--		SELECT DISTINCT B.FK_CTRTIERS
	--			 , B.FK_TIERS
	--			 , B.FK_GROUPE
	--			 , B.CORG
	--			 , B.CEXO 
	--			 , B.REF
	--			 , B.CCRITDP
	--			 , CASE B.SENS WHEN 'D' THEN B.MONTANT ELSE -B.MONTANT END AS MT_CONTRAT_REALISE
	--		FROM MASTER_ESTIA..ESTIA_ECRIB B
	--		WHERE B.TYPBON = 'CTR' 
	--		AND B.CORG = '11'
	--		AND B.FK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	--		AND B.FK_TIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_TIERS,','))
	--		AND B.CSTE IN  ('RE')
	--		AND B.CEXO = DATEPART(YEAR, GETDATE())
	--	) EB
	--	ON ECRITAUX.CORG = EB.CORG AND ECRITAUX.REF = EB.REF
	--	WHERE ECRITAUX.CTYPECRI = 'FAC'
	--	AND ECRITAUX.CORG = '11'
	--) ECRITAUX
	--ON ECRITAUX.CORG = CTR.CORG  AND ECRITAUX.FK_CTRTIERS = CTR.PK_CTRTIERS AND ECRITAUX.FK_TIERS = T.PK_TIERS
	LEFT JOIN 
	(
		SELECT CORG, CCONTFRS, 
		SUM(MTHT) AS MT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_CONTNAT 
		GROUP BY CORG, CCONTFRS
	) CONTNAT
	ON CONTNAT.CORG = CTR.CORG AND CONTNAT.CCONTFRS = CTR.CCONTFRS
	WHERE CTR.DLIMPREST >= GETDATE()
	AND IMMEUBLE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	AND T.PK_TIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_TIERS,','))
	AND CTR.PK_CTRTIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_CTRTIERS,','))
	ORDER BY IMMEUBLE.LGROUPE, T.LTIERS, CTR.CCONTFRS;

	--SELECT CTR.PK_CTRTIERS
	--	 , T.PK_TIERS
	--	 , CASE CTR.PK_CTRTIERS WHEN 2009 THEN 184 WHEN 1785 THEN 176 ELSE IMMEUBLE.PK_GROUPE END AS FK_IMMEUBLE
	--	 ,  CASE CTR.PK_CTRTIERS WHEN 2009 THEN '65 BD GENERAL DE GAULLE - 3406' 
	--							 WHEN 1785 THEN '85 AV. GENERAL-LECLERC 6141' 
	--		ELSE UPPER(IMMEUBLE.LGROUPE) END AS NOM_IMMEUBLE
	--	 , CTR.CORG
	--	 , CTR.CCONTFRS AS NUM_CONTRAT
	--	 , UPPER(CTR.LCTRTIERS) AS LB_CONTRAT
	--	 , CTR.CTIERS AS CD_FOURNISSEUR
	--	 , UPPER(T.LTIERS) AS NOM_FOURNISSEUR
	--	 , CONTNAT.MT_CONTRAT AS MT_CONTRAT_INIT
	--	 , EB.DATEC
	--	 , EB.LIBELLE
	--	 , EB.CRITERE
	--	 , ISNULL(EB.MT_CONTRAT_REALISE, 0) AS MT_CONTRAT_REALISE
	--	 , EB.REF
	--	 , EB.NOPIECE
	--	 , EB.NOFACT
	--	 , EB.UTIL
	--FROM MASTER_ESTIA..ESTIA_CTRTIERS CTR
	--LEFT JOIN MASTER_ESTIA..ESTIA_TIERS T
	--ON T.PK_TIERS = CTR.FK_TIERS
	--LEFT JOIN
	--(
	--	SELECT DISTINCT FK_CTRTIERS, FK_GROUPE AS FK_IMMEUBLE
	--	FROM MASTER_ESTIA..ESTIA_VENTPCHA
	--) VENTPCHA
	--ON VENTPCHA.FK_CTRTIERS = CTR.PK_CTRTIERS
	--LEFT JOIN MASTER_ESTIA..ESTIA_GROUPE IMMEUBLE
	--ON IMMEUBLE.PK_GROUPE = VENTPCHA.FK_IMMEUBLE
	--LEFT JOIN
	--(
	--	SELECT B.FK_CTRTIERS
	--		 , B.FK_TIERS
	--		 , B.CORG
	--		 , B.CEXO 
	--		 , B.DATEC
	--		 , B.LIBELLE
	--		 , B.CCRITDP AS CRITERE
	--		 , CASE B.SENS WHEN 'D' THEN B.MONTANT ELSE -B.MONTANT END AS MT_CONTRAT_REALISE
	--		 , B.REF
	--		 , B.NOPIECE
	--		 , T.NOFACT
	--		 , UPPER(B.UTIL) AS UTIL
	--	FROM MASTER_ESTIA..ESTIA_ECRIB B
	--	LEFT JOIN MASTER_ESTIA..ESTIA_ECRITAUX T
	--	ON T.CORG = B.CORG AND T.REF = B.REF
	--	WHERE B.TYPBON = 'CTR' 
	--	AND B.CORG = '11'
	--	AND B.FK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	--	--AND B.CCRITDP IN (1001, 1002, 1003, 1004, 1005, 1006, 1012, 9003, 9004, 9005, 9006, 9012)
	--	AND B.CSTE IN  ('RE')
	--	AND B.CEXO = DATEPART(YEAR, GETDATE())		
	--) EB
	--ON EB.FK_CTRTIERS = CTR.PK_CTRTIERS
	--LEFT JOIN 
	--(
	--	SELECT CORG, CCONTFRS, 
	--	SUM(MTHT) AS MT_CONTRAT
	--	FROM MASTER_ESTIA..ESTIA_CONTNAT 
	--	GROUP BY CORG, CCONTFRS
	--) CONTNAT
	--ON CONTNAT.CORG = CTR.CORG AND CONTNAT.CCONTFRS = CTR.CCONTFRS
	--WHERE CTR.DLIMPREST >= GETDATE()
	--AND IMMEUBLE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	--AND T.PK_TIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_TIERS,','))
	--ORDER BY IMMEUBLE.LGROUPE, T.LTIERS, CTR.CCONTFRS;

	END