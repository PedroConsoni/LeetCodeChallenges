# LeetCode SQL – 1148. Article Views I

## Challenge Description

The **"Article Views I"** challenge on LeetCode focuses on practicing the use of the **WHERE clause**, **column comparison**, and handling **duplicate results** using **DISTINCT**.

The problem provides one table:

### `Views` Table

| Column     | Type |
|------------|------|
| article_id | int  |
| author_id  | int  |
| viewer_id  | int  |
| view_date  | date |

- Each row represents a view of an article.
- `author_id` identifies the author of the article.
- `viewer_id` identifies the user who viewed the article.

---

## Objective

Return the IDs of authors who viewed **at least one of their own articles**.

The result should contain:

* `id` (author_id renamed as id)

The result must be ordered in ascending order.

---

## SQL Solution (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY id;
```

---

## Query Explanation

### SELECT

```sql
SELECT DISTINCT author_id AS id
```

- `author_id` is selected because we need to return the author's ID.
- `AS id` renames the column to match the expected output.
- `DISTINCT` ensures that each author appears only once in the result.

Without `DISTINCT`, the same author could appear multiple times if they viewed their article more than once.

---

### FROM

```sql
FROM views
```

Defines the table from which the data is retrieved.

---

### WHERE

```sql
WHERE author_id = viewer_id
```

This condition filters rows where:

- The person who viewed the article is the same as the author.

In other words:

- The author viewed their own article.

---

### ORDER BY

```sql
ORDER BY id
```

Ensures the result is sorted in ascending order by author ID, as required by the problem.

---

## Example

### Input

| article_id | author_id | viewer_id | view_date  |
|------------|----------|-----------|------------|
| 1          | 3        | 5         | 2019-08-01 |
| 1          | 3        | 6         | 2019-08-02 |
| 2          | 7        | 7         | 2019-08-01 |
| 2          | 7        | 6         | 2019-08-02 |
| 4          | 7        | 1         | 2019-07-22 |
| 3          | 4        | 4         | 2019-07-21 |

---

### Output

| id |
|----|
| 4  |
| 7  |

Authors 4 and 7 viewed at least one of their own articles.

---

## Key Concepts Reinforced

This challenge reinforces important SQL fundamentals:

* Column comparison inside `WHERE`
* Using **DISTINCT** to remove duplicates
* Column aliasing with **AS**
* Sorting results with **ORDER BY**

---

## Conclusion

Although simple, this challenge reinforces core SQL filtering concepts.

Understanding how to compare columns within the same table and eliminate duplicates is essential for real-world data querying scenarios in data analysis, data engineering, and back-end development.

---