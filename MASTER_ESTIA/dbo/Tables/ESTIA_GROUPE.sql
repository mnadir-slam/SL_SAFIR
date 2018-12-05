﻿CREATE TABLE [dbo].[ESTIA_GROUPE] (
    [PK_GROUPE]          INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]             INT             NULL,
    [FK_AGENCE]          INT             NULL,
    [CORG]               VARCHAR (4)     NOT NULL,
    [CAGENCE]            VARCHAR (4)     NOT NULL,
    [CGROUPE]            INT             NOT NULL,
    [LGROUPE]            VARCHAR (64)    NULL,
    [RUE]                VARCHAR (76)    NULL,
    [LIEUDIT]            VARCHAR (76)    NULL,
    [CPOS]               VARCHAR (10)    NULL,
    [VILLE]              VARCHAR (64)    NULL,
    [CCOMM]              INT             NULL,
    [CQUART]             VARCHAR (6)     NULL,
    [CSECTEUR]           VARCHAR (6)     NULL,
    [CCATHLM]            VARCHAR (6)     NULL,
    [CCATIMM]            VARCHAR (6)     NULL,
    [RCTIERS]            VARCHAR (14)    NULL,
    [DEBOP]              DATE            NULL,
    [FINOP]              DATE            NULL,
    [DEBLOC]             DATE            NULL,
    [DATREN]             DATE            NULL,
    [CFINANC]            VARCHAR (10)    NULL,
    [TREPART]            INT             NULL,
    [DATCONV]            DATE            NULL,
    [CONTCONV]           VARCHAR (60)    NULL,
    [CSECTANA]           VARCHAR (14)    NULL,
    [DATDCONS]           DATE            NULL,
    [DATFCONS]           DATE            NULL,
    [DATACHAT]           DATE            NULL,
    [DATSERV]            DATE            NULL,
    [DATREHA]            DATE            NULL,
    [TEMPATRI]           VARCHAR (1)     NULL,
    [CREGIS]             INT             NULL,
    [CENCAIS]            INT             NULL,
    [LOYMAXI]            NUMERIC (18, 3) NULL,
    [COEFREL]            NUMERIC (19, 4) NULL,
    [COEFOBJ]            NUMERIC (19, 4) NULL,
    [CTYPTOUR]           INT             NULL,
    [CBASSIN]            VARCHAR (6)     NULL,
    [LOYMORIG]           NUMERIC (18, 3) NULL,
    [RCTYPTIERS]         VARCHAR (2)     NULL,
    [GETIERS]            VARCHAR (14)    NULL,
    [CENVOI]             VARCHAR (4)     NULL,
    [COEFSURL]           NUMERIC (20, 5) NULL,
    [FINGEST]            DATE            NULL,
    [BLOCAGE]            DATE            NULL,
    [GESTDEPUIS]         DATE            NULL,
    [GESTION]            VARCHAR (4)     NULL,
    [GEOVAR]             VARCHAR (1)     NULL,
    [TVA]                VARCHAR (1)     NULL,
    [TAUXN]              NUMERIC (17, 2) NULL,
    [TAUXN-1]            NUMERIC (18, 2) NULL,
    [FINTVA]             DATE            NULL,
    [TAXBUREAU]          VARCHAR (1)     NULL,
    [PREPOND]            VARCHAR (1)     NULL,
    [PRIXMARCHE]         NUMERIC (15)    NULL,
    [CZONE]              VARCHAR (6)     NULL,
    [COTIERS]            VARCHAR (14)    NULL,
    [GETYPTIERS]         VARCHAR (2)     NULL,
    [CRESP]              VARCHAR (12)    NULL,
    [TYPGEST]            VARCHAR (2)     NULL,
    [CANNEXE1]           VARCHAR (1)     NULL,
    [COTYPTIERS]         VARCHAR (2)     NULL,
    [TRIG]               VARCHAR (2)     NULL,
    [CANNEXE2]           VARCHAR (1)     NULL,
    [STECH]              VARCHAR (1)     NULL,
    [SGEST]              VARCHAR (1)     NULL,
    [SCOMPTA]            VARCHAR (1)     NULL,
    [DEBAN1]             DATE            NULL,
    [FINAN1]             DATE            NULL,
    [DEBAN2]             DATE            NULL,
    [FINAN2]             DATE            NULL,
    [NOTYPTIERS]         VARCHAR (2)     NULL,
    [NOTIERS]            VARCHAR (14)    NULL,
    [DATEVAL]            DATE            NULL,
    [DATAUTO]            DATE            NULL,
    [PRXVENT]            NUMERIC (17, 2) NULL,
    [PRXPLAN]            NUMERIC (17, 2) NULL,
    [ACTYPTIERS]         VARCHAR (2)     NULL,
    [ACTIERS]            VARCHAR (14)    NULL,
    [DOTYPTIERS]         VARCHAR (2)     NULL,
    [DOTIERS]            VARCHAR (14)    NULL,
    [PRTYPTIERS]         VARCHAR (2)     NULL,
    [PRTIERS]            VARCHAR (14)    NULL,
    [VOTYPTIERS]         VARCHAR (2)     NULL,
    [VOTIERS]            VARCHAR (14)    NULL,
    [MTVEN]              NUMERIC (17, 2) NULL,
    [MTACHAT]            NUMERIC (17, 2) NULL,
    [DVENTE]             DATE            NULL,
    [DAUTO]              DATE            NULL,
    [CDEPART]            VARCHAR (4)     NULL,
    [PEGAS]              DATE            NULL,
    [TRIGD]              DATE            NULL,
    [NOMBMP]             VARCHAR (80)    NULL,
    [XPLAN]              INT             NULL,
    [YPLAN]              INT             NULL,
    [LPLAN]              INT             NULL,
    [HPLAN]              INT             NULL,
    [CNIVRATT1]          VARCHAR (24)    NULL,
    [CNIVRATT2]          VARCHAR (24)    NULL,
    [CNIVRATT3]          VARCHAR (24)    NULL,
    [CNIVRATT4]          VARCHAR (24)    NULL,
    [CNIVRATT5]          VARCHAR (24)    NULL,
    [CNIVRATT6]          VARCHAR (24)    NULL,
    [CNIVRATT7]          VARCHAR (24)    NULL,
    [CNIVRATT8]          VARCHAR (24)    NULL,
    [DDCONS]             DATE            NULL,
    [DFCONS]             DATE            NULL,
    [DREHAB]             DATE            NULL,
    [CONVENT]            VARCHAR (1)     NULL,
    [TRANSOP]            VARCHAR (2)     NULL,
    [PROVHT]             VARCHAR (1)     NULL,
    [INTPEGAS]           VARCHAR (2)     NULL,
    [ADRCOMP]            VARCHAR (76)    NULL,
    [D1FUSION]           DATE            NULL,
    [D2FUSION]           DATE            NULL,
    [TYPSOL]             VARCHAR (2)     NULL,
    [MIGCOMPT]           INT             NULL,
    [CFISCAL]            VARCHAR (6)     NULL,
    [TEMMAJ]             VARCHAR (2)     NULL,
    [DATMAJ]             DATE            NULL,
    [COMPOSITION]        VARCHAR (1000)  NULL,
    [PERMISCONS]         VARCHAR (1000)  NULL,
    [ADRESSE_ID]         INT             NULL,
    [AGENCE_ID]          INT             NULL,
    [ARCHIVE]            VARCHAR (1)     NULL,
    [CCATEGORIE]         VARCHAR (10)    NULL,
    [CIMPLANTAT]         VARCHAR (10)    NULL,
    [GROUPE_ID]          INT             NULL,
    [NBBATIMENTS]        INT             NULL,
    [NBIMMEUBLES]        INT             NULL,
    [NBLOCAUX]           INT             NULL,
    [NUMSEQUENCEDOSSIER] INT             NULL,
    [REFERENCE]          VARCHAR (60)    NULL,
    CONSTRAINT [PK_ESTIA_GROUPE] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC)
);

