-- 1. Sélection de colonnes simples
SELECT
  id,
  name,
  surname
FROM customer_analytics.customers;

-- 2. Vérification des valeurs distinctes
SELECT DISTINCT name FROM customer_analytics.customers;
SELECT DISTINCT surname FROM customer_analytics.customers;
SELECT DISTINCT id FROM customer_analytics.customers;

-- 3. Clients avec 3 commandes
SELECT * FROM customer_analytics.customers
WHERE number_of_orders = 3;

-- 4. Commandes >= 3 OU date de création après le 1er septembre 2022
SELECT * FROM customer_analytics.customers
WHERE number_of_orders >= 3 OR creation_date >= '2022-09-01';

-- 5. Commandes >= 3 ET date de création après le 1er janvier 2022
SELECT * FROM customer_analytics.customers
WHERE number_of_orders >= 3 AND creation_date >= '2022-01-01';

-- 6. Noms de famille finissant par "s"
SELECT * FROM customer_analytics.customers
WHERE surname LIKE '%s';

-- 7. Clients dont le prénom est Paul ou George
SELECT * FROM customer_analytics.customers
WHERE name IN ('Paul','George');

-- 8. Renommer la colonne name en firstname
SELECT name AS firstname
FROM customer_analytics.customers;

-- 9. Colonne binaire is_customers (1 si nb commandes > 0, sinon 0)
SELECT IF(number_of_orders > 0, 1, 0) AS is_customers
FROM customer_analytics.customers;

-- 10. Création d'une colonne de segmentation client
SELECT
  id,
  name,
  surname,
  number_of_orders,
  IF(number_of_orders > 0, 1, 0) AS is_customers,
  CASE
    WHEN number_of_orders = 0 THEN 'New'
    WHEN number_of_orders IN (1,2) THEN 'Occasional'
    WHEN number_of_orders >= 3 THEN 'Frequent'
  END AS segment
FROM customer_analytics.customers
ORDER BY id;

-- 11. Calcul du panier moyen
SELECT
  id,
  name,
  surname,
  number_of_orders,
  total_turnover,
  IF(number_of_orders > 0, 1, 0) AS is_customers,
  SAFE_DIVIDE(total_turnover, number_of_orders) AS average_basket
FROM customer_analytics.customers
ORDER BY id;

-- 12.a. Clients ayant un panier moyen NULL
SELECT
  id,
  name,
  surname,
  number_of_orders,
  total_turnover,
  SAFE_DIVIDE(total_turnover, number_of_orders) AS average_basket
FROM customer_analytics.customers
WHERE SAFE_DIVIDE(total_turnover, number_of_orders) IS NULL
ORDER BY id;

-- 12.b. Clients avec panier moyen non NULL
SELECT
  id,
  name,
  surname,
  number_of_orders,
  total_turnover,
  SAFE_DIVIDE(total_turnover, number_of_orders) AS average_basket
FROM customer_analytics.customers
WHERE SAFE_DIVIDE(total_turnover, number_of_orders) IS NOT NULL
ORDER BY id;
