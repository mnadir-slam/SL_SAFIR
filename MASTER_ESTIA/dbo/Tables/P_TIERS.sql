﻿CREATE TABLE [dbo].[P_TIERS] (
    [CD_TYPE_TIERS]  VARCHAR (2)  NOT NULL,
    [CD_TIERS]       VARCHAR (14) NOT NULL,
    [NOM_TIERS]      VARCHAR (76) NULL,
    [VILLE]          VARCHAR (64) NULL,
    [IND_TIERS_SIIC] VARCHAR (1)  CONSTRAINT [DF_P_TIERS_IND_TIERS_SIIC] DEFAULT ('N') NOT NULL,
    [CD_TIERS_SIIC]  VARCHAR (8)  NULL,
    CONSTRAINT [PK_P_TIERS] PRIMARY KEY CLUSTERED ([CD_TYPE_TIERS] ASC, [CD_TIERS] ASC)
);

