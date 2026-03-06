# LeetCode SQL – Duplicate Emails

## Challenge Description

The **"Duplicate Emails"** challenge on LeetCode focuses on practicing **GROUP BY** and **HAVING** clauses in SQL to identify **duplicate values** in a table.

In this problem, we need to find email addresses that appear **more than once** in the `Person` table.

---

## Table Structure

### `Person` Table

| Column | Type    |
| ------ | ------- |
| id     | int     |
| email  | varchar |

Each record represents a person, and multiple people may share the same email address.

---

## Objective

Return all **duplicate emails**, meaning emails that appear **more than once** in the table.

### Expected column:

* `email`

---

## SQL Solution

```sql
SELECT email
FROM person
GROUP BY email
HAVING COUNT(email) > 1;
```

---

## Query Explanation

### GROUP BY

```sql
GROUP BY email
```

Groups records by the `email` field, allowing us to count how many times each email appears.

---

### COUNT

```sql
COUNT(email)
```

Counts the number of occurrences of each email within its group.

---

### HAVING

```sql
HAVING COUNT(email) > 1
```

The `HAVING` clause is used to **filter groups**, unlike `WHERE`, which filters rows.

In this case, it keeps only the groups where the email appears **more than once**, identifying duplicate emails.

---

## Example

### Person Table

| id | email                     |
| -- | ------------------------- |
| 1  | [a@b.com](mailto:a@b.com) |
| 2  | [c@d.com](mailto:c@d.com) |
| 3  | [a@b.com](mailto:a@b.com) |

### Result

| email                     |
| ------------------------- |
| [a@b.com](mailto:a@b.com) |

---

## Conclusion

This challenge reinforces essential SQL concepts:

* Using **GROUP BY** for aggregation
* Applying the **COUNT** function
* Filtering groups with **HAVING**

It is a fundamental exercise for identifying **duplicate records in databases**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
