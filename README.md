# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_PROJECT1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_PROJECT1`.
- **Table Creation**: A table named `Retail_Sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
```sql
CREATE DATABASE SQL_PROJECT1;

CREATE TABLE
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
```

### 2. Data Cleaning 

- **Record Count**: Determine the total number of records in the dataset.
- **Top 10**: Determine the structure of the records in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```sql
SELECT COUNT (*) FROM Retail_Sales;

SELECT TOP 10 * FROM Retail_Sales;

SELECT * FROM Retail_Sales
WHERE 
		transactions_id is NULL OR
		sale_date is NULL OR
		sale_time is NULL OR
		customer_id is NULL OR
		gender is NULL OR
		age is NULL OR
		category is NULL OR
		quantity is NULL OR
		price_per_unit is NULL OR
		cogs is NULL OR
		total_sale is NULL;

DELETE FROM Retail_Sales
WHERE
		transactions_id is NULL OR
		sale_date is NULL OR
		sale_time is NULL OR
		customer_id is NULL OR
		gender is NULL OR
		category is NULL OR
		quantity is NULL OR
		price_per_unit is NULL OR
		cogs is NULL OR
		total_sale is NULL;
```

### 3. Data Exploration

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
```sql
SELECT COUNT (*) as total_sales FROM Retail_Sales
SELECT COUNT (DISTINCT customer_id) as total_sales FROM Retail_Sales
SELECT DISTINCT category FROM Retail_Sales
```

### 4. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05'.**
```sql
SELECT *
FROM Retail_Sales
WHERE sale_date = '2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022.**:
```sql
SELECT *
FROM Retail_Sales
Where category = 'clothing' 
	AND
	YEAR(sale_date) = 2022 AND MONTH(sale_date) = 11
	AND
	quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	Category,
	Sum(total_sale) AS net_sale,
	COUNT(*) as total_orders
FROM Retail_Sales
GROUP BY category
```

4. **Write a SQL  query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
	AVG(age) as avg_age
FROM Retail_Sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM Retail_Sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
	category,
	gender, 
	COUNT(*) as total_trans
FROM Retail_Sales
GROUP BY 
	category,
	gender
ORDER BY 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best-selling month in each year.**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
SELECT TOP 5
	customer_id,
	SUM(total_sale) as total_sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY 2 Desc
```

9. **Write a SQL query to find the number of unique customers who purhased items from each category.**:
```sql
SELECT 
	category,
	COUNT(DISTINCT customer_id) as unique_customer
FROM Retail_Sales
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## 5. Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## 6. Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## 7. Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Sandra Nnamdi

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **YouTube**: [Subscribe to my channel for tutorials and insights](https://youtube.com/@techwithsandra?si=PmtHNiN0chXppySJ)
- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/designsbysandra_/#))
- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/nnamdi-s-1540441a4)

Thank you for your support, and I look forward to connecting with you!
