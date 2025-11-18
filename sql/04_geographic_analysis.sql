SELECT
*
FROM(
SELECT
Country,
customer_segment,
number_of_customers,
number_of_customers*100/SUM(number_of_customers)OVER(PARTITION BY Country) as segment_precentage,
SUM(number_of_customers)OVER(PARTITION BY Country) AS total_country_customers
FROM(
SELECT
Country,
COUNT(*) AS number_of_customers,
CASE WHEN total_spent < 305 THEN 'Low-Value'
WHEN total_spent <=1654 THEN 'Medium-Value'
ELSE 'High-Value' END AS customer_segment
FROM(
  SELECT
    CustomerID,
    Country,
    SUM(total_order_value) AS total_spent,
    AVG(total_order_value) AS average_order_value,
    COUNT(DISTINCT(InvoiceNo)) AS number_of_purchases
  FROM (
    SELECT
      CustomerID,
      InvoiceNo,
      Country,
      SUM(UnitPrice*Quantity) AS total_order_value
    FROM
    `my-first-project-462019.online_retail.retail_data` 
    WHERE
    CHAR_LENGTH(InvoiceNo) = 6
    AND CustomerID IS NOT NULL
    GROUP BY
      InvoiceNo,
      CustomerID,
      Country)
  GROUP BY
    CustomerID,
    Country
  ORDER BY
    total_spent DESC)
GROUP BY
  Country,
  customer_segment
ORDER BY
  customer_segment,
  Country)
  ORDER BY segment_precentage DESC)
  WHERE total_country_customers > 10
  ORDER BY segment_precentage DESC
