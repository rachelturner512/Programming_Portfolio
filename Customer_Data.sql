/* In this SQL, I'm querying a database with multiple tables in it to quantify statistics about customer and order data. */

/* How many orders were placed in January? */
SELECT COUNT(orderID) 
FROM JanSales;

/* How many of these orders in January were for an iPhone? */

SELECT COUNT(orderID)
FROM JanSales
WHERE Product = "iPhone";

/* Select the customer account numbers for all the orders placed in February */

SELECT acctnum
FROM BIT_DB.customers cust

INNER JOIN BIT_DB.FebSales Feb
ON cust.order_id=FEB.orderid;

/* Which product was the cheapest one sold in January, and what was the price? */

SELECT distinct product, price FROM BIT_DB.JanSales 
ORDER BY price ASC LIMIT 1;

/* What is the total revenue for each product sold in January? */

SELECT sum(quantity)*price as revenue
,product
FROM BIT_DB.JanSales
GROUP BY product;

/* Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what was the total revenue? */
SELECT
sum(Quantity), 
product, 
sum(quantity)*price as revenue
FROM BIT_DB.FebSales 
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY product;

/* How many customers ordered more than 2 products at a time, and what was the average amount spent for those customers? */
SELECT
count(cust.acctnum), 
avg(quantity)*price
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id
WHERE Feb.Quantity>2;

/* List all the products sold in Los Angeles in February, and include how many of each were sold. */
SELECT Product, SUM(quantity)
FROM BIT_DB.FebSales
WHERE location LIKE '%Los Angeles%'
GROUP BY Product;

