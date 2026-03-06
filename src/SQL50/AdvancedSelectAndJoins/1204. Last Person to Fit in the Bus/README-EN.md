# LeetCode SQL – 1204. Last Person to Fit in the Bus

## Challenge Description

The **"Last Person to Fit in the Bus"** problem on LeetCode focuses on:

- Window functions
- Running totals with `SUM() OVER`
- Ordering rows
- Filtering based on cumulative values
- Limiting results with `TOP`

The problem provides a single table:

### `Queue` Table

| Column | Type |
|------|------|
| person_id | int |
| person_name | varchar |
| weight | int |
| turn | int |

Each row represents a person waiting in a queue to enter a bus.

- `person_id` identifies the person
- `person_name` contains the person's name
- `weight` represents the person's weight
- `turn` indicates the order in which people enter the bus

The bus has a **maximum weight capacity of 1000**.

---

# Objective

Determine **the name of the last person who can enter the bus without exceeding the weight limit**.

People must enter the bus **in the order defined by `turn`**.

---

# SQL Solution (Based on My Implementation)

```sql
WITH WeightSum AS (
    SELECT 
        person_name, 
        SUM(weight) OVER (ORDER BY turn) AS cumulative_weight
    FROM Queue
)
SELECT TOP 1 person_name
FROM WeightSum
WHERE cumulative_weight <= 1000
ORDER BY cumulative_weight DESC;
```

---

# Query Explanation

## Step 1 – Creating a Common Table Expression (CTE)

```sql
WITH WeightSum AS (...)
```

This creates a **Common Table Expression (CTE)**.

The CTE is used to calculate the **cumulative weight of people entering the bus** in the correct order.

---

## Step 2 – Calculating the Running Total

```sql
SUM(weight) OVER (ORDER BY turn)
```

This is a **window function** that calculates a running total.

Explanation:

- `ORDER BY turn` ensures the calculation follows the queue order.
- Each row accumulates the total weight of all previous passengers plus the current one.

Example:

| turn | weight | cumulative_weight |
|----|----|----|
| 1 | 200 | 200 |
| 2 | 300 | 500 |
| 3 | 400 | 900 |
| 4 | 200 | 1100 |

This shows how the total weight grows as more passengers board the bus.

---

## Step 3 – Filtering Valid Passengers

```sql
WHERE cumulative_weight <= 1000
```

This condition ensures we only keep rows where the total weight **does not exceed the bus capacity**.

Any passenger that causes the cumulative weight to exceed **1000** is excluded.

---

## Step 4 – Finding the Last Valid Passenger

```sql
ORDER BY cumulative_weight DESC
```

The rows are ordered from **largest cumulative weight to smallest**.

This means the passenger who fills the bus closest to its limit appears first.

---

## Step 5 – Returning Only One Result

```sql
SELECT TOP 1
```

This returns **only the first row** from the ordered result.

That row corresponds to **the last passenger who can enter the bus without exceeding the weight limit**.

---

# Why This Works

This solution works because it:

- Calculates a **running total of passenger weights**
- Maintains the correct boarding order using `turn`
- Filters out passengers exceeding the weight limit
- Selects the passenger whose cumulative weight is **closest to the maximum capacity**

This guarantees that the returned person is **the last one who can board the bus safely**.

---

# Example

If the table contains:

| person_id | person_name | weight | turn |
|---|---|---|---|
| 1 | Alice | 250 | 1 |
| 2 | Bob | 175 | 2 |
| 3 | Alex | 350 | 3 |
| 4 | John | 400 | 4 |
| 5 | Marie | 200 | 5 |

### Running Total

| person_name | cumulative_weight |
|---|---|
| Alice | 250 |
| Bob | 425 |
| Alex | 775 |
| John | 1175 |
| Marie | 1375 |

The bus limit is **1000**.

John would exceed the limit.

---

### Result

| person_name |
|---|
| Alex |

Alex is the **last person who can enter the bus without exceeding the weight limit**.

---

# Conclusion

This challenge reinforces important SQL concepts such as:

- Window functions
- Running totals using `SUM() OVER`
- Ordering results
- Filtering cumulative values
- Returning limited results with `TOP`

It is a great exercise for understanding how to **analyze sequential data and cumulative constraints using SQL**.