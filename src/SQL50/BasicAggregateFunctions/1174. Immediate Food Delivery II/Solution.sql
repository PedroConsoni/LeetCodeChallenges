WITH primeiroPedidos AS (
    SELECT customer_id,
    MIN(order_date) as primeira_data
    FROM Delivery
    GROUP BY customer_id
)

SELECT
    ROUND(SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0
    / COUNT(*),
    2
    ) AS immediate_percentage
FROM Delivery d
INNER JOIN primeiroPedidos p
ON d.customer_id = p.customer_id
AND d.order_date = p.primeira_data