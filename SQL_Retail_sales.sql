create database sql_project ;

use sql_project;

select * from [Retail_Sales ];

select count(*) as total_records from [Retail_Sales ];

select * from [Retail_Sales ]
where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null
	;


	delete from [Retail_Sales ]
	where 
	 transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or 
	gender is null
	or 
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null
	;

	-- How many sales we have?

	select count(*) from [Retail_Sales ];
	
	-- How many uniuque customers we have ?

	select count(distinct customer_id) as unique_customer from [Retail_Sales ];

	-- How many uniuque category  we have ?

	select count (distinct category) as total_category from [Retail_Sales ];


	-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from [Retail_Sales ] where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022



select * from [Retail_Sales ]
		where category= 'Clothing'
			  and 
			  quantiy >=4
			  and 
			  sale_date between '2022-11-01' and '2022-11-30';

								
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(total_sale) as total_sales,category from [Retail_Sales ] group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) as avg_age from [Retail_Sales ] where category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from [Retail_Sales ] where total_sale >1000 ;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transactions_id) as total_transaction ,category, gender  from [Retail_Sales ] 
			group by  gender , category
			order by 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from (select year(sale_date) as year,MONTH(sale_date) as month ,AVG(total_sale) as avg_sale , 
		RANK() over(partition  by year(sale_date) order by AVG(total_sale) desc) as rank 
		from [Retail_Sales ] 
			group by  year(sale_date) ,MONTH(sale_date) ) as t
			where rank =1
			 


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top 5  customer_id ,sum(total_sale) as higest_sale from [Retail_Sales ] group by customer_id
order by sum(total_sale) desc;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category , count(distinct(customer_id)) as unique_customer from [Retail_Sales ] group by category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales 
as (
SELECT *,
       CASE
           WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
           WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS shift
FROM [Retail_Sales ])
select 
shift,count(*) as total_orders from hourly_sales group by shift;
;