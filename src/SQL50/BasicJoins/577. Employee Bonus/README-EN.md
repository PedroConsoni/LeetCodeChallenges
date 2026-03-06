# LeetCode SQL – Employee Bonus

## Challenge Description

The **"Employee Bonus"** challenge on LeetCode aims to practice the use of **LEFT OUTER JOIN** combined with **filtering using the WHERE clause**, including proper handling of **NULL values**.

The problem provides two tables related to employees and their respective bonuses.

---

## Table Structure

### `Employee` Table

| Column     | Type    |
| ---------- | ------- |
| empId      | int     |
| name       | varchar |
| supervisor | int     |
| salary     | int     |

### `Bonus` Table

| Column | Type |
| ------ | ---- |
| empId  | int  |
| bonus  | int  |

Not every employee has a bonus record.

---

## Objective

Return a list containing:

* `name` (employee name)
* `bonus` (bonus amount)

The query must include:

* Employees with a **bonus less than 1000**
* Employees with **no bonus recorded** (`NULL`)

---

## SQL Solution

```sql
SELECT e.name, b.bonus
FROM employee e
LEFT OUTER JOIN bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;
```

---

## Query Explanation

### SELECT

```sql
SELECT e.name, b.bonus
```

Selects:

* The employee name from the `Employee` table
* The bonus value from the `Bonus` table

---

### FROM

```sql
FROM employee e
```

Defines the main table of the query.

> The `Employee` table is used as the base to ensure all employees are considered.

---

### LEFT OUTER JOIN

```sql
LEFT OUTER JOIN bonus b
ON e.empId = b.empId
```

The `LEFT OUTER JOIN` ensures that:

* All employees appear in the result
* Bonus data is returned only when a matching record exists

When no bonus exists, the value will be `NULL`.

---

### WHERE with OR and IS NULL

```sql
WHERE b.bonus < 1000 OR b.bonus IS NULL
```

Applies the filtering criteria:

* Employees with a bonus **less than 1000**
* Employees **without a registered bonus**

The **OR** operator ensures that either condition is sufficient.

---

## Expected Result

| name | bonus |
| ---- | ----- |
| Brad | NULL  |
| John | 500   |
| Dan  | NULL  |

> Employees without a bonus or with a bonus below 1000 are included in the result.

---

## Conclusion

This challenge reinforces important SQL concepts:

* Use of **LEFT OUTER JOIN**
* Handling **NULL values**
* Applying filters with **WHERE** and **OR**

It is an excellent exercise to strengthen knowledge of **joins and data filtering** in SQL.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
