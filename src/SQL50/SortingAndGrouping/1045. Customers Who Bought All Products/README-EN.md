# LeetCode SQL – 1045. Customers Who Bought All Products

## Challenge Description

The **"Customers Who Bought All Products"** problem on LeetCode focuses on:

- Aggregation with `COUNT`
- Removing duplicates using `DISTINCT`
- Filtering groups with `HAVING`
- Using subqueries
- Comparing aggregated results

The problem provides two tables:

### `Customer` Table

| Column       | Type |
|-------------|------|
| customer_id | int  |
| product_key | int  |

Each row represents a product purchased by a customer.

A customer may appear multiple times because:
- They can buy multiple products
- They may buy the same product more than once

---

### `Product` Table

| Column       | Type |
|-------------|------|
| product_key | int  |

Each row represents a unique product available.

---

## Objective

Return the `customer_id` of customers who bought **all products** listed in the `Product` table.

Output format:

| customer_id |
|-------------|

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    customer_id
FROM 
    Customer
GROUP BY 
    customer_id
HAVING 
    COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
```

---

## Query Explanation

### Step 1 – Grouping by Customer

```sql
GROUP BY customer_id
```

The `GROUP BY` clause groups all purchases by each customer.

This allows us to calculate how many unique products each customer has bought.

---

### Step 2 – Counting Distinct Products per Customer

```sql
COUNT(DISTINCT product_key)
```

- `COUNT()` counts records
- `DISTINCT` removes duplicates

This ensures:

- If a customer bought the same product multiple times, it is counted only once
- We count how many unique products each customer purchased

---

### Step 3 – Counting Total Products

```sql
(SELECT COUNT(*) FROM Product)
```

This subquery calculates the total number of products available.

Since the `Product` table contains unique products:

- `COUNT(*)` returns the total number of different products

---

### Step 4 – Comparing Both Counts

```sql
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)
```

The `HAVING` clause filters grouped results.

We compare:

- Number of unique products bought by the customer
- Total number of products available

If both numbers are equal:

- The customer bought every product

---

## Why This Works

- `GROUP BY` isolates each customer
- `COUNT(DISTINCT ...)` calculates unique purchases
- The subquery retrieves the total number of products
- The `HAVING` clause ensures only complete buyers are returned

This approach is efficient and logically clear.

---

## Example

### Product Table

| product_key |
|-------------|
| 1           |
| 2           |
| 3           |

Total products = 3

### Customer Table

| customer_id | product_key |
|-------------|-------------|
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 2           |

### Step-by-step reasoning

Customer 1:
Unique products bought: 1, 2, 3  
Total = 3 → Matches total products → ✅ Included  

Customer 2:
Unique products bought: 1, 2  
Total = 2 → Does not match total products → ❌ Excluded  

---

## Final Output

| customer_id |
|-------------|
| 1           |

---

## Conclusion

This challenge reinforces important SQL concepts:

- Grouped aggregation
- Eliminating duplicates with `DISTINCT`
- Using subqueries for comparison
- Filtering groups with `HAVING`

It is an excellent exercise for understanding relational division logic in SQL.