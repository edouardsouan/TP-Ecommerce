-----------------------------------------------------------------------------
--DATA.SQL--
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC ADDUSER--
-----------------------------------------------------------------------------
CALL ADDUSER('MACHUT', 'Nicolas', 'machut.nicolas@gmail.com', 'secret');
CALL ADDUSER('SOUAN', 'Edouard', 'souan.edouard@gmail.com', 'grosLard');
CALL ADDUSER('GOLONKA', 'Marion', 'golonka.marion@gmail.com', 'yeah');
CALL ADDUSER('LAFFONT', 'Edouard', 'laffont.edouard@gmail.com', 'feignant');
CALL ADDUSER('DUFFERMONT', 'Valentin', 'duffermont.valentin@gmail.com', 'yop');
CALL ADDUSER('RIFFARD', 'Julien', 'riffard.julien@gmail.com', 'petitCon');
CALL ADDUSER('SAVAROCHE', 'Kim', 'savaroche.kim@gmail.com', 'chinois');
CALL ADDUSER('LECUONA', 'Patrice', 'lecuona.patrice@gmail.com', 'planning');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC ADDCB--
-----------------------------------------------------------------------------
CALL ADDCB('1','1231231231231231','101','11/19');
CALL ADDCB('2','9090909090909090','213','11/14');
CALL ADDCB('3','1231231233213219','106','04/17');
CALL ADDCB('3','1231231231235683','901','06/18');
CALL ADDCB('4','1231230909031231','567','10/15');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC ADDTYPEDRESSE--
-----------------------------------------------------------------------------
CALL ADDTYPEADRESSE('FACTURATION');
CALL ADDTYPEADRESSE('LIVRAISON');
CALL ADDTYPEADRESSE('POINT LIVRAISON');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC ADDADRESSE--
-----------------------------------------------------------------------------
CALL ADDADRESSE(1,'sous le pont de pierre','tente N°33','33000','BORDEAUX','FACTURATION');
CALL ADDADRESSE(1,'sous le pont de pierre','tente N°33','33000','BORDEAUX','LIVRAISON');
CALL ADDADRESSE(3,'4 rue imaginaire','appt 5 fictif','33000','BORDEAUX','FACTURATION');
CALL ADDADRESSE(5,'sous le pont de pierre','tente N°33','33000','BORDEAUX','LIVRAISON');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouveauGenre--
-----------------------------------------------------------------------------
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
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouveauStyle--
-----------------------------------------------------------------------------
CALL nouveauStyle('Rock');
CALL nouveauStyle('Country');
CALL nouveauStyle('Rap');
CALL nouveauStyle('Reggae');
CALL nouveauStyle('Techno');
CALL nouveauStyle('Blues');
CALL nouveauStyle('Dance');
CALL nouveauStyle('House');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouveauLivre--
-----------------------------------------------------------------------------
CALL nouveauLivre(2, 'Clean Code', 'A Handbook of Agile Software Craftsmanship', 431, 12, 'Robert C.Martin', 22);
CALL nouveauLivre(2, 'Le sexe pour les nuls', 'Avec les nuls, tout devient facile !', 366, 11, 'Dr Ruth K.Westheimer', 30);
CALL nouveauLivre(2, 'Game Of Thrones T1', 'Kings and queens, knights and renegades, liars, lors and honest men. All will play the Game of Thrones', 801, 10, 'George RR Martin', 24);
CALL nouveauLivre(2, 'La route', 'Le chef d oeuvre de MCCarthy adapté au cinéma avec Vigo Mortensen' , 251, 9, 'Cormac MCCarthy', 21);
CALL nouveauLivre(2, 'Star Wars - Ordre 66', 'Alors que le Chancelier Palpatine est sur le point de signer l arrêt de mort...' , 630, 8, 'Karen Travis', 23);
CALL nouveauLivre(2, 'Millénium 1', 'Les Hommes qui n aimaient pas les femmes' , 705, 7, 'Stieg Larsson', 29);
CALL nouveauLivre(2, 'Innocent', 'Un ami en danger. Une bagarre qui dégénère. Un accident. A vingt ans, Matt Hunter ...' , 517, 6, 'Harlan Coben', 29);
CALL nouveauLivre(2, 'Le seigneur des anneaux', 'La communauté de l anneau' , 928, 5, 'J.R.R. Tolkien', 24);
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouveauCD--
-----------------------------------------------------------------------------
CALL nouveauCD(2, 'Just A Little Beat', 'Super CD de beat Making', 8, 'Hoosky');
CALL nouveauCD(2, 'Revolve And Step Up', 'Moins bien que les précédents album mais pas mal...', 1, 'Puppetmastaz');
CALL nouveauCD(2, 'Tetra', 'Un peu trop commercial à mon gout ! ', 8, 'C2C');
CALL nouveauCD(2, '2001', 'Un des meilleurs album de rap de tous les temps !', 1, 'Dr. Dre');
CALL nouveauCD(2, 'L art de la joie', 'L été c est cool le ska !', 4, 'La Ruda Salska');
CALL nouveauCD(2, 'Ladilafe', 'Pas mal ...', 4, 'Tryo');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouvellePiste--
-----------------------------------------------------------------------------
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
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouveauVendeur--
-----------------------------------------------------------------------------
CALL nouveauVendeur('Amazon');
CALL nouveauVendeur('DVD-A-Tout-Prix');
CALL nouveauVendeur('Espace Multimédia');
CALL nouveauVendeur('Monde du livre');
CALL nouveauVendeur('Jaime lire');
CALL nouveauVendeur('Music Power');
CALL nouveauVendeur('La foire au cd');
CALL nouveauVendeur('Vive les livres');
CALL nouveauVendeur('Culture.com');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC vendeurVendProduit--
-----------------------------------------------------------------------------
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
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouveauEditeur--
-----------------------------------------------------------------------------
CALL nouveauEditeur('Bourgois');
CALL nouveauEditeur('Belfond');
CALL nouveauEditeur('Babel noir');
CALL nouveauEditeur('Fleuve noir');
CALL nouveauEditeur('Edition de l\'olivier');
CALL nouveauEditeur('HarperCollins');
CALL nouveauEditeur('First Editions');
CALL nouveauEditeur('Prentice Hall');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouvelEtat--
-----------------------------------------------------------------------------
CALL nouvelEtat('Annulé');
CALL nouvelEtat('En cours');
CALL nouvelEtat('Expédié');
CALL nouvelEtat('Livré');
-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC nouvelleTVA--
-----------------------------------------------------------------------------
CALL nouvelleTVA(20);
CALL nouvelleTVA(10);
CALL nouvelleTVA(5.5);


