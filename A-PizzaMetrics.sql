------------ A. Pizza Metrics ------------------

1. How many pizzas were ordered?
SELECT COUNT(*) FROM customer_orders

2. How many unique customer orders were made?
SELECT COUNT(DISTINCT customer_id) FROM customer_orders	

3. How many successful orders were delivered by each runner?

SELECT RUNNER_ID, COUNT(*)
		FROM runner_orders 	
			WHERE cancellation NOT LIKE '%cancellation%'
				GROUP BY 1;

4. How many of each type of pizza was delivered?
SELECT p.pizza_name
		, SUM(CASE WHEN C.PIZZA_ID = 1 THEN 1 ELSE 0) AS Meat_Lovers
        , SUM(CASE WHEN C.PIZZA_ID = 2 THEN 1 ELSE 0) AS Vegetarian
		FROM CUSTOMERS_ORDERS C
			INNER JOIN PIZZA_NAMES P ON C.PIZZA_ID = P.PIZZA_ID
				GROUP BY 1

5. How many Vegetarian and Meatlovers were ordered by each customer?
SELECT C.CUSTOMER_ID
		, SUM(CASE WHEN C.PIZZA_ID = 1 THEN 1 ELSE 0) AS Meat_Lovers
        , SUM(CASE WHEN C.PIZZA_ID = 2 THEN 1 ELSE 0) AS Vegetarian
		FROM CUSTOMERS_ORDERS C
			INNER JOIN PIZZA_NAMES P ON C.PIZZA_ID = P.PIZZA_ID
				GROUP BY 1
-
6. What was the maximum number of pizzas delivered in a single order?
SELECT order_id, COUNT(*)
			FROM customer_orders1
				GROUP BY 1
					ORDER BY COUNT(*) DESC
						LIMIT 1

7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?



8. How many pizzas were delivered that had both exclusions and extras?
SELECT COUNT(*) 
		FROM customer_orders1
			WHERE exclusions IS NOT NULL AND extras IS NOT NULL

9. What was the total volume of pizzas ordered for each hour of the day?

SELECT 
    EXTRACT(HOUR FROM order_time) AS hour_of_day, 
    COUNT(*) 
    FROM customer_orders1
		GROUP BY 1
			
    
10. What was the volume of orders for each day of the week?

SELECT 
   DAYNAME(order_time) AS day_of_week, 
    COUNT(*) 
    FROM customer_orders1
		GROUP BY 1
			


