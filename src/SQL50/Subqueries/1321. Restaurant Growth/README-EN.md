# LeetCode SQL – 1321. Restaurant Growth

## Challenge Description

The **"Restaurant Growth"** problem on LeetCode focuses on practicing:

- Common Table Expressions (`WITH`)
- Aggregation with `SUM`
- Window functions
- Rolling (moving) averages
- Sorting results with `ORDER BY`

The problem provides a single table:

### `Customer` Table

| Column | Type |
|------|------|
| customer_id | int |
| name | varchar |
| visited_on | date |
| amount | int |

Each row represents a **customer visit to the restaurant**, including the date of the visit and the amount spent.

---

## Objective

Calculate the **total revenue and average revenue for a rolling 7-day period**.

Rules:

- The calculation must include the **current day and the previous 6 days**
- Only days with **complete 7-day windows** should appear in the result
- The final result must include:

| visited_on | amount | average_amount |

Where:

- `visited_on` → the ending day of the 7-day window
- `amount` → total revenue for those 7 days
- `average_amount` → average daily revenue over the same period

The result must be **ordered by date**.

---

## SQL Solution (Based on My Implementation)

```sql
WITH DailySales AS (
    SELECT 
        visited_on, 
        SUM(amount) AS day_amount
    FROM Customer
    GROUP BY visited_on
),
CalculatedStats AS (

    SELECT 
        visited_on,
        SUM(day_amount) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        AVG(CAST(day_amount AS FLOAT)) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
    FROM DailySales
)

SELECT 
    visited_on, 
    amount, 
    ROUND(average_amount, 2) AS average_amount
FROM CalculatedStats
WHERE row_num >= 7
ORDER BY visited_on;
```

---

## Query Explanation

### Step 1 – Calculating Daily Revenue

```sql
WITH DailySales AS (
```

The first **Common Table Expression (CTE)** calculates the **total amount spent per day**.

```sql
SELECT 
    visited_on, 
    SUM(amount) AS day_amount
FROM Customer
GROUP BY visited_on
```

This groups all rows by `visited_on`.

If multiple customers visited on the same day, their spending is **summed into a single daily value**.

Example result:

| visited_on | day_amount |
|---|---|
| 2020-01-01 | 100 |
| 2020-01-02 | 150 |
| 2020-01-03 | 200 |

---

### Step 2 – Calculating the 7-Day Rolling Total

```sql
SUM(day_amount) OVER (
    ORDER BY visited_on 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
) AS amount
```

This **window function** calculates a **rolling sum over 7 days**.

Explanation:

- `ORDER BY visited_on` ensures the calculation follows chronological order
- `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` includes:
  - The current day
  - The previous **6 days**

So each row represents the **total revenue of the last 7 days**.

---

### Step 3 – Calculating the 7-Day Average

```sql
AVG(CAST(day_amount AS FLOAT)) OVER (
    ORDER BY visited_on 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
)
```

This window function calculates the **average daily revenue within the same 7-day window**.

The `CAST` ensures the result is calculated as a **floating-point number**, allowing decimal values.

---

### Step 4 – Creating a Row Number

```sql
ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
```

This assigns a **sequential number to each row** based on date order.

This helps determine **when a full 7-day window becomes available**.

Example:

| visited_on | row_num |
|---|---|
| Day 1 | 1 |
| Day 2 | 2 |
| Day 3 | 3 |
| ... | ... |

The first valid 7-day calculation appears when `row_num = 7`.

---

### Step 5 – Filtering Only Complete 7-Day Windows

```sql
WHERE row_num >= 7
```

This removes the first six rows because they **do not yet have a full 7-day history**.

Only rows with complete rolling windows remain.

---

### Step 6 – Rounding the Average

```sql
ROUND(average_amount, 2)
```

This rounds the average value to **two decimal places**, matching the problem requirements.

---

### Step 7 – Ordering the Final Result

```sql
ORDER BY visited_on
```

The final result is sorted by date in **ascending order**.

---

## Why This Works

This solution works because:

- The first CTE aggregates **daily totals**
- Window functions compute **rolling sums and averages**
- `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` defines a **7-day window**
- `ROW_NUMBER` ensures incomplete windows are removed
- `ROUND` formats the average correctly

Together, these techniques produce a **moving financial analysis of restaurant revenue**.

---

## Example

If the daily totals were:

| visited_on | day_amount |
|---|---|
| Day 1 | 100 |
| Day 2 | 200 |
| Day 3 | 150 |
| Day 4 | 120 |
| Day 5 | 180 |
| Day 6 | 220 |
| Day 7 | 250 |

Then the first valid row would be:

| visited_on | amount | average_amount |
|---|---|---|
| Day 7 | 1220 | 174.29 |

Because:

- `amount` = sum of Day1 → Day7
- `average_amount` = average of those 7 days

---

## Conclusion

This challenge reinforces several important SQL concepts:

- Using **CTEs** to organize complex queries
- Aggregating daily data
- Applying **window functions**
- Calculating **rolling totals and averages**
- Filtering incomplete windows
- Formatting results

It demonstrates how SQL can perform **time-based analytics and moving averages**, which are very common in financial and business data analysis.