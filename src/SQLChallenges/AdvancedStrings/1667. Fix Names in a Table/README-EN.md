# LeetCode SQL – 1667. Fix Names in a Table

## Challenge Description

The **"Fix Names in a Table"** challenge on LeetCode focuses on practicing **string manipulation functions** and formatting text properly in SQL.

The problem provides one table:

### `Users` Table

| Column  | Type    |
|---------|---------|
| user_id | int     |
| name    | varchar |

The `name` column may contain inconsistent capitalization such as:

- `aLice`
- `bOB`
- `CHARLIE`

The goal is to standardize the names so that:

- The first letter is uppercase
- The remaining letters are lowercase

---

## Objective

Return:

* `user_id`
* `name` (properly formatted)

The result must be ordered by `user_id` in ascending order.

---

## SQL Solution (SQL Server / T-SQL)

```sql
SELECT user_id, 
       UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS name
FROM users
ORDER BY user_id;
```

---

## Query Explanation

### SELECT

```sql
SELECT user_id, 
       UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS name
```

- `user_id` is selected as required.
- The `name` column is transformed and aliased as `name`.

Let’s break down the formatting logic:

---

### `LEFT(name, 1)`

Extracts the first character of the name.

Example:
- `aLice` → `a`

---

### `UPPER(LEFT(name, 1))`

Converts the first character to uppercase.

Example:
- `a` → `A`

---

### `SUBSTRING(name, 2, LEN(name))`

Extracts the rest of the name starting from the second character.

Example:
- `aLice` → `Lice`

---

### `LOWER(SUBSTRING(...))`

Converts the remaining characters to lowercase.

Example:
- `Lice` → `lice`

---

### String Concatenation (`+`)

```sql
UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name)))
```

Combines:

- Uppercased first letter
- Lowercased remaining letters

Final result:
- `aLice` → `Alice`
- `bOB` → `Bob`
- `CHARLIE` → `Charlie`

---

### FROM

```sql
FROM users
```

Defines the table being queried.

---

### ORDER BY

```sql
ORDER BY user_id
```

Ensures the results are sorted in ascending order by `user_id`.

---

## Example

### Input

| user_id | name     |
|----------|----------|
| 1        | aLice    |
| 2        | bOB      |
| 3        | CHARLIE  |

---

### Output

| user_id | name     |
|----------|----------|
| 1        | Alice    |
| 2        | Bob      |
| 3        | Charlie  |

---

## Key Concepts Reinforced

This challenge reinforces important SQL concepts:

* String manipulation functions (`UPPER`, `LOWER`, `LEFT`, `SUBSTRING`, `LEN`)
* String concatenation
* Column aliasing with `AS`
* Sorting results using `ORDER BY`

---

## Conclusion

This exercise demonstrates how SQL can be used for data cleaning and formatting.

Proper string formatting is essential in real-world scenarios involving data standardization, user input normalization, and data quality improvement.

---