﻿
CREATE VIEW [dbo].[V_D_IMMEUBLE]
AS
SELECT GETDATE() AS DT_REF
	 , GROUPE.PK_GROUPE AS PK_IMMEUBLE
	 , 'ESTIA' AS CD_ORIGINE
	 , GROUPE.CORG AS CD_SOCIETE
	 , REPLACE(STR(GROUPE.CGROUPE, 4, 0), ' ', '0') AS CD_IMMEUBLE
	 , GROUPE.CGROUPE AS NM_IMMEUBLE
	 , GROUPE.LGROUPE AS ADRLGN1
	 , GROUPE.RUE AS ADRLGN2
	 , GROUPE.LIEUDIT AS ADRLGN3
	 , CONVERT(VARCHAR(76), NULL) AS ADRLGN4
	 , GROUPE.CPOS AS CODPOS
	 , GROUPE.VILLE, CONVERT(VARCHAR(1), 'G') AS CD_TYPE_IMMEUBLE
	 , CONVERT(VARCHAR(19), 'Immeuble de gestion') AS LB_TYPE_IMMEUBLE
	 , CONVERT(VARCHAR(3), NULL) AS CD_CLASSE_IMMEUBLE
	 , CONVERT(VARCHAR(30), NULL) AS LB_CLASSE_IMMEUBLE
	 , ISNULL(WGL.NB_BAUX_ACTIFS, 0) AS NB_LOTS_PRINCIPAUX
	 , ISNULL(WGS.NB_LOTS, 0) AS NB_LOTS
	 , ISNULL(WGS.SURF_HAB, 0) AS SURFACE_TOTALE
	 , GROUPE.DFCONS AS DT_ACHEVEMENT_TRAVAUX
	 , WGC.CD_RESPONSABLE_PATRIMOINE
	 , WGC.LB_RESPONSABLE_PATRIMOINE
	 , WGC.CD_RESPONSABLE_TRAVAUX
	 , WGC.LB_RESPONSABLE_TRAVAUX
	 , WGC.CD_RESPONSABLE_GROUPE
	 , WGC.LB_RESPONSABLE_GROUPE
	 , CONVERT(NUMERIC(6, 0), NULL) AS NM_RECETTE_IMPOTS
	 , CONVERT(NUMERIC(6, 0), NULL) AS NM_PERCEPTION
	 , WGC.CD_COMPTABLE_IMMEUBLE
	 , WGC.LB_COMPTABLE_IMMEUBLE
	 , WGC.CD_CONTROLEUR_GESTION
	 , WGC.LB_CONTROLEUR_GESTION
	 , WGC.CD_ASSET_MANAGER_CLIENT
	 , WGC.LB_ASSET_MANAGER_CLIENT
	 , WGC.CD_ETAT_GESTION
	 , WGC.LB_ETAT_GESTION
	 , WGC.CD_TYPOLOGIE_ACTIF
	 , WGC.LB_TYPOLOGIE_ACTIF
	 , WGC.CD_GERANCE_COPRO
	 , WGC.LB_GERANCE_COPRO
	 , WGC.CD_PROPRIETAIRE
	 , WGC.LB_PROPRIETAIRE
	 , WGC.CD_GROUPE_PROPRIETAIRE
	 , WGC.LB_GROUPE_PROPRIETAIRE
	 , WGC.CD_LOCALISATION
	 , WGC.LB_LOCALISATION
	 , P_VLM.VLM_ARC AS VLM_ARCHIVE
	 , P_VLM.VLM_PKG_SIMPLE
	 , P_VLM.VLM_PKG_DOUBLE
	 , PI.CHEMIN_PLAN
	 , PI.CHEMIN_ETAT_SURFACES
	 , PI.CHEMIN_TB
	 , PI.CHEMIN_TF
	 , CASE WHEN GROUPE.CAGENCE = 'RO' THEN 'TERTIAIRE' WHEN GROUPE.CAGENCE = 'PA' THEN 'RESIDENTIEL' END POLE_GESTION
	 , '\\viveris.local\VIVERIS-DFS\IMMO\DOCS IMMEUBLES\Mandats\' + WGM.CMANDAT + '.pdf' AS CHEMIN_MANDAT
FROM dbo.ESTIA_GROUPE AS GROUPE 
LEFT OUTER JOIN dbo.P_IMMEUBLE AS PI ON GROUPE.CORG = PI.CD_SOCIETE AND GROUPE.CAGENCE = PI.CD_AGENCE AND GROUPE.CGROUPE = PI.NM_IMMEUBLE 
LEFT OUTER JOIN dbo.WRK_GROUPE_LOCATION AS WGL ON GROUPE.CORG = WGL.CORG AND GROUPE.CAGENCE = WGL.CAGENCE AND GROUPE.CGROUPE = WGL.CGROUPE 
LEFT OUTER JOIN dbo.WRK_GROUPE_SURFACE AS WGS ON GROUPE.CORG = WGS.CORG AND GROUPE.CAGENCE = WGS.CAGENCE AND GROUPE.CGROUPE = WGS.CGROUPE 
LEFT OUTER JOIN dbo.WRK_GROUPE_CRITLIB AS WGC ON GROUPE.CGROUPE = WGC.CGROUPE AND GROUPE.CAGENCE = WGC.CAGENCE AND GROUPE.CORG = WGC.CORG 
LEFT OUTER JOIN dbo.P_VLM ON GROUPE.PK_GROUPE = P_VLM.PK_IMMEUBLE 
LEFT OUTER JOIN WRK_GROUPE_MANGES AS WGM ON GROUPE.CORG = WGM.CORG AND GROUPE.CAGENCE = WGM.CAGENCE AND GROUPE.CGROUPE = WGM.CGROUPE
WHERE GROUPE.CORG = '11'
AND GROUPE.CGROUPE NOT IN ('2222', '8888', '4027', '9999', '8510', '1024', '4444', '1111')