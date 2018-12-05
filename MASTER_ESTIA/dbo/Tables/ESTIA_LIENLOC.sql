﻿CREATE TABLE [dbo].[ESTIA_LIENLOC] (
    [PK_LIENLOC] INT          IDENTITY (1, 1) NOT NULL,
    [FK_TIERS]   INT          NULL,
    [FK_COMPTE]  INT          NULL,
    [CTYPTIERS]  VARCHAR (2)  NOT NULL,
    [CTIERS]     VARCHAR (14) NOT NULL,
    [CORG]       VARCHAR (4)  NOT NULL,
    [CCOMPTE]    VARCHAR (22) NOT NULL,
    [TITULAIRE]  VARCHAR (1)  NULL,
    [DATSOR]     DATE         NULL,
    [TRIG]       VARCHAR (2)  NULL,
    [DATENT]     DATE         NULL,
    [MIGCOMPT]   INT          NULL,
    [DATTACH]    DATE         NULL,
    [CMOTIFATT]  VARCHAR (4)  NULL,
    [DDETACH]    DATE         NULL,
    [CMOTIFDET]  VARCHAR (4)  NULL,
    [SOLIDDEB]   DATE         NULL,
    [SOLIDFIN]   DATE         NULL,
    [CHARGPLA]   VARCHAR (2)  NULL,
    [CHARGAPL]   VARCHAR (2)  NULL,
    [VISITE]     VARCHAR (2)  NULL,
    [OCCUPANT]   VARCHAR (2)  NULL,
    [CSITUFA]    VARCHAR (2)  NULL,
    [DATMAR]     DATE         NULL,
    [LIEUMAR]    VARCHAR (60) NULL,
    [DATVIMA]    DATE         NULL,
    [DATVEU]     DATE         NULL,
    [DATDIV]     DATE         NULL,
    [DATDECES]   DATE         NULL,
    [CONFIDEN]   VARCHAR (2)  NULL,
    [CPARENTE]   VARCHAR (6)  NULL,
    [CTYPAREN]   VARCHAR (2)  NULL,
    [CTPARENT]   VARCHAR (14) NULL,
    [CENFANAITR] VARCHAR (2)  NULL,
    [DENFANAITR] DATE         NULL,
    [CODEAGREM]  VARCHAR (20) NULL,
    [NBANAITRE]  INT          NULL,
    [ALTERNE]    VARCHAR (2)  NULL,
    [MULTIEMP]   VARCHAR (2)  NULL,
    [RK]         INT          NULL
);

