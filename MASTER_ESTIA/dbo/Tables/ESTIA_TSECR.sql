﻿CREATE TABLE [dbo].[ESTIA_TSECR] (
    [PK_TSECR]  INT             IDENTITY (1, 1) NOT NULL,
    [CORG]      VARCHAR (4)     NOT NULL,
    [CTYPTIERS] VARCHAR (2)     NOT NULL,
    [CJOURNAL]  VARCHAR (6)     NOT NULL,
    [NODOC]     VARCHAR (24)    NULL,
    [MTLET]     NUMERIC (17, 2) NULL,
    [NOPIECE]   VARCHAR (24)    NULL,
    [REF]       VARCHAR (42)    NULL,
    [DATEC]     DATE            NOT NULL,
    [DVAL]      DATE            NOT NULL,
    [PERIODE]   VARCHAR (12)    NOT NULL,
    [LIBELLE]   VARCHAR (60)    NULL,
    [MONTANT]   NUMERIC (17, 2) NULL,
    [SENS]      VARCHAR (2)     NOT NULL,
    [CTYPECRI]  VARCHAR (6)     NULL,
    [CTIERS]    VARCHAR (14)    NOT NULL,
    [PIEC2]     INT             NULL,
    [DATECH]    DATE            NULL,
    [TRAIT]     VARCHAR (6)     NULL,
    [TRIG]      VARCHAR (2)     NULL,
    [DATRAP]    DATE            NULL,
    [CMODREG]   VARCHAR (4)     NULL,
    [CTSCAT]    VARCHAR (4)     NOT NULL,
    [ACOMPTE]   VARCHAR (1)     NULL,
    [VALIDE]    VARCHAR (1)     NULL,
    [ORD]       INT             NULL,
    [NODOM]     INT             NULL,
    [LETTRAGE]  VARCHAR (16)    NULL,
    [UTIL]      VARCHAR (24)    NULL,
    [INFO]      VARCHAR (44)    NULL,
    [CMANDAT]   VARCHAR (16)    NULL
);

