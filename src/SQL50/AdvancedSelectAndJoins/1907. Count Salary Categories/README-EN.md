# LeetCode SQL – 1907. Count Salary Categories

## Challenge Description

The **"Count Salary Categories"** problem on LeetCode focuses on practicing:

- Conditional filtering with `WHERE`
- Aggregation using `COUNT`
- Combining result sets with `UNION`
- Categorizing numeric ranges

The problem provides a single table:

### `Accounts` Table

| Column | Type |
|------|------|
| account_id | int |
| income | int |

Each row represents a bank account and the income associated with that account.

---

## Objective

Classify all accounts into **three salary categories** and count how many accounts belong to each category.

The categories are:

- **Low Salary** → income **less than 20000**
- **Average Salary** → income **between 20000 and 50000**
- **High Salary** → income **greater than 50000**

The result must contain two columns:

| category | accounts_count |

Each row represents one salary category and the number of accounts within that category.

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION

SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000

UNION

SELECT 'High Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;
```

---

## Query Explanation

### Step 1 – Counting Low Salary Accounts

```sql
SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000
```

This query performs three things:

1. Filters rows where the income is **less than 20000**
2. Uses `COUNT(*)` to count how many rows match this condition
3. Assigns the label `'Low Salary'` to the result using `AS category`

Example partial result:

| category | accounts_count |
|--------|---------------|
| Low Salary | 3 |

---

### Step 2 – Counting Average Salary Accounts

```sql
SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000
```

This query selects accounts where the income falls **between 20000 and 50000**, inclusive.

The condition:

```sql
income >= 20000 AND income <= 50000
```

Ensures that:

- Accounts earning **exactly 20000** are included
- Accounts earning **exactly 50000** are also included

These accounts are categorized as **Average Salary**.

---

### Step 3 – Counting High Salary Accounts

```sql
SELECT 'High Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000
```

This query filters accounts with income **greater than 50000**.

All accounts that meet this condition are categorized as **High Salary**.

---

### Step 4 – Combining Results with UNION

```sql
UNION
```

The `UNION` operator merges the results of the three queries into a **single result set**.

Each query returns the same structure:

- A category label
- A count of accounts

Because the columns match, SQL can combine them into one final output.

---

## Why This Works

This solution works because:

- `COUNT(*)` efficiently counts rows matching a condition
- Each salary range is handled independently
- `UNION` combines the results into one table
- Static labels clearly identify each category

This makes the query **simple, readable, and logically organized**.

---

## Example

If the `Accounts` table contains:

| account_id | income |
|------------|--------|
| 1 | 15000 |
| 2 | 22000 |
| 3 | 48000 |
| 4 | 52000 |
| 5 | 80000 |

The classification becomes:

- **Low Salary** → 15000
- **Average Salary** → 22000, 48000
- **High Salary** → 52000, 80000

Final result:

| category | accounts_count |
|--------|---------------|
| Low Salary | 1 |
| Average Salary | 2 |
| High Salary | 2 |

---

## Conclusion

This challenge reinforces several important SQL concepts:

- Filtering numeric ranges with `WHERE`
- Counting rows using `COUNT`
- Categorizing data into logical groups
- Combining multiple queries with `UNION`

Although the problem is relatively simple, it demonstrates how SQL can transform raw numerical data into **structured and meaningful grouped results**, which is a common task in data analysis.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***