# LeetCode SQL – 1789. Primary Department for Each Employee

## Challenge Description

The **"Primary Department for Each Employee"** problem on LeetCode focuses on:

- Filtering with `WHERE`
- Aggregation using `GROUP BY`
- Using `HAVING` with aggregate functions
- Combining results with `UNION`
- Understanding conditional logic in SQL

The problem provides a single table:

### `Employee` Table

| Column | Type |
|------|------|
| employee_id | int |
| department_id | int |
| primary_flag | varchar |

Each row represents an employee assigned to a department.

- `employee_id` identifies the employee
- `department_id` identifies the department
- `primary_flag` indicates if the department is the **primary department**

Possible values for `primary_flag`:

- `'Y'` → Primary department  
- `'N'` → Not the primary department

An employee can belong to **multiple departments**, but only one of them can be the **primary department**.

---

# Objective

Return the **primary department for each employee**.

Rules:

1. If an employee belongs to **only one department**, that department is automatically their primary department.
2. If an employee belongs to **multiple departments**, the row where `primary_flag = 'Y'` must be returned.

The final result must include:

- `employee_id`
- `department_id`

---

# SQL Solution (Based on My Implementation)

```sql
SELECT 
    employee_id, 
    department_id
FROM 
    Employee
WHERE 
    employee_id IN (
        SELECT employee_id 
        FROM Employee 
        GROUP BY employee_id 
        HAVING COUNT(*) = 1
    )

UNION

SELECT 
    employee_id, 
    department_id
FROM 
    Employee
WHERE 
    primary_flag = 'Y';
```

---

# Query Explanation

## Step 1 – Finding Employees With Only One Department

```sql
SELECT employee_id 
FROM Employee 
GROUP BY employee_id 
HAVING COUNT(*) = 1
```

This subquery groups the table by `employee_id`.

```sql
GROUP BY employee_id
```

This groups all rows belonging to the same employee.

Then we count how many department records each employee has:

```sql
COUNT(*)
```

The condition:

```sql
HAVING COUNT(*) = 1
```

Filters only employees who belong to **exactly one department**.

If an employee appears only once in the table, that department must be their **primary department**.

---

## Step 2 – Returning Those Employees

```sql
WHERE employee_id IN (...)
```

This condition filters the `Employee` table and returns the rows for employees who appear in the subquery result.

These employees have **only one department**, so that department is returned.

---

## Step 3 – Selecting Employees With an Explicit Primary Department

```sql
WHERE primary_flag = 'Y'
```

For employees who belong to **multiple departments**, the table includes a flag indicating which one is the **primary department**.

This condition selects only the row where the flag is `'Y'`.

---

## Step 4 – Combining Both Results

```sql
UNION
```

The `UNION` operator combines the results of the two queries.

It ensures that the final output contains:

1. Employees with **only one department**
2. Employees with **multiple departments**, but only their **primary department**

`UNION` also removes duplicates automatically.

---

# Why This Works

This solution handles both possible cases in the dataset.

### Case 1 — Employee has only one department

- The `GROUP BY` with `HAVING COUNT(*) = 1` identifies these employees.
- Since there is only one department, that department must be the primary one.

### Case 2 — Employee has multiple departments

- The column `primary_flag` identifies which department is the main one.
- Filtering with `primary_flag = 'Y'` returns the correct department.

Using `UNION`, we combine both cases and guarantee that **each employee returns exactly one department**.

---

# Example

If the table contains:

| employee_id | department_id | primary_flag |
|--------------|--------------|--------------|
| 1 | 1 | N |
| 2 | 1 | Y |
| 2 | 2 | N |
| 3 | 3 | N |
| 4 | 2 | N |
| 4 | 3 | Y |

Explanation:

- Employee **1** belongs to only one department → department **1**
- Employee **2** belongs to multiple departments → primary is **1**
- Employee **3** belongs to only one department → department **3**
- Employee **4** belongs to multiple departments → primary is **3**

Result:

| employee_id | department_id |
|--------------|--------------|
| 1 | 1 |
| 2 | 1 |
| 3 | 3 |
| 4 | 3 |

---

# Conclusion

This challenge reinforces several important SQL concepts:

- Aggregation using `GROUP BY`
- Filtering grouped results with `HAVING`
- Using subqueries inside `WHERE`
- Combining datasets with `UNION`
- Handling different logical scenarios within the same dataset

It is a great exercise for understanding how to solve **conditional data problems using SQL logic and set operations**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***