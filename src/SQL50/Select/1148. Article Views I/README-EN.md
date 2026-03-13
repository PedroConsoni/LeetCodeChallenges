# LeetCode SQL – 1148. Article Views I

## Challenge Description

The **"Article Views I"** problem on LeetCode focuses on:

- Filtering rows using `WHERE`
- Comparing values from the same row
- Removing duplicates with `DISTINCT`
- Sorting results with `ORDER BY`

The problem provides a single table.

### `Views` Table

| Column     | Type |
|------------|------|
| article_id | int  |
| author_id  | int  |
| viewer_id  | int  |
| view_date  | date |

Each row represents a **view of an article**.

- `author_id` represents the **author of the article**
- `viewer_id` represents the **user who viewed the article**

---

## Objective

Return the **IDs of authors who viewed their own articles**.

The result must:

- Display the column name as **`id`**
- Contain **unique values only**
- Be **sorted in ascending order**

---

## SQL Solution (Based on My Implementation)

```sql
SELECT DISTINCT author_id as id
FROM views
WHERE author_id = viewer_id
ORDER BY author_id ASC;
```

---

## Query Explanation

### Step 1 – Comparing Author and Viewer

```sql
WHERE author_id = viewer_id
```

This condition checks whether the **author of the article is the same user who viewed it**.

If:

- `author_id = viewer_id` → the author viewed their own article
- `author_id ≠ viewer_id` → the viewer is someone else

This filter keeps only the rows where the **author accessed their own article**.

---

### Step 2 – Selecting the Author ID

```sql
SELECT author_id AS id
```

The problem requires the output column to be named **`id`**.

Because the table column is named `author_id`, we rename it using:

```sql
AS id
```

This creates the correct output format expected by LeetCode.

---

### Step 3 – Removing Duplicate Authors

```sql
DISTINCT
```

An author may view their own article **multiple times**.

For example:

| author_id | viewer_id |
|-----------|-----------|
| 7         | 7         |
| 7         | 7         |
| 7         | 7         |

Without `DISTINCT`, the result would contain repeated rows.

Using `DISTINCT` ensures that **each author appears only once in the result**.

---

### Step 4 – Sorting the Results

```sql
ORDER BY author_id ASC
```

This sorts the final result by **author ID in ascending order**.

Example order:

```
1
3
7
9
```

This satisfies the problem requirement that results must be **sorted from smallest to largest ID**.

---

## Why This Works

This query works efficiently because:

- `WHERE author_id = viewer_id` identifies when authors view their own articles
- `DISTINCT` removes duplicate author IDs
- `AS id` ensures the output column matches the required name
- `ORDER BY` guarantees the correct sorting

Together, these SQL clauses produce the exact output expected by the problem.

---

## Example

If the table contains the following data:

| article_id | author_id | viewer_id | view_date |
|------------|-----------|-----------|-----------|
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 3         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |

### Step 1 – Filter rows where the author viewed their own article

| article_id | author_id | viewer_id | view_date |
|------------|-----------|-----------|-----------|
| 1          | 3         | 3         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |

### Step 2 – Select `author_id` as `id`

| id |
|----|
| 3  |
| 7  |

### Step 3 – Apply `DISTINCT`

No duplicates appear, so the table remains the same.

### Step 4 – Sort ascending

Final result:

| id |
|----|
| 3  |
| 7  |

---

## Conclusion

This challenge reinforces several fundamental SQL concepts:

- Filtering rows with `WHERE`
- Comparing values from the same row
- Removing duplicates using `DISTINCT`
- Renaming columns with `AS`
- Sorting results with `ORDER BY`

Although simple, this exercise is important for practicing **SQL filtering logic and result formatting**, which are essential skills when working with relational databases.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***