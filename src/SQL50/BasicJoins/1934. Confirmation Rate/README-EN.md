# LeetCode SQL – 1934. Confirmation Rate

## Challenge Description

The **"Confirmation Rate"** problem on LeetCode focuses on:

- `LEFT JOIN`
- Conditional aggregation with `CASE`
- `AVG` function
- Handling `NULL` values
- Rounding numeric results

The problem provides two tables:

---

### `Signups` Table

| Column   | Type |
|----------|------|
| user_id  | int  |
| time_stamp | datetime |

Each row represents a user who signed up.

---

### `Confirmations` Table

| Column   | Type |
|----------|------|
| user_id  | int  |
| time_stamp | datetime |
| action   | enum ('confirmed', 'timeout') |

Each row represents a confirmation attempt made by a user.

---

## Objective

For each user, calculate the **confirmation rate** defined as:

```
number of confirmed actions / total number of confirmation attempts
```

Requirements:

- Return every `user_id` from `Signups`
- If a user has no confirmation attempts, return `0`
- Round the result to **2 decimal places**

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    s.user_id, 
    ROUND(
        ISNULL(
            AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END), 
            0
        ), 2
    ) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c ON s.user_id = c.user_id
GROUP BY 
    s.user_id;
```

---

## Query Explanation

### Step 1 – LEFT JOIN

```sql
FROM Signups s
LEFT JOIN Confirmations c 
    ON s.user_id = c.user_id
```

The `LEFT JOIN` ensures:

- All users from `Signups` appear
- Users with no confirmations still appear
- Missing confirmation records produce `NULL`

---

### Step 2 – Conditional Logic with CASE

```sql
CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END
```

This transforms:

- `'confirmed'` → `1.0`
- Any other value (`timeout`) → `0.0`

This allows us to calculate a ratio using `AVG`.

---

### Step 3 – Using AVG()

```sql
AVG(...)
```

Since we converted:

- Confirmed → 1
- Not confirmed → 0

The average becomes:

```
sum of confirmed / total attempts
```

Which is exactly the confirmation rate.

---

### Step 4 – Handling NULL Users

```sql
ISNULL(AVG(...), 0)
```

If a user has no confirmation records:

- `AVG` returns `NULL`
- `ISNULL` converts it to `0`

This satisfies the problem requirement.

---

### Step 5 – Rounding

```sql
ROUND(..., 2)
```

Rounds the result to **2 decimal places**.

---

## Example

If a user has:

| action     |
|------------|
| confirmed  |
| timeout    |
| confirmed  |

Numeric transformation:

| value |
|-------|
| 1.0   |
| 0.0   |
| 1.0   |

Average:

```
(1 + 0 + 1) / 3 = 0.67
```

Result:

```
0.67
```

---

## Conclusion

This challenge reinforces:

- Using `LEFT JOIN` to preserve base records
- Conditional aggregation
- Transforming categorical values into numeric logic
- Handling `NULL` values properly
- Rounding numeric results

It is an excellent exercise for mastering analytical SQL logic.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***