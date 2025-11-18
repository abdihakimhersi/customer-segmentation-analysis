# NULL investigation
SELECT
  COUNT(*) as number_of_invoices,
  CHAR_LENGTH(InvoiceNo) as character_in_id
FROM 
  `my-first-project-462019.online_retail.retail_data`
WHERE
  CustomerID is NULL
GROUP BY
  character_in_id

# Investigating invoice number difference
SELECT
  *,
CHAR_LENGTH(InvoiceNo) as number_of_characters_id
FROM 
  `my-first-project-462019.online_retail.retail_data`
WHERE
  CHAR_LENGTH(InvoiceNo) = 6

# Customer analysis with NULL
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
  total_spent DESC
