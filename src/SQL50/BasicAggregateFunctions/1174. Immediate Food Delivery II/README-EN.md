# LeetCode SQL – 1174. Immediate Food Delivery II

## Challenge Description

The **"Immediate Food Delivery II"** problem on LeetCode focuses on:

- Common Table Expressions (CTE)
- Aggregate functions (`MIN`, `COUNT`, `SUM`)
- Conditional logic with `CASE WHEN`
- Percentage calculations
- Rounding with `ROUND`
- Filtering first records per group

The problem provides a single table:

---

### `Delivery` Table

| Column                      | Type |
|-----------------------------|------|
| delivery_id                 | int  |
| customer_id                 | int  |
| order_date                  | date |
| customer_pref_delivery_date | date |

Each row represents a delivery order, including:

- The customer who made the order
- The date the order was placed
- The customer’s preferred delivery date

---

## Objective

Calculate the percentage of customers whose **first order** was delivered on their **preferred delivery date**.

The result must be:

- Returned as `immediate_percentage`
- Rounded to **2 decimal places**

---

## SQL Solution (Based on My Implementation)

```sql
WITH primeiroPedidos AS (
    SELECT customer_id,
    MIN(order_date) as primeira_data
    FROM Delivery
    GROUP BY customer_id
)

SELECT
    ROUND(
        SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS immediate_percentage
FROM Delivery d
INNER JOIN primeiroPedidos p
ON d.customer_id = p.customer_id
AND d.order_date = p.primeira_data;
```

---

## Query Explanation

### Step 1 – Identifying Each Customer's First Order (CTE)

```sql
WITH primeiroPedidos AS (
    SELECT customer_id,
    MIN(order_date) as primeira_data
    FROM Delivery
    GROUP BY customer_id
)
```

This CTE:

- Groups orders by `customer_id`
- Uses `MIN(order_date)` to find each customer's first order date

Result:

- One row per customer
- The earliest order date for each customer

---

### Step 2 – Joining Back to the Delivery Table

```sql
INNER JOIN primeiroPedidos p
ON d.customer_id = p.customer_id
AND d.order_date = p.primeira_data
```

This ensures we:

- Select only the first order of each customer
- Exclude all subsequent orders

Now the dataset contains exactly one row per customer (their first order).

---

### Step 3 – Checking If the Delivery Was Immediate

```sql
CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END
```

Logic:

- If the order date equals the preferred delivery date → immediate (return 1)
- Otherwise → not immediate (return 0)

---

### Step 4 – Calculating the Percentage

```sql
SUM(...) * 100.0 / COUNT(*)
```

Explanation:

- `SUM(...)` counts how many first orders were immediate
- `COUNT(*)` counts total first orders
- `100.0` ensures decimal division
- The result is converted into a percentage

---

### Step 5 – Rounding the Result

```sql
ROUND(..., 2)
```

Ensures:

- The result has exactly **2 decimal places**
- Matches the problem requirement

---

## Why This Works

- The CTE isolates the first order per customer
- The `JOIN` filters only those first orders
- `CASE WHEN` converts logical conditions into numeric values
- `SUM / COUNT` calculates the proportion
- `100.0` prevents integer division
- `ROUND` formats the final percentage correctly

Each component directly satisfies a requirement of the problem.

---

## Example

### Delivery Table

| delivery_id | customer_id | order_date  | customer_pref_delivery_date |
|------------|------------|------------|-----------------------------|
| 1          | 1          | 2023-01-01 | 2023-01-01                  |
| 2          | 1          | 2023-01-02 | 2023-01-02                  |
| 3          | 2          | 2023-01-05 | 2023-01-06                  |
| 4          | 3          | 2023-01-07 | 2023-01-07                  |

---

### First Orders Only

- Customer 1 → 2023-01-01 → Immediate
- Customer 2 → 2023-01-05 → Not immediate
- Customer 3 → 2023-01-07 → Immediate

Immediate = 2  
Total customers = 3  

Percentage:

```
(2 / 3) × 100 = 66.67%
```

---

## Conclusion

This challenge reinforces:

- Using CTEs to isolate first records
- Applying `MIN` for earliest values
- Conditional aggregation techniques
- Percentage calculation logic
- Avoiding integer division
- Clean reporting with `ROUND`

It is a great exercise for mastering analytical SQL patterns involving first-event analysis.