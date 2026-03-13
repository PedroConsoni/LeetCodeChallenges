# LeetCode SQL – 2356. Number of Unique Subjects Taught by Each Teacher

## Challenge Description

The **"Number of Unique Subjects Taught by Each Teacher"** problem on LeetCode focuses on:

- Aggregation with `COUNT`
- Removing duplicates using `DISTINCT`
- Grouping data with `GROUP BY`

The problem provides a single table:

### `Teacher` Table

| Column      | Type |
|------------|------|
| teacher_id | int  |
| subject_id | int  |
| dept_id    | int  |

Each row represents a subject taught by a specific teacher.

A teacher may appear multiple times because:

- They can teach multiple subjects
- The same subject may appear more than once in the table

---

## Objective

For each `teacher_id`, return:

- The total number of **unique subjects** they teach

The result should contain:

| teacher_id | cnt |
|------------|-----|

Where:

- `teacher_id` = Teacher identifier  
- `cnt` = Number of distinct subjects taught by that teacher  

---

## SQL Solution (Based on My Implementation)

```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id;
```

---

## Query Explanation

### Step 1 – Grouping by Teacher

```sql
GROUP BY teacher_id
```

The `GROUP BY` clause groups all rows that have the same `teacher_id`.

This means:

- All records of the same teacher are treated as a single group
- Aggregation functions operate inside each teacher group

Without `GROUP BY`, we would get a single total for the entire table instead of one result per teacher.

---

### Step 2 – Counting Unique Subjects

```sql
COUNT(DISTINCT subject_id)
```

- `COUNT()` counts rows
- `DISTINCT` removes duplicate values before counting

This ensures that:

- If a teacher appears multiple times with the same `subject_id`, it is counted only once
- Only unique subjects are included in the total

Without `DISTINCT`, duplicate subjects would inflate the result.

---

### Step 3 – Renaming the Column

```sql
AS cnt
```

`AS` creates an alias for the calculated column.

Instead of returning:

```
COUNT(DISTINCT subject_id)
```

We rename it to:

```
cnt
```

This matches the required output format of the problem.

---

## Why This Works

- `GROUP BY` separates data by teacher
- `COUNT(DISTINCT ...)` guarantees unique subject counting
- The query performs grouping and aggregation in a single efficient step

This is the cleanest and most optimized way to solve the problem.

---

## Example

If the table contains:

| teacher_id | subject_id | dept_id |
|------------|------------|---------|
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 2          | 1       |

### Step-by-step reasoning

### Teacher 1:
Subjects: 2, 2, 3  
Unique subjects: 2, 3  
Total = 2  

### Teacher 2:
Subjects: 1, 2, 2  
Unique subjects: 1, 2  
Total = 2  

---

## Final Output

| teacher_id | cnt |
|------------|-----|
| 1          | 2   |
| 2          | 2   |

---

## Conclusion

This challenge reinforces fundamental SQL concepts:

- Data aggregation
- Eliminating duplicates using `DISTINCT`
- Grouping records with `GROUP BY`
- Using column aliases for cleaner output

Although straightforward, this problem is essential for mastering grouped aggregations and correctly counting unique values in relational databases.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***