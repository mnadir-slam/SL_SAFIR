﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GLIPRO] 
( 
	@DT_DEBUT DATETIME,
	@DT_FIN DATETIME,
	--@CD_SOC NVARCHAR(MAX),
	@PK_PROPRIETAIRE NVARCHAR(MAX),
	@PK_IMMEUBLE NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT WGM.FK_TIERS
	 , WGM.PK_GROUPE
     , ECRAC.CORG
	 , ECRAC.CJOURNAL
	 , ECRAC.DATEC
	 , ECRAC.DVAL
	 , ECRAC.CCG
	 , ECRAC.LIBELLE
	 , ECRAC.SENS
	 , ECRAC.MONTANT
	 , ECRAC.CTYPECRI
	 , ECRAC.NOPIECE
	 , ECRAC.REF
	 , ECRAC.TRAIT
	 , ECRAC.TYPCPTA
	 , ECRAC.PERIODE
	 , ECRAC.BANAL
	 , ECRAC.ORD
	 , ECRAC.NODOC
	 , ECRAC.INTERFACE
	 , ECRAC.UTIL
	 , ECRAC.INFO
	 , ECRAC.ECCG
	 , ECRAC.MTLET
	 , ECRAC.CMANDAT
	 , ECRAC.ECRAC_ID  
FROM MASTER_ESTIA..ESTIA_ECRAC ECRAC
LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
ON WGM.FK_MANGES = ECRAC.FK_MANGES
LEFT JOIN MASTER_ESTIA..ESTIA_TIERS TIERS
ON TIERS.PK_TIERS = WGM.FK_TIERS
left join
(
	select LIENMO.CORG, LIENMO.BANOPE as BANAL_OPE, LIENMO.BANMAR as BANAL_MAR
	from MASTER_ESTIA..ESTIA_LIENMO LIENMO
	where LIENMO.CSTE = 'Q'
	--and LIENMO.CORG IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@CD_SOC,',')) 
	and LIENMO.corg = '11'
) LIENMO
on LIENMO.CORG = ECRAC.CORG and LIENMO.BANAL_OPE = ECRAC.REF
left join
(
	select CPTGLOB.CORG, CPTGLOB.REF, CPTGLOB.NOCHEQUE as AVIS_ECHEANCE
	from MASTER_ESTIA..ESTIA_CPTGLOB CPTGLOB
	where CPTGLOB.TYPCPTA = 'LG'
	--and CPTGLOB.CORG IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@CD_SOC,',')) 
	AND CPTGLOB.CORG = '11'
) CPTGLOB
on CPTGLOB.CORG = LIENMO.CORG and CPTGLOB.REF = LIENMO.BANAL_MAR
--WHERE ECRAC.CORG IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@CD_SOC,','))  
WHERE ECRAC.CORG = '11'
and ECRAC.DATEC between @DT_DEBUT and @DT_FIN --'20161210' AND '20170310'
and WGM.FK_TIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_PROPRIETAIRE,','))  --(10852, 5879, 6318)
and WGM.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
and ECRAC.ETECR in ('N', 'E')
and ECRAC.CCG not in ('80100000', '80910000')
ORDER BY ECRAC.CMANDAT
	   , WGM.CGROUPE 
	   , TIERS.CTIERS
	   , ECRAC.DATEC

END