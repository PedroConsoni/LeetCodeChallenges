SELECT p.product_id,
    COALESCE(ROUND(SUM(p.price * u.units) / CAST(SUM(u.units) AS float), 2), 0) as average_price
FROM prices p
LEFT JOIN unitssold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND end_date
GROUP BY p.product_id