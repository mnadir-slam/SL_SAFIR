﻿CREATE TABLE [dbo].[WRK_INTERFACE_EASYFOLDER_CONTRATS_TEST] (
    [PK_TEMPS]                   DATE           NULL,
    [ACTION]                     NVARCHAR (255) NULL,
    [IDENTIFIANT_DREAM_IMMEUBLE] NVARCHAR (50)  NULL,
    [IDENTIFIANT_ESTIA_IMMEUBLE] NUMERIC (38)   NULL,
    [NOM_IMMEUBLE_ESTIA]         NVARCHAR (255) NULL,
    [NUM_CONTRAT]                INT            NULL,
    [LB_CONTRAT]                 NVARCHAR (255) NULL,
    [DT_FIN_PRESTATION]          DATETIME       NULL,
    [IFC_DT_TRAITEMENT]          DATETIME       NULL,
    [IFC_STATUT_TRAITEMENT]      NVARCHAR (100) NULL,
    [IFC_ERREUR_TRAITEMENT]      NVARCHAR (MAX) NULL
);

