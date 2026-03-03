# LeetCode SQL – 1070. Product Sales Analysis III

## Challenge Description

The **"Product Sales Analysis III"** problem on LeetCode focuses on:

- Common Table Expressions (`WITH`)
- Window functions
- Ranking with `RANK()`
- Partitioning data with `PARTITION BY`
- Ordering with `ORDER BY`

The problem provides a single table:

### `Sales` Table

| Column      | Type |
|------------|------|
| product_id | int  |
| year       | int  |
| quantity   | int  |
| price      | int  |

Each row represents the sales information of a product in a specific year.

A product may appear multiple times because:
- It can have sales records in multiple years

---

## Objective

For each `product_id`, return:

- The **first year** the product was sold
- The `quantity` sold in that year
- The `price` in that year

The output format:

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|

---

## SQL Solution (Based on My Implementation)

```sql
WITH RankedSales AS ( 
    SELECT 
        product_id, 
        year AS first_year, 
        quantity, 
        price,
        RANK() OVER(PARTITION BY product_id ORDER BY year ASC) as rn
    FROM Sales
)
SELECT 
    product_id, 
    first_year, 
    quantity, 
    price
FROM RankedSales
WHERE rn = 1;
```

---

## Query Explanation

### Step 1 – Creating a Common Table Expression (CTE)

```sql
WITH RankedSales AS ( ... )
```

The `WITH` clause creates a temporary result set called `RankedSales`.

This improves:

- Readability
- Logical separation of ranking logic from filtering logic

---

### Step 2 – Applying the Window Function

```sql
RANK() OVER(PARTITION BY product_id ORDER BY year ASC)
```

This is the core of the solution.

- `PARTITION BY product_id` separates data by product
- `ORDER BY year ASC` sorts each product’s records from oldest to newest
- `RANK()` assigns a ranking number within each product group

The earliest year for each product receives `rn = 1`.

---

### Step 3 – Renaming the Year Column

```sql
year AS first_year
```

We rename `year` to `first_year` to match the required output format and clarify meaning.

---

### Step 4 – Filtering Only the First Year

```sql
WHERE rn = 1
```

This condition ensures that:

- Only the earliest sales record for each product is returned
- All other ranked rows are excluded

---

## Why This Works

- `PARTITION BY` isolates each product
- `ORDER BY year ASC` ensures chronological ranking
- `RANK()` correctly identifies the first sale year
- The CTE separates ranking logic from final filtering

This approach is efficient and scalable for large datasets.

---

## Example

If the table contains:

| product_id | year | quantity | price |
|------------|------|----------|-------|
| 1          | 2018 | 10       | 100   |
| 1          | 2019 | 15       | 120   |
| 2          | 2017 | 5        | 200   |
| 2          | 2018 | 8        | 210   |

### Step-by-step reasoning

### Product 1:
Years: 2018, 2019  
Earliest year: 2018  
Quantity: 10  
Price: 100  

### Product 2:
Years: 2017, 2018  
Earliest year: 2017  
Quantity: 5  
Price: 200  

---

## Final Output

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|
| 1          | 2018       | 10       | 100   |
| 2          | 2017       | 5        | 200   |

---

## Conclusion

This challenge reinforces important SQL concepts:

- Window functions
- Ranking with `RANK()`
- Partitioning data
- Using CTEs for cleaner queries
- Filtering based on window function results

It is a fundamental exercise for mastering analytical SQL queries.