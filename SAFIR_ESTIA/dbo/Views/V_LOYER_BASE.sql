







CREATE VIEW [dbo].[V_LOYER_BASE]
AS
/*SELECT HQLOCAT.FK_BAIL, SUM(CASE WHEN PSRE.IND_CALCUL_LOYER = 'O' AND PSRE.IND_CALCUL_FRANCHISE = 'N'  
								 /*CASE WHEN P.IND_FRANCHISE_LOYER = 'N'*/ THEN HQLOCAT.NB /*ELSE 0 END*/ ELSE 0 END) AS MT_LOYER_BASE
FROM     MASTER_ESTIA.dbo.ESTIA_HQLOCAT AS HQLOCAT INNER JOIN
                      (SELECT FK_BAIL, MIN(DDEB) AS DDEB
                       FROM      MASTER_ESTIA.dbo.ESTIA_HQLOCAT
                       GROUP BY FK_BAIL) AS REQ ON REQ.FK_BAIL = HQLOCAT.FK_BAIL AND REQ.DDEB = HQLOCAT.DDEB INNER JOIN
                  MASTER_ESTIA.dbo.P_RUBRIQUE AS P ON P.CD_RUBRIQUE = HQLOCAT.CRUB INNER JOIN
                  MASTER_ESTIA.dbo.P_SOUS_REG_ELTFAC AS PSRE ON PSRE.CD_SOUS_REG_ELTFAC = P.CD_SOUS_REG_ELTFAC
GROUP BY HQLOCAT.FK_BAIL*/
select estia_hqlocat.fk_location as fk_bail, sum(estia_hqlocat.nb) mt_loyer_base
from master_estia..estia_hqlocat 
left join master_estia..p_rubrique
on p_rubrique.cd_rubrique = estia_hqlocat.crub
left join master_estia..p_sous_reg_eltfac psre
on psre.cd_sous_reg_eltfac = p_rubrique.cd_sous_reg_eltfac inner join
(
	select hqlocat.fk_location, min(ddeb) as ddeb
	from master_estia..estia_hqlocat hqlocat
	left join master_estia..p_rubrique
	on p_rubrique.cd_rubrique = hqlocat.crub
	left join master_estia..p_sous_reg_eltfac psre
	on psre.cd_sous_reg_eltfac = p_rubrique.cd_sous_reg_eltfac
	where /*hqlocat.corg = 11 and hqlocat.cagence = 'PA' and hqlocat.cgroupe = 1044 and hqlocat.cimmeub = 11 and hqlocat.clocal = 3001 and hqlocat.occ = 1
	and*/ psre.ind_calcul_loyer = 'O' and psre.ind_calcul_franchise = 'N' and psre.ind_calcul_palier = 'N' and p_rubrique.cd_sous_reg_eltfac <> 'LOR'
	group by fk_location
) req
on req.fk_location = estia_hqlocat.fk_location and req.ddeb = estia_hqlocat.ddeb
where psre.ind_calcul_loyer = 'O' and psre.ind_calcul_franchise = 'N' and psre.ind_calcul_palier = 'N' and p_rubrique.cd_sous_reg_eltfac <> 'LOR'
group by estia_hqlocat.fk_location
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LOYER_BASE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[27] 2[22] 3) )"
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
         Begin Table = "HQLOCAT"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 308
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "REQ"
            Begin Extent = 
               Top = 7
               Left = 356
               Bottom = 124
               Right = 616
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 7
               Left = 664
               Bottom = 168
               Right = 976
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PSRE"
            Begin Extent = 
               Top = 7
               Left = 1024
               Bottom = 168
               Right = 1313
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
      Begin ColumnWidths = 9
         Width = 284
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
      Begin ColumnWidths = 12
         Column = 3240
         Alias = 1668
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LOYER_BASE';

