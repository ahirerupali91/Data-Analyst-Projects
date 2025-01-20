-----CALCULATED AVERAGE ORDER AMOUNT FOR EACH COUNTRY----

SELECT country, AVG(priceEach * quantityOrdered) AS avg_order_value
FROM classicmodels.customers c
INNER JOIN  orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.ordernUmber
GROUP BY country
ORDER BY avg_order_value DESC;

----CALCULATED TOTAL SALES AMOUNT FOR EACH PRODUCT LINE------------

SELECT pl.productLine, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
JOIN productlines pl ON p.productLine = pl.productLine
GROUP BY pl.productLine
ORDER BY total_sales DESC;

-----TOP 10 BEST SELLING PRODUCTS BASED ON TOTAL QUANTITY SOLD------

SELECT productName, SUM(quantityOrdered) AS units_sold
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY productName
ORDER BY  units_sold DESC
LIMIT 10;

-----EVALUATED THE SALES PERFORMANCE OF EACH SALES REPRESENTATIVE ------

SELECT e.firstname, e.lastname, SUM(quantityOrdered * priceEach) AS order_value
FROM employees e 
INNER JOIN customers c 
ON employeeNumber = salesRepEmployeeNumber AND e.jobtitle = 'Sales Rep'
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
GROUP BY e.firstname, e.lastname;

----CALCULATED AVERAGE NUMBER OF ORDERS PLACED BY EACH CUSTOMER---------

SELECT COUNT(o.orderNumber)/COUNT(DISTINCT c.customerNumber)
FROM customers c
LEFT JOIN orders o
ON c.customerNumber  = o.customerNumber;

-----CALCULATED THE PERCENTAGE OF ORDERS THAT WERE SHIPPED ON TIME--------------

SELECT *, SUM(CASE WHEN shippedDate <= requiredDate THEN 1 ELSE 0 END)/ COUNT(orderNumber) * 100 AS percent_on_time
FROM orders;

-------CALCULATED PROFIT MARGIN ON EACH PRODUCT BY SUBSTRACTING THE COST OF GOODS SOLD(COGS) FROM THE SALES REVENUE----------

SELECT productName, SUM((priceEach*quantityOrdered) - (buyPrice*quantityOrdered)) AS net_profit
FROM products p
INNER JOIN orderdetails o
ON p.productCode = o.productCode
GROUP BY productName;


---------SEGMENT CUSTOMERS BASED ON THEIR TOTAL PURCHASE AMOUNT----------------------

SELECT c.*,t2.customer_segment
FROM customers c
LEFT JOIN
(SELECT *,
CASE WHEN total_purchase_value > 100000 THEN 'High Value'
	 WHEN total_purchase_value BETWEEN 50000 AND 100000 THEN 'Medium Value'
	 WHEN total_purchase_value < 50000 THEN 'Low Value'
     ELSE 'other'
END AS customer_segment
FROM
(SELECT customerNumber, SUM(priceEach * quantityOrdered) AS total_purchase_value
 FROM orders o
 INNER JOIN orderdetails od
 ON o.orderNumber = od.orderNumber
 GROUP BY customerNumber)t1
 )t2
ON c.customernumber = t2.customernumber;

-----Identify frequently co-purchased products to understand cross selling opportunities-----------------

SELECT 
    od1.productCode AS product1,
    p1.productname AS productname1, 
    od2.productCode AS product2,
    p2.productname AS productname2,
    COUNT(*) AS co_purchase_count
FROM 
    orderdetails od1
JOIN 
    orderdetails od2 ON od1.orderNumber = od2.orderNumber AND od1.productCode <> od2.productCode
JOIN 
	products p1 ON od1.productCode = p1.productCode
JOIN 
	products p2 ON od2.productCode = p2.productCode
GROUP BY 
    product1, productname1, product2, productname2
ORDER BY 
    co_purchase_count DESC;
    
