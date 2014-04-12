--------------------------------------------------------
--  Fichier créé - samedi-avril-12-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ADDUSER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "ECOMMERCE"."ADDUSER" (p_CliNom CLIENT.CLI_NOM%TYPE,p_CliPrenom CLIENT.CLI_PRENOM%TYPE,p_Cli_MAIL CLIENT.CLI_MAIL%TYPE,p_CliPwd CLIENT.CLI_MOTDEPASSE%TYPE ) AS
BEGIN
INSERT INTO CLIENT(CLI_ID,CLI_NOM,CLI_PRENOM,CLI_MAIL,CLI_MOTDEPASSE)
VALUES(SEQ_CLIENT.NEXTVAL,p_CliNom,p_CliPrenom,p_Cli_MAIL,p_CliPwd);
END;

/
