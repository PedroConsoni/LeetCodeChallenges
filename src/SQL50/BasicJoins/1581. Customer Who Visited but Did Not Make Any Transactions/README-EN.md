# LeetCode SQL – 1581. Customer Who Visited but Did Not Make Any Transactions

## Challenge Description

The **"Customer Who Visited but Did Not Make Any Transactions"** challenge on LeetCode focuses on practicing **LEFT JOIN**, **NULL filtering**, and **aggregation with GROUP BY**.

The problem provides two tables:

### `Visits` Table

| Column       | Type |
|--------------|------|
| visit_id     | int  |
| customer_id  | int  |

### `Transactions` Table

| Column         | Type |
|----------------|------|
| transaction_id | int  |
| visit_id       | int  |
| amount         | int  |

- Each row in `Visits` represents a customer visit.
- Each row in `Transactions` represents a transaction made during a visit.
- Some visits may not have any transactions.

---

## Objective

Return:

* `customer_id`
* `count_no_trans`

Where:

- `count_no_trans` represents the number of visits a customer made **without making any transactions**.

---

## SQL Solution

```sql
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans 
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;
```

---

## Query Explanation

### SELECT

```sql
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
```

- `v.customer_id` identifies the customer.
- `COUNT(v.visit_id)` counts how many visits had no transactions.
- `AS count_no_trans` renames the column as required.

---

### FROM

```sql
FROM Visits v
```

Defines `Visits` as the base table.

Since we need to analyze all visits (including those without transactions), it must be the main table.

---

### LEFT JOIN

```sql
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
```

The `LEFT JOIN` ensures:

- All visits are returned.
- Matching transactions are included when they exist.
- If no transaction exists, the columns from `Transactions` will be `NULL`.

---

### WHERE

```sql
WHERE t.transaction_id IS NULL
```

Filters only visits that:

- Do not have a matching transaction.

If `transaction_id` is `NULL`, it means the visit had no transaction.

---

### GROUP BY

```sql
GROUP BY v.customer_id
```

Groups the filtered results by customer.

This allows counting how many no-transaction visits each customer had.

---

## Example

### Input

#### Visits

| visit_id | customer_id |
|----------|------------|
| 1        | 23         |
| 2        | 9          |
| 4        | 30         |
| 5        | 54         |
| 6        | 96         |
| 7        | 54         |
| 8        | 54         |

#### Transactions

| transaction_id | visit_id | amount |
|----------------|----------|--------|
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |

---

### Output

| customer_id | count_no_trans |
|-------------|---------------|
| 30          | 1             |
| 54          | 2             |
| 96          | 1             |

These customers visited but did not complete transactions during those visits.

---

## Key Concepts Reinforced

This challenge reinforces important SQL concepts:

* Use of **LEFT JOIN**
* Filtering unmatched rows using `IS NULL`
* Aggregation with **COUNT()**
* Grouping results using **GROUP BY**
* Combining joins with aggregation

---

## Conclusion

This exercise demonstrates a very common real-world scenario:

Identifying records that exist in one table but not in another.

Understanding how to use `LEFT JOIN` together with `IS NULL` filtering and aggregation is essential for data analysis, reporting, and data engineering tasks.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***