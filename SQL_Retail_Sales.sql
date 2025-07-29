-- SQL RETAIL SALES ANALYSIS 

CREATE DATABASE SQL_PROJECT1;

-- CREATE TABLE
DROP TABLE IF EXISTS Retail_Sales
CREATE TABLE Retail_Sales
				(
					transactions_id	INT PRIMARY KEY,
					sale_date DATE,
					sale_time TIME,
					customer_id	INT,
					gender VARCHAR (15),
					age	INT,
					category VARCHAR (15),	
					quantiy	INT,
					price_per_unit FLOAT,
					cogs FLOAT,	
					total_sale FLOAT
				);

SELECT * FROM Retail_Sales;

-- DATA CLEANING
SELECT TOP 10 * FROM Retail_Sales;

SELECT COUNT (*) FROM Retail_Sales;

SELECT * FROM Retail_Sales
WHERE 
		transactions_id is NULL
		OR
		sale_date is NULL
		OR
		sale_time is NULL
		OR
		customer_id is NULL
		OR
		gender is NULL
		OR
		age is NULL
		OR
		category is NULL
		OR
		quantity is NULL
		OR
		price_per_unit is NULL
		OR
		cogs is NULL
		OR
		total_sale is NULL;

-- Deleting null data
DELETE FROM Retail_Sales
where
		transactions_id is NULL
		OR
		sale_date is NULL
		OR
		sale_time is NULL
		OR
		customer_id is NULL
		OR
		gender is NULL
		OR
		category is NULL
		OR
		quantity is NULL
		OR
		price_per_unit is NULL
		OR
		cogs is NULL
		OR
		total_sale is NULL;

-- DATA EXPLORATION

-- How many sales we have?
SELECT COUNT (*) as total_sales FROM Retail_Sales

-- How many unique customers we have?
SELECT COUNT (DISTINCT customer_id) as total_sales FROM Retail_Sales

-- How many unique category we have?
SELECT DISTINCT category FROM Retail_Sales

--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- Q2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q3 Write a SQL  query to calculate the total _ sales (total_sale) for each category.
-- Q4 Write a SQL  query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q5 Write a SQL  query to find all transactions where the total_sale is greater than 1000.
-- Q6 Write a SQL  query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q7 Write a SQL  query to calculate the average sale for each month. Find out best-selling month in each year.
-- Q8 Write a SQL  query to find the top 5 customers based on the highest total sales.
-- Q9 Write a SQL  query to find the number of unique customers who purhased items from each category.
-- Q10 Write a SQL  query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).


-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05'

-- Q2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022.

SELECT *
FROM Retail_Sales
Where category = 'clothing' 
	AND
	YEAR(sale_date) = 2022 AND MONTH(sale_date) = 11
	AND
	quantity >= 4

-- Q3 Write a SQL  query to calculate the total sales (total_sale) for each category.

SELECT 
	Category,
	Sum(total_sale) AS net_sale,
	COUNT(*) as total_orders
FROM Retail_Sales
GROUP BY category

-- Q4 Write a SQL  query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
	AVG(age) as avg_age
FROM Retail_Sales
WHERE category = 'Beauty'

-- Q5 Write a SQL  query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM Retail_Sales
WHERE total_sale > 1000

-- Q6 Write a SQL  query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender, 
	COUNT(*) as total_trans
FROM Retail_Sales
GROUP BY 
	category,
	gender
ORDER BY 1

-- Q7 Write a SQL  query to calculate the average sale for each month. Find out best-selling month in each year.

SELECT 
		year,
		month,
		avg_sale
FROM
(
SELECT 
	DATEPART(YEAR, sale_date) as year,
	DATEPART(MONTH, sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY DATEPART(YEAR, sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM Retail_Sales
GROUP BY 
	DATEPART(YEAR, sale_date) ,
	DATEPART(MONTH, sale_date)
) as t2
WHERE rank = 1

-- Q8 Write a SQL  query to find the top 5 customers based on the highest total sales.

SELECT TOP 5
	customer_id,
	SUM(total_sale) as total_sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY 2 Desc

-- Q9 Write a SQL  query to find the number of unique customers who purhased items from each category.

SELECT 
	category,
	COUNT(DISTINCT customer_id) as unique_customer
FROM Retail_Sales
GROUP BY category

-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).
-- SELECT EXTRACT(HOUR FROM CURRENT_TIME)

;WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
		WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM Retail_Sales
)
SELECT
shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift	

-- END OF PROJECT
