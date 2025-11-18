# Customer segmentation on total spent
SELECT
COUNT(*) AS number_of_customers,
CASE WHEN total_spent < 305 THEN 'Low-Value'
WHEN total_spent <=1654 THEN 'Medium-Value'
ELSE 'High-Value' END AS customer_segment
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
GROUP BY
  customer_segment
