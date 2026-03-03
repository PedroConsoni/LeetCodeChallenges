# LeetCode SQL – 1280. Students and Examinations

## Challenge Description

The **"Students and Examinations"** problem on LeetCode focuses on practicing:

- `CROSS JOIN`
- `LEFT JOIN`
- Aggregation with `COUNT`
- `GROUP BY`
- Handling missing records

The problem provides three tables:

### `Students` Table

| Column       | Type |
|-------------|------|
| student_id  | int  |
| student_name| varchar |

---

### `Subjects` Table

| Column       | Type |
|-------------|------|
| subject_name| varchar |

---

### `Examinations` Table

| Column       | Type |
|-------------|------|
| student_id  | int  |
| subject_name| varchar |

The `Examinations` table records every time a student attends an exam.

---

## Objective

For each student and each subject, return:

- `student_id`
- `student_name`
- `subject_name`
- The number of exams the student attended for that subject

Important:

- Every student must appear with every subject
- If a student did not attend any exam for a subject, the count must be `0`

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name, 
    COUNT(e.student_id) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
```

---

## Query Explanation

### Step 1 – CROSS JOIN

```sql
CROSS JOIN Subjects sub
```

The `CROSS JOIN` creates all possible combinations between:

- Every student
- Every subject

This guarantees that every student appears for every subject, even if no exam was taken.

---

### Step 2 – LEFT JOIN

```sql
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
```

The `LEFT JOIN` attaches exam records when they exist.

If a student did not attend an exam for a subject:

- The columns from `Examinations` will be `NULL`
- The row will still appear because it is a `LEFT JOIN`

---

### Step 3 – Counting Exams

```sql
COUNT(e.student_id)
```

Counts how many times the student attended that subject's exam.

Important:

- `COUNT(column)` ignores `NULL`
- If no exam exists, the count automatically becomes `0`

---

### Step 4 – GROUP BY

```sql
GROUP BY s.student_id, s.student_name, sub.subject_name
```

Groups results per:

- Student
- Subject

This allows correct aggregation.

---

### Step 5 – ORDER BY

```sql
ORDER BY s.student_id, sub.subject_name
```

Sorts the output by:

1. Student ID
2. Subject name

---

## Conclusion

This challenge reinforces:

- Using `CROSS JOIN` to generate combinations
- Using `LEFT JOIN` to preserve missing data
- Aggregation with `COUNT`
- Proper grouping and ordering
- Handling `NULL` values correctly

It is a very important SQL exercise for mastering relational logic.