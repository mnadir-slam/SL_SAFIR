﻿CREATE PROCEDURE [dbo].[RECUP_ESTIA_COMPTABILITE]
AS
BEGIN

DECLARE @ID_LOG INT, @NB INT


--CPTGLOB: TABLE DE COMPTABILITE DES LOCATAIRES
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('CPTGLOB', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_CPTGLOB
INSERT INTO ESTIA_CPTGLOB (CORG, CCOMPTE, DATEC, CJOURNAL, CTYPECRI, SENS, LIB, CBANQUE, TYPCPTA, LETTRAGE, MONTANT, NOPIECE, REF, TRIG, TRAIT, CRUB, NOLOCAT, NOBAIL, MONTDOUT, REGROUPLOC, CTIERS, CORGPAY, CSTE, CTYPTIERS, CTASS, NOCHEQUE, REFREJET, DREJET, INFO, MONTEXC, MONTCRE, GELE, ECHEANCE, MOTREJ, REMANGES, CMONNAIE, MTEURO, MTEDV, MONTD1, CMANDAT/*, PATYPTIERS, PATIERS, DVAL, MONTD2, MONTD3, MONTEDV, LETECH, EDITQUIT, CSINIS, MIGCOMPT, CTYPRGLT*/)
SELECT CORG, CCOMPTE, DATEC, CJOURNAL, CTYPECRI, SENS, LIB, CBANQUE, TYPCPTA, LETTRAGE, REPLACE(MONTANT, ',','.') AS MONTANT, NOPIECE, REF, TRIG, TRAIT, CRUB, NOLOCAT, NOBAIL, REPLACE(MONTDOUT, ',','.') AS MONTDOUT, REGROUPLOC, CTIERS, CORGPAY, CSTE, CTYPTIERS, CTASS, NOCHEQUE, REFREJET, DREJET, INFO, MONTEXC, MONTCRE, GELE, ECHEANCE, MOTREJ, REMANGES, CMONNAIE, MTEURO, REPLACE(MTEDV, ',','.') AS MTEDV, REPLACE(MONTD1, ',','.') AS MONTD1, CMANDAT/*, PATYPTIERS, PATIERS, DVAL, MONTD2, MONTD3, MONTEDV, LETECH, EDITQUIT, CSINIS, MIGCOMPT, CTYPRGLT*/
FROM ESTIA_SOURCE..CPTGLOB
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG

--ECRAC: TABLE DE COMPTABILITE GENERALE
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('ECRAC', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_ECRAC
INSERT INTO ESTIA_ECRAC (ETECR, CORG, CJOURNAL, DATEC, DVAL, CCG, LIBELLE, SENS, MONTANT, CTYPECRI, NOPIECE, REF, TRAIT, TYPCPTA, REGROUPE, PERIODE, CNATANA, CSECTANA, BANAL, MODIF, EDITJOUR, EXTRAC, CCGERR, CCPARTIE, CAGENCE, GRTRESOR, ORD, CBORDERO, GRORD, REGROUPCUM, UTIL, REGROUPLOC, ANALYT, NODOC, INFO, INTERFACE, CMODREG, TRIG, REGROUP2, ARCHIVE, FOLIO, LIGNE, DPEC, BAN2, ECCG, MTLET, CMANDAT, ECRAC_ID, MIGCOMPT)
SELECT ETECR, CORG, CJOURNAL, 
convert(datetime, SUBSTRING(DATEC, 7, 2) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2), 103) AS DATEC, 
CASE WHEN LEN(DVAL) = 8 AND ISDATE(SUBSTRING(DVAL, 7, 2) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DVAL, 7, 2) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2), 103)
	 WHEN LEN(DVAL) = 10 AND ISDATE(substring(DVAL, 7, 4) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2)) = 1 THEN convert(datetime, substring(DVAL, 7, 4) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2), 103) END AS DVAL, 
CCG, LIBELLE, SENS, REPLACE(MONTANT, ',','.') AS MONTANT, CTYPECRI, NOPIECE, REF, TRAIT, TYPCPTA, REGROUPE, PERIODE, CNATANA, CSECTANA, BANAL, MODIF, EDITJOUR, EXTRAC, CCGERR, CCPARTIE, CAGENCE, GRTRESOR, ORD, CBORDERO, GRORD, REGROUPCUM, UTIL, REGROUPLOC, ANALYT, NODOC, INFO, INTERFACE, CMODREG, TRIG, REGROUP2, ARCHIVE, FOLIO, LIGNE, DPEC, BAN2, ECCG, REPLACE(MTLET, ',','.') AS MTLET, CMANDAT, ECRAC_ID, MIGCOMPT
FROM ESTIA_SOURCE..ECRAC
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG


--ECRAC_PROP : TABLE DES ECRITURES MIROIR VALIDEES PROPRIETAIRE
--INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('ECRAC_PROP', 'N', GETDATE())
--SET @ID_LOG = @@IDENTITY
--TRUNCATE TABLE ESTIA_ECRAC_PROP
--INSERT INTO ESTIA_ECRAC_PROP (ETECR, CORG, CJOURNAL, DATEC, DVAL, CCG, LIBELLE, SENS, MONTANT, CTYPECRI, NOPIECE, REF, TRAIT, TYPCPTA, REGROUPE, PERIODE, CNATANA, CSECTANA, BANAL, MODIF, EDITJOUR, EXTRAC, CCGERR, CCPARTIE, CAGENCE, GRTRESOR, ORD, CBORDERO, GRORD, REGROUPCUM, UTIL, REGROUPLOC, ANALYT, NODOC, INFO, INTERFACE, CMODREG, TRIG, REGROUP2, ARCHIVE, FOLIO, LIGNE, DPEC, BAN2, ECCG, MTLET, CMANDAT, ECRAC_ID, MIGCOMPT)
--SELECT ETECR, CORG, CJOURNAL, DATEC, DVAL, CCG, LIBELLE, SENS, MONTANT, CTYPECRI, NOPIECE, REF, TRAIT, TYPCPTA, REGROUPE, PERIODE, CNATANA, CSECTANA, BANAL, MODIF, EDITJOUR, EXTRAC, CCGERR, CCPARTIE, CAGENCE, GRTRESOR, ORD, CBORDERO, GRORD, REGROUPCUM, UTIL, REGROUPLOC, ANALYT, NODOC, INFO, INTERFACE, CMODREG, TRIG, REGROUP2, ARCHIVE, FOLIO, LIGNE, DPEC, BAN2, ECCG, MTLET, CMANDAT, ECRAC_ID, MIGCOMPT
--FROM OPENQUERY(ESTIA, 'SELECT ETECR, CORG, CJOURNAL, DATEC, DVAL, CCG, LIBELLE, SENS, MONTANT, CTYPECRI, NOPIECE, REF, TRAIT, TYPCPTA, REGROUPE, PERIODE, CNATANA, CSECTANA, BANAL, MODIF, EDITJOUR, EXTRAC, CCGERR, CCPARTIE, CAGENCE, GRTRESOR, ORD, CBORDERO, GRORD, REGROUPCUM, UTIL, REGROUPLOC, ANALYT, NODOC, INFO, INTERFACE, CMODREG, TRIG, REGROUP2, ARCHIVE, FOLIO, LIGNE, DPEC, BAN2, ECCG, MTLET, CMANDAT, ECRAC_ID, MIGCOMPT FROM PUB.ECRAC WHERE DATEC >= ''2012-07-01'' AND CORG <> ''PG'' AND REGROUPLOC like ''V%'' AND ETECR = ''C''')
--SET @NB = @@ROWCOUNT
--UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG


--ECRITANA: TABLE DE ECRITURES ANALYTIQUES
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('ECRITANA', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_ECRITANA
INSERT INTO ESTIA_ECRITANA (CORG , CJOURNAL , TYPPOS , CCB , NOPIECE , REF , DATEC , DVAL , PERIODE , LIBELLE , CCG , ETECR , MONTANT , SENS , CTYPECRI , CNATANA , CSECTANA , UTIL , ORD , INFO , CSTE , CEXO , CSECTREG , TRIG , CACCESS , NODOC , MTTC , MTHT)
SELECT CORG , CJOURNAL , TYPPOS , CCB , NOPIECE , REF , DATEC , DVAL , PERIODE , LIBELLE , CCG , ETECR , REPLACE(MONTANT, ',','.') AS MONTANT , SENS , CTYPECRI , CNATANA , CSECTANA , UTIL , ORD , INFO , CSTE , CEXO , CSECTREG , TRIG , CACCESS , NODOC , REPLACE(MTTC, ',','.') AS MTTC , REPLACE(MTHT, ',','.') AS MTHT
FROM ESTIA_SOURCE..ECRITANA
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG


--ECRITAUX: TABLE DES ECRITURES AUXILIAIRES
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('ECRITAUX', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_ECRITAUX
INSERT INTO ESTIA_ECRITAUX (CORG, CTYPTIERS, TRIG, CJOURNAL, FOLIO, LIGNE, NOPIECE, REF, DATEC, DVAL, PERIODE, LIBELLE, MONTANT, SENS, CTYPECRI, CTIERS, LETTRAGE, TYPCPTA, DATECH, TRAITE, QTE, CDEVISE, MTDEVISE, FTIERS, CHRONO, COMPTA, BLET, DATRAP, RELEVE, CMODREG, CCATEG, CTYPCOM, COPE, REFTIERS, NOFACT, REFFAC, VALIDE, LETRORI, UTIL, EXTRAIT, TRAIT, CDEPR, NORD, DBOR, CTRANCHE, MOTBLOC, CMANDAT)
SELECT CORG, CTYPTIERS, TRIG, CJOURNAL, FOLIO, LIGNE, NOPIECE, REF, 
CASE WHEN LEN(DATEC) = 8 AND ISDATE(SUBSTRING(DATEC, 7, 2) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATEC, 7, 2) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2), 103)
	 WHEN LEN(DATEC) = 10 AND ISDATE(substring(DATEC, 7, 4) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2)) = 1 THEN convert(datetime, substring(DATEC, 7, 4) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2), 103) END AS DATEC, 
CASE WHEN LEN(DVAL) = 8 AND ISDATE(SUBSTRING(DVAL, 7, 2) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DVAL, 7, 2) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2), 103)
	 WHEN LEN(DVAL) = 10 AND ISDATE(substring(DVAL, 7, 4) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2)) = 1 THEN convert(datetime, substring(DVAL, 7, 4) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2), 103) END AS DVAL, 
PERIODE, LIBELLE, REPLACE(MONTANT, ',','.') AS MONTANT, SENS, CTYPECRI, CTIERS, LETTRAGE, TYPCPTA, 
CASE WHEN LEN(DATECH) = 8 AND ISDATE(SUBSTRING(DATECH, 7, 2) + substring(DATECH, 4, 2) + substring(DATECH, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATECH, 7, 2) + substring(DATECH, 4, 2) + substring(DATECH, 1, 2), 103)
	 WHEN LEN(DATECH) = 10 AND ISDATE(substring(DATECH, 7, 4) + substring(DATECH, 4, 2) + substring(DATECH, 1, 2)) = 1 THEN convert(datetime, substring(DATECH, 7, 4) + substring(DATECH, 4, 2) + substring(DATECH, 1, 2), 103) END AS DATECH, 
TRAITE, QTE, CDEVISE, REPLACE(MTDEVISE, ',','.') AS MTDEVISE, FTIERS, CHRONO, COMPTA, BLET, 
CASE WHEN LEN(DATRAP) = 8 AND ISDATE(SUBSTRING(DATRAP, 7, 2) + substring(DATRAP, 4, 2) + substring(DATRAP, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATRAP, 7, 2) + substring(DATRAP, 4, 2) + substring(DATRAP, 1, 2), 103)
	 WHEN LEN(DATRAP) = 10 AND ISDATE(substring(DATRAP, 7, 4) + substring(DATRAP, 4, 2) + substring(DATRAP, 1, 2)) = 1 THEN convert(datetime, substring(DATRAP, 7, 4) + substring(DATRAP, 4, 2) + substring(DATRAP, 1, 2), 103) END AS DATRAP, 
RELEVE, CMODREG, CCATEG, CTYPCOM, COPE, REFTIERS, NOFACT, REFFAC, VALIDE, LETRORI, UTIL, EXTRAIT, TRAIT, CDEPR, NORD, 
CASE WHEN LEN(DBOR) = 8 AND ISDATE(SUBSTRING(DBOR, 7, 2) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DBOR, 7, 2) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2), 103)
	 WHEN LEN(DBOR) = 10 AND ISDATE(substring(DBOR, 7, 4) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2)) = 1 THEN convert(datetime, substring(DBOR, 7, 4) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2), 103) END AS DBOR, 
CTRANCHE, MOTBLOC, CMANDAT
FROM ESTIA_SOURCE..ECRITAUX
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG



--ENTFAC: TABLE DES ENTETES DE FACTURES
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('ENTFAC', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_ENTFAC
INSERT INTO ESTIA_ENTFAC (CORG, CTIERS, CTYPTIERS, CJOURNAL, NUMCPTE, LTIERS, RUE, CPOS, CCOMM, BDIS, REF, CNOMENC, MTHT, MTTVA, DCOURRIER, REFFOUR, CEMPLOY, /*LCOM,*/ TYPMDT, CCONTFRS, LIB, DREGUL, CVENTPCHAR, CODFAC, CBANQUE, CGUICHET, CCATEG, VALIDE, NODOC, TYPFACT, DRETOUR, SAISCRIT, PREMAND, TRI, MTTTC, NOPIECE, DATEC, UTIL, LIEUDIT, TRIG, DATENREG, CNATPRES, CRUB, DIMPCONT, DATFAC, DEVHT, DEVTVA, DEVTTC, CDEVISE, BASCULASM, COPE, CTRANCHE, CDEPR, NORD, CPHASE, CMODREG, AUTO, RECUP, DECH, DBOR, LIBPAI, TRAIT, FACAVO, DERFAC, DRETSOU, MTBLOQ, PARV, NOPRE, REFSCAN, FVALIDE, DETAT, REFGED, ARCHIVE, CMANDAT, MODTVA, ADRCOMP, CCOMPTE, CLOCAL, DATAG, TYPEAG, MTLIAV, REFHONO, MIGCOMPT, CODNAT, CLEIBAN, COORDBANQ_ID)
SELECT CORG, CTIERS, CTYPTIERS, CJOURNAL, NUMCPTE, LTIERS, RUE, CPOS, CCOMM, BDIS, REF, CNOMENC1, REPLACE(MTHT, ',','.') AS MTHT, REPLACE(MTTVA, ',','.') AS MTTVA, 
CASE WHEN LEN(DCOURRIER) = 8 AND ISDATE(SUBSTRING(DCOURRIER, 7, 2) + substring(DCOURRIER, 4, 2) + substring(DCOURRIER, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DCOURRIER, 7, 2) + substring(DCOURRIER, 4, 2) + substring(DCOURRIER, 1, 2), 103)
	 WHEN LEN(DCOURRIER) = 10 AND ISDATE(substring(DCOURRIER, 7, 4) + substring(DCOURRIER, 4, 2) + substring(DCOURRIER, 1, 2)) = 1 THEN convert(datetime, substring(DCOURRIER, 7, 4) + substring(DCOURRIER, 4, 2) + substring(DCOURRIER, 1, 2), 103) END AS DCOURRIER, REFFOUR, CEMPLOY, /*LCOM,*/ TYPMDT, CCONTFRS, LIB, 
CASE WHEN LEN(DREGUL) = 8 AND ISDATE(SUBSTRING(DREGUL, 7, 2) + substring(DREGUL, 4, 2) + substring(DREGUL, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DREGUL, 7, 2) + substring(DREGUL, 4, 2) + substring(DREGUL, 1, 2), 103)
	 WHEN LEN(DREGUL) = 10 AND ISDATE(substring(DREGUL, 7, 4) + substring(DREGUL, 4, 2) + substring(DREGUL, 1, 2)) = 1 THEN convert(datetime, substring(DREGUL, 7, 4) + substring(DREGUL, 4, 2) + substring(DREGUL, 1, 2), 103) END AS DREGUL, CVENTPCHAR, CODFAC, CBANQUE, CGUICHET, CCATEG, VALIDE, NODOC, TYPFACT, 
CASE WHEN LEN(DRETOUR) = 8 AND ISDATE(SUBSTRING(DRETOUR, 7, 2) + substring(DRETOUR, 4, 2) + substring(DRETOUR, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DRETOUR, 7, 2) + substring(DRETOUR, 4, 2) + substring(DRETOUR, 1, 2), 103)
	 WHEN LEN(DRETOUR) = 10 AND ISDATE(substring(DRETOUR, 7, 4) + substring(DRETOUR, 4, 2) + substring(DRETOUR, 1, 2)) = 1 THEN convert(datetime, substring(DRETOUR, 7, 4) + substring(DRETOUR, 4, 2) + substring(DRETOUR, 1, 2), 103) END AS DRETOUR, SAISCRIT, PREMAND, TRI, REPLACE(MTTTC, ',','.') AS MTTTC, NOPIECE, 
CASE WHEN LEN(DATEC) = 8 AND ISDATE(SUBSTRING(DATEC, 7, 2) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATEC, 7, 2) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2), 103)
	 WHEN LEN(DATEC) = 10 AND ISDATE(substring(DATEC, 7, 4) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2)) = 1 THEN convert(datetime, substring(DATEC, 7, 4) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2), 103) END AS DATEC, UTIL, LIEUDIT, TRIG, 
CASE WHEN LEN(DATENREG) = 8 AND ISDATE(SUBSTRING(DATENREG, 7, 2) + substring(DATENREG, 4, 2) + substring(DATENREG, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATENREG, 7, 2) + substring(DATENREG, 4, 2) + substring(DATENREG, 1, 2), 103)
	 WHEN LEN(DATENREG) = 10 AND ISDATE(substring(DATENREG, 7, 4) + substring(DATENREG, 4, 2) + substring(DATENREG, 1, 2)) = 1 THEN convert(datetime, substring(DATENREG, 7, 4) + substring(DATENREG, 4, 2) + substring(DATENREG, 1, 2), 103) END AS DATENREG, CNATPRES, CRUB, DIMPCONT, 
CASE WHEN LEN(DATFAC) = 8 AND ISDATE(SUBSTRING(DATFAC, 7, 2) + substring(DATFAC, 4, 2) + substring(DATFAC, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATFAC, 7, 2) + substring(DATFAC, 4, 2) + substring(DATFAC, 1, 2), 103)
	 WHEN LEN(DATFAC) = 10 AND ISDATE(substring(DATFAC, 7, 4) + substring(DATFAC, 4, 2) + substring(DATFAC, 1, 2)) = 1 THEN convert(datetime, substring(DATFAC, 7, 4) + substring(DATFAC, 4, 2) + substring(DATFAC, 1, 2), 103) END AS DATFAC, REPLACE(DEVHT, ',','.') AS DEVHT, REPLACE(DEVTVA, ',','.') AS DEVTVA, REPLACE(DEVTTC, ',','.') AS DEVTTC, CDEVISE, BASCULASM, COPE, CTRANCHE, CDEPR, NORD, CPHASE, CMODREG, AUTO, RECUP, 
CASE WHEN LEN(DECH) = 8 AND ISDATE(SUBSTRING(DECH, 7, 2) + substring(DECH, 4, 2) + substring(DECH, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DECH, 7, 2) + substring(DECH, 4, 2) + substring(DECH, 1, 2), 103)
	 WHEN LEN(DECH) = 10 AND ISDATE(substring(DECH, 7, 4) + substring(DECH, 4, 2) + substring(DECH, 1, 2)) = 1 THEN convert(datetime, substring(DECH, 7, 4) + substring(DECH, 4, 2) + substring(DECH, 1, 2), 103) END AS DECH, 
CASE WHEN LEN(DBOR) = 8 AND ISDATE(SUBSTRING(DBOR, 7, 2) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DBOR, 7, 2) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2), 103)
	 WHEN LEN(DBOR) = 10 AND ISDATE(substring(DBOR, 7, 4) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2)) = 1 THEN convert(datetime, substring(DBOR, 7, 4) + substring(DBOR, 4, 2) + substring(DBOR, 1, 2), 103) END AS DBOR, LIBPAI, TRAIT, FACAVO, DERFAC, 
CASE WHEN LEN(DRETSOU) = 8 AND ISDATE(SUBSTRING(DRETSOU, 7, 2) + substring(DRETSOU, 4, 2) + substring(DRETSOU, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DRETSOU, 7, 2) + substring(DRETSOU, 4, 2) + substring(DRETSOU, 1, 2), 103)
	 WHEN LEN(DRETSOU) = 10 AND ISDATE(substring(DRETSOU, 7, 4) + substring(DRETSOU, 4, 2) + substring(DRETSOU, 1, 2)) = 1 THEN convert(datetime, substring(DRETSOU, 7, 4) + substring(DRETSOU, 4, 2) + substring(DRETSOU, 1, 2), 103) END AS DRETSOU, REPLACE(MTBLOQ, ',','.') AS MTBLOQ, PARV, NOPRE, REFSCAN, FVALIDE, 
CASE WHEN LEN(DETAT) = 8 AND ISDATE(SUBSTRING(DETAT, 7, 2) + substring(DETAT, 4, 2) + substring(DETAT, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DETAT, 7, 2) + substring(DETAT, 4, 2) + substring(DETAT, 1, 2), 103)
	 WHEN LEN(DETAT) = 10 AND ISDATE(substring(DETAT, 7, 4) + substring(DETAT, 4, 2) + substring(DETAT, 1, 2)) = 1 THEN convert(datetime, substring(DETAT, 7, 4) + substring(DETAT, 4, 2) + substring(DETAT, 1, 2), 103) END AS DETAT, REFGED, ARCHIVE, CMANDAT, MODTVA, ADRCOMP, CCOMPTE, CLOCAL, 
CASE WHEN LEN(DATAG) = 8 AND ISDATE(SUBSTRING(DATAG, 7, 2) + substring(DATAG, 4, 2) + substring(DATAG, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DATAG, 7, 2) + substring(DATAG, 4, 2) + substring(DATAG, 1, 2), 103)
	 WHEN LEN(DATAG) = 10 AND ISDATE(substring(DATAG, 7, 4) + substring(DATAG, 4, 2) + substring(DATAG, 1, 2)) = 1 THEN convert(datetime, substring(DATAG, 7, 4) + substring(DATAG, 4, 2) + substring(DATAG, 1, 2), 103) END AS DATAG, 
TYPEAG, REPLACE(MTLIAV, ',','.') AS MTLIAV, REFHONO, MIGCOMPT, CODNAT, CLEIBAN, COORDBANQ_ID
FROM ESTIA_SOURCE..ENTFAC
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG




--HDEPCS: TABLE DES ECRITURES DE DEPENSES
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('HDEPCS', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_HDEPCS
INSERT INTO ESTIA_HDEPCS (CORG, CAGENCE, CGROUPE, CCRITDP, CSCRITDP, DEFFETREG, REF, MTHT, MTTVA, TEXTDEP, MTRECUP, MTTC, TYPDEP, TRIG, MTBASE, MTNREC, MTTVADED, CTVA, PRORATA, CSECTANA, CSECTREG, LIBELLE, CCATEG, DEVHT, DEVTVA, DEVRECUP, DEVTTC, DEVBASE, DEVNREC, DEVTVADED, TEXTCOP, DATEC, NUMINV, RECUPTX, CNOMENM, TVACOMPTA, PROVHT, NORD, HTRECUP, TTCRECUP, TVARECUP, ANAENC, MTTVADEDREC, EXTRAC, CMANDAT, CPRESTA, QTE, CEDIRGT, CENSEMBLE, RENOUV, ADF, TEXTPRO)
SELECT CORG, CAGENCE, CGROUPE, CCRITDP, CSCRITDP, 
CASE WHEN LEN(DEFFETREG) = 8 AND ISDATE(SUBSTRING(DEFFETREG, 7, 2) + substring(DEFFETREG, 4, 2) + substring(DEFFETREG, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DEFFETREG, 7, 2) + substring(DEFFETREG, 4, 2) + substring(DEFFETREG, 1, 2), 103)
	 WHEN LEN(DEFFETREG) = 10 AND ISDATE(substring(DEFFETREG, 7, 4) + substring(DEFFETREG, 4, 2) + substring(DEFFETREG, 1, 2)) = 1 THEN convert(datetime, substring(DEFFETREG, 7, 4) + substring(DEFFETREG, 4, 2) + substring(DEFFETREG, 1, 2), 103) END AS DEFFETREG, 
REF, REPLACE(MTHT, ',','.') AS MTHT, REPLACE(MTTVA, ',','.') AS MTTVA, TEXTDEP, REPLACE(MTRECUP, ',','.') AS MTRECUP, REPLACE(MTTC, ',','.') AS MTTC, TYPDEP, TRIG, REPLACE(MTBASE, ',','.') AS MTBASE, REPLACE(MTNREC, ',','.') AS MTNREC, REPLACE(MTTVADED, ',','.') AS MTTVADED, CTVA, REPLACE(PRORATA, ',','.') AS PRORATA, CSECTANA, CSECTREG, LIBELLE, CCATEG, REPLACE(DEVHT, ',','.') AS DEVHT, REPLACE(DEVTVA, ',','.') AS DEVTVA, REPLACE(DEVRECUP, ',','.') AS DEVRECUP, REPLACE(DEVTTC, ',','.') AS DEVTTC, REPLACE(DEVBASE, ',','.') AS DEVBASE, REPLACE(DEVNREC, ',','.') AS DEVNREC, REPLACE(DEVTVADED, ',','.') AS DEVTVADED, TEXTCOP, 
convert(datetime, SUBSTRING(DATEC, 7, 2) + substring(DATEC, 4, 2) + substring(DATEC, 1, 2), 103) DATEC, 
NUMINV, REPLACE(RECUPTX, ',','.') AS RECUPTX, CNOMENM, TVACOMPTA, PROVHT, NORD, REPLACE(HTRECUP, ',','.') AS HTRECUP, REPLACE(TTCRECUP, ',','.') AS TTCRECUP, REPLACE(TVARECUP, ',','.') AS TVARECUP, ANAENC, REPLACE(MTTVADEDREC, ',','.') AS MTTVADEDREC, EXTRAC, CMANDAT, CPRESTA, REPLACE(QTE, ',','.') AS QTE, CEDIRGT, CENSEMBLE, RENOUV, ADF, TEXTPRO
FROM ESTIA_SOURCE..HDEPCS
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG


--JOURNAL: TABLE DE REFERENCE DES JOURNAUX
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('JOURNAL', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_JOURNAL
INSERT INTO ESTIA_JOURNAL (CJOURNAL, LJOURNAL, TASS, TYPJOU, JOUAUX, JOUCAIS, TYPBORD, LISTORG, TRIG, CTYPBOR, BUDGET, AUTORISE, SAUTORISE, CAUTORISE, TEMEDIT, LACTIF)
SELECT CJOURNAL, LJOURNAL, TASS, TYPJOU, JOUAUX, JOUCAIS, TYPBORD, LISTORG, TRIG, CTYPBOR, BUDGET, AUTORISE, SAUTORISE, CAUTORISE, TEMEDIT, LACTIF
FROM ESTIA_SOURCE..JOURNAL
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE() WHERE ID_LOG = @ID_LOG



--PECRIP: TABLE ??????
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('PECRIP', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_PECRIP
INSERT INTO ESTIA_PECRIP (CORG, COPE, CCG, DECR, DVAL, CTYPECRI, LIB, MONTANT, SENS, NOPIECE, CJOURNAL, TRAIT, REF, TYPCPTA, CBANQUE, LOTDEP, CFOUR, NORD, TYPTRV, CTYPOP, CPTAB, CTYPCOM, ORD, GRORD, NODOC, CLOT, CMODREG, NOAVTS, DECH, DFACT, TRIGD, UTIL, CTRANCHE, CDEPR, CPOSTE, MTHT, MTTTC, TYPE, MTCONVERT, DEVISE, NOMTIREUR, CAGENCE, CCOMPTE, CPHASE, TTVA, TEMIGRA, PCELASM, REFINIT, P1LASM, P2LASM, S1TTVA, S2TTVA, REFITVA, MTVALASM, CSECTANA, CSECTREG, HTD, BANAL, REFDUPLI, MIGCOMPT)
SELECT CORG, COPE, CCG, 
convert(datetime, SUBSTRING(DECR, 7, 2) + substring(DECR, 4, 2) + substring(DECR, 1, 2), 103) DECR, 
convert(datetime, SUBSTRING(DVAL, 7, 2) + substring(DVAL, 4, 2) + substring(DVAL, 1, 2), 103) DVAL, 
CTYPECRI, LIB, REPLACE(MONTANT, ',','.') AS MONTANT, SENS, NOPIECE, CJOURNAL, TRAIT, REF, TYPCPTA, CBANQUE, LOTDEP, CFOUR, NORD, TYPTRV, CTYPOP, CPTAB, CTYPCOM, ORD, GRORD, NODOC, CLOT, CMODREG, NOAVTS, 
CASE WHEN LEN(DECH) = 8 AND ISDATE(SUBSTRING(DECH, 7, 2) + substring(DECH, 4, 2) + substring(DECH, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DECH, 7, 2) + substring(DECH, 4, 2) + substring(DECH, 1, 2), 103)
	 WHEN LEN(DECH) = 10 AND ISDATE(substring(DECH, 7, 4) + substring(DECH, 4, 2) + substring(DECH, 1, 2)) = 1 THEN convert(datetime, substring(DECH, 7, 4) + substring(DECH, 4, 2) + substring(DECH, 1, 2), 103) END AS DECH, 
CASE WHEN LEN(DFACT) = 8 AND ISDATE(SUBSTRING(DFACT, 7, 2) + substring(DFACT, 4, 2) + substring(DFACT, 1, 2)) = 1 THEN convert(datetime, SUBSTRING(DFACT, 7, 2) + substring(DFACT, 4, 2) + substring(DFACT, 1, 2), 103)
	 WHEN LEN(DFACT) = 10 AND ISDATE(substring(DFACT, 7, 4) + substring(DFACT, 4, 2) + substring(DFACT, 1, 2)) = 1 THEN convert(datetime, substring(DFACT, 7, 4) + substring(DFACT, 4, 2) + substring(DFACT, 1, 2), 103) END AS DFACT, 
TRIGD, UTIL, CTRANCHE, CDEPR, CPOSTE, REPLACE(MTHT, ',','.') AS MTHT, REPLACE(MTTTC, ',','.') AS MTTTC, TYPE, REPLACE(MTCONVERT, ',','.') AS MTCONVERT, DEVISE, NOMTIREUR, CAGENCE, CCOMPTE, CPHASE, REPLACE(TTVA, ',','.') AS TTVA, TEMIGRA, PCELASM, REFINIT, REPLACE(P1LASM, ',','.') AS P1LASM, REPLACE(P2LASM, ',','.') AS P2LASM, REPLACE(S1TTVA, ',','.') AS S1TTVA, REPLACE(S2TTVA, ',','.') AS S2TTVA, REFITVA, REPLACE(MTVALASM, ',','.') AS MTVALASM, CSECTANA, CSECTREG, REPLACE(HTD, ',','.') AS HTD, BANAL, REFDUPLI, MIGCOMPT
FROM ESTIA_SOURCE..PECRIP
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE() WHERE ID_LOG = @ID_LOG




--PLANC: TABLE DU PLAN COMPTABLE
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('PLANC', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_PLANC
INSERT INTO ESTIA_PLANC (CORG, CCG, INTIT, INTITR, DOUV, DBLOC, DMAJ, TIERS, ANAL, CNATANA, COMPCENT, COMPCLO, SOLDOK, SENSINT, TYPCPTA, TRESOR, REGROUPE, CTRCIL, CHPC, BCG, CMONEY, CRESI, CAGECO, CRESO, SCB, VCB, VISORD, ANOUVO, CBANQUE, GUICHET, COMPTE, NBJOUR, TEMRB, SOLDBANQ, CG68, CG28, CMETIMMO, CPTIMMO, ENGA, CCATEG, RECUP, CPTVA, CDOMSOC, TRIGD, FISC, CNATHON, SAISINT, TRIG, VISREC, CNTVA, GSECT, NATMOD, NATBIEN, CG675, AUTORISE, SAUTORISE, CAUTORISE, TEMOIN, CPBUDD, CCOLBUD, CPANA, LISTORG, ASSMDT, COMPAMOFI, MIGCOMPT)
SELECT CORG, CCG, INTIT, INTITR, DOUV, DBLOC, DMAJ, TIERS, ANAL, CNATANA, COMPCENT, COMPCLO, SOLDOK, SENSINT, TYPCPTA, TRESOR, REGROUPE, CTRCIL, CHPC, BCG, CMONEY, CRESI, CAGECO, CRESO, SCB, VCB, VISORD, ANOUVO, CBANQUE, GUICHET, COMPTE, NBJOUR, TEMRB, SOLDBANQ, CG68, CG28, CMETIMMO, CPTIMMO, ENGA, CCATEG, RECUP, CPTVA, CDOMSOC, TRIGD, FISC, CNATHON, SAISINT, TRIG, VISREC, CNTVA, GSECT, NATMOD, NATBIEN, CG675, AUTORISE, SAUTORISE, CAUTORISE, TEMOIN, CPBUDD, CCOLBUD, CPANA, LISTORG, ASSMDT, COMPAMOFI, MIGCOMPT
FROM ESTIA_SOURCE..PLANC
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE() WHERE ID_LOG = @ID_LOG



--TSECR: TABLE DES ECRITURES AUXILIAIRES PROPRIETAIRE
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('TSECR', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_TSECR
INSERT INTO ESTIA_TSECR (CORG, CTYPTIERS, CJOURNAL, NODOC, MTLET, NOPIECE, REF, DATEC, DVAL, PERIODE, LIBELLE, MONTANT, SENS, CTYPECRI, CTIERS, PIEC2, DATECH, TRAIT, TRIG, DATRAP, CMODREG, CTSCAT, ACOMPTE, VALIDE, ORD, NODOM, LETTRAGE, UTIL, INFO, CMANDAT)
SELECT CORG, CTYPTIERS, CJOURNAL, NODOC, REPLACE(MTLET, ',','.') AS MTLET, NOPIECE, REF, DATEC, DVAL, PERIODE, LIBELLE, REPLACE(MONTANT, ',','.') AS MONTANT, SENS, CTYPECRI, CTIERS, PIEC2, DATECH, TRAIT, TRIG, DATRAP, CMODREG, CTSCAT, ACOMPTE, VALIDE, ORD, NODOM, LETTRAGE, UTIL, INFO, CMANDAT
FROM ESTIA_SOURCE..TSECR
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE() WHERE ID_LOG = @ID_LOG



--TYPECRI: TABLE DE REFERENCE DES TYPES D'ECRITURE
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('TYPECRI', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_TYPECRI
INSERT INTO ESTIA_TYPECRI (CTYPECRI, LTYPECRI, TRIG, RTYPECRI, TASS, DCN, RVA, PRL, PIN, DEA, FAC, RPRL, RAUP, LACTIF)
SELECT CTYPECRI, LTYPECRI, TRIG, RTYPECRI, TASS, DCN, RVA, PRL, PIN, DEA, FAC, RPRL, RAUP, LACTIF
FROM ESTIA_SOURCE..TYPECRI
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE() WHERE ID_LOG = @ID_LOG


--ECRIB: TABLE DES ECRITURES BUDGETAIRES
INSERT INTO L_REPURERATION_ESTIA (NOM_TABLE, IND_SUCCES, DT_DEBUT) VALUES ('ECRIB', 'N', GETDATE())
SET @ID_LOG = @@IDENTITY
TRUNCATE TABLE ESTIA_ECRIB
INSERT INTO ESTIA_ECRIB (CSTE, CORG, CEXO, TYPPOS, CCB, MONTANT, SENS, TYPBON, NOBON, CTRAIT, LIBELLE, CJOURNAL, DATEC, PERIODE, REF, ORD, CCG, CCRITDP, TRIG, NOPIECE, REFMAN, TYPLIG, RECUP, REGMAN, UTIL, INFO, ANALYT, CTYPCOM, BANAL, REFART, QTE, PUHT, PRORATA, CTVA, CAGENCE, CGROUPE, MTTC, MTHT, NODOC, PUHTDEV, CNOMENM, CSCRITDP, PROVHT)
SELECT CSTE, CORG, CEXO, TYPPOS, CCB, REPLACE(MONTANT, ',','.') , SENS, TYPBON, NOBON, CTRAIT, LIBELLE, CJOURNAL, DATEC, PERIODE, REF, ORD, CCG, CCRITDP, TRIG, NOPIECE, REFMAN, TYPLIG, RECUP, REGMAN, UTIL, INFO, ANALYT, CTYPCOM, BANAL, REFART, QTE, PUHT, REPLACE(PRORATA, ',','.') AS PRORATA, CTVA, CAGENCE, CGROUPE, REPLACE(MTTC, ',','.') AS MTTC, REPLACE(MTHT, ',','.') AS MTHT, NODOC, REPLACE(PUHTDEV, ',','.') AS PUHTDEV, CNOMENM, CSCRITDP, PROVHT
FROM ESTIA_SOURCE..ECRIB
WHERE REF IS nOT NULL
SET @NB = @@ROWCOUNT
UPDATE L_REPURERATION_ESTIA SET IND_SUCCES = 'O', DT_FIN = GETDATE(), NB_LIGNES = @NB WHERE ID_LOG = @ID_LOG

END