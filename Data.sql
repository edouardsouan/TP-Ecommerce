-----------------------------------------------------------------------------
--DATA.SQL--
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
--AJOUT DE DONNEES UTILISANT LA PROC ADDTYPEDRESSE--
-----------------------------------------------------------------------------
exec ADDTYPEADRESSE('FACTURATION');
exec ADDTYPEADRESSE('LIVRAISON');
exec ADDTYPEADRESSE('POINT LIVRAISON');