------
--REBOOT : Conception d’une base de données SQL pour une plateforme de réemploi d’appareils électroniques
--"CONTEXTE DU PROJET
--Aujourd’hui, on a tous des appareils électroniques : smartphones, ordinateurs, tablettes, accessoires… Et on les remplace assez souvent, même quand ils marchent encore ou qu’une simple réparation suffirait. Résultat, les déchets électroniques s’accumulent et on perd des ressources qui pourraient très bien resservir.
--Le réemploi et la réparation sont des pistes concrètes pour donner une seconde vie à ces appareils. Mais pour que ça fonctionne vraiment, il faut pouvoir s’y retrouver : savoir quels appareils sont disponibles, à qui ils appartiennent, qui peut les réparer, quelles ventes ont été faites et ce que les utilisateurs en ont pensé.
--C’est de là que vient Reboot, un projet fictif de plateforme dédiée au réemploi et à la réparation d’appareils électroniques. Le but est de créer une base de données relationnelle pour regrouper toutes ces informations au même endroit et les rendre plus faciles à exploiter.
--Le projet s’appuie sur sept tables principales : utilisateur, categorie, appareil, reparateur, reparation,vente et evaluation. Chaque table a son rôle, et les clés primaires et étrangères permettent de relier les données entre elles.


-- REBOOT : projet SQL simple avec SQLite
PRAGMA foreign_keys = ON;

CREATE TABLE utilisateur (
 id_utilisateur INTEGER PRIMARY KEY,
 nom TEXT NOT NULL,
 ville TEXT NOT NULL,
 email TEXT NOT NULL UNIQUE
);
CREATE TABLE categorie (
 id_categorie INTEGER PRIMARY KEY,
 nom_categorie TEXT NOT NULL
);
CREATE TABLE appareil (
 id_appareil INTEGER PRIMARY KEY,
 nom_appareil TEXT NOT NULL,
 marque TEXT NOT NULL,
 etat TEXT NOT NULL,
 prix_estime REAL NOT NULL,
 statut TEXT NOT NULL,
 id_categorie INTEGER NOT NULL,
 id_vendeur INTEGER NOT NULL,
 FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie),
 FOREIGN KEY (id_vendeur) REFERENCES utilisateur(id_utilisateur)
);
CREATE TABLE reparateur (
 id_reparateur INTEGER PRIMARY KEY,
 nom_reparateur TEXT NOT NULL,
 ville TEXT NOT NULL,
 specialite TEXT NOT NULL
);
CREATE TABLE reparation (
 id_reparation INTEGER PRIMARY KEY,
 id_appareil INTEGER NOT NULL,
 id_reparateur INTEGER NOT NULL,
 cout_reparation REAL NOT NULL,
 date_reparation TEXT NOT NULL,
 resultat TEXT NOT NULL,
 FOREIGN KEY (id_appareil) REFERENCES appareil(id_appareil),
 FOREIGN KEY (id_reparateur) REFERENCES reparateur(id_reparateur)
);
CREATE TABLE vente (
 id_vente INTEGER PRIMARY KEY,
 id_appareil INTEGER NOT NULL UNIQUE,
 id_acheteur INTEGER NOT NULL,
 prix_vente REAL NOT NULL,
 date_vente TEXT NOT NULL,
 FOREIGN KEY (id_appareil) REFERENCES appareil(id_appareil),
 FOREIGN KEY (id_acheteur) REFERENCES utilisateur(id_utilisateur)
);
CREATE TABLE evaluation (
 id_evaluation INTEGER PRIMARY KEY,
 id_utilisateur INTEGER NOT NULL,
 id_reparation INTEGER,
 id_vente INTEGER,
 note INTEGER NOT NULL,
 commentaire TEXT,
 FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur),
 FOREIGN KEY (id_reparation) REFERENCES reparation(id_reparation),
 FOREIGN KEY (id_vente) REFERENCES vente(id_vente)
);

-- DONNEES : au moins 5 lignes par table

--Insertion les données daans la Table UTILISATEUR
INSERT INTO utilisateur VALUES
(1,'Amine Laurent','Annecy','amine@example.com'),
(2,'Sofia Martin','Annemasse','sofia@example.com'),
(3,'Lucas Bernard','Geneve','lucas@example.com'),
(4,'Ines Robert','Chambery','ines@example.com'),
(5,'Noah Petit','Annecy','noah@example.com'),
(6,'Emma Garcia','Thonon','emma@example.com');

--Insertion des données dans la table categorie
INSERT INTO categorie VALUES
(1,'Smartphone'),(2,'Ordinateur'),(3,'Tablette'),(4,'Audio'),(5,'Accessoire');

--Insertion des données dans la table appareil
INSERT INTO appareil VALUES
(1,'iPhone 12','Apple','Bon',260,'Vendu',1,1),
(2,'Galaxy S21','Samsung','Bon',220,'Vendu',1,2),
(3,'ThinkPad T14','Lenovo','Use',390,'Disponible',2,3),
(4,'MacBook Air M1','Apple','Excellent',520,'Vendu',2,4),
(5,'iPad 9','Apple','A reparer',180,'En reparation',3,5),
(6,'Casque WH-1000XM4','Sony','Bon',150,'Vendu',4,6),
(7,'Enceinte JBL Flip 5','JBL','Use',55,'Vendu',4,1),
(8,'Chargeur USB-C','Anker','Excellent',15,'Recycle',5,2);

--Insertion des données dans la table reparateur
INSERT INTO reparateur VALUES
(1,'AlpRepair','Annecy','Smartphones'),
(2,'TechSecondeVie','Annemasse','Ordinateurs'),
(3,'RepareTout','Geneve','Audio'),
(4,'EcoCircuit','Chambery','Tablettes'),
(5,'Atelier Numerique','Thonon','Multi-appareils');

--Insertion des données dans la table reparation
INSERT INTO reparation VALUES
(1,3,2,62,'2026-04-04','Repare'),
(2,5,4,145,'2026-04-08','Partiellement repare'),
(3,8,5,12,'2026-04-09','Irreparable'),
(4,2,1,20,'2026-04-11','Repare'),
(5,6,3,39,'2026-04-14','Repare'),
(6,7,3,42,'2026-04-18','Partiellement repare');

--Insertion des données dans la table vente
INSERT INTO vente VALUES
(1,1,3,245,'2026-04-20'),
(2,4,2,495,'2026-04-21'),
(3,2,6,205,'2026-04-24'),
(4,6,4,135,'2026-04-25'),
(5,7,5,48,'2026-04-26');

INSERT INTO evaluation VALUES
(1,3,NULL,1,5,'Appareil conforme'),
(2,2,NULL,2,4,'Bonne transaction'),
(3,6,NULL,3,4,'Produit correct'),
(4,2,1,NULL,5,'Reparation rapide'),
(5,4,5,NULL,4,'Bon service'),
(6,1,4,NULL,3,'Service correct');

-- Q1 : Tous les appareils
SELECT * FROM appareil;
--Interprétation : Le résultat présente les huit appareils enregistrés dans la base de données, avec leurs marques, leurs états, leurs prix estimés et leurs statuts.

-- Q2 : Appareils disponibles
SELECT nom_appareil, marque, prix_estime
FROM appareil WHERE statut = 'Disponible';
--Commentaire : Cette requête affiche uniquement le nom, la marque et le prix estimé des appareils dont le statut est « Disponible »
--Interprétation : Trois appareils sont disponibles : le ThinkPad T14, le casque WH-1000XM4 et l'enceinte JBL Flip 5. Ils peuvent être proposés à la vente.

-- Q3 : Appareils estimes a plus de 200 euros
SELECT nom_appareil, prix_estime FROM appareil WHERE prix_estime > 200;
--Commentaire : Cette requête sélectionne les appareils dont le prix estimé est strictement supérieur à 200 €. Elle permet de filtrer le catalogue en fonction de la valeur estimée des appareils.
--Interprétation : Quatre appareils dépassent 200 € : l'iPhone 12, le Galaxy S21, le ThinkPad T14 et le MacBook Air M1. Ce sont les appareils dont la valeur estimée est supérieure à ce seuil.

-- Q4 : Appareils et categorie
SELECT appareil.nom_appareil, categorie.nom_categorie
FROM appareil JOIN categorie ON appareil.id_categorie = categorie.id_categorie;
--Commentaire : Cette requête utilise JOIN pour associer chaque appareil à sa catégorie. La liaison est réalisée grâce à id_categorie, présent dans les deux tables.
--Interprétation : Les appareils sont associés à leur catégorie respective. Les smartphones et les appareils audio sont notamment représentés par plusieurs produits.

-- Q5 : Appareils et vendeur
SELECT appareil.nom_appareil, utilisateur.nom AS vendeur
FROM appareil JOIN utilisateur ON appareil.id_vendeur = utilisateur.id_utilisateur;
--Commentaire : Cette requête relie la table appareil à la table utilisateur afin d'afficher le nom de chaque appareil et celui de la personne qui le propose.
--Interprétation : Chaque appareil est associé à l'utilisateur qui l'a enregistré sur la plateforme. Certains utilisateurs proposent plusieurs appareils.

-- Q6 : Nombre d'appareils par categorie
SELECT categorie.nom_categorie, COUNT(appareil.id_appareil) AS nombre_appareils
FROM categorie LEFT JOIN appareil ON categorie.id_categorie = appareil.id_categorie
GROUP BY categorie.nom_categorie;
--Interprétation : Les catégories « Smartphone » et « Audio » comptent chacune deux appareils. Les autres catégories en comptent une chacune, ce qui permet de comparer la composition du catalogue.

-- Q7 : Prix moyen éstimé par categorie
SELECT categorie.nom_categorie, ROUND(AVG(appareil.prix_estime),2) AS prix_moyen
FROM categorie JOIN appareil ON categorie.id_categorie = appareil.id_categorie
GROUP BY categorie.nom_categorie;
--Interprétation : La catégorie « Ordinateur » présente le prix moyen estimé le plus élevé, à 455 €, tandis que la catégorie « Accessoire » affiche le prix moyen le plus faible, à 15 €.

-- Q8 : Categories ayant au moins deux appareils
SELECT categorie.nom_categorie, COUNT(appareil.id_appareil) AS nombre_appareils
FROM categorie JOIN appareil ON categorie.id_categorie = appareil.id_categorie
GROUP BY categorie.nom_categorie
HAVING COUNT(appareil.id_appareil) >= 2;
--Interprétation : Seules les catégories « Smartphone » et « Audio » satisfont la condition, avec deux appareils chacune.

-- Q9 : Chiffre d'affaires total
SELECT SUM(prix_vente) AS chiffre_affaires_total FROM vente;
--Interprétation : Le chiffre d'affaires total des cinq ventes enregistrées est de 1 128 €. Ce montant correspond à la somme des prix de vente, et non au bénéfice net de la plateforme.

-- Q10 : Ventes, appareil et acheteur
SELECT vente.id_vente, appareil.nom_appareil, utilisateur.nom AS acheteur, vente.prix_vente
FROM vente
JOIN appareil ON vente.id_appareil = appareil.id_appareil
JOIN utilisateur ON vente.id_acheteur = utilisateur.id_utilisateur;
--Interprétation : Les cinq transactions permettent d'identifier les appareils vendus, leurs acheteurs et leurs prix. Le MacBook Air M1 est vendu au prix le plus élevé, soit 495 €.

-- Q11 : Reparations et reparateurs
SELECT appareil.nom_appareil, reparateur.nom_reparateur, reparation.cout_reparation, reparation.resultat
FROM reparation
JOIN appareil ON reparation.id_appareil = appareil.id_appareil
JOIN reparateur ON reparation.id_reparateur = reparateur.id_reparateur;
--Interprétation : Les réparations sont associées aux appareils concernés et aux professionnels responsables. Le résultat permet notamment de distinguer les réparations complètes, partielles et les échecs.

-- Q12 : Cout moyen des reparations
SELECT ROUND(AVG(cout_reparation),2) AS cout_moyen FROM reparation;
--Interprétation : Le coût moyen des six réparations enregistrées est de 53,33 €. Cette moyenne donne une indication du coût des interventions dans le jeu de données.

-- Q13 : Reparations a plus de 40 euros
SELECT id_reparation, cout_reparation, resultat 
FROM reparation WHERE cout_reparation > 40;
--Interprétation : Trois réparations dépassent 40 € : celles de 62 €, 145 € et 42 €. La réparation de l'iPad 9, à 145 €, est la plus coûteuse.

-- Q14 : Nombre de reparations par reparateur
SELECT reparateur.nom_reparateur, COUNT(reparation.id_reparation) AS nombre_reparations
FROM reparateur LEFT JOIN reparation ON reparateur.id_reparateur = reparation.id_reparateur
GROUP BY reparateur.nom_reparateur ORDER BY nombre_reparations DESC;
--Interprétation : RepareTout a réalisé trois réparations, soit le nombre le plus élevé. Les autres réparateurs ont chacun réalisé une intervention.

-- Q15 : Appareils vendus
SELECT appareil.nom_appareil, vente.prix_vente, vente.date_vente
FROM appareil JOIN vente ON appareil.id_appareil = vente.id_appareil;
--Interprétation : Cinq appareils apparaissent dans les ventes : l'iPhone 12, le MacBook Air M1, le Galaxy S21, le casque WH-1000XM4 et l'enceinte JBL Flip 5.

-- Q16 : Appareils pas encore vendus
SELECT appareil.nom_appareil, appareil.statut
FROM appareil LEFT JOIN vente ON appareil.id_appareil = vente.id_appareil
WHERE vente.id_vente IS NULL;
--Interprétation : Trois appareils n'ont aucune vente enregistrée : le ThinkPad T14, l'iPad 9 et le chargeur USB-C. Ils présentent respectivement les statuts « Disponible », « En reparation » et « Recycle ».

-- Q17 : Note moyenne des evaluations
SELECT ROUND(AVG(note),2) AS note_moyenne FROM evaluation;
--Interprétation : La note moyenne des six évaluations est de 4,17 sur 5, ce qui indique une appréciation globalement positive dans les données fictives.


-- Q18 : Evaluations et auteur
SELECT utilisateur.nom, evaluation.note, evaluation.commentaire
FROM evaluation JOIN utilisateur ON evaluation.id_utilisateur = utilisateur.id_utilisateur;
--Interprétation : Les six évaluations sont associées aux utilisateurs qui les ont publiées. Les notes et commentaires permettent de consulter les retours laissés sur les ventes et les réparations.

-- Q19 : Appareils plus chers que le prix moyen global
SELECT nom_appareil, prix_estime FROM appareil
WHERE prix_estime > (SELECT AVG(prix_estime) FROM appareil);
--Interprétation : Le prix estimé moyen des huit appareils est de 223,75 €. Quatre appareils dépassent cette moyenne : l'iPhone 12, le Galaxy S21, le ThinkPad T14 et le MacBook Air M1.

--Q20 :Quels appareils peuvent être facilement réemployés et à quels prix sont-ils estimés ?
SELECT nom_appareil, marque, etat, prix_estime
FROM appareil
WHERE etat IN ('Bon', 'Excellent')
AND statut != 'Recycle'
ORDER BY prix_estime ASC;
--Interprétation des résultats : Cette requête identifie les appareils en bon ou excellent état qui peuvent être réemployés sans réparation importante, tout en présentant leur prix estimé. Le tri par prix croissant permet de repérer en priorité les appareils les plus accessibles financièrement.

---CONCLUSION
--La base de données SQL de Reboot permet de gérer les utilisateurs, les catégories d’appareils, les ventes, les réparations et les évaluations à travers sept tables et vingt requêtes SQL.
--Ces requêtes facilitent le suivi des appareils, l’analyse des prix, des ventes et des coûts de réparation.
--On répond directement à l’objectif central du projet en identifiant les appareils en bon ou excellent état susceptibles d’être réemployés, ainsi que leurs prix estimés.
--Elle permet ainsi de mettre en évidence le potentiel de seconde vie des équipements électroniques.
--Reboot contribue donc à promouvoir une consommation plus responsable, en favorisant le réemploi des appareils, la réduction des déchets électroniques et l’allongement de leur durée de vie.

--Utilisation IA Générative : Les données proscrites, et utilisées lors de ce projet, ont été généré par L'IA.