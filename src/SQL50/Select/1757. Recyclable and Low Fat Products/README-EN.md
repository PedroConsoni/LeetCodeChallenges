# LeetCode SQL – 1757. Recyclable and Low Fat Products

## Challenge Description

The **"Recyclable and Low Fat Products"** challenge on LeetCode focuses on practicing the use of the **WHERE clause** with multiple conditions using the **AND** logical operator.

The problem provides one table:

### `Products` Table

| Column     | Type    |
|------------|---------|
| product_id | int     |
| low_fats   | enum    |
| recyclable | enum    |

- `low_fats` can be either `'Y'` or `'N'`
- `recyclable` can be either `'Y'` or `'N'`

---

## Objective

Return the IDs of products that are:

- **Low fat**
- **Recyclable**

The result should contain:

* `product_id`

---

## SQL Solution (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT product_id
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

---

## Query Explanation

### SELECT

```sql
SELECT product_id
```

Selects the column required in the final result.

The challenge only asks for the product ID.

---

### FROM

```sql
FROM products
```

Defines the table from which the data will be retrieved.

---

### WHERE Condition

```sql
WHERE low_fats = 'Y' AND recyclable = 'Y'
```

This condition filters rows based on **two requirements**:

- `low_fats = 'Y'` → The product must be low fat.
- `recyclable = 'Y'` → The product must be recyclable.

The **AND operator** ensures that both conditions must be TRUE at the same time.

If either condition is false, the product will not appear in the result.

---

## Example

### Input

| product_id | low_fats | recyclable |
|------------|----------|------------|
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |

---

### Output

| product_id |
|------------|
| 1          |
| 3          |

Only products 1 and 3 meet both conditions.

---

## Key Concepts Reinforced

This challenge reinforces fundamental SQL concepts:

* Use of the **WHERE** clause
* Logical operator **AND**
* Filtering based on multiple conditions
* Boolean-like filtering using categorical values ('Y' / 'N')

---

## Conclusion

Although simple, this challenge is important because it strengthens the foundation of conditional filtering in SQL.

Understanding how logical operators like **AND** work is essential for writing precise queries in data analysis, data engineering, and back-end development scenarios.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***