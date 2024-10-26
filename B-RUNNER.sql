--------------------- B. Runner and Customer Experience -----------------------------


1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT *
	, FLOOR(DATEDIFF(registration_date, '2021-01-01') / 7) + 1 FROM RUNNERS


2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to 
pickup the order?

SELECT RUNNER_ID, ROUND(AVG(TIMESTAMPDIFF(SECOND, C.order_time, RO.pickup_time) / 60.00),2)
		FROM runner_orders RO
			INNER JOIN customer_orders1 C ON C.ORDER_ID = RO.ORDER_ID
				GROUP BY 1

3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

SELECT C.ORDER_ID, COUNT(*) AS PIZZA_COUNT,
		ROUND(MAX(TIMESTAMPDIFF(MINUTE, C.order_time, RO.pickup_time)),2) AS PREP_TIME
		FROM RUNNER_ORDERS RO INNER JOIN customer_orders1 C 
			ON RO.ORDER_ID = C.ORDER_ID
				WHERE DISTANCE NOT LIKE 'NULL'
					GROUP BY 1
						ORDER BY PREP_TIME DESC

4. What was the average distance travelled for each customer?

SELECT c.CUSTOMER_ID, ROUND(avg(REPLACE(RO.distance, 'km', '')),2)
		FROM customer_orders1 C INNER JOIN RUNNER_ORDERS RO
				ON C.ORDER_ID = RO.ORDER_ID
					GROUP BY 1

5. What was the difference between the longest and shortest delivery times for all orders?

SELECT MAX(REPLACE(REPLACE(REPLACE(duration, 'minutes', ''), 'mins', ''), 'minute', ''))
 - MIN(REPLACE(REPLACE(REPLACE(duration, 'minutes', ''), 'mins', ''), 'minute', ''))
FROM RUNNER_ORDERS
WHERE DURATION <> 'null'

6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

SELECT RUNNER_ID
		, ROUND(AVG(REPLACE(DISTANCE, 'km', '')
			/ REPLACE(REPLACE(REPLACE(duration, 'minutes', ''), 'mins', ''), 'minute', '')),2) AS SPEED
				FROM RUNNER_ORDERS
					WHERE DISTANCE NOT in ('null')
						group by 1

7. What is the successful delivery percentage for each runner?

WITH SUCCESSFUL_DELIVERY AS(SELECT RUNNER_ID
 , COUNT(*) AS SUCCESS
FROM RUNNER_ORDERS WHERE CANCELLATION IS NOT NULL AND PICKUP_TIME NOT LIKE 'NULL'
GROUP BY 1)

, TOTAL_DELIVERIES AS(SELECT RUNNER_ID
 , COUNT(*) AS TOTAL
FROM RUNNER_ORDERS 
GROUP BY 1)

SELECT TD.RUNNER_ID, CONCAT (ROUND(SUCCESS * 100.00 / TOTAL, 2), ' %') AS SUCCESS_RATE
FROM TOTAL_DELIVERIES TD INNER JOIN SUCCESSFUL_DELIVERY SD
ON TD.RUNNER_ID = SD.RUNNER_ID

------------------- C. Ingredient Optimisation ------------------------

1. What was the most common exclusion?
SELECT EXCLUSIONS
FROM customer_orders1 
WHERE EXCLUSIONS NOT IN ('', 'NULL')
GROUP BY 1
ORDER BY COUNT(EXCLUSIONS) DESC
LIMIT 1

2. What was the most commonly added extra?
SELECT EXTRAS
FROM customer_orders1 
WHERE EXTRAS NOT IN ('', 'NULL')
GROUP BY 1
ORDER BY COUNT(EXTRAS) DESC
LIMIT 1
