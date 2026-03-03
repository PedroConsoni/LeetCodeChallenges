# LeetCode SQL – Employees Earning More Than Their Managers

## Challenge Description

The **"Employees Earning More Than Their Managers"** challenge on LeetCode focuses on practicing **SELF JOINs** in SQL, where a table is joined with itself to compare related records.

In this problem, we need to identify employees who earn a **higher salary than their own managers**.

---

## Table Structure

### `Employee` Table

| Column    | Type    |
| --------- | ------- |
| id        | int     |
| name      | varchar |
| salary    | int     |
| managerId | int     |

Each employee may have a manager, indicated by the `managerId` column, which references the `id` of another employee in the same table.

---

## Objective

Return the names of employees whose **salary is greater than the salary of their managers**.

### Expected column:

* `Employee` (employee name)

---

## SQL Solution

```sql
SELECT e.name AS Employee
FROM employee e
JOIN employee m
ON e.managerid = m.id
WHERE e.salary > m.salary;
```

---

## Query Explanation

### SELF JOIN

```sql
FROM employee e
JOIN employee m
```

The `employee` table is used twice:

* `e` represents the **employee**
* `m` represents the **manager**

This allows comparison between employees and their managers within the same table.

---

### Join Condition (ON)

```sql
ON e.managerid = m.id
```

Defines the relationship:

* The employee's `managerId` (`e`) matches the manager's `id` (`m`).

---

### WHERE (Salary Comparison)

```sql
WHERE e.salary > m.salary
```

Filters only the employees whose salary is **greater than their manager's salary**.

---

## Expected Result

| Employee |
| -------- |
| Joe      |
| Sam      |

> Only employees who earn more than their managers appear in the result.

---

## Conclusion

This challenge reinforces important SQL concepts:

* Use of **SELF JOIN**
* Comparing records within the same table
* Applying filters with **WHERE**

It is an essential exercise for understanding **hierarchical relationships** in databases.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
