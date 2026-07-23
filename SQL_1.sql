-----Data Importing
create table retail_sales(

		transactions_id	 INT PRIMARY KEY,
		sale_date   Date,
		sale_time	Time,
		customer_id INT,
		gender	VARCHAR(20),
		age	    INT,
		category VARCHAR(25),
		quantiy int,
		price_per_unit	float,
		cogs	float,
		total_sale float
)
----Data cleaning
select *
from retail_sales
where transactions_id is null or
	   sale_date is null or
	   sale_time is null or
	   customer_id is null or
	   gender is null or
	   category is null or
	   quantiy is null or
	   price_per_unit is null or
	   cogs is null or
	   total_sale is null

delete ------is used to delete from table

-----------Data Exploration
---------How many sales we have

select count(*) as Sales_count
from retail_sales

------How many customers we have

select count(distinct customer_id) as customer_count
from retail_sales

select count(customer_id) as customer_count
from retail_sales

select distinct category
from retail_sales
------------------Data Analysis and Business Key Problems & Answers----------------------------------------------------------------
----Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select *
from retail_sales
where sale_date = '2022-11-05'

--Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 10 in the month of Nov-2022:

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4
---Write a SQL query to calculate the total sales (total_sale) for each category.:

select category, sum(total_sale) as total_sales
from retail_sales
group by category
order by 2 desc

----Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age), 0) as Customers_Average_age
from retail_sales
where category = 'Beauty'

---Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select *
from retail_sales
where total_sale > 1000

---Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category, gender, count(*) as Total_transactions
from retail_sales
group by category, gender
order by 1 

------Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select *
from retail_sales

with MonthAVG
as (
	select extract(year from sale_date) as year,
		   extract(month from sale_date) as month,
		   Avg(total_sale) as Average_sales,
		   Rank() over (partition by extract(year from sale_date) order by Avg(total_sale) desc) as rank
	from retail_sales
	group by 1, 2
)

select year, month, Average_sales
from MonthAVG
where rank = 1

---**Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id, sum(total_sale) as Total_sales
from retail_sales
group by customer_id
order by 1, Total_sales desc limit 5;

----Write a SQL query to find the number of unique customers who purchased items from each category:
select category, count(distinct customer_id) as UniqueCustomerCount
From retail_sales
group by category

----Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_shift
as(
		select *,
		       case when extract(Hour from sale_time)< 12 then 'Morning'
			        when extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
					else 'evening'
					end as shift
		from retail_sales
		
)
select shift, count(*) as Number_of_orders
From hourly_shift
Group by shift












