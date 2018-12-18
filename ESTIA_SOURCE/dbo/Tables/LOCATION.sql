﻿CREATE TABLE [dbo].[LOCATION] (
    [CORG]          VARCHAR (50) NULL,
    [CAGENCE]       VARCHAR (50) NULL,
    [CGROUPE]       VARCHAR (50) NULL,
    [CIMMEUB]       VARCHAR (50) NULL,
    [CLOCAL]        VARCHAR (50) NULL,
    [OCC]           VARCHAR (50) NULL,
    [CCOMPTE]       VARCHAR (50) NULL,
    [NOLOCAT]       VARCHAR (50) NULL,
    [CONTLOC]       VARCHAR (50) NULL,
    [DATENTQUIT]    DATE         NULL,
    [DATENTREGU]    VARCHAR (50) NULL,
    [DENTETAT]      VARCHAR (50) NULL,
    [HEURETAT]      VARCHAR (50) NULL,
    [MINETAT]       VARCHAR (50) NULL,
    [CEMPLOY]       VARCHAR (50) NULL,
    [DATSORQUIT]    DATE         NULL,
    [DATSOREGU]     DATE         NULL,
    [TERME]         VARCHAR (50) NULL,
    [DATSORPREV]    DATE         NULL,
    [DATSORETAT]    DATE         NULL,
    [HEURETATPS]    VARCHAR (50) NULL,
    [MINETATPS]     VARCHAR (50) NULL,
    [PEMPLOY]       VARCHAR (50) NULL,
    [DSORETAT]      VARCHAR (50) NULL,
    [HEURETATS]     VARCHAR (50) NULL,
    [MINETATS]      VARCHAR (50) NULL,
    [SEMPLOY]       VARCHAR (50) NULL,
    [CTYPLOC]       VARCHAR (50) NULL,
    [PERIOD]        VARCHAR (50) NULL,
    [CBAIL]         VARCHAR (50) NULL,
    [COEFPOND]      VARCHAR (50) NULL,
    [COEFREL]       VARCHAR (50) NULL,
    [RPTIERS]       VARCHAR (50) NULL,
    [RETIERS]       VARCHAR (50) NULL,
    [RPTYPTIERS]    VARCHAR (50) NULL,
    [CTYPECRI]      VARCHAR (50) NULL,
    [DECOMPTE]      VARCHAR (50) NULL,
    [RETYPTIERS]    VARCHAR (50) NULL,
    [DURBAIL]       VARCHAR (50) NULL,
    [DURPREAV]      VARCHAR (50) NULL,
    [DGARAN]        VARCHAR (50) NULL,
    [DATENTBAIL]    VARCHAR (50) NULL,
    [DATSORCONT]    DATE         NULL,
    [CMOTDDE]       VARCHAR (50) NULL,
    [CDESTI]        VARCHAR (50) NULL,
    [TRIMIND]       VARCHAR (50) NULL,
    [NOBAIL]        VARCHAR (50) NULL,
    [DEBPER]        VARCHAR (50) NULL,
    [SHAB]          VARCHAR (50) NULL,
    [SCORR]         VARCHAR (50) NULL,
    [SCHAU]         VARCHAR (50) NULL,
    [NOCONT]        VARCHAR (50) NULL,
    [DREVISION]     DATE         NULL,
    [PEREVISION]    VARCHAR (50) NULL,
    [ENTPRES]       VARCHAR (50) NULL,
    [EDITAR]        VARCHAR (50) NULL,
    [EDITDEC]       VARCHAR (50) NULL,
    [TRIG]          VARCHAR (50) NULL,
    [DENRGSORT]     VARCHAR (50) NULL,
    [DEMISAVIS]     VARCHAR (50) NULL,
    [DIMPQUITT]     VARCHAR (50) NULL,
    [CACCESS]       VARCHAR (50) NULL,
    [MOIPER]        VARCHAR (50) NULL,
    [DATEFFET]      DATE         NULL,
    [DATFIN]        DATE         NULL,
    [TAXADD]        VARCHAR (50) NULL,
    [TAUXRECUP]     VARCHAR (50) NULL,
    [CQUABAIL]      VARCHAR (50) NULL,
    [DGREV]         VARCHAR (50) NULL,
    [SUTILE]        VARCHAR (50) NULL,
    [SCUTILE]       VARCHAR (50) NULL,
    [INDEMOCC]      VARCHAR (50) NULL,
    [COEF]          VARCHAR (50) NULL,
    [SREELLE]       VARCHAR (50) NULL,
    [SIMPOS]        VARCHAR (50) NULL,
    [COPRO]         VARCHAR (50) NULL,
    [EDITBAIL]      VARCHAR (50) NULL,
    [POURCIDR]      VARCHAR (50) NULL,
    [MTPREV]        VARCHAR (50) NULL,
    [REFINTERF]     VARCHAR (50) NULL,
    [PRETMT]        VARCHAR (50) NULL,
    [PRETDEP]       VARCHAR (50) NULL,
    [PRETOBJ]       VARCHAR (50) NULL,
    [PRETDUR]       VARCHAR (50) NULL,
    [MUTANT]        VARCHAR (50) NULL,
    [DGDU]          VARCHAR (50) NULL,
    [DGENC]         VARCHAR (50) NULL,
    [ALERTE]        VARCHAR (50) NULL,
    [MATYPTIERS]    VARCHAR (50) NULL,
    [MATIERS]       VARCHAR (50) NULL,
    [DATTACH]       VARCHAR (50) NULL,
    [DDETACH]       VARCHAR (50) NULL,
    [DFERME]        VARCHAR (50) NULL,
    [MTMINICA]      VARCHAR (50) NULL,
    [MTMAXICA]      VARCHAR (50) NULL,
    [PRCCA]         VARCHAR (50) NULL,
    [DGFACIAL]      VARCHAR (50) NULL,
    [INDCONNU]      VARCHAR (50) NULL,
    [LBAREMCA]      VARCHAR (50) NULL,
    [PRISQUE]       VARCHAR (50) NULL,
    [PFERME]        VARCHAR (50) NULL,
    [PREAGES]       VARCHAR (50) NULL,
    [CNUMI]         VARCHAR (50) NULL,
    [DERTERM]       VARCHAR (50) NULL,
    [INDREF]        VARCHAR (50) NULL,
    [NAVENAN]       VARCHAR (50) NULL,
    [DREVIS]        VARCHAR (50) NULL,
    [DECHEANCE]     VARCHAR (50) NULL,
    [LTVA]          VARCHAR (50) NULL,
    [LDIV]          VARCHAR (50) NULL,
    [INDPREC]       VARCHAR (50) NULL,
    [NBDG]          VARCHAR (50) NULL,
    [LTRIENNAL]     VARCHAR (50) NULL,
    [SIGETATS]      VARCHAR (50) NULL,
    [LREVCAUT]      VARCHAR (50) NULL,
    [LCLOCAUT]      VARCHAR (50) NULL,
    [NBJCAUT]       VARCHAR (50) NULL,
    [CMOTIF]        VARCHAR (50) NULL,
    [NBPRCAU]       VARCHAR (50) NULL,
    [CFTYPTIERS]    VARCHAR (50) NULL,
    [RELANCE]       VARCHAR (50) NULL,
    [TYPEDI]        VARCHAR (50) NULL,
    [COMPENS]       VARCHAR (50) NULL,
    [COCORG]        VARCHAR (50) NULL,
    [COMANDAT]      VARCHAR (50) NULL,
    [CODDEB]        VARCHAR (50) NULL,
    [CODFIN]        VARCHAR (50) NULL,
    [CFTIERS]       VARCHAR (50) NULL,
    [COCTIERS]      VARCHAR (50) NULL,
    [CFCONVOC]      VARCHAR (50) NULL,
    [DFINBAIL]      VARCHAR (50) NULL,
    [MACONVOC]      VARCHAR (50) NULL,
    [NBJBAIL]       VARCHAR (50) NULL,
    [RPCONVOC]      VARCHAR (50) NULL,
    [LOCIDR]        VARCHAR (50) NULL,
    [CMANDAT]       VARCHAR (50) NULL,
    [PRCPLAF]       VARCHAR (50) NULL,
    [PRCHONO]       VARCHAR (50) NULL,
    [LDGTVA]        VARCHAR (50) NULL,
    [CFISCAL]       VARCHAR (50) NULL,
    [MIGCOMPT]      VARCHAR (50) NULL,
    [CMOTIFNP]      VARCHAR (50) NULL,
    [CMOTREP]       VARCHAR (50) NULL,
    [TEMMAJ]        VARCHAR (50) NULL,
    [DATMAJ]        VARCHAR (50) NULL,
    [TEDCONG]       VARCHAR (50) NULL,
    [DETDATE]       VARCHAR (50) NULL,
    [LASSUR]        VARCHAR (50) NULL,
    [LVIR]          VARCHAR (50) NULL,
    [TYPTAUX]       VARCHAR (50) NULL,
    [TAUXINT]       VARCHAR (50) NULL,
    [CMOTIFDA]      VARCHAR (50) NULL,
    [DEDITBAI]      VARCHAR (50) NULL,
    [DELAIPAIEMENT] VARCHAR (50) NULL,
    [CMODPAI]       VARCHAR (50) NULL,
    [DBASSIN]       VARCHAR (50) NULL,
    [DSECTEUR]      VARCHAR (50) NULL,
    [DCOMM]         VARCHAR (50) NULL,
    [DPAYS]         VARCHAR (50) NULL,
    [DDEPART]       VARCHAR (50) NULL,
    [CENVOIAVIS]    VARCHAR (50) NULL,
    [DEDITFACINOC]  VARCHAR (50) NULL,
    [CTYPQUI]       VARCHAR (50) NULL,
    [REVISNEG]      VARCHAR (50) NULL,
    [EDELSOR]       VARCHAR (50) NULL,
    [EDLENT]        VARCHAR (50) NULL,
    [TAUXPLURI]     VARCHAR (50) NULL,
    [DDEBPLAFPLURI] VARCHAR (50) NULL,
    [DFINPLAFPLURI] VARCHAR (50) NULL,
    [INDEXREFPLURI] VARCHAR (50) NULL,
    [PRETDECOMPTE]  VARCHAR (50) NULL,
    [EDLPSOR]       VARCHAR (50) NULL,
    [EPTIERS]       VARCHAR (50) NULL,
    [EPTYPTIERS]    VARCHAR (50) NULL,
    [JDURBAIL]      VARCHAR (50) NULL,
    [ADURBAIL]      VARCHAR (50) NULL,
    [DATSORTHEO]    VARCHAR (50) NULL,
    [REVLOCBAIL]    VARCHAR (50) NULL
);
