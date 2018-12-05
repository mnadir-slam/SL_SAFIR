﻿CREATE TABLE [dbo].[ESTIA_TIERS] (
    [PK_TIERS]   INT           IDENTITY (1, 1) NOT NULL,
    [CPOS]       VARCHAR (10)  NULL,
    [CTYPTIERS]  VARCHAR (2)   NOT NULL,
    [DATNAI]     DATE          NULL,
    [CTIERS]     VARCHAR (14)  NOT NULL,
    [PETIERS]    VARCHAR (14)  NULL,
    [PETYPTIERS] VARCHAR (2)   NULL,
    [SIRET]      VARCHAR (30)  NULL,
    [CQC]        VARCHAR (8)   NULL,
    [RTIERS]     VARCHAR (24)  NULL,
    [LTIERS]     VARCHAR (76)  NULL,
    [RUE]        VARCHAR (76)  NULL,
    [COMMUNE]    VARCHAR (76)  NULL,
    [LBANQUE]    VARCHAR (52)  NULL,
    [BDIS]       VARCHAR (64)  NULL,
    [CPAYS]      VARCHAR (6)   NULL,
    [CONTACT]    VARCHAR (60)  NULL,
    [TEL]        VARCHAR (50)  NULL,
    [CTEL]       VARCHAR (40)  NULL,
    [TELECOP]    VARCHAR (40)  NULL,
    [TELEX]      VARCHAR (40)  NULL,
    [CQCCONT]    VARCHAR (8)   NULL,
    [CAPE]       VARCHAR (12)  NULL,
    [CSTATUT]    VARCHAR (8)   NULL,
    [CCOMM]      INT           NULL,
    [ASCON]      VARCHAR (30)  NULL,
    [ASDAT]      DATE          NULL,
    [ASPOL]      VARCHAR (30)  NULL,
    [CCAGASSUR]  INT           NULL,
    [CCODASSUR]  VARCHAR (14)  NULL,
    [NOM]        VARCHAR (76)  NULL,
    [PRENOM]     VARCHAR (40)  NULL,
    [POUM]       VARCHAR (5)   NULL,
    [INSEE]      VARCHAR (30)  NULL,
    [CSITUFA]    VARCHAR (2)   NULL,
    [NBENT]      INT           NULL,
    [CPROF]      VARCHAR (4)   NULL,
    [CBANQUE]    INT           NULL,
    [PRECONT]    VARCHAR (20)  NULL,
    [FONCONT]    VARCHAR (6)   NULL,
    [TELCONT]    VARCHAR (40)  NULL,
    [POSTCONT]   VARCHAR (20)  NULL,
    [FAXCONT]    VARCHAR (40)  NULL,
    [CGUICHET]   INT           NULL,
    [NUMCPTE]    VARCHAR (22)  NULL,
    [RIB]        INT           NULL,
    [CTYPPREL]   VARCHAR (2)   NULL,
    [DLAIJOUR]   INT           NULL,
    [JPDLAI]     INT           NULL,
    [CMODREG]    VARCHAR (4)   NULL,
    [CFONCTIO]   VARCHAR (10)  NULL,
    [LIEUNAI]    VARCHAR (60)  NULL,
    [TRIG]       VARCHAR (10)  NULL,
    [TRIGD]      VARCHAR (50)  NULL,
    [TELBUR]     VARCHAR (40)  NULL,
    [INTERNET]   VARCHAR (100) NULL,
    [CAPITAL]    VARCHAR (50)  NULL,
    [RCS]        VARCHAR (100) NULL,
    [NOIDENT]    VARCHAR (40)  NULL,
    [NBHEURE]    VARCHAR (50)  NULL,
    [PARTGRP]    VARCHAR (1)   NULL,
    [DCONV]      VARCHAR (50)  NULL,
    [NUMCONV]    INT           NULL,
    [ADRCOMP]    VARCHAR (76)  NULL,
    [TVACEE]     VARCHAR (30)  NULL,
    [ASSPERT]    VARCHAR (1)   NULL,
    [MOIS]       INT           NULL,
    [FREQASS]    INT           NULL,
    [DERACPTE]   VARCHAR (50)  NULL,
    [LTIERS1]    VARCHAR (80)  NULL,
    [LTIERS2]    VARCHAR (80)  NULL,
    [MIGCOMPT]   INT           NULL,
    [EXTIDENT]   VARCHAR (76)  NULL,
    [EXTPASSE]   VARCHAR (40)  NULL,
    [EXTACC]     VARCHAR (2)   NULL,
    [EXTVER]     VARCHAR (2)   NULL,
    [POUREV]     VARCHAR (50)  NULL,
    [CARTET]     VARCHAR (40)  NULL,
    [CARTEG]     VARCHAR (40)  NULL,
    [RATIERS]    VARCHAR (14)  NULL,
    [CODNAT]     VARCHAR (4)   NULL,
    [CLEIBAN]    VARCHAR (4)   NULL,
    [TIERS_ID]   INT           NULL,
    [CTYPDECRF]  VARCHAR (10)  NULL,
    [DDEUNIQ]    VARCHAR (2)   NULL,
    [UNIQADRES]  VARCHAR (1)   NULL,
    [UNIQCOORD]  VARCHAR (1)   NULL,
    [ASDATFIN]   VARCHAR (50)  NULL,
    [LHEBERGE]   VARCHAR (76)  NULL,
    CONSTRAINT [PK_ESTIA_TIERS] PRIMARY KEY CLUSTERED ([CTYPTIERS] ASC, [CTIERS] ASC)
);

