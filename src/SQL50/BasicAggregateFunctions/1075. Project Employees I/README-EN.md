# LeetCode SQL – 1075. Project Employees I

## Challenge Description

The **"Project Employees I"** problem on LeetCode focuses on:

- `JOIN` between tables
- Aggregate functions (`AVG`)
- Type conversion with `CAST`
- Rounding numeric values with `ROUND`
- Grouping results with `GROUP BY`

The problem provides two tables:

---

### `Project` Table

| Column      | Type |
|------------|------|
| project_id | int  |
| employee_id| int  |

Each row indicates that a specific employee is assigned to a project.

---

### `Employee` Table

| Column           | Type |
|------------------|------|
| employee_id      | int  |
| name             | varchar |
| experience_years | int  |

Each row represents an employee and their years of experience.

---

## Objective

For each `project_id`, return:

- The **average years of experience** of employees working on that project
- The result must be rounded to **2 decimal places**

The output should contain:

- `project_id`
- `average_years`

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    project_id, 
    ROUND(AVG(CAST(experience_years AS DECIMAL(10,2))), 2) average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY project_id;
```

---

## Query Explanation

### Step 1 – Joining the Tables

```sql
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
```

The `JOIN` connects both tables using `employee_id`.

Why?

- The `Project` table tells us **who is in each project**
- The `Employee` table tells us **how many years of experience each employee has**

By joining them, we can access both:

- `project_id`
- `experience_years`

in the same result set.

---

### Step 2 – Converting to Decimal

```sql
CAST(experience_years AS DECIMAL(10,2))
```

Even though `experience_years` is an integer, we convert it to `DECIMAL(10,2)` to:

- Ensure decimal precision during averaging
- Avoid unexpected integer rounding behavior
- Prepare the value for proper rounding later

---

### Step 3 – Calculating the Average

```sql
AVG(...)
```

The `AVG()` function calculates the average experience of employees **within each project**.

However, this only works correctly because we use:

```sql
GROUP BY project_id
```

This groups all employees belonging to the same project before calculating the average.

---

### Step 4 – Rounding to 2 Decimal Places

```sql
ROUND(AVG(...), 2)
```

The `ROUND` function ensures:

- The result always shows exactly **2 decimal places**
- The output matches the problem requirement

Example:

- 3.666666 → 3.67
- 5 → 5.00

---

### Step 5 – Grouping the Results

```sql
GROUP BY project_id
```

This ensures:

- One row per project
- The average is calculated separately for each project

Without `GROUP BY`, the query would return a single average for all projects combined.

---

## Why This Works

- `JOIN` connects project assignments with employee experience
- `GROUP BY` separates calculations per project
- `AVG` computes the mean experience
- `CAST` guarantees decimal precision
- `ROUND` ensures correct formatting

Each part of the query directly corresponds to one requirement of the problem.

---

## Example

### Project Table

| project_id | employee_id |
|------------|------------|
| 1          | 1          |
| 1          | 2          |
| 2          | 3          |

### Employee Table

| employee_id | name   | experience_years |
|------------|--------|------------------|
| 1          | Alice  | 3                |
| 2          | Bob    | 5                |
| 3          | Carol  | 4                |

---

### Calculation

- Project 1 → Employees 1 and 2 → (3 + 5) / 2 = 4.00
- Project 2 → Employee 3 → 4 / 1 = 4.00

---

### Result

| project_id | average_years |
|------------|--------------|
| 1          | 4.00         |
| 2          | 4.00         |

---

## Conclusion

This challenge reinforces:

- Understanding relationships between tables
- Correct use of `JOIN`
- Applying aggregate functions
- Using `GROUP BY` properly
- Formatting numeric results with `ROUND`

It is a fundamental SQL problem for mastering aggregation with joins — a very common scenario in real-world data analysis.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***