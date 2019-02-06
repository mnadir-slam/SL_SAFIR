﻿






CREATE VIEW [dbo].[V_D_FOURNISSEUR]
AS
--SELECT DISTINCT 
--                         TIERS.CTIERS AS CD_FOURNISSEUR, CASE WHEN ISNUMERIC(TIERS.CTIERS) <> 0 THEN CONVERT(INT, TIERS.CTIERS) END AS NM_FOURNISSEUR, TIERS.CQC AS CD_QUALITE_CIVILE, 
--                         QC.LQC AS LB_QUALITE_CIVILE, TIERS.LTIERS AS NOM_FOURNISSEUR, TIERS.PRENOM AS PRENOM_FOURNISSEUR, TIERS.RTIERS AS CPLT_NOM_FOURNISSEUR, TIERS.RUE AS ADRLGN1, 
--                         TIERS.COMMUNE AS ADRLGN2, TIERS.CPOS AS CODPOS, TIERS.BDIS AS VILLE, TIERS.CPAYS AS CD_PAYS, TIERS.TEL AS TELEPHONE, TIERS.TELECOP AS FAX, TIERS.INTERNET AS EMAIL, 
--                         UPPER(TIERSF.CMODREG) AS CD_MODE_REGLEMENT, TIERS.SIRET, BANQUE.LBANQUE, CONVERT(VARCHAR(30), TIERSF.CBANQUE) AS CBANQUE, TIERSF.GUICHET, CONVERT(VARCHAR(30), TIERSF.NUMCPTE) AS NUMCPTE, CASE WHEN LEN(TIERSF.RIB) 
--                         < 2 THEN CAST('0' AS VARCHAR(1)) + CAST(TIERSF.RIB AS VARCHAR(2)) ELSE TIERSF.RIB END AS RIB, 'EUR' AS DEVISE, BANQUE.CPAYSBIC, BANQUE.BIC8 AS BIC, 'IBAN' AS IDENTIFIER_IBAN, 
--                         COORDBANQ.CPAYSIBAN, COORDBANQ.CLEIBAN, CONVERT(VARCHAR(30), COORDBANQ.CODEIBAN) AS CODE_IBAN
--FROM            dbo.ESTIA_TIERS AS TIERS INNER JOIN
--                         dbo.ESTIA_TIERSF AS TIERSF ON TIERS.CTIERS = TIERSF.CTIERS AND TIERS.CTYPTIERS = TIERSF.CTYPTIERS LEFT OUTER JOIN
--                         dbo.ESTIA_QC AS QC ON TIERS.CQC = QC.CQC LEFT OUTER JOIN
--                         dbo.ESTIA_FINDIV AS FINDIV ON FINDIV.CTIERS = TIERS.CTIERS LEFT OUTER JOIN
--                         dbo.ESTIA_BANQUE AS BANQUE ON BANQUE.CBANQUE = TIERSF.CBANQUE LEFT OUTER JOIN
--                         dbo.ESTIA_COORDBANQ AS COORDBANQ ON COORDBANQ.COORDBANQ_ID = TIERSF.COORDBANQ_ID--ON COORDBANQ.CBANQUE = TIERSF.CBANQUE AND COORDBANQ.GUICHET = TIERSF.GUICHET AND COORDBANQ.COMPTE = TIERSF.NUMCPTE AND COORDBANQ.CLE = TIERSF.RIB
--WHERE        (FINDIV.FINGEST IS NULL) OR
--                         (FINDIV.FINGEST > GETDATE())

SELECT DISTINCT 
    TIERS.CTIERS AS CD_FOURNISSEUR
  , CASE WHEN ISNUMERIC(TIERS.CTIERS) <> 0 THEN CONVERT(INT, TIERS.CTIERS) END AS NM_FOURNISSEUR
  , TIERS.CQC AS CD_QUALITE_CIVILE
  , QC.LQC AS LB_QUALITE_CIVILE
  , TIERS.LTIERS AS NOM_FOURNISSEUR
  , TIERS.PRENOM AS PRENOM_FOURNISSEUR
  , TIERS.RTIERS AS CPLT_NOM_FOURNISSEUR
  , TIERS.RUE AS ADRLGN1
  , TIERS.COMMUNE AS ADRLGN2
  , TIERS.CPOS AS CODPOS
  , TIERS.BDIS AS VILLE
  , TIERS.CPAYS AS CD_PAYS
  , TIERS.TEL AS TELEPHONE
  , TIERS.TELECOP AS FAX
  , TIERS.INTERNET AS EMAIL
  , UPPER(TIERSF.CMODREG) AS CD_MODE_REGLEMENT
  , TIERS.SIRET
  , BANQUE.LBANQUE
  , CONVERT(VARCHAR(30), TIERSF.CBANQUE) AS CBANQUE
  , TIERSF.GUICHET, CONVERT(VARCHAR(30), TIERSF.NUMCPTE) AS NUMCPTE
  , CASE WHEN LEN(TIERSF.RIB) < 2 THEN CAST('0' AS VARCHAR(1)) + CAST(TIERSF.RIB AS VARCHAR(2)) ELSE TIERSF.RIB END AS RIB
  , 'EUR' AS DEVISE
  , BANQUE.CPAYSBIC
  , BANQUE.BIC8 AS BIC
  , 'IBAN' AS IDENTIFIER_IBAN
  , COORDBANQ.CPAYSIBAN
  , COORDBANQ.CLEIBAN
  , CONVERT(VARCHAR(30), COORDBANQ.CODEIBAN) AS CODE_IBAN
  , USER_CRE.DATCRE
  , USER_CRE.USERCRE
  , USER_MOD.DATMOD
  , ISNULL(USER_MOD.LUTIL, USER_MOD.CUTIL) USERMOD
FROM	dbo.ESTIA_TIERS AS TIERS 
		INNER JOIN dbo.ESTIA_TIERSF AS TIERSF ON TIERS.CTIERS = TIERSF.CTIERS AND TIERS.CTYPTIERS = TIERSF.CTYPTIERS 
		LEFT OUTER JOIN dbo.ESTIA_QC AS QC ON TIERS.CQC = QC.CQC 
		LEFT OUTER JOIN dbo.ESTIA_FINDIV AS FINDIV ON FINDIV.CTIERS = TIERS.CTIERS 
		LEFT OUTER JOIN dbo.ESTIA_BANQUE AS BANQUE ON BANQUE.CBANQUE = TIERSF.CBANQUE 
		LEFT OUTER JOIN dbo.ESTIA_COORDBANQ AS COORDBANQ ON COORDBANQ.COORDBANQ_ID = TIERSF.COORDBANQ_ID
		LEFT OUTER JOIN
		(
			SELECT CRTIERS.CTIERS
				 , CRTIERS.DATEC DATCRE
				 , ISNULL(MENPRIN.LUTIL, CRTIERS.CUTIL) USERCRE
			FROM ESTIA_CRTIERS CRTIERS
			LEFT JOIN ESTIA_MENPRIN MENPRIN
			ON UPPER(MENPRIN.UTIL) = UPPER(CRTIERS.CUTIL)
			WHERE CRTIERS.TYPMOD = 'N'
		) USER_CRE
		ON USER_CRE.CTIERS = TIERS.CTIERS
		LEFT JOIN
		(
			SELECT CRTIERS.CTIERS
				 , MAX(CRTIERS.DATEC) DATMOD
				 , MAX(CRTIERS.CUTIL) CUTIL
				 , MAX(MENPRIN.LUTIL) LUTIL
				 --, RANK() OVER (PARTITION BY CRTIERS.CTIERS, CRTIERS.DATEC ORDER BY CRTIERS.DATEC DESC) RK
			FROM ESTIA_CRTIERS CRTIERS
			LEFT JOIN ESTIA_MENPRIN MENPRIN
			ON UPPER(MENPRIN.UTIL) = UPPER(CRTIERS.CUTIL)
			WHERE CRTIERS.TYPMOD = 'M'
			GROUP BY CRTIERS.CTIERS
		) USER_MOD
		on USER_MOD.CTIERS = TIERS.CTIERS
WHERE        (FINDIV.FINGEST IS NULL) OR
                         (FINDIV.FINGEST > GETDATE())
GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[V_D_FOURNISSEUR] TO [usersf]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[V_D_FOURNISSEUR] TO [usersf]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_D_FOURNISSEUR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ias = 3195
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_D_FOURNISSEUR';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[24] 2[20] 3) )"
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
         Left = -4501
      End
      Begin Tables = 
         Begin Table = "TIERS"
            Begin Extent = 
               Top = 774
               Left = 38
               Bottom = 904
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TIERSF"
            Begin Extent = 
               Top = 774
               Left = 285
               Bottom = 904
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "QC"
            Begin Extent = 
               Top = 774
               Left = 532
               Bottom = 904
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FINDIV"
            Begin Extent = 
               Top = 774
               Left = 779
               Bottom = 904
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BANQUE"
            Begin Extent = 
               Top = 774
               Left = 1026
               Bottom = 904
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "COORDBANQ"
            Begin Extent = 
               Top = 906
               Left = 38
               Bottom = 1036
               Right = 247
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3420
         Al', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_D_FOURNISSEUR';

