# LeetCode SQL – 620. Not Boring Movies

## Challenge Description

The **"Not Boring Movies"** problem on LeetCode focuses on:

- Filtering with `WHERE`
- Using arithmetic operators
- Sorting results with `ORDER BY`
- Applying multiple conditions

The problem provides a single table:

### `Cinema` Table

| Column      | Type |
|------------|------|
| id         | int  |
| movie      | varchar |
| description| varchar |
| rating     | float |

Each row represents a movie.

---

## Objective

Return all movies that:

- Have an **odd `id`**
- Have a `description` different from `'boring'`

The result must be:

- Ordered by `rating` in **descending order**

---

## SQL Solution (Based on My Implementation)

```sql
SELECT *
FROM cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;
```

---

## Query Explanation

### Step 1 – Filtering Odd IDs

```sql
id % 2 = 1
```

The modulo operator `%` calculates the remainder of division.

If:

- `id % 2 = 1` → the number is odd
- `id % 2 = 0` → the number is even

This condition ensures we only select movies with **odd IDs**.

---

### Step 2 – Excluding "boring" Movies

```sql
description != 'boring'
```

This condition filters out movies where the description is exactly `'boring'`.

Only movies with other descriptions are included.

---

### Step 3 – Ordering by Rating

```sql
ORDER BY rating DESC
```

Sorts the result by:

- Highest rating first
- Lowest rating last

---

## Why This Works

- The modulo operator efficiently identifies odd numbers
- The `AND` operator combines both filtering conditions
- `ORDER BY DESC` ensures proper ranking

---

## Example

If the table contains:

| id | movie  | description | rating |
|----|--------|------------|--------|
| 1  | A      | funny      | 8.5    |
| 2  | B      | boring     | 9.0    |
| 3  | C      | exciting   | 7.5    |
| 4  | D      | boring     | 6.0    |

The result will be:

| id | movie | description | rating |
|----|-------|------------|--------|
| 1  | A     | funny      | 8.5    |
| 3  | C     | exciting   | 7.5    |

Because:

- IDs 1 and 3 are odd
- Neither has description `'boring'`
- Results are ordered by rating descending

---

## Conclusion

This challenge reinforces:

- Logical filtering
- Use of arithmetic operators
- Combining conditions with `AND`
- Sorting with `ORDER BY`

It is a straightforward but important SQL exercise for mastering filtering logic.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***