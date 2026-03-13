# LeetCode SQL – 1633. Percentage of Users Attended a Contest

## Challenge Description

The **"Percentage of Users Attended a Contest"** problem on LeetCode focuses on:

- Aggregate functions (`COUNT`)
- Subqueries
- Arithmetic calculations
- Rounding values with `ROUND`
- Sorting results with multiple criteria

The problem provides two tables:

---

### `Users` Table

| Column   | Type |
|----------|------|
| user_id  | int  |
| user_name| varchar |

Each row represents a user in the system.

---

### `Register` Table

| Column     | Type |
|------------|------|
| contest_id | int  |
| user_id    | int  |

Each row indicates that a specific user registered for a contest.

---

## Objective

For each `contest_id`, return:

- The percentage of users who registered for that contest
- Rounded to **2 decimal places**

The result must be:

- Ordered by `percentage` in **descending order**
- If two contests have the same percentage, order by `contest_id` in **ascending order**

---

## SQL Solution (Based on My Implementation)

```sql
SELECT
    contest_id,
    ROUND(
        COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users),
        2
    ) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
```

---

## Query Explanation

### Step 1 – Counting Registered Users per Contest

```sql
COUNT(user_id)
```

This counts how many users registered for each contest.

Because we use:

```sql
GROUP BY contest_id
```

The count is calculated separately for each contest.

---

### Step 2 – Getting the Total Number of Users

```sql
(SELECT COUNT(*) FROM Users)
```

This subquery returns the total number of users in the system.

It is necessary because the percentage formula is:

```
(number of users registered in contest / total users) * 100
```

---

### Step 3 – Calculating the Percentage

```sql
COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users)
```

Important detail:

- `100.0` is used instead of `100` to force decimal division.
- This avoids integer division and ensures accurate percentage calculation.

---

### Step 4 – Rounding the Result

```sql
ROUND(..., 2)
```

This ensures:

- The percentage is rounded to **2 decimal places**
- The output matches the problem requirement

Example:

- 33.333333 → 33.33
- 50 → 50.00

---

### Step 5 – Ordering the Results

```sql
ORDER BY percentage DESC, contest_id ASC
```

This means:

1. Higher percentages appear first
2. If two contests have the same percentage, the smaller `contest_id` comes first

---

## Why This Works

- `GROUP BY` separates calculations per contest
- `COUNT` calculates the number of participants
- The subquery retrieves the total number of users
- `100.0` ensures proper decimal arithmetic
- `ROUND` formats the output correctly
- `ORDER BY` applies the required sorting rules

Each part of the query directly corresponds to one requirement of the problem.

---

## Example

### Users Table

| user_id | user_name |
|---------|-----------|
| 1       | Alice     |
| 2       | Bob       |
| 3       | Carol     |
| 4       | David     |

### Register Table

| contest_id | user_id |
|------------|---------|
| 10         | 1       |
| 10         | 2       |
| 20         | 2       |
| 20         | 3       |

---

### Calculation

Total users = 4

- Contest 10 → 2 users → (2 / 4) × 100 = 50.00  
- Contest 20 → 2 users → (2 / 4) × 100 = 50.00  

---

### Final Result

| contest_id | percentage |
|------------|------------|
| 10         | 50.00      |
| 20         | 50.00      |

Ordered by percentage descending and contest_id ascending.

---

## Conclusion

This challenge reinforces:

- Aggregation with `COUNT`
- Using subqueries
- Performing percentage calculations
- Avoiding integer division errors
- Sorting with multiple criteria

It is an excellent exercise for mastering real-world reporting logic in SQL.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***