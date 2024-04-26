SELECT * FROM article ORDER BY DESIGNATION ASC;
SELECT * FROM article ORDER BY PRIX DESC;
SELECT * FROM article WHERE DESIGNATION LIKE "%boulon%" ORDER BY PRIX ASC;
SELECT * FROM article WHERE DESIGNATION LIKE "%sachet%";
SELECT * FROM article, fournisseur WHERE fournisseur.ID = ID_FOU ORDER BY fournisseur.NOM ASC, PRIX DESC;
SELECT * FROM article, fournisseur WHERE fournisseur.ID = ID_FOU AND ID_FOU = 3;
SELECT ID_FOU, fournisseur.NOM, AVG(PRIX) FROM article, fournisseur WHERE fournisseur.ID = ID_FOU AND ID_FOU = 3; 
SELECT ID_FOU, fournisseur.NOM, AVG(PRIX) FROM article, fournisseur WHERE fournisseur.ID = ID_FOU GROUP BY fournisseur.NOM; 
SELECT * FROM bon WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';
SELECT bon.NUMERO AS num_commande, 
	article.DESIGNATION AS article, 
	compo.QTE AS qte 
	FROM compo, bon, article 
	WHERE compo.ID_BON = bon.ID 
	AND compo.ID_ART = article.ID 
	AND compo.ID_ART IN (2, 3, 4, 6) 
	ORDER BY num_commande ASC;
SELECT bon.NUMERO AS num_commande, 
	fournisseur.NOM AS nom_fournisseur 
	FROM compo, bon, fournisseur 
	WHERE compo.ID_BON = bon.ID 
	AND fournisseur.ID = bon.ID_FOU 
	AND compo.ID_ART IN (2, 3, 4, 6) 
	GROUP BY num_commande;
SELECT bon.NUMERO AS num_commande, 
	SUM(article.PRIX * compo.QTE) AS prix_total
	FROM compo, bon, article 
	WHERE compo.ID_BON = bon.ID 
	AND article.ID = compo.ID_ART
	GROUP BY num_commande;
SELECT bon.NUMERO AS num_commande, 
	SUM(compo.QTE) AS qte_totale
	FROM compo, bon 
	WHERE compo.ID_BON = bon.ID 
    GROUP BY num_commande;
SELECT bon.NUMERO AS num_commande, 
	SUM(compo.QTE) AS qte_totale
	FROM compo, bon 
	WHERE compo.ID_BON = bon.ID
    GROUP BY num_commande
    HAVING qte_totale > 25;
SELECT bon.NUMERO AS num_commande,
	DATE_CMDE AS date_commande,
	SUM(article.PRIX * compo.QTE) AS prix_total
	FROM compo, bon, article 
	WHERE compo.ID_BON = bon.ID 
	AND article.ID = compo.ID_ART
	GROUP BY num_commande
    HAVING date_commande LIKE '%-04-%';
SELECT article.REF, article.DESIGNATION, article.ID_FOU 
	FROM (SELECT * FROM article) virtua, article 
	WHERE virtua.DESIGNATION = article.DESIGNATION 
    AND virtua.ID_FOU != article.ID_FOU;
SELECT MONTH(DATE_CMDE) AS mois_commande,
	SUM(article.PRIX * compo.QTE) AS prix_total
	FROM compo, bon, article 
	WHERE compo.ID_BON = bon.ID 
	AND article.ID = compo.ID_ART
	GROUP BY mois_commande;
SELECT bon.NUMERO AS num_commande 
	FROM bon 
	WHERE NOT EXISTS (SELECT * FROM compo WHERE bon.ID = compo.ID_BON);
SELECT virtua.nom_fournisseur,
AVG(prix_total) as moyenne_prix
FROM 
(SELECT bon.NUMERO AS num_commande, 
	SUM(article.PRIX * compo.QTE) AS prix_total,
    fournisseur.NOM as nom_fournisseur
	FROM compo, bon, article, fournisseur
	WHERE compo.ID_BON = bon.ID 
	AND article.ID = compo.ID_ART
    AND fournisseur.ID = bon.ID_FOU
	GROUP BY num_commande)
AS virtua
GROUP BY virtua.nom_fournisseur;