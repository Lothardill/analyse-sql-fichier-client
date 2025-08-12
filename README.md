# Introduction au SQL – Transformations de données

Ce dépôt regroupe plusieurs exercices réalisés dans le cadre d’une montée en compétence en SQL.  
Chaque partie correspond à une compétence ou une notion particulière, et contient les fichiers SQL et jeux de données associés.

## Partie 1 – Requêtes SQL de base

Objectif : découvrir les bases du langage SQL (SELECT, WHERE, conditions, opérateurs logiques, CASE, IF, etc.).

Fichiers :
- `1-basic_queries.sql` : requêtes sur les clients (sélection, filtres, création de colonnes, panier moyen)
- `1-customers_dataset.csv` : dataset

## Partie 2 – Typage des données et corrections

Objectif : apprendre à détecter et corriger des erreurs de typage via les fonctions `CAST()` et `SAFE_CAST()`.

Fichiers :
- `2-data_types_cleaning.sql` : corrections appliquées sur les colonnes
- `2-circle_stock_raw.csv`, `2-circle_stock_validated.csv` : datasets


## Partie 3 – Analyse de campagnes CRM

Objectif : manipuler des données marketing, calculer des indicateurs comme taux d’ouverture, CTR, et chiffre d’affaires par email.

Fichiers :
- `3-crm_mail_analysis.sql` : exploration, filtres, KPIs
- `3-mail_campaigns.csv` : jeu de données

## Partie 4 – Analyse de satisfaction client (NPS)

Objectif : nettoyer et enrichir un jeu de données de feedback client, créer un score NPS, analyser son évolution par période ou par transporteur.

Fichiers :
- `4-nps_analysis.sql` : nettoyage, création du score NPS et analyses
- `4-nps_data_raw.csv` : jeu de données


Technologies utilisées

- Google BigQuery (SQL standard)
- Fichiers Excel importés manuellement
