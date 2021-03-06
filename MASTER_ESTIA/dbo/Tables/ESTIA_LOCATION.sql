﻿CREATE TABLE [dbo].[ESTIA_LOCATION] (
    [PK_LOCATION]   INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]        INT             NULL,
    [FK_AGENCE]     INT             NULL,
    [FK_GROUPE]     INT             NULL,
    [FK_IMMEUB]     INT             NULL,
    [FK_LOCAL]      INT             NULL,
    [FK_COMPTE]     INT             NULL,
    [FK_TIERS]      INT             NULL,
    [FK_BAIL]       INT             NULL,
    [CORG]          VARCHAR (4)     NOT NULL,
    [CAGENCE]       VARCHAR (4)     NOT NULL,
    [CGROUPE]       INT             NOT NULL,
    [CIMMEUB]       INT             NOT NULL,
    [CLOCAL]        INT             NOT NULL,
    [OCC]           INT             NOT NULL,
    [CCOMPTE]       VARCHAR (22)    NULL,
    [NOLOCAT]       INT             NULL,
    [CONTLOC]       INT             NULL,
    [DATENTQUIT]    DATE            NULL,
    [DATENTREGU]    DATE            NULL,
    [DENTETAT]      DATE            NULL,
    [HEURETAT]      INT             NULL,
    [MINETAT]       INT             NULL,
    [CEMPLOY]       INT             NULL,
    [DATSORQUIT]    DATE            CONSTRAINT [DF__ESTIA_LOC__DATSO__4AA30C57] DEFAULT (NULL) NULL,
    [DATSOREGU]     DATE            NULL,
    [TERME]         INT             NULL,
    [DATSORPREV]    DATE            NULL,
    [DATSORETAT]    DATE            NULL,
    [HEURETATPS]    INT             NULL,
    [MINETATPS]     INT             NULL,
    [PEMPLOY]       INT             NULL,
    [DSORETAT]      DATE            NULL,
    [HEURETATS]     INT             NULL,
    [MINETATS]      INT             NULL,
    [SEMPLOY]       INT             NULL,
    [CTYPLOC]       VARCHAR (4)     NULL,
    [PERIOD]        INT             NULL,
    [CBAIL]         VARCHAR (4)     NULL,
    [COEFPOND]      NUMERIC (19, 4) NULL,
    [COEFREL]       NUMERIC (19, 4) NULL,
    [RPTIERS]       VARCHAR (14)    NULL,
    [RETIERS]       VARCHAR (14)    NULL,
    [RPTYPTIERS]    VARCHAR (2)     NULL,
    [CTYPECRI]      VARCHAR (6)     NULL,
    [DECOMPTE]      DATE            NULL,
    [RETYPTIERS]    VARCHAR (2)     NULL,
    [DURBAIL]       INT             NULL,
    [DURPREAV]      INT             NULL,
    [DGARAN]        NUMERIC (17, 2) NULL,
    [DATENTBAIL]    DATE            NULL,
    [DATSORCONT]    DATE            NULL,
    [CMOTDDE]       VARCHAR (4)     NULL,
    [CDESTI]        VARCHAR (4)     NULL,
    [TRIMIND]       INT             NULL,
    [NOBAIL]        INT             NULL,
    [DEBPER]        INT             NULL,
    [SHAB]          NUMERIC (17, 2) NULL,
    [SCORR]         NUMERIC (17, 2) NULL,
    [SCHAU]         NUMERIC (17, 2) NULL,
    [NOCONT]        VARCHAR (20)    NULL,
    [DREVISION]     DATE            NULL,
    [PEREVISION]    INT             NULL,
    [ENTPRES]       VARCHAR (2)     NULL,
    [EDITAR]        VARCHAR (1)     NULL,
    [EDITDEC]       VARCHAR (1)     NULL,
    [TRIG]          VARCHAR (2)     NULL,
    [DENRGSORT]     DATE            NULL,
    [DEMISAVIS]     DATE            NULL,
    [DIMPQUITT]     DATE            NULL,
    [CACCESS]       VARCHAR (2)     NULL,
    [MOIPER]        INT             NULL,
    [DATEFFET]      DATE            NULL,
    [DATFIN]        DATE            NULL,
    [TAXADD]        VARCHAR (1)     NULL,
    [TAUXRECUP]     NUMERIC (17, 2) NULL,
    [CQUABAIL]      VARCHAR (6)     NULL,
    [DGREV]         VARCHAR (1)     NULL,
    [SUTILE]        NUMERIC (17, 2) NULL,
    [SCUTILE]       NUMERIC (17, 2) NULL,
    [INDEMOCC]      VARCHAR (1)     NULL,
    [COEF]          NUMERIC (17, 2) NULL,
    [SREELLE]       NUMERIC (17, 2) NULL,
    [SIMPOS]        NUMERIC (17, 2) NULL,
    [COPRO]         VARCHAR (2)     NULL,
    [EDITBAIL]      VARCHAR (1)     NULL,
    [POURCIDR]      NUMERIC (17, 2) NULL,
    [MTPREV]        NUMERIC (17, 2) NULL,
    [REFINTERF]     VARCHAR (40)    NULL,
    [PRETMT]        NUMERIC (17, 2) NULL,
    [PRETDEP]       DATE            NULL,
    [PRETOBJ]       VARCHAR (80)    NULL,
    [PRETDUR]       INT             NULL,
    [MUTANT]        VARCHAR (1)     NULL,
    [DGDU]          NUMERIC (17, 2) NULL,
    [DGENC]         NUMERIC (17, 2) NULL,
    [ALERTE]        VARCHAR (2)     NULL,
    [MATYPTIERS]    VARCHAR (2)     NULL,
    [MATIERS]       VARCHAR (14)    NULL,
    [DATTACH]       DATE            NULL,
    [DDETACH]       DATE            NULL,
    [DFERME]        DATE            NULL,
    [MTMINICA]      NUMERIC (17, 2) NULL,
    [MTMAXICA]      NUMERIC (17, 2) NULL,
    [PRCCA]         NUMERIC (17, 2) NULL,
    [DGFACIAL]      VARCHAR (1)     NULL,
    [INDCONNU]      VARCHAR (1)     NULL,
    [LBAREMCA]      VARCHAR (1)     NULL,
    [PRISQUE]       INT             NULL,
    [PFERME]        INT             NULL,
    [PREAGES]       INT             NULL,
    [CNUMI]         VARCHAR (10)    NULL,
    [DERTERM]       VARCHAR (1)     NULL,
    [INDREF]        INT             NULL,
    [NAVENAN]       INT             NULL,
    [DREVIS]        DATE            NULL,
    [DECHEANCE]     DATE            NULL,
    [LTVA]          VARCHAR (1)     NULL,
    [LDIV]          VARCHAR (1)     NULL,
    [INDPREC]       INT             NULL,
    [NBDG]          INT             NULL,
    [LTRIENNAL]     VARCHAR (1)     NULL,
    [SIGETATS]      VARCHAR (1)     NULL,
    [LREVCAUT]      VARCHAR (1)     NULL,
    [LCLOCAUT]      VARCHAR (1)     NULL,
    [NBJCAUT]       INT             NULL,
    [CMOTIF]        VARCHAR (4)     NULL,
    [NBPRCAU]       INT             NULL,
    [CFTYPTIERS]    VARCHAR (2)     NULL,
    [RELANCE]       VARCHAR (1)     NULL,
    [TYPEDI]        VARCHAR (2)     NULL,
    [COMPENS]       VARCHAR (2)     NULL,
    [COCORG]        VARCHAR (4)     NULL,
    [COMANDAT]      VARCHAR (16)    NULL,
    [CODDEB]        DATE            NULL,
    [CODFIN]        DATE            NULL,
    [CFTIERS]       VARCHAR (14)    NULL,
    [COCTIERS]      VARCHAR (14)    NULL,
    [CFCONVOC]      VARCHAR (6)     NULL,
    [DFINBAIL]      DATE            NULL,
    [MACONVOC]      VARCHAR (6)     NULL,
    [NBJBAIL]       INT             NULL,
    [RPCONVOC]      VARCHAR (6)     NULL,
    [LOCIDR]        VARCHAR (1)     NULL,
    [CMANDAT]       VARCHAR (16)    NULL,
    [PRCPLAF]       NUMERIC (17, 2) NULL,
    [PRCHONO]       NUMERIC (17, 2) NULL,
    [LDGTVA]        VARCHAR (1)     NULL,
    [CFISCAL]       VARCHAR (6)     NULL,
    [MIGCOMPT]      INT             NULL,
    [CMOTIFNP]      VARCHAR (4)     NULL,
    [CMOTREP]       VARCHAR (4)     NULL,
    [TEMMAJ]        VARCHAR (2)     NULL,
    [DATMAJ]        DATE            NULL,
    [TEDCONG]       VARCHAR (1)     NULL,
    [DETDATE]       DATE            NULL,
    [LASSUR]        VARCHAR (1)     NULL,
    [LVIR]          VARCHAR (1)     NULL,
    [TYPTAUX]       VARCHAR (2)     NULL,
    [TAUXINT]       NUMERIC (17, 2) NULL,
    [CMOTIFDA]      VARCHAR (4)     NULL,
    [DEDITBAI]      DATE            NULL,
    [DELAIPAIEMENT] INT             NULL,
    [CMODPAI]       VARCHAR (4)     NULL,
    [DBASSIN]       VARCHAR (6)     NULL,
    [DSECTEUR]      VARCHAR (6)     NULL,
    [DCOMM]         INT             NULL,
    [DPAYS]         VARCHAR (6)     NULL,
    [DDEPART]       VARCHAR (4)     NULL,
    [CENVOIAVIS]    VARCHAR (4)     NULL,
    [DEDITFACINOC]  DATE            NULL,
    [CTYPQUI]       VARCHAR (4)     NULL,
    [REVISNEG]      VARCHAR (2)     NULL,
    [EDELSOR]       INT             NULL,
    [EDLENT]        INT             NULL,
    [TAUXPLURI]     NUMERIC (17, 2) NULL,
    [DDEBPLAFPLURI] DATE            NULL,
    [DFINPLAFPLURI] DATE            NULL,
    [INDEXREFPLURI] INT             NULL,
    CONSTRAINT [PK_ESTIA_LOCATION] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC, [OCC] ASC)
);

