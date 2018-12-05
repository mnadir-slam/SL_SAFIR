CREATE TABLE [dbo].[P_ETAT_LOC_INIT] (
    [CODE_SOCIETE]         NVARCHAR (2)    NULL,
    [PK_IMMEUBLE]          NUMERIC (38)    NULL,
    [CODE_IMMEUBLE]        NUMERIC (38)    NULL,
    [NOM_IMMEUBLE]         NVARCHAR (255)  NULL,
    [PK_LOT]               NVARCHAR (255)  NULL,
    [NM_LOT]               NUMERIC (38)    NULL,
    [PK_BAIL]              NUMERIC (38)    NULL,
    [NM_BAIL]              NUMERIC (38)    NULL,
    [PK_LOCATAIRE]         NUMERIC (38)    NULL,
    [NM_LOCATAIRE]         NUMERIC (38)    NULL,
    [NOM_LOCATAIRE]        NVARCHAR (255)  NULL,
    [DATE_ENTREE]          DATETIME        NULL,
    [DATE_SIGNATURE]       DATETIME        NULL,
    [DATE_EFFET]           DATETIME        NULL,
    [MT_DG_BASE]           NUMERIC (38, 2) NULL,
    [MT_LOYER_ANNUEL_BASE] NUMERIC (38, 2) NULL,
    [TYPE_INDICE ]         NVARCHAR (255)  NULL,
    [INDICE_BASE]          NVARCHAR (255)  NULL,
    [VAL_INDICE_BASE]      NUMERIC (38, 2) NULL
);

