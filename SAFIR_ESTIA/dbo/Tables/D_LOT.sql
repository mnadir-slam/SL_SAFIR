﻿CREATE TABLE [dbo].[D_LOT] (
    [DT_REF]                  DATETIME        NULL,
    [PK_LOT]                  INT             NOT NULL,
    [FK_IMMEUBLE]             INT             NULL,
    [FK_MANDAT_GERANCE]       INT             NULL,
    [CD_ORIGINE]              VARCHAR (5)     NULL,
    [CD_SOCIETE]              VARCHAR (4)     NULL,
    [CD_IMMEUBLE]             VARCHAR (4)     NULL,
    [NM_IMMEUBLE]             INT             NULL,
    [CD_LOT]                  VARCHAR (4)     NULL,
    [NM_LOT]                  INT             NULL,
    [CD_TYPE_LOT]             VARCHAR (6)     NULL,
    [LB_TYPE_LOT]             VARCHAR (60)    NULL,
    [CD_USAGE]                VARCHAR (6)     NULL,
    [LB_USAGE]                VARCHAR (60)    NULL,
    [CD_BATIMENT]             VARCHAR (4)     NULL,
    [CD_ESCALIER]             VARCHAR (4)     NULL,
    [ETAGE]                   VARCHAR (10)    NULL,
    [NM_ETAGE]                INT             NULL,
    [PORTE]                   VARCHAR (8)     NULL,
    [NB_PIECES]               INT             NULL,
    [VAL_SURFACE_REELLE]      NUMERIC (17, 2) NULL,
    [VAL_SURFACE_CORRIGEE]    NUMERIC (17, 2) NULL,
    [VAL_MILLIEMES_GENERAUX]  NUMERIC (17, 2) NULL,
    [NB_PARKINGS]             INT             NULL,
    [NB_EMPLACEMENTS_PARKING] INT             NULL,
    [DT_DEBUT_GESTION]        DATETIME        NULL,
    [DT_FIN_GESTION]          DATETIME        NULL,
    [CD_SOCIETE_GERANCE]      VARCHAR (4)     NULL,
    [CD_MANDAT_GERANCE]       VARCHAR (16)    NULL,
    [NM_MANDAT_GERANCE]       NUMERIC (16)    NULL,
    [CD_SOCIETE_SYNDIC]       VARCHAR (4)     NULL,
    [NM_MANDAT_SYNDIC]        NUMERIC (16)    NULL,
    [VAL_SURFACE_TAXABLE]     NUMERIC (17, 2) NULL,
    [DT_DEBUT_EN_SERVICE]     DATE            NULL,
    [DT_FIN_EN_SERVICE]       DATE            NULL,
    [CD_MOTIF_VACANCE]        VARCHAR (2)     NULL,
    [LB_MOTIF_VACANCE]        VARCHAR (30)    NULL,
    [MT_LOYER_MARCHE]         NUMERIC (12, 2) NULL,
    [MT_CHARGES_MARCHE]       NUMERIC (12, 2) NULL,
    [CD_REG_USAGE]            VARCHAR (3)     NULL,
    [LB_REG_USAGE]            VARCHAR (60)    NULL,
    CONSTRAINT [PK_D_LOT] PRIMARY KEY CLUSTERED ([PK_LOT] ASC)
);

