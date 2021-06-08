/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/

SELECT productname, quantityperunit FROM products;

/* TASK II
Q2. Write a query to get most expense and least expensive Product list (name and unit price)
*/

SELECT productname, unitprice FROM products
ORDER BY unitprice DESC;

/* TASK III
Q3. Write a query to count current and discontinued products.
*/

SELECT discontinued, COUNT(productname) 
FROM products
GROUP BY discontinued;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/

SELECT products.productname, categories.categoryname FROM products
JOIN categories ON categories.categoryid = products.categoryid;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from USA region. (26 rows)
This question doesn't reall make sense
*/

SELECT products.productname, products.unitprice, suppliers.region FROM products
JOIN suppliers ON suppliers.supplierid = products.supplierid
WHERE suppliers.region != 'USA';

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/

SELECT SUM(quantity) AS orders_sold FROM order_details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/

SELECT orderid, SUM(quantity) FROM order_details
GROUP BY orderid;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/

SELECT firstname, lastname, current_date, hiredate FROM employees
WHERE age(current_date, hiredate) > interval '5 year';

SELECT firstname, lastname, current_date, hiredate FROM employees
WHERE (current_date - hiredate) > (5 * 365);

/* apparently
SELECT firstname, lastname, current_date, hiredate FROM employees
WHERE (current_date - hiredate) > 5;
will give days, not years. Which is why the selected query is better?
*/