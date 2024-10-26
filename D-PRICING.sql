----------------- D. Pricing and Ratings----------------------

1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no 
charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

SELECT SUM(CASE WHEN C.PIZZA_ID = 1 THEN 12 ELSE 10 end) AS total_revenue
		FROM customer_orders1 C
			INNER JOIN PIZZA_NAMES P ON C.PIZZA_ID = P.PIZZA_ID
				
2. What if there was an additional $1 charge for any pizza extras? Add cheese is $1 extra



3.If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for 
extras and each runner is paid $0.30 per kilometre traveled - how much money does 
Pizza Runner have left over after these deliveries?
SELECT 
	SUM(CASE WHEN C.PIZZA_ID = 1 THEN 12 ELSE 10 end) - (SELECT SUM(DISTANCE * 0.30) 
								FROM RUNNER_ORDERS WHERE cancellation IS NULL)
    AS total_revenue
		FROM customer_orders1 C
			INNER JOIN PIZZA_NAMES P ON C.PIZZA_ID = P.PIZZA_ID
	

