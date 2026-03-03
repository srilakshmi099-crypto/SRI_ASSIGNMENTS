/*Write a query to list customer names and their order numbers*/
SELECT c.customerName,o.orderNumber  FROM customers c JOIN orders o ON c.customerNumber=o.customerNumber;

select c.customerName,o.orderNumber  from customers c , orders o where c.customerNumber=o.customerNumber;

/*Write a query to show all customers and their orders, including customers with no orders.*/
SELECT c.customerName,o.orderNumber  FROM customers c 
LEFT JOIN orders o ON c.customerNumber=o.customerNumber; 

/*--Write a query to find customers who have not placed any orders.*/
SELECT c.customerName,o.orderNumber  FROM customers c 
LEFT JOIN orders o ON c.customerNumber=o.customerNumber
WHERE o.ordernumber is NULL;

/*Write a query to display total number of orders per customer;*/
select c.customerName,count(o.orderNumber) 
 from customers c join orders  o on c.customerNumber=o.customerNumber group by o.customerNumber;

/*Write a query to assign row numbers to customers based on credit limit (highest first).*/
SELECT customerName, customerNumber,ROW_NUMBER() OVER (ORDER BY creditLimit DESC) AS row_num	FROM customers;
   

/*Write a query to find customers whose credit limit is above the average credit limit.*/

select customerName ,creditLimit from customers where creditLimit > (select avg(creditLimit) from customers);

/*Write a query to display customer name and total payment amount using subquery.*/

select c.customerName, (Select sum(amount) from payments p where p.customerNumber=c.customerNumber) as total_payment from customers c;

/*Write a query to find top 3 customers based on credit limit.*/

select customerName ,customerNumber,creditLimit from customers order by creditLimit desc limit 3 ;

/*Write a query to list orders with total order amount (quantity × price).*/
select orderNumber,sum(quantityOrdered * priceEach) as total_order_amount from orderdetails group by orderNumber; 

/*Write a query to rank customers within each country based on credit limit.*/

select customerName,creditLimit,country,rank() over(partition by country order by creditLimit desc) as ranks from customers;

/*Write a query to find customers who placed more orders than the average number of orders per customer.*/
SELECT c.customerName, COUNT(o.orderNumber) AS TotalCount
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
HAVING COUNT(o.orderNumber) > (
SELECT AVG(order_counts)
FROM (
SELECT COUNT(orderNumber) AS order_counts
FROM orders
GROUP BY customerNumber
) AS subquery
);


/*Write a query to display customer name, order number, and product name (use multiple joins).*/
select c.customername, o.orderNumber, p.productname from customers c 
    join orders o on c.customerNumber=o.customerNumber
    join orderdetails od on o.orderNumber=od.orderNumber 
    join products p on od.productCode=p.productCode ;

/*Write a query to find products that have never been ordered.*/

select p.productName,od.orderNumber from products p 
left join orderdetails od on p.productCode=od.productCode where orderNumber is null;
/*OR*/
select p.productName,p.productCode  from products p where p.productCode not in (select od.productCode from orderdetails od);


/*Write a query to find 2nd highest credit limit using ranking function.*/

select customerName ,creditLimit,ranks from 
(select customerName,creditLimit, rank()over (order by creditLimit desc) as ranks from customers) ranktable  where ranks=2;

/*Write a query to find top 2 customers in each country based on credit limit.*/

select CustomerName,country,creditLimit,ranks from 
 (select CustomerName,country,creditLimit,dense_rank() over (partition by country order by creditLimit desc) as ranks from customers) 
 ranktable where ranks <= 2;   

/*Write a query to find total number of orders placed by each customer.*/
select c.customerName,o.customerNumber,count(o.orderNumber) as orderspercustomer from orders o 
 join customers c on o.customerNumber=c.customerNumber   group by o.customerNumber;
 
 /*Write a query to calculate total payment amount made by each customer.*/

select c.customerName,p.customerNumber,sum(p.amount) from payments p  
join customers c on c.customerNumber=p.customerNumber group by p.customerNumber ;

/*Write a query to find average credit limit for each country.*/
select avg(creditLimit),country from customers group by country;

/*Write a query to display total quantity ordered for each product.*/
select p.productName,sum(od.quantityOrdered),od.productcode from orderdetails od 
join products p on p.productCode=od.productCode group by productCode;

/*Write a query to find number of employees working in each office.*/
select oc.addressLine1,oc.postalCode,count(e.employeeNumber) ,e.officeCode from employees e join offices oc on e.officeCode=oc.officeCode group by e.officeCode;

