-- 1. Exploration de la table brute
SELECT * 
FROM analytics_dataset.customer_feedback_raw;

-- 2. Vérification de la clé primaire
SELECT COUNT(DISTINCT order_id) AS distinct_ids,
       COUNT(*) AS total_rows
FROM analytics_dataset.customer_feedback_raw;

-- 3. Recherche des doublons récents
SELECT *
FROM analytics_dataset.customer_feedback_raw
ORDER BY feedback_date DESC, order_id DESC;

-- 4. Suppression des doublons via table dédupliquée
CREATE TABLE analytics_dataset.customer_feedback_deduplicated AS
SELECT DISTINCT *
FROM analytics_dataset.customer_feedback_raw;

-- 5. Création de la colonne NPS (-1 = détracteur, 0 = passif, 1 = promoteur)
CREATE TABLE analytics_dataset.customer_feedback_with_nps AS
SELECT
  feedback_date,
  order_id,
  carrier,
  customer_segment,
  overall_score,
  CASE
    WHEN overall_score BETWEEN 9 AND 10 THEN 1
    WHEN overall_score BETWEEN 7 AND 8 THEN 0
    WHEN overall_score BETWEEN 0 AND 6 THEN -1
    ELSE NULL
  END AS nps,
  other_columns...
FROM analytics_dataset.customer_feedback_deduplicated;

-- 6. Comptage global NPS
SELECT
  COUNTIF(nps IS NOT NULL) AS total_reviews,
  COUNTIF(nps = 1) AS total_promoters,
  COUNTIF(nps = -1) AS total_detractors,
  ROUND( (COUNTIF(nps = 1) - COUNTIF(nps = -1)) / COUNTIF(nps IS NOT NULL) * 100, 1) AS nps_score
FROM analytics_dataset.customer_feedback_with_nps;

-- 7. Évolution NPS juin vs août
-- Juin
SELECT
  COUNTIF(nps IS NOT NULL) AS total_reviews,
  COUNTIF(nps = 1) AS total_promoters,
  COUNTIF(nps = -1) AS total_detractors,
  ROUND( (COUNTIF(nps = 1) - COUNTIF(nps = -1)) / COUNTIF(nps IS NOT NULL) * 100, 1) AS nps_score
FROM analytics_dataset.customer_feedback_with_nps
WHERE feedback_date BETWEEN '2021-06-01' AND '2021-06-30';

-- Août
SELECT
  COUNTIF(nps IS NOT NULL) AS total_reviews,
  COUNTIF(nps = 1) AS total_promoters,
  COUNTIF(nps = -1) AS total_detractors,
  ROUND( (COUNTIF(nps = 1) - COUNTIF(nps = -1)) / COUNTIF(nps IS NOT NULL) * 100, 1) AS nps_score
FROM analytics_dataset.customer_feedback_with_nps
WHERE feedback_date BETWEEN '2021-08-01' AND '2021-08-31';

-- 8. Analyse d’un transporteur spécifique (exemple : Carrier_A Home)
-- Juin
SELECT
  COUNTIF(nps IS NOT NULL) AS total_reviews,
  COUNTIF(nps = 1) AS total_promoters,
  COUNTIF(nps = -1) AS total_detractors,
  ROUND( (COUNTIF(nps = 1) - COUNTIF(nps = -1)) / COUNTIF(nps IS NOT NULL) * 100, 1) AS nps_score
FROM analytics_dataset.customer_feedback_with_nps
WHERE feedback_date BETWEEN '2021-06-01' AND '2021-06-30'
  AND carrier = 'Carrier_A Home';

-- Août
SELECT
  COUNTIF(nps IS NOT NULL) AS total_reviews,
  COUNTIF(nps = 1) AS total_promoters,
  COUNTIF(nps = -1) AS total_detractors,
  ROUND( (COUNTIF(nps = 1) - COUNTIF(nps = -1)) / COUNTIF(nps IS NOT NULL) * 100, 1) AS nps_score
FROM analytics_dataset.customer_feedback_with_nps
WHERE feedback_date BETWEEN '2021-08-01' AND '2021-08-31'
  AND carrier = 'Carrier_A Home';

-- 9. Sélection des clients à rappeler (août, transporteur = Carrier_A Home)
SELECT *
FROM analytics_dataset.customer_feedback_with_nps
WHERE feedback_date BETWEEN '2021-08-01' AND '2021-08-31'
  AND carrier = 'Carrier_A Home'
  AND (nps = -1 OR delivery_satisfaction <= 3)
ORDER BY customer_segment;

-- 10. NPS par segment
SELECT
  customer_segment,
  ROUND(AVG(nps) * 100, 1) AS avg_nps
FROM analytics_dataset.customer_feedback_with_nps
GROUP BY customer_segment;

-- 11. NPS par segment sur juin, juillet, août
SELECT
  customer_segment,
  EXTRACT(MONTH FROM feedback_date) AS month,
  ROUND(AVG(nps) * 100, 1) AS avg_nps
FROM analytics_dataset.customer_feedback_with_nps
WHERE feedback_date BETWEEN '2021-06-01' AND '2021-08-31'
GROUP BY 1, 2
ORDER BY 1, 2;