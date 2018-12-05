﻿CREATE TABLE [dbo].[ESTIA_TRANCHE] (
    [CORG]      VARCHAR (4)     NOT NULL,
    [CMARCHE]   VARCHAR (22)    NOT NULL,
    [CTRANCHE]  INT             NOT NULL,
    [LTRANCHE]  VARCHAR (60)    NULL,
    [DDEXEC]    DATE            NULL,
    [DFINPREV]  DATE            NULL,
    [FERMCOND]  VARCHAR (2)     NULL,
    [DELAI]     INT             NULL,
    [TYPDEL]    VARCHAR (2)     NULL,
    [DFEXEC]    DATE            NULL,
    [DDD]       DATE            NULL,
    [TRIG]      VARCHAR (2)     NULL,
    [COPE]      VARCHAR (22)    NULL,
    [DPRELIM]   DATE            NULL,
    [DAUTOENGA] DATE            NULL,
    [DDOC]      DATE            NULL,
    [DCONFORM]  DATE            NULL,
    [DFGEST]    DATE            NULL,
    [DORDS]     DATE            NULL,
    [DRESEPT]   DATE            NULL,
    [DACHEV]    DATE            NULL,
    [DDAT]      DATE            NULL,
    [DCLOTU]    DATE            NULL,
    [CSTEOM]    VARCHAR (2)     NULL,
    [CODEOM]    VARCHAR (22)    NULL,
    [LASM]      VARCHAR (1)     NULL,
    [LASMPRORA] NUMERIC (17, 2) NULL,
    [LASMIXTE]  VARCHAR (1)     NULL,
    [ASSUTVA]   VARCHAR (1)     NULL,
    [PRORATA]   NUMERIC (17, 2) NULL,
    [DPROG]     DATE            NULL,
    [CETAT]     VARCHAR (4)     NULL,
    [TEMIGRA]   VARCHAR (2)     NULL,
    [TXPRESTA]  NUMERIC (17, 2) NULL,
    [CAVOPE]    VARCHAR (4)     NULL,
    [RENOUV]    VARCHAR (2)     NULL,
    [CMODCOMP]  VARCHAR (18)    NULL,
    [GESTCOMP]  VARCHAR (2)     NULL,
    CONSTRAINT [PK_ESTIA_TRANCHE] PRIMARY KEY CLUSTERED ([CORG] ASC, [CMARCHE] ASC, [CTRANCHE] ASC)
);

