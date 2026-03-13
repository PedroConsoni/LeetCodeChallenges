# LeetCode SQL – 1978. Employees Whose Manager Left the Company

## Challenge Description

The **"Employees Whose Manager Left the Company"** problem on LeetCode focuses on practicing:

- Filtering data with `WHERE`
- Using `NULL` conditions
- Subqueries with `NOT IN`
- Sorting results with `ORDER BY`

The problem provides a single table:

### `Employees` Table

| Column | Type |
|------|------|
| employee_id | int |
| name | varchar |
| manager_id | int |
| salary | int |

Each row represents an employee in a company.

- `employee_id` is the unique identifier of the employee
- `manager_id` represents the employee's manager
- If a manager leaves the company, their `employee_id` will no longer appear in the table

---

## Objective

Find all employees who:

- Have a **salary lower than 30000**
- Have a **manager assigned**
- But their **manager no longer exists in the Employees table**

The result should return:

| employee_id |

And must be ordered by `employee_id` in **ascending order**.

---

## SQL Solution (Based on My Implementation)

```sql
SELECT employee_id
FROM Employees
WHERE salary < 30000
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (
      SELECT employee_id FROM Employees
  )
ORDER BY employee_id;
```

---

## Query Explanation

### Step 1 – Filtering Employees With Salary Below 30000

```sql
salary < 30000
```

This condition selects employees whose salary is **less than 30000**.

Only these employees are considered in the final result.

---

### Step 2 – Ensuring the Employee Has a Manager

```sql
manager_id IS NOT NULL
```

This condition ensures that the employee **actually has a manager assigned**.

If `manager_id` were `NULL`, it would mean:

- The employee does not have a manager
- Or the employee is at the top of the hierarchy

These cases are excluded from the result.

---

### Step 3 – Checking if the Manager Left the Company

```sql
manager_id NOT IN (
    SELECT employee_id FROM Employees
)
```

This subquery retrieves **all employee IDs currently in the company**.

```sql
SELECT employee_id FROM Employees
```

Then the condition checks if the `manager_id` **is not present in this list**.

If the manager ID does not exist in the Employees table, it means:

- The manager **left the company**

Therefore, the employee is included in the result.

---

### Step 4 – Ordering the Result

```sql
ORDER BY employee_id
```

This sorts the final output by **employee_id in ascending order**.

This ensures the result follows the order required by the problem.

---

## Why This Works

This solution works because:

- `salary < 30000` filters employees with lower salaries
- `manager_id IS NOT NULL` ensures the employee actually has a manager
- `NOT IN` checks whether the manager still exists in the table
- The subquery retrieves the list of current employees
- `ORDER BY` guarantees the result is sorted correctly

Together, these conditions isolate employees whose **manager is no longer part of the company**.

---

## Example

If the `Employees` table contains:

| employee_id | name | manager_id | salary |
|-------------|------|-----------|-------|
| 1 | Alice | NULL | 60000 |
| 2 | Bob | 1 | 25000 |
| 3 | Charlie | 5 | 20000 |
| 4 | David | 1 | 40000 |

Employee **Charlie** has:

- salary = 20000 (< 30000)
- manager_id = 5
- manager **5 does not exist in the table**

Final result:

| employee_id |
|-------------|
| 3 |

---

## Conclusion

This challenge reinforces several important SQL concepts:

- Filtering rows using multiple conditions
- Handling `NULL` values
- Using subqueries to validate relationships
- Applying `NOT IN` for exclusion logic
- Sorting results with `ORDER BY`

It is a useful exercise for understanding how SQL can detect **missing relationships in relational data**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***