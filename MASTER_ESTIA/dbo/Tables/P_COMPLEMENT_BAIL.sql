CREATE TABLE [dbo].[P_COMPLEMENT_BAIL] (
    [PK_BAIL]       NUMERIC (38)    NULL,
    [NM_IMMEUBLE]   NUMERIC (38)    NULL,
    [NOM_IMMEUBLE]  NVARCHAR (255)  NULL,
    [NM_BAIL]       NVARCHAR (255)  NULL,
    [NOM_LOCATAIRE] NVARCHAR (255)  NULL,
    [CHEMIN_BAIL]   NVARCHAR (2000) NULL,
    [CORG]          VARCHAR (4)     NULL,
    [CAGENCE]       VARCHAR (4)     NULL,
    [CGROUPE]       INT             NULL,
    [CIMMEUB]       INT             NULL,
    [CLOCAL]        INT             NULL,
    [OCC]           INT             NULL
);

