﻿CREATE TABLE [dbo].[ESTIA_DPROCTX] (
    [CTYPROC]   VARCHAR (6)  NOT NULL,
    [NOPROC]    INT          NOT NULL,
    [CORG]      VARCHAR (4)  NOT NULL,
    [CCOMPTE]   VARCHAR (22) NOT NULL,
    [NOBAIL]    INT          NULL,
    [TYPER]     VARCHAR (2)  NULL,
    [CTYPTIERS] VARCHAR (2)  NULL,
    [CTIERS]    VARCHAR (14) NULL,
    [CAGENCE]   VARCHAR (4)  NULL,
    [CGROUPE]   INT          NULL,
    [CIMMEUB]   INT          NULL,
    [CLOCAL]    INT          NULL,
    [OCC]       INT          NULL,
    [DATCREAT]  DATE         NULL,
    [CEMPLOY]   INT          NULL,
    [REF]       VARCHAR (40) NULL,
    [DATCLO]    DATE         NULL,
    [CMOTSCR]   VARCHAR (6)  NULL,
    [DATSUSP]   DATE         NULL,
    [SMOTSCR]   VARCHAR (6)  NULL,
    [TRIG]      VARCHAR (2)  NULL,
    [MIGCOMPT]  INT          NULL,
    [DSUSPFIN]  DATE         NULL,
    [DARRETE]   DATE         NULL,
    [PERARRETE] INT          NULL,
    [NODOS]     INT          NULL,
    [PRINCIPAL] VARCHAR (1)  NULL
);

