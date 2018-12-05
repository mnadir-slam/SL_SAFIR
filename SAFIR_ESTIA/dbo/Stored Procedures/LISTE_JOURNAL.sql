-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_JOURNAL] 
(
	@DT_DEBUT DATETIME,
	@DT_FIN DATETIME,
	@UTIL NVARCHAR(MAX),
	@TYPE_FACTURE NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select distinct CJOURNAL
from
(
	select DATEPART(MONTH, ENTFAC.DATEC) AS MOIS
		 , DATEPART(YEAR, ENTFAC.DATEC) AS ANNEE
		 , ENTFAC.UTIL
		 , MENPRIN.LUTIL
		 , upper(ENTFAC.CJOURNAL) AS CJOURNAL
		 , 'FPS' AS CD_TYPE_FACTURE
		 , 'Factures pré saisies' AS LB_TYPE_FACTURE
	from MASTER_ESTIA..ESTIA_ENTFAC ENTFAC
	left join MASTER_ESTIA..ESTIA_MENPRIN MENPRIN
	on MENPRIN.UTIL = ENTFAC.UTIL
	where ENTFAC.DATEC between @DT_DEBUT and @DT_FIN
	union
	select DATEPART(MONTH, ECRITAUX.DATEC) AS MOIS
		 , DATEPART(YEAR, ECRITAUX.DATEC) AS ANNEE
		 , ECRITAUX.UTIL
		 , MENPRIN.LUTIL
		 , upper(ECRITAUX.CJOURNAL) AS CJOURNAL
		 , 'FS' AS CD_TYPE_FACTURE
		 , 'Factures saisies' AS LB_TYPE_FACTURE
	from MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
	left join MASTER_ESTIA..ESTIA_MENPRIN MENPRIN
	on MENPRIN.UTIL = ECRITAUX.UTIL
	where ECRITAUX.DATEC between @DT_DEBUT and @DT_FIN
) SRC
where CD_TYPE_FACTURE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@TYPE_FACTURE,',')) 
and UTIL IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@UTIL,',')) 
order by CJOURNAL

END