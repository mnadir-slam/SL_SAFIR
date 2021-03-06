﻿CREATE TABLE [dbo].[WRK_TRAIT_LOTS] (
    [CD_CAS]                      INT             NULL,
    [LB_CAS]                      VARCHAR (100)   NULL,
    [FK_ORG]                      INT             NULL,
    [FK_PROPRIETAIRE]             INT             NULL,
    [FK_GROUPE]                   INT             NULL,
    [FK_BAIL]                     INT             NULL,
    [FK_LOCAL]                    INT             NULL,
    [NOM_PROPRIETAIRE]            VARCHAR (100)   NULL,
    [CORG]                        VARCHAR (4)     NULL,
    [CD_IMMEUBLE_DREAM]           VARCHAR (100)   NULL,
    [CGROUPE]                     INT             NULL,
    [LGROUPE]                     VARCHAR (100)   NULL,
    [CCOMPTE]                     VARCHAR (22)    NULL,
    [NOBAIL]                      INT             NULL,
    [NOM_LOCATAIRE]               VARCHAR (100)   NULL,
    [CD_STATUT]                   VARCHAR (1)     NULL,
    [DT_DEBUT_RAT]                DATE            NULL,
    [DT_FIN_RAT]                  DATE            NULL,
    [DT_DEBUT_OCCUPATION]         DATE            NULL,
    [DT_FIN_OCCUPATION]           DATE            NULL,
    [DT_DEBUT_VACANCE]            DATE            NULL,
    [DT_FIN_VACANCE]              DATE            NULL,
    [DT_DEBUT_OCCUPATION_TRIM]    DATE            NULL,
    [DT_FIN_OCCUPATION_TRIM]      DATE            NULL,
    [DT_DEBUT_VACANCE_TRIM]       DATE            NULL,
    [DT_FIN_VACANCE_TRIM]         DATE            NULL,
    [NB_JOURS_TRIM]               INT             NULL,
    [NB_JOURS_OCCUPATION_TRIM]    INT             NULL,
    [NB_JOURS_VACANCE_TRIM]       INT             NULL,
    [SURFACE_TOTALE_IMMEUBLE]     NUMERIC (18, 2) NULL,
    [CD_TYPE_LOT]                 VARCHAR (6)     NULL,
    [LB_TYPE_LOT]                 VARCHAR (30)    NULL,
    [CD_REG_USAGE]                VARCHAR (6)     NULL,
    [LB_REG_USAGE]                VARCHAR (60)    NULL,
    [VAL_SURF_BUR]                NUMERIC (18, 2) NULL,
    [VAL_SURF_COM]                NUMERIC (18, 2) NULL,
    [VAL_SURF_ARC]                NUMERIC (18, 2) NULL,
    [VAL_SURF_HAB]                NUMERIC (18, 2) NULL,
    [VAL_SURF_ACT]                NUMERIC (18, 2) NULL,
    [VLM]                         NUMERIC (18, 2) NULL,
    [VLM_BUREAUX]                 NUMERIC (18, 2) NULL,
    [VLM_COMMERCES]               NUMERIC (18, 2) NULL,
    [VLM_ARCHIVES]                NUMERIC (18, 2) NULL,
    [VLM_HABITATION]              NUMERIC (18, 2) NULL,
    [VLM_ACTIVITE]                NUMERIC (18, 2) NULL,
    [VLM_PKG_EXT]                 NUMERIC (18, 2) NULL,
    [VLM_PKG_INT]                 NUMERIC (18, 2) NULL,
    [VLM_BUREAUX_PRORATISE]       NUMERIC (18, 2) NULL,
    [VLM_COMMERCES_PRORATISE]     NUMERIC (18, 2) NULL,
    [VLM_ARCHIVES_PRORATISE]      NUMERIC (18, 2) NULL,
    [VLM_HABITATION_PRORATISE]    NUMERIC (18, 2) NULL,
    [VLM_ACTIVITE_PRORATISE]      NUMERIC (18, 2) NULL,
    [VLM_PKG_EXT_PRORATISE]       NUMERIC (18, 2) NULL,
    [VLM_PKG_INT_PRORATISE]       NUMERIC (18, 2) NULL,
    [LOYER_FACIAL]                NUMERIC (18, 2) NULL,
    [MT_FRANCHISE_PALIER]         NUMERIC (18, 2) NULL,
    [LOYER_FACIAL_TRIMESTRIEL]    NUMERIC (18, 2) NULL,
    [LOYER_TRIMESTRIEL_QUITTANCE] NUMERIC (18, 2) NULL
);

