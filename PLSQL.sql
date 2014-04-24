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
  CREATE OR REPLACE PROCEDURE ADDUSER (p_CliNom CLIENT.CLI_NOM%TYPE,p_CliPrenom CLIENT.CLI_PRENOM%TYPE,p_Cli_MAIL CLIENT.CLI_MAIL%TYPE,p_CliPwd CLIENT.CLI_MOTDEPASSE%TYPE ) AS
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
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout des types d'adresses
------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE ADDTYPEADRESSE(p_LibTypeAdr TYPEADRESSE.ADRTYPE_LIBELLE%TYPE)
AS
BEGIN
  INSERT INTO TYPEADRESSE (ADRTYPE_ID,ADRTYPE_LIBELLE)
  VALUES(SEQ_TYPEADRESSE.NEXTVAL,p_LibTypeAdr);
END;
/

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
/
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
/


------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un genre de livre
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouveauGenre(pGenre IN GENRE.genre_libelle%TYPE)
IS
BEGIN 
	INSERT INTO Genre(genre_id, genre_libelle)
	VALUES(seq_genre.nextval, pGenre);
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un style musical
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouveauStyle(pStyle IN StyleMusical.music_libelle%TYPE)
IS 
BEGIN
  INSERT INTO StyleMusical(music_id, music_libelle)
  VALUES(seq_style.nextval, pStyle);
END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un livre
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouveauLivre(pTVA IN TVA.tva_code%TYPE, pNom IN PRODUIT.prod_nom%TYPE, pDescription IN PRODUIT.prod_description%type, pNbPages IN LIVRE.liv_nbPages%TYPE, pEditeur IN EDITEUR.edit_id%TYPE, pAuteur IN LIVRE.liv_auteur%TYPE, pGenre IN GENRE.genre_libelle%TYPE)
IS 
prodId NUMBER;
BEGIN
  prodId := seq_produit.nextval;
  INSERT INTO PRODUIT(prod_id, TVA_tva_code, prod_nom, prod_description)
  VALUES(prodId, pTVA, pNom,  pDescription);

  INSERT INTO LIVRE(PRODUIT_prod_id, liv_nbPages, EDITEUR_edit_id, liv_auteur, Genre_genre_id)
  VALUES(prodId, pNbPages, pEditeur, pAuteur, pGenre);

END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un cd
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouveauCD(pTVA IN TVA.tva_code%TYPE, pNom IN PRODUIT.prod_nom%TYPE, pDescription IN PRODUIT.prod_description%TYPE, pStyle IN StyleMusical.music_id%TYPE, pArtiste IN CD.cd_artiste%TYPE)
IS
  prodId NUMBER;
BEGIN
  prodId := seq_produit.nextval;
  INSERT INTO PRODUIT(prod_id, TVA_tva_code, prod_nom, prod_description)
  VALUES(prodId, pTVA, pNom,  pDescription);

  INSERT INTO CD(PRODUIT_prod_id, StyleMusical_music_id, cd_artiste)
  VALUES(prodId, pStyle, pArtiste);
END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'une piste d'un cd
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouvellePiste(pIdCd IN PRODUIT.prod_id%TYPE, pTitre IN PISTE.pis_titre%TYPE, pDuree IN PISTE.pist_duree%TYPE)
IS 
BEGIN
  INSERT INTO PISTE(pist_id, CD_PRODUIT_prod_id, pis_titre, pist_duree)
  VALUES(seq_piste.nextval, pIdCd, pTitre, pDuree);
END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un vendeur
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouveauVendeur(pNom IN VENDEUR.vend_nom%TYPE)
IS 
BEGIN
  INSERT INTO VENDEUR(vend_id, vend_nom)
  VALUES(seq_vendeur.nextval, pNom);
END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Association Vendeur / Produit
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE vendeurVendProduit(pIdProduit IN PRODUIT.prod_id%TYPE, pIdVendeur IN VENDEUR.vend_id%TYPE, pPrix IN VEND.vend_prix%TYPE)
IS 
BEGIN
  INSERT INTO VEND(vend_id, PRODUIT_prod_id, VENDEUR_vend_id, vend_prix)
  VALUES(seq_vend.nextval, pIdProduit, pIdVendeur, pPrix);
END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'une TVA
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouvelleTVA(pTaux IN TVA.tva_taux%TYPE, pDateDebut IN NVARCHAR2, pDateFin IN NVARCHAR2 )
IS
  BEGIN
    INSERT INTO TVA(tva_code, tva_taux, tva_dateDebut, tva_dateFin)
    VALUES(seq_tva.nextval, pTaux, TO_TIMESTAMP(pDateDebut, 'DD/MM/YYYY'), TO_TIMESTAMP(pDateFin, 'DD/MM/YYYY'));
  END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un éditeur
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouveauEditeur(pNom IN EDITEUR.edit_nom%TYPE)
IS
BEGIN
  INSERT INTO EDITEUR(edit_id, edit_nom)
  VALUES(seq_editeur.nextval, pNom);
END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajout d'un été de commande
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE nouvelEtat(pLibelle IN ETAT.etat_libelle%TYPE)
IS 
BEGIN
	INSERT INTO ETAT(etat_id, etat_libelle)
	VALUES(seq_etat.nextval, pLibelle);
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Association note / Client / Vendeur
------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE noterVendeur(pNote IN NOTEVENDEUR.note_valeur%TYPE, pIdClient IN CLIENT.cli_id%TYPE, pIdVendeur IN VENDEUR.vend_id%TYPE)
IS
BEGIN
	INSERT INTO NOTEVENDEUR(note_id, note_valeur, Client_cli_id, VENDEUR_vend_id)
	VALUES(seq_notevendeur.nextval, pNote, pIdClient, pIdVendeur);
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Affichage de tous les CD
------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace PROCEDURE catalogueCD
IS
  CURSOR listeCd IS SELECT PROD_NOM, PROD_DESCRIPTION, MUSIC_LIBELLE, CD_ARTISTE FROM PRODUIT
  INNER JOIN CD ON CD.PRODUIT_PROD_ID = PRODUIT.PROD_ID
  INNER JOIN STYLEMUSICAL ON music_id = CD.STYLEMUSICAL_MUSIC_ID
  WHERE PROD_ID IN (
    SELECT PRODUIT_prod_id FROM CD
  );

  v_nom PRODUIT.prod_nom%TYPE;
  v_description PRODUIT.PROD_DESCRIPTION%TYPE;
  v_libelle STYLEMUSICAL.music_libelle%TYPE;
  v_artiste CD.CD_ARTISTE%TYPE;
BEGIN
  OPEN listeCd;
    LOOP
        FETCH listeCd INTO v_nom, v_description, v_libelle, v_artiste;
        DBMS_OUTPUT.PUT_LINE('Nom : ' || v_nom ||' Description : '|| v_description ||' Genre : '|| v_libelle ||' Artiste : '|| v_artiste); 
        EXIT WHEN listeCd%NOTFOUND; 
    END LOOP;
  CLOSE listeCd;
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Affichage de tous les livres
------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace PROCEDURE catalogueLivre
IS
  CURSOR listeLivre IS SELECT PRODUIT.PROD_NOM, PRODUIT.PROD_DESCRIPTION, LIVRE.LIV_NBPAGES, EDITEUR.EDIT_NOM, LIVRE.LIV_AUTEUR, GENRE.GENRE_LIBELLE, TVA.TVA_TAUX
                       FROM PRODUIT
                         INNER JOIN LIVRE ON LIVRE.PRODUIT_PROD_ID=PRODUIT.PROD_ID
                         INNER JOIN EDITEUR ON EDITEUR.EDIT_ID=LIVRE.EDITEUR_EDIT_ID
                         INNER JOIN GENRE ON GENRE.GENRE_ID=LIVRE.GENRE_GENRE_ID
                         INNER JOIN TVA ON TVA.TVA_CODE=PRODUIT.TVA_TVA_CODE
                       WHERE PROD_ID IN (SELECT LIVRE.PRODUIT_PROD_ID FROM LIVRE);
  v_nom PRODUIT.prod_nom%TYPE;
  v_description PRODUIT.prod_description%TYPE;
  v_nbPages LIVRE.liv_nbPages%TYPE;
  v_editeur EDITEUR.edit_nom%TYPE;
  v_auteur LIVRE.liv_auteur%TYPE;
  v_genre GENRE.genre_libelle%TYPE;
  v_tva TVA.tva_taux%TYPE;
BEGIN
    OPEN listeLivre;
    LOOP
      FETCH listeLivre INTO v_nom, v_description, v_nbPages, v_editeur, v_auteur, v_genre, v_tva;
        DBMS_OUTPUT.PUT_LINE('Nom : ' || v_nom || ' Description : ' || v_description || ' Nombre de pages : ' || v_nbPages || ' Editeur : ' || v_editeur || ' Auteur : ' || v_auteur || ' Genre : ' || v_genre || ' TVA : ' || v_tva);
        EXIT WHEN listeLivre%NOTFOUND;
      END LOOP;
  CLOSE listeLivre;
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Affichage de toutes les commandes en cours d'un client
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE commandesEnCours(pidClient IN CLIENT.cli_id%TYPE)
IS
  CURSOR commandesEnCours IS
    SELECT COMMANDE.COMMANDE_NUMERO, TO_DATE(COMMANDE.COMMANDE_DATE, 'DD/MM/YYYY'), ETAT.ETAT_LIBELLE, SUM(VEND.VEND_PRIX)
    FROM COMMANDE
    INNER JOIN ETATCOMMANDE ON ETATCOMMANDE.COMMANDE_COMMANDE_NUMERO = COMMANDE.COMMANDE_NUMERO
    INNER JOIN ETAT ON ETAT.ETAT_ID = ETATCOMMANDE.ETAT_ETAT_ID
    INNER JOIN VEND ON VEND.VENDEUR_VEND_ID=COMMANDE.VEND_VEND_ID
    WHERE COMMANDE_NUMERO IN (
    SELECT COMMANDE_COMMANDE_NUMERO
    FROM ETATCOMMANDE
    WHERE ETAT_ETAT_ID = 3 OR ETAT_ETAT_ID = 4
    ) AND COMMANDE.CLIENT_CLI_ID = pidClient
    GROUP BY COMMANDE.COMMANDE_NUMERO, COMMANDE.COMMANDE_DATE, ETAT.ETAT_LIBELLE, VEND.VEND_PRIX
    ORDER BY COMMANDE.COMMANDE_DATE;

  v_numero COMMANDE.COMMANDE_ID%TYPE;
  v_date DATE;
  v_etat ETAT.ETAT_LIBELLE%TYPE;
  v_total VEND.VEND_PRIX%TYPE;
BEGIN
  OPEN commandesEnCours;
    LOOP
      FETCH commandesEnCours INTO v_numero, v_date, v_etat, v_total;
      DBMS_OUTPUT.PUT_LINE(v_numero || v_date || v_etat || v_total);
      EXIT WHEN commandesEnCours%NOTFOUND;
      END LOOP;
  CLOSE commandesEnCours;
END;


------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ajouter au panier
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ajouterAuPanier(pIdClient IN CLIENT.CLI_ID%TYPE, pIdProduit IN PRODUIT.prod_id%TYPE, pQuantite IN NUMBER)
IS
  v_dernierNumero NUMBER;
BEGIN
  SELECT commande_numero INTO v_dernierNumero
  FROM commande
  INNER JOIN ETATCOMMANDE ON ETATCOMMANDE.COMMANDE_COMMANDE_NUMERO=commande.COMMANDE_NUMERO
  WHERE CLIENT_CLI_ID = 2 AND ETATCOMMANDE.ETAT_ETAT_ID=1;

  IF v_dernierNumero IS NULL THEN
    SELECT MAX(commande_numero) INTO v_dernierNumero
    FROM commande;
  END IF;

  INSERT INTO COMMANDE(commande_date, commande_id, Client_cli_id, Vend_vend_id, commande_numero, commande_quantite)
  VALUES(CURRENT_DATE, seq_commande.nextval, pIdClient, pIdProduit, v_dernierNumero, pQuantite);

  INSERT INTO ETATCOMMANDE(etaCom_id, Etat_etat_id, etaCom_dateDebut, Commande_commande_numero)
  VALUES(seq_etatCommande, 1, CURRENT_DATE, v_dernierNumero);
END;