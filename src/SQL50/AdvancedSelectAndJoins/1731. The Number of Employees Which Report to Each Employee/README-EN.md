# LeetCode SQL – 1731. The Number of Employees Which Report to Each Employee

## Challenge Description

The **"The Number of Employees Which Report to Each Employee"** problem on LeetCode focuses on:

- Self joins
- Aggregation with `COUNT` and `AVG`
- Grouping with `GROUP BY`
- Type casting
- Ordering results

The problem provides a single table:

### `Employees` Table

| Column       | Type |
|-------------|------|
| employee_id | int  |
| name        | varchar |
| age         | int  |
| reports_to  | int  |

Each row represents an employee.

- `reports_to` references another employee’s `employee_id`
- If `reports_to` is `NULL`, the employee does not report to anyone

This creates a hierarchical relationship within the same table.

---

## Objective

For each manager (an employee who has at least one direct report), return:

- `employee_id`
- `name`
- Number of employees reporting to them (`reports_count`)
- Average age of their direct reports (`average_age`, rounded to the nearest integer)

The result must be ordered by `employee_id`.

Output format:

| employee_id | name | reports_count | average_age |
|-------------|------|---------------|-------------|

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    m.employee_id, 
    m.name, 
    COUNT(e.employee_id) AS reports_count, 
    CAST(ROUND(AVG(CAST(e.age AS FLOAT)), 0) AS INT) AS average_age
FROM Employees e
INNER JOIN Employees m ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;
```

---

## Query Explanation

### Step 1 – Self Join

```sql
FROM Employees e
INNER JOIN Employees m ON e.reports_to = m.employee_id
```

This is a self join because we are joining the `Employees` table to itself.

- `e` represents employees (subordinates)
- `m` represents managers

The condition:

```sql
e.reports_to = m.employee_id
```

Connects each employee to their manager.

Only managers with at least one direct report will appear due to the `INNER JOIN`.

---

### Step 2 – Counting Direct Reports

```sql
COUNT(e.employee_id) AS reports_count
```

Since each joined row represents one reporting employee:

- Counting `e.employee_id` gives the number of direct reports per manager

---

### Step 3 – Calculating Average Age

```sql
CAST(ROUND(AVG(CAST(e.age AS FLOAT)), 0) AS INT) AS average_age
```

Breakdown:

1. `CAST(e.age AS FLOAT)` ensures accurate decimal calculation
2. `AVG(...)` calculates the average age
3. `ROUND(..., 0)` rounds to the nearest integer
4. `CAST(... AS INT)` converts the result back to integer

This guarantees the final value matches the required format.

---

### Step 4 – Grouping by Manager

```sql
GROUP BY m.employee_id, m.name
```

This groups all subordinate records under each manager.

Without `GROUP BY`, aggregation would not work correctly.

---

### Step 5 – Ordering Results

```sql
ORDER BY m.employee_id
```

Ensures the output is sorted by manager ID in ascending order.

---

## Why This Works

- The self join connects employees to their managers
- `COUNT()` calculates how many employees report to each manager
- `AVG()` computes the average age of direct reports
- `ROUND()` ensures correct formatting
- `GROUP BY` organizes aggregation by manager

This solution is efficient and clearly structured.

---

## Example

If the table contains:

| employee_id | name   | age | reports_to |
|-------------|--------|-----|------------|
| 1           | Alice  | 45  | NULL       |
| 2           | Bob    | 30  | 1          |
| 3           | Carol  | 25  | 1          |
| 4           | David  | 40  | NULL       |

### Step-by-step reasoning

Manager 1 (Alice):

Direct reports:
- Bob (30)
- Carol (25)

Reports count = 2  
Average age = (30 + 25) / 2 = 27.5 → Rounded = 28  

Employee 4 has no reports → Not included.

---

## Final Output

| employee_id | name  | reports_count | average_age |
|-------------|-------|---------------|-------------|
| 1           | Alice | 2             | 28          |

---

## Conclusion

This challenge reinforces advanced SQL concepts:

- Self joins
- Hierarchical relationships
- Aggregation with multiple functions
- Type casting and rounding
- Grouped reporting queries

It is an essential exercise for mastering real-world organizational data analysis.