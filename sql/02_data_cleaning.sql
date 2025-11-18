SELECT
  MIN(total_spent) AS min_total_spent,
  MAX(total_spent) AS max_total_spent,
  AVG(total_spent) AS avg_total_spent
FROM(
  SELECT
    CustomerID,
    SUM(total_order_value) AS total_spent,
    AVG(total_order_value) AS average_order_value,
    COUNT(DISTINCT(InvoiceNo)) AS number_of_purchases
  FROM (
    SELECT
      CustomerID,
      InvoiceNo,
      SUM(UnitPrice*Quantity) AS total_order_value
    FROM
    `my-first-project-462019.online_retail.retail_data` 
    WHERE
    CHAR_LENGTH(InvoiceNo) = 6
    AND CustomerID IS NOT NULL
    GROUP BY
      InvoiceNo,
      CustomerID)
  GROUP BY
    CustomerID
  ORDER BY
    total_spent DESC)
