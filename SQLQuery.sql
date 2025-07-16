select * from pizza_sales


-- TOTAL REVENUE GENERATED 
select 
sum(total_price) as Total_Revenue
from pizza_sales


-- AVERAGE ORDER VALUE (REVENUE/NO.OF ORDERS)
select 
((sum(total_price))/count(distinct order_id)) as Avg_OrderValue
from pizza_sales


-- TOTAL PIZZA SOLD
select 
sum(quantity) as Total_PizzaSold
from pizza_sales


-- TOTAL ORDERS 
select 
count(distinct order_id) as Total_Orders
from pizza_sales


-- AVERAGE PIZZA PER ORDER (NO. OF PIZZA SOLD/NO. OF ORDERS)
select 
cast(cast(sum(quantity)as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_PizzaPerOrder
from pizza_sales


-- DAILY TREND FOR TOTAL ORDERS 
select format(order_date,'dddd') as Day_Name,
count(distinct order_id) as Total_Orders
from pizza_sales
group by format(order_date,'dddd') order by Total_Orders Desc


-- MONTHLY TREND FOR TOTAL ORDERS
select format(order_date,'MMMM') as Month_Name,
count(distinct order_id) as Total_Orders
from pizza_sales
group by format(order_date,'MMMM') order by Total_Orders Desc


-- PERCENTAGE OF SALES BY PIZZA CATEGORY 
select 
(sum(total_price)/
(select 
sum(total_price)from pizza_sales
where month(order_date) =1 ))*100 as Total_percentage,
pizza_category
from pizza_sales
where month(order_date) =1
group by pizza_category order by Total_percentage desc 
/* CONCEPT OF SUBQUERRY USED*/


-- PERCENTAGE OF SALES BY PIZZA SIZE
select 
round((sum(total_price)/
(select 
sum(total_price)from pizza_sales where datepart(quarter,order_date)=1))*100,2) as Total_percentage,
pizza_size
from pizza_sales
where datepart(quarter,order_date)=1 
group by pizza_size order by Total_percentage desc


-- TOP 5 BEST SALLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS
select top 5
sum(total_price) as REVENUE,pizza_name
from pizza_sales
group by pizza_name order by REVENUE desc 

select top 5
sum(quantity) as total_quantity,pizza_name
from pizza_sales
group by pizza_name order by total_quantity desc 

select top 5
count(distinct order_id) as total_orders,pizza_name
from pizza_sales
group by pizza_name order by total_orders desc 
