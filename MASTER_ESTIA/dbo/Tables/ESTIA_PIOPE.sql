﻿CREATE TABLE [dbo].[ESTIA_PIOPE] (
    [PK_PIOPE]      INT             IDENTITY (1, 1) NOT NULL,
    [FK_POPE]       INT             NULL,
    [corg]          VARCHAR (4)     NOT NULL,
    [cope]          VARCHAR (22)    NOT NULL,
    [ntiers]        VARCHAR (14)    NULL,
    [ctva]          VARCHAR (4)     NULL,
    [ddcom]         DATE            NULL,
    [dfcom]         DATE            NULL,
    [cptvent]       VARCHAR (4)     NULL,
    [tresp]         VARCHAR (14)    NULL,
    [cnatprod]      VARCHAR (6)     NULL,
    [nbjr1]         INT             NULL,
    [nbjr2]         INT             NULL,
    [vetiers]       VARCHAR (14)    NULL,
    [ptiers]        VARCHAR (14)    NULL,
    [dettiers]      VARCHAR (14)    NULL,
    [ctranche]      INT             NOT NULL,
    [assutva]       VARCHAR (1)     NULL,
    [cbordero]      VARCHAR (4)     NULL,
    [cjournal]      VARCHAR (6)     NULL,
    [debenc]        VARCHAR (2)     NULL,
    [ctypdest]      VARCHAR (6)     NULL,
    [paicjournal]   VARCHAR (6)     NULL,
    [paicbordero]   VARCHAR (4)     NULL,
    [prorata]       NUMERIC (17, 2) NULL,
    [ldecid]        INT             NULL,
    [ddecid]        DATE            NULL,
    [dsad]          DATE            NULL,
    [lasmctva]      VARCHAR (4)     NULL,
    [lprorata]      NUMERIC (17, 2) NULL,
    [mixte]         VARCHAR (1)     NULL,
    [ddeflasm]      DATE            NULL,
    [numint]        INT             NULL,
    [numdde]        INT             NULL,
    [dagre]         DATE            NULL,
    [txlasm]        NUMERIC (17, 2) NULL,
    [shontot]       NUMERIC (17, 2) NULL,
    [shabtot]       NUMERIC (17, 2) NULL,
    [sanxtot]       NUMERIC (17, 2) NULL,
    [miltot]        NUMERIC (17, 2) NULL,
    [nblgt]         INT             NULL,
    [caprev]        NUMERIC (17, 2) NULL,
    [mtacq]         NUMERIC (17, 2) NULL,
    [nbacq]         INT             NULL,
    [cproduit]      INT             NULL,
    [cprod]         VARCHAR (6)     NULL,
    [cnatop]        VARCHAR (6)     NULL,
    [cetude]        VARCHAR (6)     NULL,
    [cnattrav]      VARCHAR (6)     NULL,
    [prcavtec]      NUMERIC (17, 2) NULL,
    [PRCFNPHONO]    NUMERIC (18, 3) NULL,
    [prcavchantier] NUMERIC (17, 2) NULL,
    CONSTRAINT [PK_ESTIA_PIOPE] PRIMARY KEY CLUSTERED ([corg] ASC, [cope] ASC, [ctranche] ASC)
);
