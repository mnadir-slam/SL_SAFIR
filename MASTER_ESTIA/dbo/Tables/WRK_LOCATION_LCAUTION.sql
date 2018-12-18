﻿CREATE TABLE [dbo].[WRK_LOCATION_LCAUTION] (
    [CORG]                VARCHAR (4)     NOT NULL,
    [CCOMPTE]             VARCHAR (22)    NOT NULL,
    [NOBAIL]              INT             NOT NULL,
    [CD_TYPE_CAUTION]     VARCHAR (4)     NULL,
    [LB_TYPE_CAUTION]     VARCHAR (60)    NULL,
    [DT_DEBUT_CAUTION]    DATE            NULL,
    [DT_FIN_CAUTION]      DATE            NULL,
    [DUREE_CAUTION_MOIS]  INT             NULL,
    [MT_CAUTION]          NUMERIC (12, 2) NULL,
    [IND_REVISABLE]       VARCHAR (1)     NULL,
    [CD_TYPE_CAUTION_AXA] VARCHAR (1)     NULL,
    CONSTRAINT [PK_WRK_LOCATION_LCAUTION] PRIMARY KEY CLUSTERED ([CORG] ASC, [CCOMPTE] ASC, [NOBAIL] ASC)
);
