-- 1. Sélection de toutes les colonnes pour visualiser la table brute
SELECT * FROM stock_analysis.circle_stock_raw;

-- 2. Identification de la clé primaire
-- On vérifie que model_id contient des valeurs uniques
SELECT DISTINCT model_id FROM stock_analysis.circle_stock_raw;

-- 3. Vérification du schéma de la table
-- Tous les champs sont en STRING : conversion nécessaire

-- 4. Conversion de in_stock en BOOLEAN (valeurs binaires : 0 / 1)
SELECT CAST(in_stock AS BOOLEAN) AS in_stock
FROM stock_analysis.circle_stock_raw;

-- 5. Tentative de conversion de date_creation en DATE (échec attendu)
SELECT CAST(date_creation AS DATE) AS date_creation
FROM stock_analysis.circle_stock_raw;
-- Erreur à cause d'un mauvais format : exemple '2021-1014'

-- 6. Retentative sur table corrigée (validated_circle_stock)
-- Le format a été nettoyé manuellement
SELECT CAST(date_creation AS DATE) AS date_creation
FROM stock_analysiscircle_stock_validated;

-- 7. Conversion de stock_days en FLOAT64
SELECT CAST(stock_days AS FLOAT64) AS stock_days
FROM stock_analysis.circle_stock_validated;

-- 8a. Tentative de CAST direct sur la colonne price
SELECT CAST(price AS FLOAT64) AS price
FROM stock_analysis.circle_stock_validated;

-- 8b. Pour éviter une erreur (si mauvaise valeur), utiliser SAFE_CAST
SELECT SAFE_CAST(price AS FLOAT64) AS price
FROM stock_analysis.circle_stock_validated;

-- 9. Requête finale : conversion complète des colonnes avec typage propre
SELECT
  model_id,
  model_type,
  CAST(stock AS INT64) AS stock,
  CAST(in_stock AS BOOLEAN) AS in_stock,
  CAST(date_creation AS DATE) AS date_creation,
  color,
  model_name,
  SAFE_CAST(price AS FLOAT64) AS price,
  CAST(stock_days AS FLOAT64) AS stock_days

FROM stock_analysis.circle_stock_validated;

