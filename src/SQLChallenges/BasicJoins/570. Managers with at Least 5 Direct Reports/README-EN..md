# LeetCode SQL – 570. Managers with at Least 5 Direct Reports

## Challenge Description

The **"Managers with at Least 5 Direct Reports"** problem on LeetCode focuses on:

- Subqueries
- `GROUP BY`
- `HAVING`
- Aggregation with `COUNT`
- Hierarchical relationships inside the same table

The problem provides a single table:

### `Employee` Table

| Column     | Type |
|------------|------|
| id         | int  |
| name       | varchar |
| department | varchar |
| managerId  | int  |

Each employee may have:

- A `managerId` that references another employee
- Or `NULL` if they do not have a manager

This creates a **self-referencing hierarchy**.

---

## Objective

Return the names of managers who have **at least 5 direct reports**.

Important:

- Only direct reports count
- We must return the manager's `name`, not their `id`

---

## SQL Solution (Based on My Implementation)

```sql
SELECT name
FROM employee
WHERE id IN (
    SELECT managerId
    FROM employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);
```

---

## Query Explanation

### Step 1 – Subquery

```sql
SELECT managerId
FROM employee
GROUP BY managerId
HAVING COUNT(*) >= 5
```

This subquery:

1. Groups employees by `managerId`
2. Counts how many employees report to each manager
3. Keeps only those with **5 or more direct reports**

---

### Step 2 – Filtering Managers

```sql
WHERE id IN (...)
```

The outer query:

- Selects employees whose `id` appears in the subquery result
- These are the managers with at least 5 direct reports

Since we select `name`, the final result contains the manager names.

---

## Why This Works

- Every employee row represents one direct report
- Grouping by `managerId` counts how many employees report to each manager
- `HAVING COUNT(*) >= 5` filters managers with enough reports
- `IN` links those manager IDs back to their names

---

## Example

If manager `1` has 5 employees reporting to them:

| id | name | managerId |
|----|------|----------|
| 2  | A    | 1        |
| 3  | B    | 1        |
| 4  | C    | 1        |
| 5  | D    | 1        |
| 6  | E    | 1        |

Manager `1` will appear in the result.

---

## Conclusion

This challenge reinforces:

- Subqueries
- Aggregation with `GROUP BY`
- Filtering with `HAVING`
- Understanding hierarchical relationships
- Counting related records inside the same table

It is a fundamental SQL exercise for mastering relational data structures.