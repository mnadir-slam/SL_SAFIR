﻿CREATE TABLE [dbo].[ESTIA_PLANC] (
    [PK_PLANC]  INT             IDENTITY (1, 1) NOT NULL,
    [CORG]      VARCHAR (4)     NOT NULL,
    [CCG]       VARCHAR (28)    NOT NULL,
    [INTIT]     VARCHAR (100)   NOT NULL,
    [INTITR]    VARCHAR (28)    NULL,
    [DOUV]      DATE            NULL,
    [DBLOC]     DATE            NULL,
    [DMAJ]      DATE            NULL,
    [TIERS]     VARCHAR (1)     NULL,
    [ANAL]      VARCHAR (1)     NULL,
    [CNATANA]   VARCHAR (16)    NULL,
    [COMPCENT]  VARCHAR (1)     NULL,
    [COMPCLO]   VARCHAR (1)     NULL,
    [SOLDOK]    VARCHAR (2)     NULL,
    [SENSINT]   VARCHAR (2)     NULL,
    [TYPCPTA]   VARCHAR (4)     NULL,
    [TRESOR]    VARCHAR (1)     NULL,
    [REGROUPE]  VARCHAR (1)     NULL,
    [CTRCIL]    VARCHAR (6)     NULL,
    [CHPC]      VARCHAR (2)     NOT NULL,
    [BCG]       VARCHAR (28)    NULL,
    [CMONEY]    VARCHAR (2)     NULL,
    [CRESI]     VARCHAR (4)     NULL,
    [CAGECO]    VARCHAR (6)     NULL,
    [CRESO]     VARCHAR (2)     NULL,
    [SCB]       VARCHAR (28)    NULL,
    [VCB]       VARCHAR (28)    NULL,
    [VISORD]    VARCHAR (1)     NULL,
    [ANOUVO]    VARCHAR (2)     NULL,
    [CBANQUE]   VARCHAR (10)    NULL,
    [GUICHET]   VARCHAR (10)    NULL,
    [COMPTE]    VARCHAR (22)    NULL,
    [NBJOUR]    INT             NULL,
    [TEMRB]     VARCHAR (1)     NULL,
    [SOLDBANQ]  NUMERIC (17, 2) NULL,
    [CG68]      VARCHAR (28)    NULL,
    [CG28]      VARCHAR (28)    NULL,
    [CMETIMMO]  VARCHAR (4)     NULL,
    [CPTIMMO]   VARCHAR (1)     NULL,
    [ENGA]      VARCHAR (2)     NULL,
    [CCATEG]    VARCHAR (4)     NULL,
    [RECUP]     VARCHAR (2)     NULL,
    [CPTVA]     VARCHAR (2)     NULL,
    [CDOMSOC]   INT             NULL,
    [TRIGD]     DATE            NULL,
    [FISC]      VARCHAR (2)     NULL,
    [CNATHON]   VARCHAR (4)     NULL,
    [SAISINT]   VARCHAR (1)     NULL,
    [TRIG]      VARCHAR (2)     NULL,
    [VISREC]    VARCHAR (1)     NULL,
    [CNTVA]     VARCHAR (4)     NULL,
    [GSECT]     VARCHAR (1)     NULL,
    [NATMOD]    VARCHAR (2)     NULL,
    [NATBIEN]   VARCHAR (2)     NULL,
    [CG675]     VARCHAR (28)    NULL,
    [AUTORISE]  VARCHAR (1000)  NULL,
    [SAUTORISE] VARCHAR (1000)  NULL,
    [CAUTORISE] VARCHAR (1000)  NULL,
    [TEMOIN]    VARCHAR (2)     NULL,
    [CPBUDD]    VARCHAR (18)    NULL,
    [CCOLBUD]   VARCHAR (6)     NULL,
    [CPANA]     VARCHAR (12)    NULL,
    [LISTORG]   VARCHAR (120)   NULL,
    [ASSMDT]    VARCHAR (2)     NULL,
    [COMPAMOFI] VARCHAR (30)    NULL,
    [MIGCOMPT]  INT             NULL,
    CONSTRAINT [PK_ESTIA_PLANC] PRIMARY KEY CLUSTERED ([CORG] ASC, [CCG] ASC, [CHPC] ASC)
);

