# LeetCode SQL – 1327. List the Products Ordered in a Period

## Challenge Description

The **"List the Products Ordered in a Period"** problem on LeetCode focuses on:

- Joining tables with `INNER JOIN`
- Filtering records using `WHERE`
- Aggregating data with `SUM`
- Grouping results using `GROUP BY`
- Filtering aggregated results using `HAVING`

The problem provides two tables.

---

## `Products` Table

| Column | Type |
|------|------|
| product_id | int |
| product_name | varchar |

Each row represents a product available in the store.

---

## `Orders` Table

| Column | Type |
|------|------|
| product_id | int |
| order_date | date |
| unit | int |

Each row represents a purchase of a specific product on a specific date.

The `unit` column represents **how many units of that product were ordered**.

---

## Objective

Return the names of products that:

- Were ordered during **February 2020**
- Have a **total ordered quantity greater than or equal to 100**

The result should include:

- `product_name`
- The **total number of units ordered** (`unit`)

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    p.product_name, 
    SUM(o.unit) AS unit
FROM 
    Products p
INNER JOIN 
    Orders o ON p.product_id = o.product_id
WHERE 
    o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;
```

---

## Query Explanation

### Step 1 – Joining the Tables

```sql
INNER JOIN Orders o ON p.product_id = o.product_id
```

The `INNER JOIN` connects the `Products` and `Orders` tables using `product_id`.

This allows us to access:

- the **product name** from `Products`
- the **order details** from `Orders`

---

### Step 2 – Filtering Orders by Date

```sql
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
```

This condition filters the dataset to include **only orders placed in February 2020**.

The `BETWEEN` operator includes both boundary dates.

---

### Step 3 – Grouping Products

```sql
GROUP BY p.product_name
```

This groups all orders belonging to the same product.

Each product will generate **one row in the final result**.

---

### Step 4 – Summing Ordered Units

```sql
SUM(o.unit)
```

The `SUM` function calculates the **total number of units ordered for each product** during the selected period.

Example:

| product_name | unit |
|--------------|------|
| Keyboard | 40 |
| Keyboard | 70 |

Result:

```
110
```

---

### Step 5 – Filtering Aggregated Results

```sql
HAVING SUM(o.unit) >= 100
```

The `HAVING` clause filters the grouped results.

Only products with **total ordered units greater than or equal to 100** will appear in the output.

---

## Example

### Products

| product_id | product_name |
|------------|-------------|
| 1 | Keyboard |
| 2 | Mouse |
| 3 | Monitor |

### Orders

| product_id | order_date | unit |
|-----------|------------|------|
| 1 | 2020-02-05 | 40 |
| 1 | 2020-02-10 | 70 |
| 2 | 2020-02-15 | 20 |
| 3 | 2020-02-20 | 90 |

---

## Result

| product_name | unit |
|--------------|------|
| Keyboard | 110 |

Explanation:

- Keyboard total units in February = **110**
- Mouse total units = **20**
- Monitor total units = **90**

Only **Keyboard** satisfies the condition `>= 100`.

---

## Why This Works

This solution works because:

- `INNER JOIN` connects products with their orders
- `WHERE` filters orders within the required date range
- `GROUP BY` aggregates orders by product
- `SUM` calculates total units ordered
- `HAVING` filters the aggregated results

---

## Key SQL Concepts Practiced

This challenge reinforces:

- Table joins
- Date filtering
- Aggregate functions
- Group filtering with `HAVING`
- Query structuring for analytical reports

---

## Conclusion

The **List the Products Ordered in a Period** challenge demonstrates how to combine **joins, aggregation, and filtering** to analyze sales data.

These techniques are commonly used in:

- sales analytics
- reporting dashboards
- business intelligence queries