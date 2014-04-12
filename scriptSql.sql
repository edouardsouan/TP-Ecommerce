-- Généré par Oracle SQL Developer Data Modeler 4.0.1.836
--   à :        2014-04-09 11:48:40 CEST
--   site :      Oracle Database 11g
--   type :      Oracle Database 11g




CREATE TABLE Adresse
  (
    adr_id        NUMBER (2) NOT NULL ,
    Client_cli_id NUMBER (2) NOT NULL ,
    adr_adresse1 NVARCHAR2 (100) ,
    adr_adresse2 NVARCHAR2 (100) ,
    adr_cp NUMBER (5) NOT NULL ,
    adr_ville NVARCHAR2 (50)
  ) ;
ALTER TABLE Adresse ADD CONSTRAINT Adresse_PK PRIMARY KEY ( adr_id, adr_cp ) ;

CREATE TABLE CB
  (
    cb_id         NUMBER (2) NOT NULL ,
    Client_cli_id NUMBER (2) NOT NULL ,
    cb_numero     NUMBER (16) ,
    cb_secu       NUMBER (3) ,
    cb_date       DATE
  ) ;
ALTER TABLE CB ADD CONSTRAINT CB_PK PRIMARY KEY ( cb_id ) ;

CREATE TABLE CD
  ( Produit_prod_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE CD ADD CONSTRAINT CD_PK PRIMARY KEY ( Produit_prod_id ) ;

CREATE TABLE Client
  (
    cli_id NUMBER (2) NOT NULL ,
    cli_nom NVARCHAR2 (50) ,
    cli_prenom NVARCHAR2 (50)
  ) ;
ALTER TABLE Client ADD CONSTRAINT Client_PK PRIMARY KEY ( cli_id ) ;

CREATE TABLE Commande
  (
    com_numero    NUMBER NOT NULL ,
    Client_cli_id NUMBER (2) NOT NULL
  ) ;
ALTER TABLE Commande ADD CONSTRAINT Commande_PK PRIMARY KEY ( com_numero ) ;

CREATE TABLE Etat
  ( etat_id NUMBER (2) NOT NULL , etat_libelle NVARCHAR2(50)
  ) ;
ALTER TABLE Etat ADD CONSTRAINT Etat_PK PRIMARY KEY ( etat_id ) ;

CREATE TABLE EtatCommande
  (
    etaCom_id           NUMBER (2) NOT NULL ,
    Etat_etat_id        NUMBER (2) NOT NULL ,
    Commande_com_numero NUMBER (2) NOT NULL ,
    etaCom_date         TIMESTAMP
  ) ;
ALTER TABLE EtatCommande ADD CONSTRAINT EtatCommande_PK PRIMARY KEY ( etaCom_id ) ;

CREATE TABLE LigneCommande
  (
    lign_id             NUMBER (2) NOT NULL ,
    Commande_com_numero NUMBER (2) NOT NULL ,
    Produit_prod_id     NUMBER (2) NOT NULL
  ) ;
ALTER TABLE LigneCommande ADD CONSTRAINT LigneCommande_PK PRIMARY KEY ( lign_id ) ;

CREATE TABLE Livre
  (
    Produit_prod_id NUMBER (2) NOT NULL ,
    liv_nbPages     NUMBER (4)
  ) ;
ALTER TABLE Livre ADD CONSTRAINT Livre_PK PRIMARY KEY ( Produit_prod_id ) ;

CREATE TABLE Piste
  (
    pist_id            NUMBER NOT NULL ,
    CD_Produit_prod_id NUMBER (2) NOT NULL ,
    pis_titre NVARCHAR2(50) ,
    pist_duree NUMBER (4)
  ) ;
ALTER TABLE Piste ADD CONSTRAINT Piste_PK PRIMARY KEY ( pist_id ) ;

CREATE TABLE Produit
  (
    prod_id      NUMBER (2) NOT NULL ,
    TVA_tva_code NUMBER (2) NOT NULL ,
    prod_nom NVARCHAR2 (50),
    prod_description CLOB
  ) ;
ALTER TABLE Produit ADD CONSTRAINT Produit_PK PRIMARY KEY ( prod_id ) ;

CREATE TABLE TVA
  (
    tva_code NUMBER (2) NOT NULL ,
    tva_taux NUMBER (4,2) NOT NULL
  ) ;
ALTER TABLE TVA ADD CONSTRAINT TVA_PK PRIMARY KEY ( tva_code ) ;

ALTER TABLE Adresse ADD CONSTRAINT Adresse_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE CB ADD CONSTRAINT CB_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE CD ADD CONSTRAINT CD_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE Commande ADD CONSTRAINT Commande_Client_FK FOREIGN KEY ( Client_cli_id ) REFERENCES Client ( cli_id ) ;

ALTER TABLE EtatCommande ADD CONSTRAINT EtatCommande_Commande_FK FOREIGN KEY ( Commande_com_numero ) REFERENCES Commande ( com_numero ) ;

ALTER TABLE EtatCommande ADD CONSTRAINT EtatCommande_Etat_FK FOREIGN KEY ( Etat_etat_id ) REFERENCES Etat ( etat_id ) ;

ALTER TABLE LigneCommande ADD CONSTRAINT LigneCommande_Commande_FK FOREIGN KEY ( Commande_com_numero ) REFERENCES Commande ( com_numero ) ;

ALTER TABLE LigneCommande ADD CONSTRAINT LigneCommande_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE Livre ADD CONSTRAINT Livre_Produit_FK FOREIGN KEY ( Produit_prod_id ) REFERENCES Produit ( prod_id ) ;

ALTER TABLE Piste ADD CONSTRAINT Piste_CD_FK FOREIGN KEY ( CD_Produit_prod_id ) REFERENCES CD ( Produit_prod_id ) ;

ALTER TABLE Produit ADD CONSTRAINT Produit_TVA_FK FOREIGN KEY ( TVA_tva_code ) REFERENCES TVA ( tva_code ) ;


CREATE SEQUENCE seq_client
START WITH 1
INCREMENT BY 1
NOMAXVALUE:

CREATE SEQUENCE seq_cb
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_adresse
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_commande
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_etat
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_etatCommande
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_ligneCommande
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_piste
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE seq_produit
START WITH 1
INCREMENT BY 1
NOMAXVALUE;
