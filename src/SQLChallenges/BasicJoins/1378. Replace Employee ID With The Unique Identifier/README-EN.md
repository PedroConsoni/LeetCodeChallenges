# LeetCode SQL – 1378. Replace Employee ID With The Unique Identifier

## Challenge Description

The **"Replace Employee ID With The Unique Identifier"** challenge on LeetCode focuses on practicing **JOIN operations**, specifically the **LEFT JOIN**, to combine data from two related tables.

The problem provides two tables:

### `Employees` Table

| Column | Type |
|--------|------|
| id     | int  |
| name   | varchar |

### `EmployeeUNI` Table

| Column    | Type |
|-----------|------|
| id        | int  |
| unique_id | int  |

- Each employee has an `id` and a `name`.
- Some employees have a corresponding `unique_id` in the `EmployeeUNI` table.
- Not all employees are guaranteed to have a matching record in `EmployeeUNI`.

---

## Objective

Return a list containing:

* `unique_id`
* `name`

Ensuring that **all employees appear in the result**, even if they do not have a `unique_id`.

---

## SQL Solution

```sql
SELECT u.unique_id, e.name
FROM employees e
LEFT JOIN employeeuni u
    ON e.id = u.id;
```

---

## Query Explanation

### SELECT

```sql
SELECT u.unique_id, e.name
```

Selects:

- `unique_id` from the `EmployeeUNI` table
- `name` from the `Employees` table

If an employee does not have a matching `unique_id`, this column will return `NULL`.

---

### FROM

```sql
FROM employees e
```

Defines the **base table** of the query.

Since the requirement is to include all employees, `Employees` must be the main table.

---

### LEFT JOIN

```sql
LEFT JOIN employeeuni u
```

The `LEFT JOIN` ensures that:

- All rows from `Employees` are returned.
- Matching rows from `EmployeeUNI` are included when available.
- If no match exists, `unique_id` will be `NULL`.

---

### ON (Join Condition)

```sql
ON e.id = u.id
```

Defines how the tables are related:

- The join occurs when the `id` from `Employees` matches the `id` from `EmployeeUNI`.

---

## Example

### Input

#### Employees

| id | name     |
|----|----------|
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |

#### EmployeeUNI

| id | unique_id |
|----|----------|
| 3  | 1        |
| 11 | 2        |
| 90 | 3        |

---

### Output

| unique_id | name     |
|------------|----------|
| NULL       | Alice    |
| NULL       | Bob      |
| 2          | Meir     |
| 3          | Winston  |
| 1          | Jonathan |

Employees without a matching `unique_id` still appear in the result.

---

## Key Concepts Reinforced

This challenge reinforces important SQL concepts:

* Use of **LEFT JOIN**
* Combining data from multiple tables
* Handling `NULL` values in joins
* Defining proper join conditions

---

## Conclusion

This exercise highlights how relational databases connect data across tables.

Understanding how `LEFT JOIN` works is fundamental for real-world scenarios in data engineering, analytics, and back-end systems where preserving unmatched records is essential.

---