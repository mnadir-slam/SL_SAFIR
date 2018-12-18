﻿CREATE TABLE [dbo].[WRK_LOCATION_HLOYCA] (
    [CORG]     VARCHAR (4)     NOT NULL,
    [CCOMPTE]  VARCHAR (22)    NOT NULL,
    [NOBAIL]   INT             NOT NULL,
    [ANNEE_CA] INT             NULL,
    [MT_CA]    NUMERIC (13, 2) NULL,
    CONSTRAINT [PK_WRK_LOCATION_HLOYCA] PRIMARY KEY CLUSTERED ([CORG] ASC, [CCOMPTE] ASC, [NOBAIL] ASC)
);
