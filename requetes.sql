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
CREATE OR REPLACE PROCEDURE nouveauGenre(pGenre IN GENRE.genre_id%TYPE)
IS
BEGIN 
	INSERT INTO Genre(genre_id, genre_libelle)
	VALUES(seq_genre.nextval, pGenre);
END;

CALL nouveauGenre("Aaventure");
CALL nouveauGenre("Aaventure");
