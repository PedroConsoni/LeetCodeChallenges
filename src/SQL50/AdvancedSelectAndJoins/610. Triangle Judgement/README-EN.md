# LeetCode SQL – 610. Triangle Judgement

## Challenge Description

The **"Triangle Judgement"** problem on LeetCode focuses on:

- Conditional logic using `CASE`
- Mathematical conditions in SQL
- Boolean expressions with `AND`
- Creating derived columns

The problem provides a single table:

### `Triangle` Table

| Column | Type |
|------|------|
| x | int |
| y | int |
| z | int |

Each row represents three numbers that may represent the **lengths of the sides of a triangle**.

---

# Objective

Determine whether the three given values **can form a triangle**.

A triangle is valid only if the **triangle inequality rule** is satisfied.

The triangle inequality rule states that:

- The sum of any two sides must be **greater than the third side**.

Therefore:

- `x + y > z`
- `x + z > y`
- `y + z > x`

If all conditions are satisfied, the output should be:

```
Yes
```

Otherwise:

```
No
```

The result must contain:

- `x`
- `y`
- `z`
- A new column called `triangle`

---

# SQL Solution (Based on My Implementation)

```sql
SELECT 
    x, 
    y, 
    z,
    CASE 
        WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM 
    Triangle;
```

---

# Query Explanation

## Step 1 – Selecting the Triangle Sides

```sql
SELECT x, y, z
```

This retrieves the three values from the table that represent the **potential triangle sides**.

---

## Step 2 – Using CASE to Apply Logic

```sql
CASE
```

The `CASE` statement works like an **IF-ELSE structure** in SQL.

It allows us to evaluate conditions and return different values depending on the result.

---

## Step 3 – Applying the Triangle Inequality Rule

```sql
WHEN x + y > z AND x + z > y AND y + z > x
```

This condition verifies the **triangle inequality rule**.

All three conditions must be true:

- The sum of side `x` and `y` must be greater than `z`
- The sum of side `x` and `z` must be greater than `y`
- The sum of side `y` and `z` must be greater than `x`

If all conditions are satisfied, the values can form a triangle.

---

## Step 4 – Returning the Result

```sql
THEN 'Yes'
ELSE 'No'
```

If the condition is true:

```
Yes
```

If the condition is false:

```
No
```

---

## Step 5 – Creating a New Column

```sql
END AS triangle
```

This creates a new column named **`triangle`** that contains the result of the evaluation.

---

# Why This Works

This solution directly implements the **mathematical definition of a triangle**.

By verifying all three triangle inequality conditions:

- Invalid triangles are filtered logically
- Valid triangles return `"Yes"`
- Invalid triangles return `"No"`

The `CASE` statement allows us to compute the result **row by row**.

---

# Example

If the table contains:

| x | y | z |
|---|---|---|
| 13 | 15 | 30 |
| 10 | 20 | 15 |

### Row 1

```
13 + 15 = 28
28 > 30 → False
```

Result:

```
No
```

### Row 2

```
10 + 20 = 30 > 15
10 + 15 = 25 > 20
20 + 15 = 35 > 10
```

Result:

```
Yes
```

Final Output:

| x | y | z | triangle |
|---|---|---|---|
| 13 | 15 | 30 | No |
| 10 | 20 | 15 | Yes |

---

# Conclusion

This challenge reinforces important SQL concepts such as:

- Conditional logic using `CASE`
- Boolean expressions with `AND`
- Mathematical validation inside SQL queries
- Creating derived columns

It is a simple but effective exercise to practice **logical conditions and computed columns in SQL**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***