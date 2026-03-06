# LeetCode SQL – 185. Department Top Three Salaries

## Challenge Description

The **"Department Top Three Salaries"** problem on LeetCode focuses on:

- Using **window functions**
- Ranking values with **DENSE_RANK**
- Partitioning data with **PARTITION BY**
- Joining tables with **JOIN**
- Filtering ranked results

The problem provides two tables:

### `Employee` Table

| Column       | Type |
|--------------|------|
| Id           | int  |
| Name         | varchar |
| Salary       | int  |
| DepartmentId | int  |

Each row represents an **employee**, including their salary and the department they belong to.

---

### `Department` Table

| Column | Type |
|------|------|
| Id   | int  |
| Name | varchar |

Each row represents a **department** in the company.

---

## Objective

Return the **top three highest salaries in each department**.

The result must include:

- `Department` → Department name
- `Employee` → Employee name
- `Salary` → Employee salary

If multiple employees have the **same salary**, they must **share the same rank**.

---

## SQL Solution (Based on My Implementation)

```sql
WITH SalariosRankeados AS (
    SELECT 
        d.Name AS Department,
        e.Name AS Employee,
        e.Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.DepartmentId 
            ORDER BY e.Salary DESC
        ) AS rnk
    FROM Employee e
    JOIN Department d ON e.DepartmentId = d.Id
)
SELECT 
    Department, 
    Employee, 
    Salary
FROM SalariosRankeados
WHERE rnk <= 3;
```

---

## Query Explanation

### Step 1 – Joining the Tables

```sql
JOIN Department d ON e.DepartmentId = d.Id
```

The `Employee` table contains the department ID, but not the department name.

To retrieve the department name, we perform a **JOIN** with the `Department` table.

This allows us to include:

- Employee name
- Salary
- Department name

---

### Step 2 – Using a Window Function for Ranking

```sql
DENSE_RANK() OVER (
    PARTITION BY e.DepartmentId 
    ORDER BY e.Salary DESC
)
```

The `DENSE_RANK()` function assigns a **rank based on salary order**.

Key details:

- `PARTITION BY e.DepartmentId` resets the ranking **for each department**
- `ORDER BY e.Salary DESC` ensures **higher salaries receive better ranks**

Example ranking:

| Employee | Salary | Rank |
|--------|--------|------|
| A      | 90000  | 1 |
| B      | 85000  | 2 |
| C      | 85000  | 2 |
| D      | 80000  | 3 |

Notice that employees with the same salary **share the same rank**.

---

### Step 3 – Storing Results in a CTE

```sql
WITH SalariosRankeados AS (...)
```

A **Common Table Expression (CTE)** is used to store the intermediate results.

The CTE contains:

- Department
- Employee
- Salary
- Rank (`rnk`)

This makes the final filtering step much simpler.

---

### Step 4 – Filtering the Top Three Salaries

```sql
WHERE rnk <= 3
```

This condition ensures we only return employees whose salary rank is:

- 1
- 2
- 3

Because `DENSE_RANK` is used, ties in salary **do not skip ranking numbers**.

This means multiple employees may appear if they share one of the top three salaries.

---

## Why This Works

This solution is effective because:

- `DENSE_RANK` properly handles **salary ties**
- `PARTITION BY` ensures ranking is calculated **within each department**
- The **CTE improves readability**
- The final filtering step becomes simple and clean

This is the standard SQL approach for solving **top N per group problems**.

---

## Example

### Employee Table

| Id | Name | Salary | DepartmentId |
|----|------|--------|--------------|
| 1 | Joe | 85000 | 1 |
| 2 | Henry | 80000 | 2 |
| 3 | Sam | 60000 | 2 |
| 4 | Max | 90000 | 1 |
| 5 | Janet | 69000 | 1 |
| 6 | Randy | 85000 | 1 |
| 7 | Will | 70000 | 1 |

### Department Table

| Id | Name |
|----|------|
| 1 | IT |
| 2 | Sales |

### Result

| Department | Employee | Salary |
|------------|---------|--------|
| IT | Max | 90000 |
| IT | Joe | 85000 |
| IT | Randy | 85000 |
| IT | Will | 70000 |
| Sales | Henry | 80000 |
| Sales | Sam | 60000 |

Employees are selected based on the **top three salaries within each department**.

---

## Conclusion

This challenge reinforces important SQL concepts:

- **Window functions**
- **DENSE_RANK**
- **Partitioning data**
- **Joining relational tables**
- **Top-N queries per group**

It is a classic SQL problem used to practice **ranking and analytical queries**.