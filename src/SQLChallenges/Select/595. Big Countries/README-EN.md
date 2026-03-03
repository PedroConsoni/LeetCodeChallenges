# LeetCode SQL – Big Countries

## Challenge Description

The **"Big Countries"** challenge on LeetCode focuses on filtering data using the **WHERE clause** combined with logical operators.

The problem provides a table named `World` that stores information about different countries.

### `World` Table

| Column     | Type    |
| ---------- | ------- |
| name       | varchar |
| continent  | varchar |
| area       | int     |
| population | int     |
| gdp        | bigint  |

---

## Objective

Retrieve the following information for countries that meet **at least one** of the criteria below:

* `area` greater than or equal to **3,000,000**
* `population` greater than or equal to **25,000,000**

### Required columns:

* `name`
* `population`
* `area`

---

## SQL Solution

```sql
SELECT w.name, w.population, w.area
FROM world w
WHERE area >= 3000000 OR population >= 25000000;
```

---

## Query Explanation

### SELECT

```sql
SELECT w.name, w.population, w.area
```

Selects the required columns from the `World` table:

* Country name
* Population
* Area

---

### FROM

```sql
FROM world w
```

Defines the source table and assigns it an alias (`w`) to simplify references.

---

### WHERE with OR

```sql
WHERE area >= 3000000 OR population >= 25000000
```

Filters the records based on **logical conditions**:

* A country is included if its **area is large enough**
* **OR** if its **population is large enough**

Only one of the conditions needs to be true for the country to appear in the result.

---

## Expected Result

| name         | population | area     |
| ------------ | ---------- | -------- |
| Russia       | 144000000  | 17098246 |
| UnitedStates | 331000000  | 9833517  |
| China        | 1400000000 | 9596961  |

> Countries that satisfy either condition are considered **"big countries"**.

---

## Conclusion

This challenge reinforces key SQL concepts:

* Filtering data using the **WHERE** clause
* Applying **logical operators (OR)**
* Selecting specific columns from a table

It is a fundamental exercise for anyone learning **SQL basics and data filtering**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
