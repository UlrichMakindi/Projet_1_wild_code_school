--- Active: 1710777414972@@51.178.25.157@23456@toys_and_models
--- FINANCES : (1) le chiffres d'affaire des commandes des 2 derniers mois par pays. (2)les commandes qui n'ont pas encore été payées.
--- RH : chaque mois, les 2 vendeurs avec le CA le plus élevé LAURA.
--- LOGISTQUE : le stock des 5 produits les plus commandés, Attention plusieurs produits en même Qté en commandes.
--- LE STOCK DES 5 PRODUITS LES PLUS VENDUS.
SELECT
    products.productCode AS Product_Code,
    products.productName AS Product_Name,
    products.quantityInStock AS Stocks,
    products.buyPrice AS Buy_Price,
    products.quantityInStock*products.buyPrice AS Prix_du_stock,
    ROUND(AVG(orderdetails.quantityOrdered),0) AS commandes_moyennes
FROM products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
GROUP BY products.productCode, Stocks
ORDER BY SUM(orderdetails.quantityOrdered) DESC
LIMIT 5;

select* from orderdetails;

--- LE STOCK DES 5 PRODUITS LES MOINS COMMANDES.
SELECT
    products.productCode AS Product_Code,
    products.productName AS Product_Name,
    products.quantityInStock AS Stocks,
    products.quantityInStock*products.buyPrice AS Prix_du_stock,
    ROUND(AVG(orderdetails.quantityOrdered),0) AS commandes_moyennes
FROM products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
GROUP BY products.productCode
ORDER BY SUM(orderdetails.quantityOrdered) ASC
LIMIT 5;

--- LE STOCK DES 5 PRODUITS LES PLUS VENDUS TRIES PAR MOIS, ANNEE.
SELECT
    products.productCode AS Product_Code,
    products.productName AS Product_Name,
    products.quantityInStock AS Stocks,
    DATEDIFF(orders.orderDate, payments.paymentDate) AS payment_time,
    MONTH(orders.orderDate) AS Month_order,
    YEAR(orders.orderDate) AS Year_order,
    SUM(orderdetails.quantityOrdered) AS Total_quantity_ordered
FROM products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN orders ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN payments ON payments.customerNumber = orders.customerNumber
GROUP BY Product_Code, orders.orderDate, payment_time
ORDER BY Total_quantity_ordered DESC
LIMIT 5;


--- TEMPS DE LIVRAISON MOYEN PAR COMMANDE
select
    orderNumber,
    orders.orderDate as order_date,
    orders.shippedDate as shipped_date,
    round(avg(abs(datediff(orders.orderDate, orders.shippedDate))), 0) AS date_diff
from orders
group by `orderNumber`
order by date_diff ASC 
;
 select * from orderdetails;
  
