# LeetCode SQL – 1484. Group Sold Products By The Date

## Challenge Description

The **"Group Sold Products By The Date"** problem on LeetCode focuses on:

- Filtering and grouping data
- Removing duplicates with `DISTINCT`
- Using aggregate functions like `COUNT`
- Aggregating strings with `STRING_AGG`
- Sorting results with `ORDER BY`

The problem provides a single table.

---

## `Activities` Table

| Column | Type |
|------|------|
| sell_date | date |
| product | varchar |

Each row represents a product that was sold on a specific date.

However, the same product may appear **multiple times on the same date**, meaning duplicates can exist.

---

## Objective

For **each `sell_date`**, return:

- The number of **distinct products sold** (`num_sold`)
- A **comma-separated list of products** sold on that date (`products`)

Additional requirements:

- Products must be **unique**
- Products must be **sorted alphabetically**
- The result must be **ordered by `sell_date`**

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STRING_AGG(product, ',') WITHIN GROUP (ORDER BY product ASC) AS products
FROM (
    SELECT DISTINCT sell_date, product
    FROM Activities
) AS DistinctActivities
GROUP BY 
    sell_date
ORDER BY 
    sell_date;
```

---

## Query Explanation

### Step 1 – Removing Duplicate Products Per Date

```sql
SELECT DISTINCT sell_date, product
FROM Activities
```

The `DISTINCT` keyword ensures that **each product appears only once per date**.

Example dataset:

| sell_date | product |
|----------|--------|
| 2020-05-30 | Headphone |
| 2020-05-30 | Headphone |

Without using `DISTINCT`, duplicates would remain and affect the final aggregation.

---

### Step 2 – Creating a Subquery

```sql
FROM (
    SELECT DISTINCT sell_date, product
    FROM Activities
) AS DistinctActivities
```

The subquery generates a **temporary result set** where duplicates have already been removed.

This ensures that the aggregation in the outer query works with **clean data**.

---

### Step 3 – Counting Unique Products

```sql
COUNT(DISTINCT product) AS num_sold
```

This counts how many **different products were sold on each date**.

Example:

Products on a specific date:

```
Headphone
Keyboard
Mouse
```

Result:

```
num_sold = 3
```

---

### Step 4 – Aggregating Products Into a String

```sql
STRING_AGG(product, ',')
```

The `STRING_AGG` function concatenates multiple rows into a **single comma-separated string**.

Example:

Rows:

| product |
|------|
| Headphone |
| Keyboard |
| Mouse |

Result:

```
Headphone,Keyboard,Mouse
```

---

### Step 5 – Ordering Products Alphabetically

```sql
WITHIN GROUP (ORDER BY product ASC)
```

This ensures that products appear **alphabetically** inside the aggregated string.

Correct order:

```
Headphone,Keyboard,Mouse
```

Instead of:

```
Mouse,Headphone,Keyboard
```

---

### Step 6 – Grouping by Date

```sql
GROUP BY sell_date
```

This groups all rows that share the same `sell_date`.

Each date becomes **one row in the final result**.

---

### Step 7 – Sorting the Final Result

```sql
ORDER BY sell_date
```

This sorts the results **chronologically** from the earliest date to the latest.

---

## Example

If the table contains:

| sell_date | product |
|----------|--------|
| 2020-05-30 | Headphone |
| 2020-05-30 | Keyboard |
| 2020-05-30 | Headphone |
| 2020-06-01 | Pencil |
| 2020-06-01 | Pencil |
| 2020-06-01 | Eraser |

---

## After Removing Duplicates

| sell_date | product |
|----------|--------|
| 2020-05-30 | Headphone |
| 2020-05-30 | Keyboard |
| 2020-06-01 | Pencil |
| 2020-06-01 | Eraser |

---

## Final Result

| sell_date | num_sold | products |
|----------|----------|----------|
| 2020-05-30 | 2 | Headphone,Keyboard |
| 2020-06-01 | 2 | Eraser,Pencil |

Explanation:

- **2020-05-30**
  - Products sold: Headphone, Keyboard
  - Total unique products: **2**

- **2020-06-01**
  - Products sold: Eraser, Pencil
  - Total unique products: **2**

---

## Why This Works

This solution works because:

- `DISTINCT` removes duplicate `(sell_date, product)` pairs
- `COUNT(DISTINCT product)` calculates the number of unique products
- `STRING_AGG` combines multiple rows into a single string
- `WITHIN GROUP (ORDER BY ...)` guarantees alphabetical ordering
- `GROUP BY sell_date` groups all sales by date

---

## Key SQL Concepts Practiced

This challenge reinforces several important SQL concepts:

- Removing duplicates with `DISTINCT`
- Aggregating values with `COUNT`
- Concatenating rows with `STRING_AGG`
- Grouping results with `GROUP BY`
- Sorting outputs with `ORDER BY`

---

## Conclusion

The **Group Sold Products By The Date** challenge is a great exercise for practicing **SQL aggregation and grouping techniques**.

It demonstrates how to:

- Clean duplicated datasets
- Perform grouped aggregations
- Generate formatted outputs using string aggregation

These techniques are widely used in **data analysis, reporting queries, and analytics pipelines**, making this problem highly relevant in real-world SQL scenarios.