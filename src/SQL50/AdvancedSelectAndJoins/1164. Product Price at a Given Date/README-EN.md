# LeetCode SQL – 1164. Product Price at a Given Date

## Challenge Description

The **"Product Price at a Given Date"** problem on LeetCode focuses on:

- Common Table Expressions (`WITH`)
- Window functions
- Ranking rows using `RANK()`
- Filtering data by date
- Combining result sets using `UNION`

The problem provides a single table:

### `Products` Table

| Column | Type |
|------|------|
| product_id | int |
| new_price | int |
| change_date | date |

Each row represents a **price change event** for a product.

- `product_id` identifies the product
- `new_price` represents the updated price
- `change_date` indicates when the price change occurred

If a product **does not have a price recorded before the given date**, its default price is **10**.

---

# Objective

Find the **price of each product on the date `2019-08-16`**.

Rules:

1. If a product had multiple price changes before that date, we must select the **most recent price change before or on `2019-08-16`**.
2. If a product **did not have any price change before that date**, its price should be **10**.

The final result must include:

- `product_id`
- `price`

---

# SQL Solution (Based on My Implementation)

```sql
WITH PrecosRecentes AS (
    SELECT 
        product_id, 
        new_price,
        RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) as rnk
    FROM Products
    WHERE change_date <= '2019-08-16'
)

SELECT product_id, new_price AS price
FROM PrecosRecentes
WHERE rnk = 1

UNION

SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';
```

---

# Query Explanation

## Step 1 – Creating a Common Table Expression (CTE)

```sql
WITH PrecosRecentes AS (...)
```

This creates a **Common Table Expression (CTE)**.

A CTE works like a temporary result set that can be referenced later in the query.

In this case, it is used to identify the **most recent price change for each product before the target date**.

---

## Step 2 – Filtering Price Changes Before the Target Date

```sql
WHERE change_date <= '2019-08-16'
```

This condition ensures that we only consider price changes that happened **on or before the target date**.

Any price changes after this date are ignored.

---

## Step 3 – Ranking Price Changes Per Product

```sql
RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC)
```

This window function assigns a **ranking to price changes for each product**.

Explanation:

- `PARTITION BY product_id` → separates rows by product
- `ORDER BY change_date DESC` → sorts price changes from most recent to oldest

The **most recent price change before the given date receives rank 1**.

---

## Step 4 – Selecting the Most Recent Price

```sql
WHERE rnk = 1
```

This filters the CTE result and returns only the **most recent price change for each product**.

The column is renamed to `price`.

---

## Step 5 – Handling Products Without Price Changes Before the Date

```sql
HAVING MIN(change_date) > '2019-08-16'
```

Some products may not have any price change before the target date.

This condition identifies those products.

If the earliest recorded price change happens **after the target date**, then the product had no valid price yet.

According to the problem rules, those products should have the **default price of 10**.

---

## Step 6 – Combining Both Results

```sql
UNION
```

The `UNION` operator combines:

1. Products with valid price updates before the target date
2. Products that should receive the **default price**

This ensures every product appears in the final result.

---

# Why This Works

This solution correctly handles the two scenarios required by the problem:

### Case 1 — Product has price changes before the date

- The window function identifies the **latest valid price**.
- Filtering with `rnk = 1` retrieves that price.

### Case 2 — Product has no price change before the date

- The `HAVING` clause identifies those products.
- The query assigns them the **default price of 10**.

By combining both results with `UNION`, the query ensures that **every product receives the correct price**.

---

# Example

If the table contains:

| product_id | new_price | change_date |
|---|---|---|
| 1 | 20 | 2019-08-14 |
| 2 | 50 | 2019-08-14 |
| 1 | 30 | 2019-08-15 |
| 1 | 35 | 2019-08-16 |
| 2 | 65 | 2019-08-17 |
| 3 | 20 | 2019-08-18 |

### Analysis

- Product **1** → latest price before or on `2019-08-16` = **35**
- Product **2** → latest price before `2019-08-16` = **50**
- Product **3** → no price before that date → **default price = 10**

---

### Result

| product_id | price |
|---|---|
| 1 | 35 |
| 2 | 50 |
| 3 | 10 |

---

# Conclusion

This challenge reinforces several important SQL concepts:

- Using **CTEs (`WITH`)**
- Applying **window functions**
- Ranking rows with `RANK()`
- Filtering by date conditions
- Combining datasets using `UNION`

It is a valuable exercise for learning how to **retrieve the latest valid records and handle missing historical data in SQL**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***