-- 1. Sélection de toutes les colonnes pour visualiser la table brute
SELECT  
FROM marketing.mail_campaign;

-- 2. Identification de la clé primaire
-- On vérifie que journey_id contient des valeurs uniques
SELECT COUNT(DISTINCT journey_id) AS distinct_ids,
       COUNT() AS total_rows
FROM marketing.mail_campaign;
-- Si les deux valeurs sont identiques, journey_id est bien une clé primaire

-- 3. Campagnes avec le plus grand nombre d'emails envoyés
SELECT
  journey_id,
  journey_name,
  sent_nb
FROM marketing.mail_campaign
ORDER BY sent_nb DESC;

-- 4. Vérification des campagnes distinctes par leur nom
SELECT DISTINCT journey_name
FROM marketing.mail_campaign;

-- 5. Campagnes ayant généré au moins 10 000 ouvertures
SELECT
  journey_id,
  journey_name,
  sent_nb,
  opening_nb
FROM marketing.mail_campaign
WHERE opening_nb = 10000
ORDER BY opening_nb DESC;

-- 6. Top 10 des campagnes avec le plus de clics
SELECT
  journey_id,
  journey_name,
  sent_nb,
  opening_nb,
  click_nb
FROM marketing.mail_campaign
ORDER BY click_nb DESC
LIMIT 10;

-- 7. Analyse d'une campagne spécifique (exemple  happyhour)
SELECT
  journey_id,
  journey_name,
  sent_nb,
  opening_nb,
  click_nb
FROM marketing.mail_campaign
WHERE journey_name LIKE '210707_nl_happyhour%';

-- 8. Plus grosses campagnes en Belgique
SELECT
  journey_id,
  journey_name,
  sent_nb,
  opening_nb,
  click_nb
FROM marketing.mail_campaign
WHERE journey_name LIKE '%nlbe%'
ORDER BY sent_nb DESC;

-- 9. Newsletters France  calcul des principaux KPIs
SELECT
  journey_id,
  journey_name,
  sent_nb,
  opening_nb,
  click_nb,
  turnover,
  ROUND(opening_nbsent_nb100,1) AS opening_rate,
  ROUND(click_nbsent_nb100,2) AS click_rate,
  ROUND(click_nbopening_nb100,1) AS CTR,
  ROUND(SAFE_CAST(REPLACE(turnover, ',', '.') AS FLOAT64)sent_nb1000,1) AS turnover_per_mille
FROM marketing.mail_campaign
WHERE journey_name LIKE '%_nl_%'
  AND journey_name NOT LIKE '%nlbe%'
ORDER BY sent_nb DESC;

-- 10. Extraction de la date depuis journey_name
SELECT
  journey_id,
  CAST(CONCAT('20', SUBSTR(journey_name, 1, 2), '-', 
                    SUBSTR(journey_name, 3, 2), '-', 
                    SUBSTR(journey_name, 5, 2)) AS DATE) AS date_date,
  journey_name,
  sent_nb,
  opening_nb,
  click_nb,
  turnover
FROM marketing.mail_campaign
WHERE journey_name LIKE '%_nl_%'
  AND journey_name NOT LIKE '%nlbe%'
  AND journey_name NOT LIKE 'COPY%'
ORDER BY date_date ASC;