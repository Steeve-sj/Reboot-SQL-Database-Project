# Reboot-SQL-Database-Project
Conception d’une base de données relationnelle avec SQLite pour une plateforme fictive de réemploi et de réparation d’appareils électroniques.

# Reboot — Base de données SQL pour le réemploi électronique

## Présentation du projet

Reboot est un projet académique visant à concevoir une base de données relationnelle pour une plateforme fictive dédiée au réemploi et à la réparation d'appareils électroniques.

L'objectif est de centraliser les informations relatives aux utilisateurs, aux appareils, aux catégories, aux réparateurs, aux réparations, aux ventes et aux évaluations afin de faciliter leur gestion et leur analyse.

Le projet s'inscrit dans une démarche d'économie circulaire visant à prolonger la durée de vie des équipements électroniques et à limiter les déchets.

## Objectifs

- Concevoir une base de données relationnelle avec SQLite.
- Créer des tables reliées par des clés primaires et étrangères.
- Insérer et structurer des données de démonstration.
- Exploiter les données à l'aide de requêtes SQL.
- Analyser les prix estimés, les ventes, les réparations et les évaluations.
- Identifier les appareils susceptibles d'être réemployés.

## Structure de la base de données

La base comprend sept tables :

| Table | Rôle |
|---|---|
| `utilisateur` | Informations sur les utilisateurs |
| `categorie` | Catégories d'appareils |
| `appareil` | Caractéristiques, état, prix et statut des appareils |
| `reparateur` | Informations sur les réparateurs |
| `reparation` | Historique et coûts des réparations |
| `vente` | Transactions et prix de vente |
| `evaluation` | Notes et commentaires des utilisateurs |

## Compétences SQL mobilisées

- `CREATE TABLE` et `INSERT INTO`
- Clés primaires et clés étrangères
- `SELECT`, `WHERE` et `ORDER BY`
- `INNER JOIN` et `LEFT JOIN`
- Fonctions d'agrégation : `COUNT`, `AVG` et `SUM`
- `GROUP BY` et `HAVING`
- Sous-requêtes
- Filtrage et analyse de données

## Exemples d'analyses réalisées

Les requêtes permettent notamment de :

- Calculer le chiffre d'affaires total des ventes enregistrées.
- Analyser le coût moyen des réparations.
- Comparer les prix estimés des appareils.
- Identifier les appareils non encore vendus.
- Étudier les évaluations des utilisateurs.
- Repérer les appareils présentant un potentiel de réemploi.

## Technologies

- **Langage :** SQL
- **Système de gestion de base de données :** SQLite

## Données et périmètre

Les données utilisées sont fictives et générées à l'aide d'une IA à des fins pédagogiques. Les résultats illustrent le fonctionnement des requêtes sur ce jeu de données et ne constituent pas des statistiques représentatives du marché réel.

## Exécution

1. Télécharger le fichier `reboot.sql`.
2. Ouvrir une base de données SQLite dans un outil compatible, par exemple DB Browser for SQLite.
3. Exécuter le script SQL.
4. Consulter les résultats des requêtes et explorer les tables.

## Auteur

Projet personnel de mise en pratique du SQL dans le cadre de l'apprentissage des systèmes d'information et de l'analyse de données.
