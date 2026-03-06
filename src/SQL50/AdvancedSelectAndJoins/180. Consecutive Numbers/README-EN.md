# LeetCode SQL – 180. Consecutive Numbers

## Challenge Description

The **"Consecutive Numbers"** problem on LeetCode focuses on:

- Self joins
- Comparing rows within the same table
- Logical filtering with `WHERE`
- Eliminating duplicates using `DISTINCT`

The problem provides a single table:

### `Logs` Table

| Column | Type |
|------|------|
| id | int |
| num | int |

Each row represents a log entry containing a number.

The `id` column is **auto-incremented**, meaning the rows are ordered sequentially.

---

# Objective

Find all numbers that appear **at least three times consecutively**.

The result must contain:

- A single column named **`ConsecutiveNums`**

Each number should appear **only once in the result**, even if it appears more than three consecutive times.

---

# SQL Solution (Based on My Implementation)

```sql
SELECT DISTINCT
    l1.num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.id = l2.id - 1
    AND l2.id = l3.id - 1
    AND l1.num = l2.num
    AND l2.num = l3.num;
```

---

# Query Explanation

## Step 1 – Creating Multiple References to the Same Table

```sql
FROM Logs l1, Logs l2, Logs l3
```

This query references the **same table three times**.

Each alias represents a different row position:

- `l1` → first row
- `l2` → second row
- `l3` → third row

This technique is called a **self join**.

It allows us to compare rows within the same table.

---

## Step 2 – Ensuring the Rows Are Consecutive

```sql
l1.id = l2.id - 1
AND l2.id = l3.id - 1
```

These conditions ensure the rows are **sequential**.

Example:

| id |
|---|
| 1 |
| 2 |
| 3 |

The conditions guarantee that:

```
l1.id = 1
l2.id = 2
l3.id = 3
```

So we are checking **three consecutive rows**.

---

## Step 3 – Checking If the Numbers Are Equal

```sql
l1.num = l2.num
AND l2.num = l3.num
```

These conditions verify that the **same number appears in all three rows**.

If all numbers match, then that number appears **three times consecutively**.

---

## Step 4 – Removing Duplicate Results

```sql
SELECT DISTINCT
```

If a number appears more than three times consecutively, the query might detect multiple sequences.

Example:

```
1,1,1,1
```

This creates two valid sequences:

```
1,1,1
1,1,1
```

Using `DISTINCT` ensures the number appears **only once in the final result**.

---

# Why This Works

This solution works because it:

- Compares **three consecutive rows**
- Verifies the numbers are identical
- Uses **self joins** to analyze sequences
- Uses `DISTINCT` to prevent duplicate results

It effectively detects numbers that appear **three times in a row**.

---

# Example

If the table contains:

| id | num |
|---|---|
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |
| 4 | 2 |
| 5 | 1 |
| 6 | 2 |
| 7 | 2 |
| 8 | 2 |

### Analysis

- Rows **1,2,3** → number **1** appears three times consecutively
- Rows **6,7,8** → number **2** appears three times consecutively

---

### Result

| ConsecutiveNums |
|---|
| 1 |
| 2 |

---

# Conclusion

This challenge reinforces important SQL concepts such as:

- Self joins
- Comparing multiple rows within the same table
- Logical filtering with `WHERE`
- Eliminating duplicates using `DISTINCT`

It is an excellent exercise for learning how to **detect patterns and sequences in relational data using SQL**.