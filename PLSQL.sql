--------------------------------------------------------
--  Fichier créé - samedi-avril-12-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ADDUSER
--------------------------------------------------------
set define off;
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un client
------------------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE OR REPLACE PROCEDURE "ECOMMERCE"."ADDUSER" (p_CliNom CLIENT.CLI_NOM%TYPE,p_CliPrenom CLIENT.CLI_PRENOM%TYPE,p_Cli_MAIL CLIENT.CLI_MAIL%TYPE,p_CliPwd CLIENT.CLI_MOTDEPASSE%TYPE ) AS
BEGIN
INSERT INTO CLIENT(CLI_ID,CLI_NOM,CLI_PRENOM,CLI_MAIL,CLI_MOTDEPASSE)
VALUES(SEQ_CLIENT.NEXTVAL,p_CliNom,p_CliPrenom,p_Cli_MAIL,p_CliPwd);
END;
/


------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'une CB à un client
------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE AddCB(p_IDUSER CLIENT.CLI_ID%TYPE, p_CBNUM CB.CB_NUMERO%TYPE, p_CBSECU CB.CB_SECU%TYPE, p_CBDATEEXP IN NVARCHAR2)
AS
    CURSOR cCBExiste IS SELECT CB_NUMERO FROM CB WHERE CB_NUMERO = p_CBNUM;
    NumCB CB.CB_NUMERO%TYPE :=0;
    CBAlreadySet EXCEPTION;
    WrongCBNumber EXCEPTION;
BEGIN

--Vérification de l'unicité de la CB--
    OPEN cCBExiste;
    LOOP
     FETCH cCBExiste INTO NumCB;
     EXIT WHEN cCBExiste%NOTFOUND;
    END LOOP;
    CLOSE cCBExiste;
 
    IF NumCB <> 0 THEN
      RAISE CBAlreadySet;
    ELSE
        --Vérification de la longueur du numéro--
      IF (length(p_CBNUM)=16) THEN
          INSERT INTO CB(CB_ID,CLIENT_CLI_ID,CB_NUMERO,CB_SECU,CB_DATE)
          VALUES(SEQ_CB.NEXTVAL,p_IDUSER,p_CBNUM,p_CBSECU,p_CBDATEEXP);
      ELSE
          RAISE WrongCBNumber;
      END IF;
  
    END IF;
 
  --Exceptions--
  EXCEPTION
    WHEN CBAlreadySet THEN
      DBMS_OUTPUT.PUT_LINE('La carte existe déjà.');
    WHEN WrongCBNumber THEN
      DBMS_OUTPUT.PUT_LINE('Le numéro de la carte est incorrect. Veuillez vérifier la valeur saisie.');
END;
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout des types d'adresses
------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE ADDTYPEADRESSE(p_LibTypeAdr TYPEADRESSE.ADRTYPE_LIBELLE%TYPE)
AS
BEGIN
  INSERT INTO TYPEADRESSE (ADRTYPE_ID,ADRTYPE_LIBELLE)
  VALUES(SEQ_TYPEADRESSE.NEXTVAL,p_LibTypeAdr);
END;


------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'une adresse
------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE AddAdresse(p_IDUSER CLIENT.CLI_ID%TYPE, p_AD1 ADRESSE.ADR_ADRESSE1%TYPE,p_AD2 ADRESSE.ADR_ADRESSE2%TYPE, p_CP ADRESSE.ADR_CP%TYPE, p_VILLE ADRESSE.ADR_VILLE%TYPE, p_TYPEADR IN VARCHAR2)
AS
  vIDTypeAdr ADRESSE.ADR_ID%TYPE := 0;
  CURSOR cTypeAdr IS SELECT ADRTYPE_ID INTO vIDTypeAdr FROM TYPEADRESSE WHERE ADRTYPE_LIBELLE = p_TYPEADR;
  TypeAdr_NOT_FOUND EXCEPTION;
  
BEGIN
  --Vérifiacation du type d'adresse renseigné--
  OPEN cTypeAdr;
  LOOP
    FETCH cTypeAdr INTO vIDTypeAdr;
    EXIT WHEN cTypeAdr%NOTFOUND;
  END LOOP;
  CLOSE cTypeAdr;
  IF vIDTypeAdr = 0 THEN 
    RAISE TypeAdr_NOT_FOUND;
  END IF;
  --Ajout de l'adresse--
  INSERT INTO ADRESSE(ADR_ID, CLIENT_CLI_ID, ADR_ADRESSE1, ADR_ADRESSE2, ADR_CP,ADR_VILLE,TYPEADRESSE_ADRTYPE_ID)
  VALUES(SEQ_ADRESSE.NEXTVAL,p_IDUSER,p_AD1,p_AD2,p_CP,p_VILLE,vIDTypeAdr);
  
  --EXCEPTIONS--
  EXCEPTION
    WHEN TypeAdr_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Le type de l adresse n existe pas. Veuillez vérifier la valeur saisie.');
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Authentification d'un utilisateur
------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE CONNEXION(p_MailUser CLIENT.CLI_MAIL%TYPE,p_Pwd CLIENT.CLI_MOTDEPASSE%TYPE)
AS
  vUserName CLIENT.CLI_NOM%TYPE := NULL;
  vUserFirstName CLIENT.CLI_PRENOM%TYPE := NULL;
  CURSOR cAuthentification IS SELECT CLI_NOM,CLI_PRENOM FROM CLIENT WHERE CLI_MOTDEPASSE=p_Pwd AND CLI_MAIL=p_MAILUSER;
  BAD_AUTH EXCEPTION;
BEGIN
--Tentative de connexion--
  OPEN cAuthentification;
  LOOP
  FETCH cAuthentification INTO vUserName,vUserFirstName;
  EXIT WHEN cAuthentification%NOTFOUND;
  END LOOP;
  CLOSE cAuthentification;
  
  IF vUserName IS NULL THEN
    RAISE BAD_AUTH;
  ELSIF vUserFirstName IS NULL THEN
    RAISE BAD_AUTH;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Bienvenue '|| vUserFirstName || ' '||vUserName);
  END IF;
  
--EXCEPTIONS--
EXCEPTION
  WHEN BAD_AUTH THEN 
    DBMS_OUTPUT.PUT_LINE('La combinaison du mail et du mot de passe renseignés est incorrecte.');
  
END;
------------------------------------------------------------------------------------------------------------------------------------------------------------
