﻿CREATE FUNCTION [dbo].[f_HIST_BAUX] 
(
	@PK_PROPRIETAIRE INT,
	@PK_IMMEUBLE NVARCHAR(MAX)
)
RETURNS @retHIST_BAUX TABLE   
(  
	FK_BAIL int,
	CMANDAT  varchar(16) NULL,
	LTIERS varchar(76) NULL,
	CAGENCE varchar(4) NULL,
	CGROUPE int NULL,
	CIMMEUB int NULL,
	CLOCAL int NULL,
	CCOMPTE varchar(22) NULL,
	DATEFFET date,
	DATENTQUIT date,
	DATSORQUIT date
)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN  
WITH HIST_BAUX_cte(FK_BAIL, CMANDAT, LTIERS, CAGENCE, CGROUPE, CIMMEUB, CLOCAL, CCOMPTE, DATEFFET, DATENTQUIT, DATSORQUIT)
AS
(
	select WHL.FK_BAIL
		 , WHL.CMANDAT
		 , PROP.LTIERS
		 , WHL.CAGENCE
		 , dbo.LPAD(WHL.CGROUPE, 4, '0') AS CGROUPE
		 , WHL.CIMMEUB
		 , dbo.LPAD(WHL.CLOCAL, 4, '0') AS CLOCAL
		 , WHL.CCOMPTE
		 , LOCATION.DATEFFET
		 , WHL.DATENTQUIT
		 , WHL.DATSORQUIT
	from MASTER_ESTIA..WRK_HISTO_LOT WHL
	left join MASTER_ESTIA..ESTIA_TIERS PROP
	on PROP.PK_TIERS = WHL.FK_PROPRIETAIRE
	left join MASTER_ESTIA..ESTIA_GROUPE GROUPE
	on GROUPE.PK_GROUPE = WHL.FK_GROUPE 
	left join MASTER_ESTIA..ESTIA_LOCATION LOCATION
	on LOCATION.PK_LOCATION = WHL.FK_BAIL
	where CD_STATUT = 'L'
	and WHL.CORG = '11'
	AND PROP.PK_TIERS = @PK_PROPRIETAIRE
	AND GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
)

-- copy the required columns to the result of the function   
   INSERT @retHIST_BAUX 
   SELECT FK_BAIL, CMANDAT, LTIERS, CAGENCE, CGROUPE, CIMMEUB, CLOCAL, CCOMPTE, DATEFFET, DATENTQUIT, DATSORQUIT
   FROM HIST_BAUX_cte   
   RETURN  
END;