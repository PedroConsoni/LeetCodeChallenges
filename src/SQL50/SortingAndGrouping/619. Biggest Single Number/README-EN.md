# LeetCode SQL – 619. Biggest Single Number

## Challenge Description

The **"Biggest Single Number"** problem on LeetCode focuses on:

- Aggregation with `COUNT`
- Filtering groups with `HAVING`
- Using subqueries
- Finding maximum values with `MAX`

The problem provides a single table:

### `MyNumbers` Table

| Column | Type |
|--------|------|
| num    | int  |

Each row contains a single integer.

The same number may appear multiple times in the table.

---

## Objective

Return the **largest number** that appears **exactly once** in the table.

If no such number exists, return `NULL`.

The output format:

| num |
|-----|

Where:

- `num` = The largest number that appears only once  

---

## SQL Solution (Based on My Implementation)

```sql
SELECT MAX(num) as num
FROM (
    SELECT num
    FROM mynumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS singlenumber;
```

---

## Query Explanation

### Step 1 – Grouping Numbers

```sql
GROUP BY num
```

The `GROUP BY` clause groups identical numbers together.

This allows us to count how many times each number appears in the table.

---

### Step 2 – Filtering Only Single Occurrences

```sql
HAVING COUNT(num) = 1
```

The `HAVING` clause filters groups after aggregation.

- `COUNT(num) = 1` ensures that we only keep numbers that appear exactly once
- Numbers that appear multiple times are excluded

At this stage, we have a list of numbers that occur only once.

---

### Step 3 – Using a Subquery

```sql
FROM (
    ...
) AS singlenumber
```

The subquery isolates the numbers that appear only once.

We treat this filtered result as a temporary table named `singlenumber`.

This makes the logic clean and modular:

- Inner query → find single-occurrence numbers  
- Outer query → find the largest among them  

---

### Step 4 – Finding the Maximum Value

```sql
MAX(num)
```

The `MAX()` function returns the largest value from the remaining numbers.

If no number appears exactly once:

- The subquery returns no rows
- `MAX()` returns `NULL`

---

## Why This Works

- `GROUP BY` groups identical numbers
- `HAVING COUNT(num) = 1` filters unique values
- The subquery isolates valid candidates
- `MAX()` selects the largest single number

This is a clean and efficient solution.

---

## Example

If the table contains:

| num |
|-----|
| 8   |
| 8   |
| 3   |
| 1   |
| 2   |
| 2   |

### Step-by-step reasoning

Grouped results:

- 8 → appears 2 times ❌  
- 3 → appears 1 time ✅  
- 1 → appears 1 time ✅  
- 2 → appears 2 times ❌  

Numbers that appear once: 3, 1  

Largest among them: **3**

---

## Final Output

| num |
|-----|
| 3   |

---

## Conclusion

This challenge reinforces key SQL concepts:

- Grouping data with `GROUP BY`
- Filtering aggregated results using `HAVING`
- Using subqueries for logical separation
- Applying aggregate functions like `MAX`

Although simple, it is a powerful exercise for understanding grouped filtering and layered query logic.