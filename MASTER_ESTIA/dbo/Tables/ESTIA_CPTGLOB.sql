﻿CREATE TABLE [dbo].[ESTIA_CPTGLOB] (
    [PK_CPTGLOB] INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]     INT             NULL,
    [FK_AGENCE]  INT             NULL,
    [FK_GROUPE]  INT             NULL,
    [FK_IMMEUB]  INT             NULL,
    [FK_LOCAL]   INT             NULL,
    [FK_COMPTE]  INT             NULL,
    [FK_BAIL]    INT             NULL,
    [FK_TIERS]   INT             NULL,
    [FK_RUB]     INT             NULL,
    [CALC_CRUB]  INT             NULL,
    [CORG]       VARCHAR (4)     NULL,
    [CCOMPTE]    VARCHAR (22)    NULL,
    [DATEC]      DATE            NULL,
    [CJOURNAL]   VARCHAR (6)     NULL,
    [CTYPECRI]   VARCHAR (6)     NULL,
    [SENS]       VARCHAR (2)     NULL,
    [LIB]        VARCHAR (80)    NULL,
    [CBANQUE]    VARCHAR (50)    NULL,
    [TYPCPTA]    VARCHAR (4)     NULL,
    [LETTRAGE]   VARCHAR (18)    NULL,
    [MONTANT]    NUMERIC (18, 2) NULL,
    [NOPIECE]    VARCHAR (16)    NULL,
    [REF]        VARCHAR (50)    NULL,
    [TRIG]       VARCHAR (50)    NULL,
    [TRAIT]      VARCHAR (6)     NULL,
    [CRUB]       VARCHAR (3)     NULL,
    [NOLOCAT]    INT             NULL,
    [NOBAIL]     INT             NULL,
    [MONTDOUT]   NUMERIC (17, 2) NULL,
    [REGROUPLOC] VARCHAR (12)    NULL,
    [CTIERS]     VARCHAR (14)    NULL,
    [CORGPAY]    VARCHAR (6)     NULL,
    [CSTE]       VARCHAR (2)     NULL,
    [CTYPTIERS]  VARCHAR (2)     NULL,
    [CTASS]      INT             NULL,
    [NOCHEQUE]   VARCHAR (16)    NULL,
    [REFREJET]   VARCHAR (42)    NULL,
    [DREJET]     DATE            NULL,
    [INFO]       VARCHAR (44)    NULL,
    [MONTEXC]    VARCHAR (50)    NULL,
    [MONTCRE]    VARCHAR (50)    NULL,
    [GELE]       VARCHAR (5)     NULL,
    [ECHEANCE]   VARCHAR (10)    NULL,
    [MOTREJ]     VARCHAR (4)     NULL,
    [REMANGES]   VARCHAR (42)    NULL,
    [CMONNAIE]   VARCHAR (20)    NULL,
    [MTEURO]     VARCHAR (50)    NULL,
    [MTEDV]      VARCHAR (50)    NULL,
    [MONTD1]     VARCHAR (50)    NULL,
    [PATYPTIERS] VARCHAR (20)    NULL,
    [PATIERS]    VARCHAR (14)    NULL,
    [DVAL]       VARCHAR (20)    NULL,
    [MONTD2]     NUMERIC (17, 2) NULL,
    [MONTD3]     NUMERIC (17, 2) NULL,
    [MONTEDV]    NUMERIC (17, 2) NULL,
    [LETECH]     VARCHAR (12)    NULL,
    [EDITQUIT]   VARCHAR (50)    NULL,
    [CSINIS]     VARCHAR (30)    NULL,
    [MIGCOMPT]   VARCHAR (20)    NULL,
    [CTYPRGLT]   VARCHAR (4)     NULL,
    [CMANDAT]    VARCHAR (50)    NULL
);

