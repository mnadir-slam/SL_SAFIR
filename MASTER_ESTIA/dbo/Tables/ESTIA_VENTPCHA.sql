﻿CREATE TABLE [dbo].[ESTIA_VENTPCHA] (
    [PK_VENTPCHA] INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]      INT             NULL,
    [FK_CTRTIERS] INT             NULL,
    [FK_TIERS]    INT             NULL,
    [FK_AGENCE]   INT             NULL,
    [FK_GROUPE]   INT             NULL,
    [CORG]        VARCHAR (4)     NOT NULL,
    [CTIERS]      VARCHAR (14)    NOT NULL,
    [CCONTFRS]    VARCHAR (24)    NOT NULL,
    [CVENTPCHA]   INT             NOT NULL,
    [LVENTPCHA]   VARCHAR (60)    NULL,
    [CGROUPE]     INT             NULL,
    [CCRITDP]     INT             NULL,
    [CSCRITDP]    INT             NULL,
    [FFVENT]      NUMERIC (17, 2) NULL,
    [TXVENT]      NUMERIC (17, 2) NULL,
    [ZAGENCE]     VARCHAR (4)     NULL,
    [PRORATATVA]  NUMERIC (17, 2) NULL,
    [CLE]         VARCHAR (4)     NULL,
    [CTVA]        VARCHAR (4)     NULL,
    [TRIG]        VARCHAR (2)     NULL,
    [CNATECH]     VARCHAR (6)     NULL,
    [CSECTANA]    VARCHAR (16)    NULL,
    [CSECTREG]    VARCHAR (16)    NULL,
    [POURC]       NUMERIC (18, 3) NULL,
    [PRORATA]     NUMERIC (17, 2) NULL,
    [PRINCIPAL]   VARCHAR (1)     NULL,
    [CCONTRASS]   VARCHAR (40)    NULL,
    [MIGCOMPT]    INT             NULL
);

