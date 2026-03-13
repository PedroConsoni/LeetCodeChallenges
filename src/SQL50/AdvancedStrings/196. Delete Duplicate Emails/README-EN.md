# LeetCode SQL – 196. Delete Duplicate Emails

## Challenge Description

The **"Delete Duplicate Emails"** problem on LeetCode focuses on:

- Identifying **duplicate records**
- Using **window functions**
- Applying **ROW_NUMBER**
- Partitioning data using **PARTITION BY**
- Deleting rows based on ranking

The problem provides a single table:

### `Person` Table

| Column | Type |
|------|------|
| Id   | int  |
| Email | varchar |

Each row represents a **person and their email address**.

However, the table may contain **duplicate email addresses**, meaning multiple rows can have the same `Email`.

---

## Objective

Delete all duplicate emails while keeping **only the row with the smallest `Id`** for each unique email.

In other words:

- If multiple rows share the same email
- Keep the one with the **lowest Id**
- Remove the rest

---

## SQL Solution (Based on My Implementation)

```sql
WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY Id ASC
           ) AS NumeroLinha
    FROM Person
)
DELETE FROM CTE 
WHERE NumeroLinha > 1;
```

---

## Query Explanation

### Step 1 – Creating a Row Number for Each Email

```sql
ROW_NUMBER() OVER (
    PARTITION BY Email 
    ORDER BY Id ASC
)
```

The `ROW_NUMBER()` window function assigns a **sequential number to each row**.

Key points:

- `PARTITION BY Email` groups rows with the same email address
- `ORDER BY Id ASC` ensures that the **smallest Id appears first**

Example:

| Id | Email | NumeroLinha |
|----|------|-------------|
| 1 | a@b.com | 1 |
| 2 | a@b.com | 2 |
| 3 | c@d.com | 1 |

This means:

- The first occurrence of each email gets `NumeroLinha = 1`
- Duplicates receive higher numbers

---

### Step 2 – Storing Results in a CTE

```sql
WITH CTE AS (...)
```

A **Common Table Expression (CTE)** is used to store the intermediate result.

This CTE contains:

- All original columns
- The generated row number (`NumeroLinha`)

This structure makes it easier to filter duplicates.

---

### Step 3 – Deleting Duplicate Rows

```sql
DELETE FROM CTE 
WHERE NumeroLinha > 1;
```

This statement deletes all rows where:

```
NumeroLinha > 1
```

Meaning:

- Keep rows with `NumeroLinha = 1`
- Delete all other rows with the same email

---

## Why This Works

This approach works efficiently because:

- `ROW_NUMBER()` uniquely identifies duplicates
- `PARTITION BY` groups rows by email
- `ORDER BY Id ASC` ensures the **lowest Id is preserved**
- The CTE allows the query to **delete rows directly from the ranked result**

This method is widely used for **removing duplicates in SQL tables**.

---

## Example

If the table contains:

| Id | Email |
|----|------|
| 1 | john@example.com |
| 2 | bob@example.com |
| 3 | john@example.com |

After applying `ROW_NUMBER()`:

| Id | Email | NumeroLinha |
|----|------|-------------|
| 1 | john@example.com | 1 |
| 3 | john@example.com | 2 |
| 2 | bob@example.com | 1 |

After the `DELETE` operation:

| Id | Email |
|----|------|
| 1 | john@example.com |
| 2 | bob@example.com |

The duplicate email row has been removed.

---

## Conclusion

This challenge reinforces several important SQL concepts:

- **Window functions**
- **ROW_NUMBER**
- **Partitioning data**
- **Handling duplicate records**
- **Deleting rows based on ranking**

It is a common real-world task in data cleaning and database management.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***