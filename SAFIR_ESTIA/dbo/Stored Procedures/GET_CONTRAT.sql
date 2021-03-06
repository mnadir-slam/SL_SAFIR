﻿
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_CONTRAT] 
(
	@PK_IMMEUBLE NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT CTR.PK_CTRTIERS
		 , T.PK_TIERS
		 , CASE CTR.PK_CTRTIERS WHEN 2009 THEN 184 WHEN 1785 THEN 176 ELSE IMMEUBLE.PK_GROUPE END AS FK_IMMEUBLE
		 , CASE CTR.PK_CTRTIERS WHEN 2009 THEN '65 BD GENERAL DE GAULLE - 3406' 
								 WHEN 1785 THEN '85 AV. GENERAL-LECLERC 6141' 
			ELSE UPPER(IMMEUBLE.LGROUPE) END AS NOM_IMMEUBLE
		 , CTR.CORG
		 , CTR.CCONTFRS AS NUM_CONTRAT
		 , UPPER(CTR.LCTRTIERS) + ' - ' + CTR.LIBFAC AS LB_CONTRAT
		 , CTR.CTIERS AS CD_FOURNISSEUR
		 , UPPER(T.LTIERS) AS NOM_FOURNISSEUR
		 , DATEADD(YEAR , DATEDIFF(YEAR, 0, GETDATE()), 0) AS DT_DEBUT_VALIDITE --, CTR.DDEBVAL AS DT_DEBUT_VALIDITE
		 , CTR.DLIMPREST AS DT_FIN_PRESTATION
		 , CTR.DURCONT AS DUREE_CONTRAT
		 , CONTNAT.MT_CONTRAT + ISNULL(AVENANT_CTR.MT_AVENANT_CONTRAT, 0) AS MT_CONTRAT_INIT
		 --, EB.MT_CONTRAT_REALISE
		 , ECRITAUX.MT_CONTRAT_REALISE 
		 , '\\viveris.local\VIVERIS-DFS\IMMO\DOCS IMMEUBLES\Contrats d''entretien\Contrats\' + RIGHT(CTR.CCONTFRS, 5) + '.pdf' AS CHEMIN_CONTRAT
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
	--LEFT JOIN
	--(
	--	SELECT DISTINCT B.FK_CTRTIERS
	--		 , B.FK_TIERS
	--		 , B.CORG
	--		 , B.CEXO 
	--		 , B.REF
	--		 --, SUM(MONTANT) AS MT_CONTRAT_REALISE
	--	FROM MASTER_ESTIA..ESTIA_ECRIB B
	--	WHERE B.TYPBON = 'CTR' 
	--	AND B.CORG = '11'
	--	AND B.FK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	--	--AND B.CCRITDP IN (1001, 1002, 1003, 1004, 1005, 1006, 1012, 9003, 9004, 9005, 9006, 9012)
	--	AND B.CSTE IN  ('RE')
	--	AND B.CEXO = DATEPART(YEAR, GETDATE())
	--	--GROUP BY B.FK_CTRTIERS, B.FK_TIERS, B.CORG, B.CEXO
	--) EB
	--ON EB.FK_CTRTIERS = CTR.PK_CTRTIERS
	-- debut modif MNA 240418
	LEFT JOIN
	(
		SELECT EB.FK_CTRTIERS
		     , EB.FK_TIERS
			 , EB.FK_GROUPE
			 , ECRITAUX.CORG--, ECRITAUX.REF
			 , SUM(ECRITAUX.MONTANT) AS MT_CONTRAT_REALISE
		FROM MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
		LEFT JOIN
		(
			SELECT DISTINCT B.FK_CTRTIERS
				 , B.FK_TIERS
				 , B.FK_GROUPE
				 , B.CORG
				 , B.CEXO 
				 , B.REF
			FROM MASTER_ESTIA..ESTIA_ECRIB B
			WHERE B.TYPBON = 'CTR' 
			AND B.CORG = '11'
			AND B.FK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
			AND B.CSTE IN  ('RE')
			AND B.CEXO = DATEPART(YEAR, GETDATE())
		) EB
		ON ECRITAUX.CORG = EB.CORG AND ECRITAUX.REF = EB.REF
		WHERE ECRITAUX.CORG = '11'
		AND ECRITAUX.CTYPECRI = 'FAC'
		GROUP BY EB.FK_CTRTIERS, EB.FK_TIERS, EB.FK_GROUPE, ECRITAUX.CORG--, ECRITAUX.REF
		--GROUP BY ECRITAUX.CORG, ECRITAUX.REF
	) ECRITAUX
	--ON ECRITAUX.CORG = EB.CORG AND ECRITAUX.REF = EB.REF
	ON ECRITAUX.CORG = CTR.CORG AND ECRITAUX.FK_CTRTIERS = CTR.PK_CTRTIERS AND ECRITAUX.FK_TIERS = T.PK_TIERS 
	-- fin modif MNA 240418
	LEFT JOIN 
	(
		SELECT CORG
			 , CCONTFRS
			 --, SUM(MTHT) AS MT_CONTRAT
			 , ISNULL(SUM(MTTC), 0) AS MT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_CONTNAT 
		GROUP BY CORG, CCONTFRS
	) CONTNAT
	ON CONTNAT.CORG = CTR.CORG AND CONTNAT.CCONTFRS = CTR.CCONTFRS
	LEFT JOIN 
	(
		SELECT CORG
			 , CCONTFRS
			 , ISNULL(SUM(MTTC), 0) AS MT_AVENANT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_AVENAN
		WHERE DSIGN >= DATEADD(YEAR , DATEDIFF(YEAR, 0, GETDATE()), 0)
		GROUP BY CORG, CCONTFRS
	) AVENANT_CTR
	ON AVENANT_CTR.CORG = CTR.CORG AND AVENANT_CTR.CCONTFRS = CTR.CCONTFRS
	WHERE CTR.DDEBVAL <= GETDATE()
	AND CTR.DLIMPREST >= GETDATE()
	AND CTR.CORG = '11'
	AND IMMEUBLE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	ORDER BY IMMEUBLE.LGROUPE, T.LTIERS, CTR.CCONTFRS;

END