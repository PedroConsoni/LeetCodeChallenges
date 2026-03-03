# LeetCode SQL – Second Highest Salary

## Challenge Description

The **"Second Highest Salary"** challenge on LeetCode focuses on practicing **subqueries** and **aggregate functions** in SQL.

The goal is to find the **second highest salary** from the `Employee` table.

---

## Table Structure

### `Employee` Table

| Column | Type |
| ------ | ---- |
| id     | int  |
| salary | int  |

The table may contain multiple employees with the same salary.

---

## Objective

Return the **second highest salary** among all employees.

* If there is no second highest salary, the query should return `NULL`.

### Expected column:

* `secondhighestsalary`

---

## SQL Solution

```sql
SELECT MAX(salary) AS secondhighestsalary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);
```

---

## Query Explanation

###  Subquery – Highest Salary

```sql
(SELECT MAX(salary) FROM employee)
```

This subquery retrieves the **highest salary** from the `Employee` table.

---

### WHERE (Exclude the Highest Salary)

```sql
WHERE salary < (SELECT MAX(salary) FROM employee)
```

Filters out employees who earn the **maximum salary**, leaving only salaries **lower than the highest one**.

---

### MAX on Filtered Result

```sql
SELECT MAX(salary) AS secondhighestsalary
```

From the remaining salaries, `MAX(salary)` returns the **largest value**, which corresponds to the **second highest salary**.

---

## Example

### Employee Table

| id | salary |
| -- | ------ |
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

### Result

| secondhighestsalary |
| ------------------- |
| 200                 |

---

## Edge Case

If all employees have the **same salary**, the subquery removes all rows, and the result will be:

| secondhighestsalary |
| ------------------- |
| NULL                |

This behavior matches the requirements of the challenge.

---

## Conclusion

This challenge reinforces key SQL concepts:

* Use of **subqueries**
* Application of **aggregate functions (MAX)**
* Handling **edge cases** with `NULL` results

It is a fundamental exercise for mastering **SQL querying logic and problem solving**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
