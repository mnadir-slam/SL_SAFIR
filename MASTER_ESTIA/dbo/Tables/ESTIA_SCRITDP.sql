﻿CREATE TABLE [dbo].[ESTIA_SCRITDP] (
    [PK_SCRITDP]  INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]      INT             NULL,
    [FK_AGENCE]   INT             NULL,
    [FK_GROUPE]   INT             NULL,
    [FK_BASE]     INT             NULL,
    [CORG]        VARCHAR (4)     NOT NULL,
    [CAGENCE]     VARCHAR (4)     NOT NULL,
    [CGROUPE]     INT             NOT NULL,
    [CCRITDP]     INT             NOT NULL,
    [CSCRITDP]    INT             NOT NULL,
    [LSCRITDP]    VARCHAR (60)    NULL,
    [CBASE]       INT             NULL,
    [CMETHCAL]    INT             NULL,
    [CTVA]        VARCHAR (4)     NULL,
    [TRECUP]      VARCHAR (1)     NULL,
    [TXRECUP]     INT             NULL,
    [PCHLOC]      NUMERIC (17, 2) NULL,
    [TREGUL]      VARCHAR (1)     NULL,
    [PEVOL]       NUMERIC (17, 2) NULL,
    [NIVQP]       VARCHAR (2)     NULL,
    [TRIG]        VARCHAR (2)     NULL,
    [TRECLOC]     VARCHAR (1)     NULL,
    [PRORATABASE] VARCHAR (1)     NULL,
    [RECUPTX]     NUMERIC (17, 2) NULL,
    [DEDUCIMP]    NUMERIC (17, 2) NULL,
    [MDPA]        VARCHAR (1)     NULL,
    [REPRES]      VARCHAR (1)     NULL,
    [RCRITDP]     INT             NULL,
    [RSCRITDP]    INT             NULL,
    [CSTE]        VARCHAR (6)     NULL,
    [CRUB]        INT             NULL,
    [MIGCOMPT]    INT             NULL,
    CONSTRAINT [PK_ESTIA_SCRITDP] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CCRITDP] ASC, [CSCRITDP] ASC)
);

