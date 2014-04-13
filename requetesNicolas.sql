#Suppression des toutes les tables de l'utilisateurs
BEGIN
    FOR c IN (SELECT object_name,
                     object_type
              FROM user_objects
              WHERE object_type IN ('TABLE') AND object_name NOT LIKE '%$%') LOOP
        EXECUTE IMMEDIATE 'DROP '
                             || c.object_type || ' "'
                             || c.object_name || '" CASCADE CONSTRAINTS';
    END LOOP;
END;

#Ajout d'un genre de livre
CREATE OR REPLACE PROCEDURE nouveauGenre(pGenre IN GENRE.genre_libelle%TYPE)
IS
BEGIN 
	INSERT INTO Genre(genre_id, genre_libelle)
	VALUES(seq_genre.nextval, pGenre);
END;

CALL nouveauGenre('Aventure');
CALL nouveauGenre('Science Fiction');
CALL nouveauGenre('Fantasy');
CALL nouveauGenre('Fantastique');
CALL nouveauGenre('Horreur');
CALL nouveauGenre('Biographie');
CALL nouveauGenre('Conte');
CALL nouveauGenre('Policier');
CALL nouveauGenre('Informatique');
CALL nouveauGenre('Guide');


CREATE OR REPLACE PROCEDURE nouveauStyle(pStyle IN StyleMusical.music_libelle%TYPE)
IS 
BEGIN
  INSERT INTO StyleMusical(music_id, music_libelle)
  VALUES(seq_style.nextval, pStyle);
END;

CALL nouveauStyle('Rock');
CALL nouveauStyle('Country');
CALL nouveauStyle('Rap');
CALL nouveauStyle('Reggae');
CALL nouveauStyle('Techno');
CALL nouveauStyle('Blues');
CALL nouveauStyle('Dance');
CALL nouveauStyle('House');


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

CALL nouveauLivre(2, 'Clean Code', 'A Handbook of Agile Software Craftsmanship', 431, 12, 'Robert C.Martin', 22);
CALL nouveauLivre(2, 'Le sexe pour les nuls', 'Avec les nuls, tout devient facile !', 366, 11, 'Dr Ruth K.Westheimer', 30);
CALL nouveauLivre(2, 'Game Of Thrones T1', 'Kings and queens, knights and renegades, liars, lors and honest men. All will play the Game of Thrones', 801, 10, 'George RR Martin', 24);
CALL nouveauLivre(2, 'La route', 'Le chef d oeuvre de MCCarthy adapté au cinéma avec Vigo Mortensen' , 251, 9, 'Cormac MCCarthy', 21);
CALL nouveauLivre(2, 'Star Wars - Ordre 66', 'Alors que le Chancelier Palpatine est sur le point de signer l arrêt de mort...' , 630, 8, 'Karen Travis', 23);
CALL nouveauLivre(2, 'Millénium 1', 'Les Hommes qui n aimaient pas les femmes' , 705, 7, 'Stieg Larsson', 29);
CALL nouveauLivre(2, 'Innocent', 'Un ami en danger. Une bagarre qui dégénère. Un accident. A vingt ans, Matt Hunter ...' , 517, 6, 'Harlan Coben', 29);
CALL nouveauLivre(2, 'Le seigneur des anneaux', 'La communauté de l anneau' , 928, 5, 'J.R.R. Tolkien', 24);


CREATE OR REPLACE PROCEDURE nouveauCD(pTVA IN TVA.tva_code%TYPE, pNom IN PRODUIT.prod_nom%TYPE, pDescription IN PRODUIT.prod_description%TYPE, pStyle IN StyleMusical.music_id%TYPE, pArtiste IN CD.music_artiste%TYPE)
IS
  prodId NUMBER;
BEGIN
  prodId := seq_produit.nextval;
  INSERT INTO PRODUIT(prod_id, TVA_tva_code, prod_nom, prod_description)
  VALUES(prodId, pTVA, pNom,  pDescription);

  INSERT INTO CD(PRODUIT_prod_id, StyleMusical_music_id, cd_artiste)
  VALUES(prodId, pStyle, pArtiste);
END;

CALL nouveauCD(2, 'Just A Little Beat', 'Super CD de beat Making', 8, 'Hoosky');
CALL nouveauCD(2, 'Revolve And Step Up', 'Moins bien que les précédents album mais pas mal...', 1, 'Puppetmastaz');
CALL nouveauCD(2, 'Tetra', 'Un peu trop commercial à mon gout ! ', 8, 'C2C');
CALL nouveauCD(2, '2001', 'Un des meilleurs album de rap de tous les temps !', 1, 'Dr. Dre');
CALL nouveauCD(2, 'L art de la joie', 'L été c est cool le ska !', 4, 'La Ruda Salska');
CALL nouveauCD(2, 'Ladilafe', 'Pas mal ...', 4, 'Tryo');


CREATE OR REPLACE PROCEDURE nouvellePiste(pIdCd IN PRODUIT.prod_id%TYPE, pTitre IN PISTE.pis_titre%TYPE, pDuree IN PISTE.pist_duree%TYPE)
IS 
BEGIN
  INSERT INTO PISTE(pist_id, CD_PRODUIT_prod_id, pis_titre, pist_duree)
  VALUES(seq_piste.nextval, pIdCd, pTitre, pDuree);
END;

CALL nouvellePiste(19, 'Greenwashing', 312);
CALL nouvellePiste(19, 'Ladilafe', 260);
CALL nouvellePiste(19, 'Nous generation', 180);
CALL nouvellePiste(19, 'Pas banal', 210);
CALL nouvellePiste(18, 'Le bruit du bang', 200);
CALL nouvellePiste(18, 'Selon', 232);
CALL nouvellePiste(18, 'Que le bon l emporte', 232);
CALL nouvellePiste(18, 'Rien venir', 242);
CALL nouvellePiste(17, 'The Watcher', 245);
CALL nouvellePiste(17, 'Fuck you', 189);
CALL nouvellePiste(17, 'Still Dre', 170);
CALL nouvellePiste(17, 'Big Egos', 250);
CALL nouvellePiste(16, 'The cell', 299);
CALL nouvellePiste(16, 'Down the road', 210);
CALL nouvellePiste(16, 'Kings Season', 194);
CALL nouvellePiste(16, 'Because of you', 300);
CALL nouvellePiste(15, 'Inner Circle', 122);
CALL nouvellePiste(15, 'Full Bashment', 230);
CALL nouvellePiste(15, 'Skit', 199);
CALL nouvellePiste(15, 'Fresh Day', 245);
CALL nouvellePiste(14, '00H00', 99);
CALL nouvellePiste(14, 'Rush Hour', 237);
CALL nouvellePiste(14, 'Flying Market', 198);
CALL nouvellePiste(14, 'Crushed', 230);

CREATE OR REPLACE PROCEDURE nouveauVendeur(pNom IN VENDEUR.vend_nom%TYPE)
IS 
BEGIN
  INSERT INTO VENDEUR(vend_id, vend_nom)
  VALUES(seq_vendeur.nextval, pNom);
END;

CALL nouveauVendeur('Amazon');
CALL nouveauVendeur('DVD-A-Tout-Prix');
CALL nouveauVendeur('Espace Multimédia');
CALL nouveauVendeur('Monde du livre');
CALL nouveauVendeur('Jaime lire');
CALL nouveauVendeur('Music Power');
CALL nouveauVendeur('La foire au cd');
CALL nouveauVendeur('Vive les livres');
CALL nouveauVendeur('Culture.com');


CREATE OR REPLACE PROCEDURE vendeurVendProduit(pIdProduit IN PRODUIT.prod_id%TYPE, pIdVendeur IN VENDEUR.vend_id%TYPE, pPrix IN VEND.vend_prix%TYPE)
IS 
BEGIN
  INSERT INTO VEND(vend_id, PRODUIT_prod_id, VENDEUR_vend_id, vend_prix)
  VALUES(seq_vend.nextval, pIdProduit, pIdVendeur, pPrix);
END;

CALL vendeurVendProduit( 14, 4, 9.50);
CALL vendeurVendProduit( 16, 4, 10);
CALL vendeurVendProduit( 17, 4, 12);
CALL vendeurVendProduit( 9, 4, 10);
CALL vendeurVendProduit( 10, 4, 17.10);
CALL vendeurVendProduit( 11, 4, 11.30);
CALL vendeurVendProduit( 19, 4, 19.90);
CALL vendeurVendProduit( 14, 5, 10.40);
CALL vendeurVendProduit( 16, 5, 11);
CALL vendeurVendProduit( 17, 5, 12.90);
CALL vendeurVendProduit( 9, 5, 10.10);
CALL vendeurVendProduit( 10, 5, 18);
CALL vendeurVendProduit( 11, 5, 11.90);
CALL vendeurVendProduit( 14, 6, 11);
CALL vendeurVendProduit( 15, 6, 10.90);
CALL vendeurVendProduit( 16, 6, 11.90);
CALL vendeurVendProduit( 9, 6, 9.90);
CALL vendeurVendProduit( 11, 6, 11.40);
CALL vendeurVendProduit( 14, 7, 9);
CALL vendeurVendProduit( 12.30, 7, );
CALL vendeurVendProduit( 16, 7, 13.10);
CALL vendeurVendProduit( 12, 7, 20);
CALL vendeurVendProduit( 13, 7, 14.10);
CALL vendeurVendProduit( 14, 8,9.50);
CALL vendeurVendProduit( 15, 8, 11.90);
CALL vendeurVendProduit( 16, 8, 7.70);
CALL vendeurVendProduit( 8, 8, 8.10);
CALL vendeurVendProduit( 13, 9, 14.50);
CALL vendeurVendProduit( 18, 9, 19.90);
CALL vendeurVendProduit( 14, 10,9.80);
CALL vendeurVendProduit( 15, 11,15.50);
CALL vendeurVendProduit( 8, 11,8.30);
CALL vendeurVendProduit( 13, 11, 14.60);
CALL vendeurVendProduit( 18, 11,19.90);
CALL vendeurVendProduit(19, 11,19.30);
CALL vendeurVendProduit( 9, 11, 12.70);
CALL vendeurVendProduit( 15, 12, 13);
CALL vendeurVendProduit( 8, 12,7.90);
CALL vendeurVendProduit( 13, 12, 13.90);
CALL vendeurVendProduit( 18, 12, 19);
CALL vendeurVendProduit( 19, 12, 20);



CREATE OR REPLACE PROCEDURE nouvelleTVA(pTaux IN TVA.tva_taux%TYPE)
IS 
BEGIN
  INSERT INTO TVA(tva_code, tva_taux)
  VALUES(seq_tva.nextval, pTaux);
END;

CALL nouvelleTVA(20);
CALL nouvelleTVA(10);
CALL nouvelleTVA(5.5);

CREATE OR REPLACE PROCEDURE nouveauEditeur(pNom IN EDITEUR.edit_nom%TYPE)
IS
BEGIN
  INSERT INTO EDITEUR(edit_id, edit_nom)
  VALUES(seq_editeur.nextval, pNom);
END;

CALL nouveauEditeur('Bourgois');
CALL nouveauEditeur('Belfond');
CALL nouveauEditeur('Babel noir');
CALL nouveauEditeur('Fleuve noir');
CALL nouveauEditeur('Edition de l\'olivier');
CALL nouveauEditeur('HarperCollins');
CALL nouveauEditeur('First Editions');
CALL nouveauEditeur('Prentice Hall');


CREATE OR REPLACE PROCEDURE catalogue()
IS 
  CURSOR listeCd IS   SELECT PROD_NOM, PROD_DESCRIPTION, MUSIC_LIBELLE, CD_ARTISTE INTO listeCd FROM PRODUIT
  INNER JOIN CD ON CD.PRODUIT_PROD_ID = PRODUIT.PROD_ID
  INNER JOIN STYLEMUSICAL ON music_id = CD.STYLEMUSICAL_MUSIC_ID
  WHERE PROD_ID IN (
    SELECT PRODUIT_prod_id FROM CD
  );


BEGIN

END;



  CURSOR listeLivre IS   SELECT PROD_NOM, PROD_DESCRIPTION, liv_nbPages, edit_nom, liv_auteur, genre_libelle INTO listeLivre FROM PRODUIT
  INNER JOIN LIVRE ON LIVRE.PRODUIT_PROD_ID=PRODUIT.PROD_ID
  INNER JOIN EDITEUR ON EDITEUR.EDIT_ID=LIVRE.EDITEUR_EDIT_ID
  INNER JOIN GENRE ON GENRE.GENRE_ID=LIVRE.GENRE_GENRE_ID
  WHERE PROD_ID IN (
    SELECT PRODUIT_prod_id FROM Livre
  );



  CREATE OR REPLACE PROCEDURE meilleuresVentes()
  IS 
  BEGIN
  END;

  test