-- Généré par Oracle SQL Developer Data Modeler 4.0.1.836
--   à :        2014-04-12 12:46:34 CEST
--   site :      Oracle Database 11g
--   type :      Oracle Database 11g


SET SERVEROUTPUT ON 

CREATE OR REPLACE TABLE Adresse
  (
    adr_id        NUMBER (2) NOT NULL ,
    Client_cli_id NUMBER (2) NOT NULL ,
    adr_adresse1 NVARCHAR2 (100) ,
    adr_adresse2 NVARCHAR2 (100) ,
    adr_cp NUMBER (5) NOT NULL ,
    adr_ville NVARCHAR2 (50) ,
    TypeAdresse_adrType_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE Adresse ADD CONSTRAINT Adresse_PK PRIMARY KEY ( adr_id, adr_cp ) ;

CREATE OR REPLACE TABLE CB
  (
    cb_id         NUMBER (2) NOT NULL ,
    Client_cli_id NUMBER (2) NOT NULL ,
    cb_numero     NUMBER (16) ,
    cb_secu       NUMBER (3) ,
    cb_date       VARCHAR2 (5)
  ) ;
ALTER TABLE CB ADD CONSTRAINT CB_PK PRIMARY KEY ( cb_id ) ;

CREATE OR REPLACE TABLE CD
  (
    Produit_prod_id       NUMBER (2) NOT NULL ,
    StyleMusical_music_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE CD ADD CONSTRAINT CD_PK PRIMARY KEY ( Produit_prod_id ) ;

CREATE OR REPLACE TABLE Client
  (
    cli_id NUMBER (2) NOT NULL ,
    cli_nom NVARCHAR2 (50) ,
    cli_prenom NVARCHAR2 (50) ,
    cli_mail NVARCHAR2 (250) ,
    cli_motDePasse NVARCHAR2 (250) NOT NULL
  ) ;
ALTER TABLE Client ADD CONSTRAINT Client_PK PRIMARY KEY ( cli_id ) ;

CREATE OR REPLACE TABLE Commande
  (
    Livraison_livr_id NUMBER (2) NOT NULL ,
    Panier_panier_id  NUMBER (3) NOT NULL
  ) ;
ALTER TABLE Commande ADD CONSTRAINT Commande_PK PRIMARY KEY ( Panier_panier_id ) ;

CREATE OR REPLACE TABLE Domicile
  (
    Livraison_livr_id NUMBER (2) NOT NULL ,
    Client_cli_id     NUMBER (2) NOT NULL
  ) ;

CREATE OR REPLACE TABLE Editeur
  (
    edit_nom NVARCHAR2 (50) ,
    edit_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE Editeur ADD CONSTRAINT Editeur_PK PRIMARY KEY ( edit_id ) ;

CREATE OR REPLACE TABLE Etat
  (
    etat_id NUMBER (2) NOT NULL ,
    etat_libelle NVARCHAR2 (50)
  ) ;
ALTER TABLE Etat ADD CONSTRAINT Etat_PK PRIMARY KEY ( etat_id ) ;

CREATE OR REPLACE TABLE EtatCommande
  (
    etaCom_id                 NUMBER (2) NOT NULL ,
    Etat_etat_id              NUMBER (2) NOT NULL ,
    etaCom_date               TIMESTAMP ,
    Commande_Panier_panier_id NUMBER (3) NOT NULL
  ) ;
ALTER TABLE EtatCommande ADD CONSTRAINT EtatCommande_PK PRIMARY KEY ( etaCom_id ) ;

CREATE OR REPLACE TABLE Genre
  (
    genre_id NUMBER (2) NOT NULL ,
    genre_libelle NVARCHAR2 (50)
  ) ;
ALTER TABLE Genre ADD CONSTRAINT Genre_PK PRIMARY KEY ( genre_id ) ;

CREATE OR REPLACE TABLE LignePanier
  (
    ligne_id         NUMBER (2) NOT NULL ,
    Panier_panier_id NUMBER (3) NOT NULL ,
    Produit_prod_id  NUMBER (2) NOT NULL
  ) ;
ALTER TABLE LignePanier ADD CONSTRAINT LignePanier_PK PRIMARY KEY ( ligne_id ) ;

CREATE OR REPLACE TABLE Livraison
  (
    livr_id NUMBER (2) NOT NULL ,
    livr_libelle NVARCHAR2 (50)
  ) ;
ALTER TABLE Livraison ADD CONSTRAINT Livraison_PK PRIMARY KEY ( livr_id ) ;

CREATE OR REPLACE TABLE Livre
  (
    Produit_prod_id NUMBER (2) NOT NULL ,
    liv_nbPages     NUMBER (4) ,
    Editeur_edit_id NUMBER (2) NOT NULL ,
    liv_auteur NVARCHAR2 (100) ,
    Genre_genre_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE Livre ADD CONSTRAINT Livre_PK PRIMARY KEY ( Produit_prod_id ) ;

CREATE OR REPLACE TABLE NoteProduit
  (
    Produit_prod_id NUMBER (2) NOT NULL ,
    Client_cli_id   NUMBER (2) NOT NULL ,
    note_id         NUMBER (3) NOT NULL ,
    note_valeur     NUMBER (2)
  ) ;
ALTER TABLE NoteProduit ADD CONSTRAINT NoteProduit_PK PRIMARY KEY ( note_id ) ;

CREATE OR REPLACE TABLE NoteVendeur
  (
    Client_cli_id   NUMBER (2) NOT NULL ,
    Vendeur_vend_id NUMBER (2) NOT NULL ,
    note_id         NUMBER (3) NOT NULL ,
    note_valeur     NUMBER (2) NOT NULL
  ) ;
ALTER TABLE NoteVendeur ADD CONSTRAINT NoteVendeur_PK PRIMARY KEY ( note_id ) ;

CREATE OR REPLACE TABLE Panier
  (
    panier_id     NUMBER (3) NOT NULL ,
    Client_cli_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE Panier ADD CONSTRAINT Panier_PK PRIMARY KEY ( panier_id ) ;

CREATE TABLE Piste
  (
    pist_id            NUMBER NOT NULL ,
    CD_Produit_prod_id NUMBER (2) NOT NULL ,
    pis_titre NVARCHAR2 (50) ,
    pist_duree NUMBER (4)
  ) ;
ALTER TABLE Piste ADD CONSTRAINT Piste_PK PRIMARY KEY ( pist_id ) ;

CREATE OR REPLACE TABLE PointRelais
  (
    Livraison_livr_id NUMBER (2) NOT NULL ,
    point_nom NVARCHAR2 (50) ,
    Adresse_adr_id NUMBER (2) NOT NULL 
  ) ;

CREATE OR REPLACE TABLE Produit
  (
    prod_id      NUMBER (2) NOT NULL ,
    TVA_tva_code NUMBER (2) NOT NULL ,
    prod_nom NVARCHAR2 (50) ,
    prod_description CLOB
  ) ;
ALTER TABLE Produit ADD CONSTRAINT Produit_PK PRIMARY KEY ( prod_id ) ;

CREATE TABLE StyleMusical
  (
    music_id NUMBER (2) NOT NULL ,
    music_libelle NVARCHAR2 (50)
  ) ;
ALTER TABLE StyleMusical ADD CONSTRAINT StyleMusical_PK PRIMARY KEY ( music_id ) ;

CREATE OR REPLACE TABLE TVA
  (
    tva_code NUMBER (2) NOT NULL ,
    tva_taux NUMBER (4,2) NOT NULL
  ) ;
ALTER TABLE TVA ADD CONSTRAINT TVA_PK PRIMARY KEY ( tva_code ) ;

CREATE OR REPLACE TABLE TypeAdresse
  (
    adrType_id NUMBER (2) NOT NULL ,
    adrType_libelle NVARCHAR2 (50)
  ) ;
ALTER TABLE TypeAdresse ADD CONSTRAINT TypeAdresse_PK PRIMARY KEY ( adrType_id ) ;

CREATE OR REPLACE TABLE Vend
  (
    vend_id         NUMBER (3) NOT NULL ,
    Produit_prod_id NUMBER (2) NOT NULL ,
    Vendeur_vend_id NUMBER (2) NOT NULL ,
    vend_prix       NUMBER (3) NOT NULL
  ) ;
ALTER TABLE Vend ADD CONSTRAINT TABLE_16_PK PRIMARY KEY ( vend_id ) ;

CREATE OR REPLACE TABLE Vendeur
  (
    vend_id NUMBER (2) NOT NULL ,
    vend_nom NVARCHAR2 (50)
  ) ;
ALTER TABLE Vendeur ADD CONSTRAINT Vendeur_PK PRIMARY KEY ( vend_id ) ;

ALTER TABLE Adresse ADD CONSTRAINT Adresse_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE Adresse ADD CONSTRAINT Adresse_TypeAdresse_FK FOREIGN KEY ( TypeAdresse_adrType_id ) REFERENCES TypeAdresse ( adrType_id ) ;

ALTER TABLE CB ADD CONSTRAINT CB_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE CD ADD CONSTRAINT CD_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE CD ADD CONSTRAINT CD_StyleMusical_FK FOREIGN KEY ( StyleMusical_music_id ) REFERENCES StyleMusical ( music_id ) ;

ALTER TABLE Commande ADD CONSTRAINT Commande_Livraison_FK FOREIGN KEY ( Livraison_livr_id ) REFERENCES Livraison ( livr_id ) ;

ALTER TABLE Commande ADD CONSTRAINT Commande_Panier_FK FOREIGN KEY ( Panier_panier_id ) REFERENCES Panier ( panier_id ) ;

ALTER TABLE Domicile ADD CONSTRAINT Domicile_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE Domicile ADD CONSTRAINT Domicile_Livraison_FK FOREIGN KEY ( Livraison_livr_id ) REFERENCES Livraison ( livr_id ) ;

ALTER TABLE EtatCommande ADD CONSTRAINT EtatCommande_Commande_FK FOREIGN KEY ( Commande_Panier_panier_id ) REFERENCES Commande ( Panier_panier_id ) ;

ALTER TABLE EtatCommande ADD CONSTRAINT EtatCommande_Etat_FK FOREIGN KEY ( Etat_etat_id ) REFERENCES Etat ( etat_id ) ;

ALTER TABLE LignePanier ADD CONSTRAINT LignePanier_Panier_FK FOREIGN KEY ( Panier_panier_id ) REFERENCES Panier ( panier_id ) ;

ALTER TABLE LignePanier ADD CONSTRAINT LignePanier_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE Livre ADD CONSTRAINT Livre_Editeur_FK FOREIGN KEY ( Editeur_edit_id ) REFERENCES Editeur ( edit_id ) ;

ALTER TABLE Livre ADD CONSTRAINT Livre_Genre_FK FOREIGN KEY ( Genre_genre_id ) REFERENCES Genre ( genre_id ) ;

ALTER TABLE Livre ADD CONSTRAINT Livre_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE NoteProduit ADD CONSTRAINT NoteProduit_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE NoteProduit ADD CONSTRAINT NoteProduit_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE NoteVendeur ADD CONSTRAINT NoteVendeur_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE NoteVendeur ADD CONSTRAINT NoteVendeur_Vendeur_FK FOREIGN KEY ( Vendeur_vend_id ) REFERENCES Vendeur ( vend_id ) ;

ALTER TABLE Panier ADD CONSTRAINT Panier_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE Piste ADD CONSTRAINT Piste_CD_FK FOREIGN KEY ( CD_Produit_prod_id ) REFERENCES CD ( Produit_prod_id ) ;

ALTER TABLE PointRelais ADD CONSTRAINT PointRelais_Adresse_FK FOREIGN KEY ( Adresse_adr_id, Adresse_adr_cp ) REFERENCES Adresse ( adr_id, adr_cp ) ;

ALTER TABLE PointRelais ADD CONSTRAINT PointRelais_Livraison_FK FOREIGN KEY ( Livraison_livr_id ) REFERENCES Livraison ( livr_id ) ;

ALTER TABLE Produit ADD CONSTRAINT Produit_TVA_FK FOREIGN KEY ( TVA_tva_code ) REFERENCES TVA ( tva_code ) ;

ALTER TABLE Vend ADD CONSTRAINT Vend_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE Vend ADD CONSTRAINT Vend_Vendeur_FK FOREIGN KEY ( Vendeur_vend_id ) REFERENCES Vendeur ( vend_id ) ;


-- Rapport récapitulatif d'Oracle SQL Developer Data Modeler : 
-- 
-- CREATE TABLE                            24
-- CREATE INDEX                             0
-- ALTER TABLE                             49
-- CREATE VIEW                              0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0



CREATE SEQUENCE seq_client
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_adresse
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_cb
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_editeur
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_etat
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_etatCommande
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_genre
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_lignePanier
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_livraison
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_noteProduit
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_noteVendeur
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_panier
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_piste
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_produit
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_style
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_typeAdresse
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_vend
START WITH 1
INCREMENT by 1
NOMAXVALUE;

CREATE SEQUENCE seq_vendeur
START WITH 1
INCREMENT by 1
NOMAXVALUE;
