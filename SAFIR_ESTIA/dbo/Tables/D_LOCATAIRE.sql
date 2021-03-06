﻿CREATE TABLE [dbo].[D_LOCATAIRE] (
    [DT_REF]               DATETIME        NULL,
    [PK_LOCATAIRE]         INT             NOT NULL,
    [CD_ORIGINE]           VARCHAR (5)     NULL,
    [CD_LOCATAIRE]         VARCHAR (14)    NULL,
    [NM_LOCATAIRE]         NUMERIC (14)    NULL,
    [CD_QUALITE_CIVILE]    VARCHAR (8)     NULL,
    [LB_QUALITE_CIVILE]    VARCHAR (60)    NULL,
    [NOM_LOCATAIRE]        VARCHAR (76)    NULL,
    [PRENOM_LOCATAIRE]     VARCHAR (40)    NULL,
    [CPLT_NOM_LOCATAIRE]   VARCHAR (30)    NULL,
    [ADRLGN1]              VARCHAR (76)    NULL,
    [ADRLGN2]              VARCHAR (76)    NULL,
    [ADRLGN3]              VARCHAR (76)    NULL,
    [CODPOS]               VARCHAR (10)    NULL,
    [VILLE]                VARCHAR (64)    NULL,
    [TELEPHONE]            VARCHAR (50)    NULL,
    [TELEPHONE_2]          VARCHAR (40)    NULL,
    [FAX]                  VARCHAR (40)    NULL,
    [CD_TYPE_TIERS]        VARCHAR (5)     NULL,
    [LB_TYPE_TIERS]        VARCHAR (17)    NULL,
    [CODE_APE]             VARCHAR (12)    NULL,
    [LIBELLE_APE]          VARCHAR (130)   NULL,
    [CODE_NAF]             VARCHAR (15)    NULL,
    [NOM_COMMERCIAL]       VARCHAR (30)    NULL,
    [IND_LOYER_VARIABLE]   VARCHAR (1)     NULL,
    [MT_CA]                NUMERIC (13, 2) NULL,
    [ANNEE_CA]             NUMERIC (4)     NULL,
    [CD_CLIENT]            VARCHAR (5)     NULL,
    [CD_TYPE_PERSONNE_AXA] VARCHAR (2)     NULL,
    [CD_SAP_IVG]           VARCHAR (13)    NULL,
    [NOM_LOCATAIRE_IVG]    VARCHAR (76)    NULL,
    CONSTRAINT [PK_D_LOCATAIRE_1] PRIMARY KEY CLUSTERED ([PK_LOCATAIRE] ASC)
);

