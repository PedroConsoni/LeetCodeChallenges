# LeetCode SQL – Combine Two Tables

## Challenge Description

The **"Combine Two Tables"** challenge on LeetCode aims to practice the use of **SQL JOINs**, specifically the **LEFT JOIN**.

The problem provides two tables:

### `Person` Table

| Column    | Type    |
| --------- | ------- |
| personID  | int     |
| firstname | varchar |
| lastname  | varchar |

### `Address` Table

| Column    | Type    |
| --------- | ------- |
| addressID | int     |
| personID  | int     |
| city      | varchar |
| state     | varchar |

Not every person has an address registered, and the challenge requires that **all people be returned**, even if no address exists.

---

## Objective

Return a list containing:

* `firstname`
* `lastname`
* `city`
* `state`

Ensuring that **all records from the `Person` table appear in the result**, even when `city` and `state` are `NULL`.

---

## SQL Solution

```sql
SELECT p.firstname, p.lastname, a.city, a.state
FROM person p
LEFT JOIN address a
ON p.personID = a.personID;
```

---

## Query Explanation

### SELECT

```sql
SELECT p.firstname, p.lastname, a.city, a.state
```

Selects the required fields:

* First name and last name from the `Person` table
* City and state from the `Address` table

---

### FROM

```sql
FROM person p
```

Defines the **base table** of the query.

> Since we want **all people**, the `Person` table must be the main table.

---

### LEFT JOIN

```sql
LEFT JOIN address a
```

The `LEFT JOIN` ensures that:

* All rows from the `Person` table are returned
* Data from the `Address` table appears only when a matching record exists

If a person **does not have an address**, the `city` and `state` columns will be `NULL`.

---

### ON (Join Condition)

```sql
ON p.personID = a.personID
```

Defines how the tables are related:

* The join occurs when `personID` matches in both tables

---

## Expected Result

| firstname | lastname | city     | state |
| --------- | -------- | -------- | ----- |
| John      | Doe      | New York | NY    |
| Jane      | Smith    | NULL     | NULL  |

> Even though `Jane Smith` does not have an address, she still appears in the result.

---

## Conclusion

This challenge reinforces fundamental SQL concepts:

* Use of **LEFT JOIN**
* Combining data from multiple tables
* Handling `NULL` values

It is an essential exercise for anyone learning **SQL for data analysis or back-end development**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
