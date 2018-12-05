

CREATE VIEW [dbo].[V_NEW_LEASES]
AS
--SELECT LOCATION.CGROUPE AS NM_IMMEUBLE, GROUPE.LGROUPE AS NOM_IMMEUBLE, CAST(RIGHT(LOCATION.CCOMPTE, 4) AS VARCHAR(4)) 
--                  + CAST(LOCATION.NOBAIL AS VARCHAR(3)) AS NOM_DU_FICHIARNom_du_fichier_Pdf, LOCATION.CCOMPTE AS IDENTIFIANT_ESTIA_COMPTE, 
--                  LOCATION.NOBAIL AS NOBAIL_ESTIA, TIERS.LTIERS AS LOCATAIRE_PRINCIPAL, LOCATION.DATEFFET, ISNULL(LOCATION.DATFIN, DATEADD(MONTH, 
--                  LOCATION.DURBAIL, LOCATION.DATEFFET)) AS DATFIN
--FROM     dbo.ESTIA_LOCATION AS LOCATION LEFT OUTER JOIN
--                  dbo.ESTIA_GROUPE AS GROUPE ON GROUPE.PK_GROUPE = LOCATION.FK_GROUPE LEFT OUTER JOIN
--                  dbo.ESTIA_LIENLOC AS LIENLOC ON LIENLOC.CORG = LOCATION.CORG AND LIENLOC.CCOMPTE = LOCATION.CCOMPTE AND LIENLOC.RK = 1 LEFT OUTER JOIN
--                  dbo.ESTIA_TIERS AS TIERS ON TIERS.CTYPTIERS = LIENLOC.CTYPTIERS AND TIERS.CTIERS = LIENLOC.CTIERS
--WHERE  (LOCATION.CORG = '11') AND (LOCATION.NOLOCAT = LOCATION.CONTLOC) AND (LOCATION.DATEFFET > GETDATE())
--SELECT 'BAIL' + REPLICATE('0', 6 - LEN(LAST_IDENT + RK)) + cast(LAST_IDENT + RK as NVARCHAR(4000)) AS [Identifiant_bail _DREAM],
--IDENTIFIANT_ESTIA_IMMEUBLE, NOM_DU_FICHIER_PDF, IDENTIFIANT_ESTIA_COMPTE, NOBAIL_ESTIA, CAST(LOCATAIRE_PRINCIPAL AS NVARCHAR(255)) AS LOCATAIRE_PRINCIPAL,
-- DT_EFFET, DT_FIN
--FROM 
--(
--	SELECT (SELECT CAST(RIGHT(MAX([IDENTIFIANT_BAIL _DREAM]), 6) AS NUMERIC(6,0)) FROM L_INTERFACE_SALEFORCE_BAUX) AS LAST_IDENT,
--	LOCATION.CGROUPE AS IDENTIFIANT_ESTIA_IMMEUBLE, GROUPE.LGROUPE AS NOM_IMMEUBLE, CAST(RIGHT(LOCATION.CCOMPTE, 4) AS VARCHAR(4)) 
--					  + CAST(LOCATION.NOBAIL AS VARCHAR(3)) AS NOM_DU_FICHIER_PDF, LOCATION.CCOMPTE AS IDENTIFIANT_ESTIA_COMPTE, LOCATION.NOBAIL AS NOBAIL_ESTIA, 
--					  TIERS.LTIERS AS LOCATAIRE_PRINCIPAL, LOCATION.DATEFFET AS DT_EFFET, ISNULL(LOCATION.DATFIN, DATEADD(MONTH, LOCATION.DURBAIL, LOCATION.DATEFFET)) 
--					  AS DT_FIN, RANK() OVER (PARTITION BY LOCATION.CORG ORDER BY LOCATION.CCOMPTE) RK
--	FROM     dbo.ESTIA_LOCATION AS LOCATION LEFT OUTER JOIN
--					  dbo.ESTIA_GROUPE AS GROUPE ON GROUPE.PK_GROUPE = LOCATION.FK_GROUPE LEFT OUTER JOIN
--					  dbo.ESTIA_LIENLOC AS LIENLOC ON LIENLOC.CORG = LOCATION.CORG AND LIENLOC.CCOMPTE = LOCATION.CCOMPTE AND LIENLOC.RK = 1 LEFT OUTER JOIN
--					  dbo.ESTIA_TIERS AS TIERS ON TIERS.CTYPTIERS = LIENLOC.CTYPTIERS AND TIERS.CTIERS = LIENLOC.CTIERS
--	WHERE  (LOCATION.CORG = '11') AND (LOCATION.NOLOCAT = LOCATION.CONTLOC) AND (LOCATION.DATEFFET > GETDATE())
--) REQ

SELECT 
       'BAIL' + cast(dbo.LPAD(LAST_IDENT + RK, 6, '0') as NVARCHAR(251)) AS [Identifiant_bail _DREAM],
IDENTIFIANT_ESTIA_IMMEUBLE, NOM_DU_FICHIER_PDF, IDENTIFIANT_ESTIA_COMPTE, NOBAIL_ESTIA, CAST(LOCATAIRE_PRINCIPAL AS NVARCHAR(255)) AS LOCATAIRE_PRINCIPAL,
 DT_EFFET, DT_FIN
FROM 
(
	select (SELECT CAST(RIGHT(MAX([IDENTIFIANT_BAIL _DREAM]), 6) AS NUMERIC(6,0)) FROM TEMP_INTERFACE_SALEFORCE_BAUX) AS LAST_IDENT,
	W.IDENTIFIANT_ESTIA_IMMEUBLE, W.NOM_IMMEUBLE, W.NOM_DU_FICHIER_PDF, W.IDENTIFIANT_ESTIA_COMPTE, W.NOBAIL_ESTIA, W.LOCATAIRE_PRINCIPAL,
	W.DT_EFFET, W.DT_FIN, RANK() OVER (PARTITION BY (SELECT CAST(RIGHT(MAX([IDENTIFIANT_BAIL _DREAM]), 6) AS NUMERIC(6,0)) FROM L_INTERFACE_SALEFORCE_BAUX) ORDER BY W.NOM_DU_FICHIER_PDF) RK
	from WRK_INTERFACE_SALEFORCE_BAUX W
	left join
	((select IDENTIFIANT_ESTIA_IMMEUBLE, NOM_DU_FICHIER_PDF
	from WRK_INTERFACE_SALEFORCE_BAUX
	where PK_TEMPS = CONVERT(DATE, DATEADD(day, -1, GETDATE()), 103))
	except
	(select IDENTIFIANT_ESTIA_IMMEUBLE, NOM_DU_FICHIER_PDF
	from WRK_INTERFACE_SALEFORCE_BAUX
	where PK_TEMPS = CONVERT(DATE, DATEADD(day, -2, GETDATE()), 103))) REQ
	on req.IDENTIFIANT_ESTIA_IMMEUBLE = W.IDENTIFIANT_ESTIA_IMMEUBLE and req.NOM_DU_FICHIER_PDF = w.NOM_DU_FICHIER_PDF
	AND NOT EXISTS
	(
		SELECT T.IDENTIFIANT_ESTIA_IMMEUBLE
		 , T.NOM_DU_FICHIER_PDF 
		FROM TEMP_INTERFACE_SALEFORCE_BAUX T
		WHERE T.IDENTIFIANT_ESTIA_IMMEUBLE = W.IDENTIFIANT_ESTIA_IMMEUBLE AND T.NOM_DU_FICHIER_PDF = W.NOM_DU_FICHIER_PDF
	)
)REQ
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_NEW_LEASES';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'0
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2976
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_NEW_LEASES';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[25] 2[24] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LOCATION"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GROUPE"
            Begin Extent = 
               Top = 7
               Left = 340
               Bottom = 168
               Right = 601
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LIENLOC"
            Begin Extent = 
               Top = 7
               Left = 649
               Bottom = 168
               Right = 893
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TIERS"
            Begin Extent = 
               Top = 7
               Left = 941
               Bottom = 168
               Right = 1185
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
         Width = 284
         Width = 1476
         Width = 1920
         Width = 1968
         Width = 2604
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3348
         Alias = 1716
         Table = 1170
         Output = 72', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_NEW_LEASES';

