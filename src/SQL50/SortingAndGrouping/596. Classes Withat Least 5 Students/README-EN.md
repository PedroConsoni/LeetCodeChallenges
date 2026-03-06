# LeetCode SQL – Classes More Than 5 Students

## Challenge Description

The **"Classes More Than 5 Students"** challenge on LeetCode focuses on practicing **GROUP BY** and **HAVING** clauses in SQL to filter groups based on aggregate conditions.

In this problem, we need to identify the **classes** that have **five or more students** enrolled.

---

## Table Structure

### `Courses` Table

| Column  | Type    |
| ------- | ------- |
| student | varchar |
| class   | varchar |

Each record represents a student enrolled in a specific class.

---

## Objective

Return the names of the **classes** that have **at least 5 students**.

### Expected column:

* `class`

---

## SQL Solution

```sql
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

---

## Query Explanation

### GROUP BY

```sql
GROUP BY class
```

Groups records by the `class` column, allowing each class to be analyzed separately.

---

### COUNT

```sql
COUNT(student)
```

Counts how many students are enrolled in each class.

---

### HAVING

```sql
HAVING COUNT(student) >= 5
```

The `HAVING` clause is used to **filter groups**, unlike `WHERE`, which filters individual rows.

In this case, only classes with **5 or more students** are returned.

---

## Example

### Courses Table

| student | class   |
| ------- | ------- |
| A       | Math    |
| B       | Math    |
| C       | Math    |
| D       | Math    |
| E       | Math    |
| F       | English |

### Result

| class |
| ----- |
| Math  |

---

## Conclusion

This challenge reinforces fundamental SQL concepts:

* Grouping data with **GROUP BY**
* Using the **COUNT** aggregate function
* Filtering groups with **HAVING**

It is an essential exercise for understanding **aggregated data analysis** in SQL.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
