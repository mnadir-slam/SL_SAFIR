﻿CREATE TABLE [dbo].[ESTIA_ENTFAC] (
    [PK_ENTFAC]    INT             IDENTITY (1, 1) NOT NULL,
    [FK_TIERS]     INT             NULL,
    [CORG]         VARCHAR (4)     NOT NULL,
    [CTIERS]       VARCHAR (14)    NOT NULL,
    [CTYPTIERS]    VARCHAR (2)     NULL,
    [CJOURNAL]     VARCHAR (6)     NULL,
    [NUMCPTE]      VARCHAR (22)    NULL,
    [LTIERS]       VARCHAR (64)    NULL,
    [RUE]          VARCHAR (76)    NULL,
    [CPOS]         VARCHAR (10)    NULL,
    [CCOMM]        INT             NULL,
    [BDIS]         VARCHAR (64)    NULL,
    [REF]          VARCHAR (42)    NULL,
    [CNOMENC]      VARCHAR (80)    NULL,
    [MTHT]         NUMERIC (17, 2) NULL,
    [MTTVA]        NUMERIC (17, 2) NULL,
    [DCOURRIER]    DATE            NULL,
    [REFFOUR]      VARCHAR (60)    NULL,
    [CEMPLOY]      INT             NULL,
    [LCOM]         VARCHAR (1248)  NULL,
    [TYPMDT]       VARCHAR (2)     NULL,
    [CCONTFRS]     VARCHAR (24)    NULL,
    [LIB]          VARCHAR (60)    NULL,
    [DREGUL]       DATE            NULL,
    [CVENTPCHAR]   INT             NULL,
    [CODFAC]       VARCHAR (2)     NULL,
    [CBANQUE]      VARCHAR (10)    NULL,
    [CGUICHET]     VARCHAR (10)    NULL,
    [CCATEG]       VARCHAR (4)     NULL,
    [VALIDE]       VARCHAR (1)     NULL,
    [NODOC]        VARCHAR (24)    NULL,
    [TYPFACT]      VARCHAR (6)     NULL,
    [DRETOUR]      DATE            NULL,
    [SAISCRIT]     VARCHAR (1)     NULL,
    [PREMAND]      VARCHAR (1)     NULL,
    [TRI]          VARCHAR (60)    NULL,
    [MTTTC]        NUMERIC (17, 2) NULL,
    [NOPIECE]      VARCHAR (16)    NULL,
    [DATEC]        DATE            NULL,
    [UTIL]         VARCHAR (24)    NULL,
    [LIEUDIT]      VARCHAR (76)    NULL,
    [TRIG]         VARCHAR (2)     NULL,
    [DATENREG]     DATE            NULL,
    [CNATPRES]     VARCHAR (6)     NULL,
    [CRUB]         INT             NULL,
    [DIMPCONT]     DATE            NULL,
    [DATFAC]       DATE            NULL,
    [DEVHT]        NUMERIC (17, 2) NULL,
    [DEVTVA]       NUMERIC (17, 2) NULL,
    [DEVTTC]       NUMERIC (17, 2) NULL,
    [CDEVISE]      VARCHAR (4)     NULL,
    [BASCULASM]    VARCHAR (1)     NULL,
    [COPE]         VARCHAR (22)    NULL,
    [CTRANCHE]     INT             NULL,
    [CDEPR]        INT             NULL,
    [NORD]         INT             NULL,
    [CPHASE]       VARCHAR (6)     NULL,
    [CMODREG]      VARCHAR (6)     NULL,
    [AUTO]         VARCHAR (1)     NULL,
    [RECUP]        VARCHAR (2)     NULL,
    [DECH]         DATE            NULL,
    [DBOR]         DATE            NULL,
    [LIBPAI]       VARCHAR (80)    NULL,
    [TRAIT]        VARCHAR (6)     NULL,
    [FACAVO]       VARCHAR (6)     NULL,
    [DERFAC]       VARCHAR (1)     NULL,
    [DRETSOU]      DATE            NULL,
    [MTBLOQ]       NUMERIC (17, 2) NULL,
    [PARV]         VARCHAR (1)     NULL,
    [NOPRE]        VARCHAR (16)    NULL,
    [REFSCAN]      VARCHAR (160)   NULL,
    [FVALIDE]      VARCHAR (2)     NULL,
    [DETAT]        DATE            NULL,
    [REFGED]       VARCHAR (80)    NULL,
    [ARCHIVE]      VARCHAR (1)     NULL,
    [CMANDAT]      VARCHAR (16)    NULL,
    [MODTVA]       VARCHAR (2)     NULL,
    [ADRCOMP]      VARCHAR (76)    NULL,
    [CCOMPTE]      VARCHAR (22)    NULL,
    [CLOCAL]       INT             NULL,
    [DATAG]        DATE            NULL,
    [TYPEAG]       VARCHAR (2)     NULL,
    [MTLIAV]       NUMERIC (17, 2) NULL,
    [REFHONO]      VARCHAR (42)    NULL,
    [MIGCOMPT]     INT             NULL,
    [CODNAT]       VARCHAR (4)     NULL,
    [CLEIBAN]      VARCHAR (4)     NULL,
    [COORDBANQ_ID] INT             NULL
);

