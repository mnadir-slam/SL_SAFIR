﻿CREATE TABLE [dbo].[WRK_LOCAL_HQLOCAL] (
    [CORG]              VARCHAR (4)     NOT NULL,
    [CAGENCE]           VARCHAR (4)     NOT NULL,
    [CGROUPE]           INT             NOT NULL,
    [CIMMEUB]           INT             NOT NULL,
    [CLOCAL]            INT             NOT NULL,
    [MT_LOYER_MARCHE]   NUMERIC (12, 2) NULL,
    [MT_CHARGES_MARCHE] NUMERIC (12, 2) NULL,
    CONSTRAINT [PK_WRK_LOCAL_HQLOCAL] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC)
);
