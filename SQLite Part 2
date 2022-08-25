// Which locations in New York recieved at least 3 orders in January, 
and how many orders did they each receive?//

SELECT distinct location, count(orderID)
FROM JanSales
WHERE location LIKE '%NY%'
GROUP BY location
HAVING count(orderID) > 2;

// How many of each type of headphone was sold in February? //

SELECT sum(Quantity) as quantity, 
Product
FROM BIT_DB.FebSales
WHERE Product like '%Headphones%'
GROUP BY Product;

// What was the average amount spent per account in February? //

SELECT avg(quantity*price)
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.Customers Cust
ON Feb.orderid = Cust.order_id;

// What was the average quantity of products purchased per account in February? //

SELECT sum(quantity)/count(cust.acctnum)
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.Customers Cust
ON Feb.orderid=cust.order_id;

//Which product brought in the most revenue in January and how much revenue did it 
bring in total?//

SELECT product,
sum(quantity*price)
FROM BIT_DB.JanSales
GROUP BY product 
ORDER BY sum(quantity*price) desc
LIMIT 1;
