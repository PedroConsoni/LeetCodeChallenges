# LeetCode SQL – 584. Find Customer Referee

## Challenge Description

The **"Find Customer Referee"** challenge on LeetCode focuses on practicing the use of **WHERE conditions**, **comparison operators**, and handling **NULL values** in SQL.

The problem provides one table:

### `Customer` Table

| Column      | Type |
|------------|------|
| id         | int  |
| name       | varchar |
| referee_id | int  |

- Each customer may have been referred by another customer.
- The `referee_id` column stores the `id` of the customer who made the referral.
- If a customer was **not referred by anyone**, the `referee_id` will be `NULL`.

---

## Objective

Return the names of customers who:

- **Were not referred by customer with id = 2**
- Or **have no referee at all (NULL)**

The result should contain:

* `name`

---

## SQL Solution (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT name
FROM customer
WHERE referee_id != 2 OR referee_id IS NULL;
```

---

## Query Explanation

### SELECT

```sql
SELECT name
```

Selects the column that must be returned in the final result.

The challenge only requires the `name` field.

---

### FROM

```sql
FROM customer
```

Defines the table from which the data will be retrieved.

---

### WHERE Condition

```sql
WHERE referee_id != 2 OR referee_id IS NULL
```

This is the most important part of the query.

Let’s break it down:

#### `referee_id != 2`

- Filters customers whose referee is **not** customer with `id = 2`.
- However, this condition alone does **not** include `NULL` values.

#### Why?

In SQL:

- Any comparison with `NULL` results in **UNKNOWN**
- And `UNKNOWN` is treated as **false** in a `WHERE` clause

So:

```sql
referee_id != 2
```

Will NOT return rows where `referee_id` is `NULL`.

---

#### `OR referee_id IS NULL`

This part explicitly includes customers who:

- Do not have a referee
- Have `referee_id` equal to `NULL`

Together, the full condition ensures:

- Customers referred by someone other than 2
- Customers not referred by anyone
- Excludes only customers referred by customer with `id = 2`

---

## Example

### Input

| id | name  | referee_id |
|----|-------|------------|
| 1  | Will  | NULL       |
| 2  | Jane  | NULL       |
| 3  | Alex  | 2          |
| 4  | Bill  | NULL       |
| 5  | Zack  | 1          |
| 6  | Mark  | 2          |

---

### Output

| name  |
|-------|
| Will  |
| Jane  |
| Bill  |
| Zack  |

Customers `Alex` and `Mark` are excluded because their `referee_id = 2`.

---

## Key Concepts Reinforced

This challenge reinforces important SQL fundamentals:

* Use of the **WHERE** clause
* Logical operators (**OR**)
* Comparison operators (`!=`)
* Proper handling of **NULL values**
* Understanding SQL’s three-valued logic (TRUE, FALSE, UNKNOWN)

---

## Conclusion

This is a simple but extremely important exercise because it highlights a common SQL pitfall:

> Comparing values with `NULL` using `=` or `!=` does not work as expected.

Understanding how `NULL` behaves is essential for writing correct filters in real-world databases, especially in data engineering and back-end development scenarios.

---