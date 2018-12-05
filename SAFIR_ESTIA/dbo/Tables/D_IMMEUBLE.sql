﻿CREATE TABLE [dbo].[D_IMMEUBLE] (
    [DT_REF]                    DATETIME        NULL,
    [PK_IMMEUBLE]               INT             NOT NULL,
    [CD_ORIGINE]                VARCHAR (5)     NULL,
    [CD_SOCIETE]                VARCHAR (4)     NULL,
    [CD_IMMEUBLE]               VARCHAR (20)    NULL,
    [NM_IMMEUBLE]               INT             NULL,
    [ADRLGN1]                   VARCHAR (64)    NULL,
    [ADRLGN2]                   VARCHAR (76)    NULL,
    [ADRLGN3]                   VARCHAR (76)    NULL,
    [ADRLGN4]                   VARCHAR (76)    NULL,
    [CODPOS]                    VARCHAR (10)    NULL,
    [VILLE]                     VARCHAR (64)    NULL,
    [CD_TYPE_IMMEUBLE]          VARCHAR (1)     NULL,
    [LB_TYPE_IMMEUBLE]          VARCHAR (19)    NULL,
    [CD_CLASSE_IMMEUBLE]        VARCHAR (3)     NULL,
    [LB_CLASSE_IMMEUBLE]        VARCHAR (30)    NULL,
    [NB_LOTS_PRINCIPAUX]        INT             NULL,
    [NB_LOTS]                   INT             NULL,
    [DT_ACHEVEMENT_TRAVAUX]     DATE            NULL,
    [CD_RESPONSABLE_PATRIMOINE] VARCHAR (10)    NULL,
    [LB_RESPONSABLE_PATRIMOINE] VARCHAR (60)    NULL,
    [CD_RESPONSABLE_TRAVAUX]    VARCHAR (10)    NULL,
    [LB_RESPONSABLE_TRAVAUX]    VARCHAR (60)    NULL,
    [CD_RESPONSABLE_GROUPE]     VARCHAR (10)    NULL,
    [LB_RESPONSABLE_GROUPE]     VARCHAR (60)    NULL,
    [NM_RECETTE_IMPOTS]         NUMERIC (6)     NULL,
    [NM_PERCEPTION]             NUMERIC (6)     NULL,
    [CD_COMPTABLE_IMMEUBLE]     VARCHAR (5)     NULL,
    [LB_COMPTABLE_IMMEUBLE]     VARCHAR (30)    NULL,
    [CD_CONTROLEUR_GESTION]     VARCHAR (5)     NULL,
    [LB_CONTROLEUR_GESTION]     VARCHAR (30)    NULL,
    [CD_ASSET_MANAGER_CLIENT]   VARCHAR (5)     NULL,
    [LB_ASSET_MANAGER_CLIENT]   VARCHAR (30)    NULL,
    [CD_ETAT_GESTION]           VARCHAR (5)     NULL,
    [LB_ETAT_GESTION]           VARCHAR (30)    NULL,
    [CD_TYPOLOGIE_ACTIF]        VARCHAR (5)     NULL,
    [LB_TYPOLOGIE_ACTIF]        VARCHAR (30)    NULL,
    [CD_GERANCE_COPRO]          VARCHAR (5)     NULL,
    [LB_GERANCE_COPRO]          VARCHAR (30)    NULL,
    [CD_PROPRIETAIRE]           VARCHAR (5)     NULL,
    [LB_PROPRIETAIRE]           VARCHAR (30)    NULL,
    [CD_GROUPE_PROPRIETAIRE]    VARCHAR (5)     NULL,
    [LB_GROUPE_PROPRIETAIRE]    VARCHAR (30)    NULL,
    [CD_LOCALISATION]           VARCHAR (5)     NULL,
    [LB_LOCALISATION]           VARCHAR (30)    NULL,
    [VLM_ARCHIVE]               INT             NULL,
    [VLM_PARKING_SIMPLE]        INT             NULL,
    [SURFACE_TOTALE]            NUMERIC (18, 2) NULL,
    [CHEMIN_PLAN]               VARCHAR (255)   NULL,
    [CHEMIN_ETAT_SURFACES]      VARCHAR (255)   NULL,
    [VLM_PARKING_DOUBLE]        INT             NULL,
    [CHEMIN_TB]                 VARCHAR (255)   NULL,
    [CHEMIN_TF]                 VARCHAR (255)   NULL,
    [POLE_GESTION]              VARCHAR (50)    NULL,
    [CHEMIN_MANDAT]             VARCHAR (255)   NULL,
    CONSTRAINT [PK_D_IMMEUBLE_1] PRIMARY KEY CLUSTERED ([PK_IMMEUBLE] ASC)
);

