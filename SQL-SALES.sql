SELECT count(*) FROM sales;
SET SQL_SAFE_UPDATES = 0;


#----DATA CLEANING {REMOVING THE NULL ROWS IN THE TABLE}

delete from sales
where transactions_id is null
or sale_date is null or sale_time is  null or customer_id is null or gender is null or category is null or quantiy is null or price_per_unit is null or
cogs is null or total_sale is null;

#--------DATA EMPLORATION---

#--------HOW many sales we have?
SELECT COUNT(*) AS TOTAL_SALE FROM SALES;

#------HOW many customer we have?
SELECT CUSTOMER_ID,COUNT(CUSTOMER_ID) TOTAL_NUMBER ,    COUNT(*) OVER() AS TOTAL_CUSTOMERS
FROM SALES 
GROUP BY CUSTOMER_ID
ORDER BY CUSTOMER_ID;

select count( distinct customer_id) as total from sales;

select category ,count(category) from sales
group by category;

#-------DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWERS

#-----Q1.WRITE A SQL QUERY TO RETRIEVEA LL COLIMS FOR SALES AMADE ON '2022-11-05'
SELECT * FROM SALES
WHERE SALE_DATE = '2022-11-05'
ORDER BY TRANSACTIONS_ID;

SELECT COUNT(SALE_DATE) FROM SALES
WHERE SALE_DATE = '2022-11-05';

#----Q2.WRITE A SQL QUERY TO RETRIEVE ALL TRANSCTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 10 IN THE MONTH OF NOV-2022

SELECT  *    FROM SALES
WHERE CATEGORY ='CLOTHING' AND quantiy >= 4 AND SALE_DATE
 BETWEEN '2022-11-01' AND '2022-11-28'
 order by transactions_id;


#----Q3. Write a SQL query to calculate 
#the total sales (total_sale) for each category.:

SELECT CATEGORY ,sum(total_sale) as  total ,count(total_sale) as totalsales from sales
group by category
order by total desc;


#-----Q4.Write a SQL query to find the average age of customers who purchased
#-------- items from the 'Beauty' category.:

select category,round(avg(age),2) average_age from sales
where category = 'beauty';

#----Q5.Write a SQL query to find all transactions
#----- where the total_sale is greater than 1000.:

SELECT transactions_id,total_sale from sales
where total_sale >=1000
order by transactions_id desc;

#---Q6.Write a SQL query to find the 
#---total number of transactions (transaction_id) made
#-----by each gender in each category.:

SELECT  gender,category ,count(transactions_id) as total_n0_transaction from sales
group by gender,category
order by category;

#----Q7.Write a SQL query to calculate the average sale for each month.
#----- Find out best selling month in each year:

SELECT * from (select year(sale_date) as years,month(sale_date) as months , avg(total_sale) AVGER ,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks
from sales
group by years,months
order by 1, 3 desc ) as t1
where ranks=1
;

#----Q8.**Write a SQL query to find the top 5 customers 
#-----based on the highest total sales **:

SELECT customer_id,sum(total_sale) as total from sales
group by customer_id
order by 2 desc
limit 5;

#------Q9.Write a SQL query to find the number of unique customers 
#---------who purchased items from each category.:

select category ,count(distinct(customer_id)) as no from sales
group by category;


#-----Q10.Write a SQL query to create each shift and number of orders
#----- (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT shift, COUNT(*) AS total_orders
FROM (
  SELECT *,
    CASE
      WHEN HOUR(sale_time) < 12 THEN 'morning'
      WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
      ELSE 'evening'
    END AS shift
  FROM sales
) AS shifted_sales
GROUP BY shift
ORDER BY shift;

#----SQL-PROJECT 2 IS SUCESSFULLY COMPLETED.



