# LeetCode SQL – 1068. Product Sales Analysis I

## Challenge Description

The **"Product Sales Analysis I"** challenge on LeetCode focuses on practicing **INNER JOIN** operations to combine related data from multiple tables.

The problem provides two tables:

### `Sales` Table

| Column     | Type |
|------------|------|
| sale_id    | int  |
| product_id | int  |
| year       | int  |
| quantity   | int  |
| price      | int  |

### `Product` Table

| Column       | Type    |
|--------------|---------|
| product_id   | int     |
| product_name | varchar |

- The `Sales` table contains sales information for products.
- The `Product` table contains product details.
- Both tables are related through the `product_id` column.

---

## Objective

Return a list containing:

* `product_name`
* `year`
* `price`

The result should include only records where there is a matching product in both tables.

---

## SQL Solution

```sql
SELECT p.product_name, s.year, s.price
FROM sales s
INNER JOIN product p
    ON s.product_id = p.product_id;
```

---

## Query Explanation

### SELECT

```sql
SELECT p.product_name, s.year, s.price
```

Selects:

- `product_name` from the `Product` table
- `year` from the `Sales` table
- `price` from the `Sales` table

---

### FROM

```sql
FROM sales s
```

Defines the base table of the query as `Sales`.

---

### INNER JOIN

```sql
INNER JOIN product p
```

The `INNER JOIN` ensures that:

- Only rows with matching `product_id` values in both tables are returned.
- If a product does not exist in the `Product` table, its sales will not appear in the result.

---

### ON (Join Condition)

```sql
ON s.product_id = p.product_id
```

Defines how the tables are connected:

- The join occurs when the `product_id` in `Sales` matches the `product_id` in `Product`.

---

## Example

### Input

#### Sales

| sale_id | product_id | year | quantity | price |
|----------|------------|------|----------|-------|
| 1        | 100        | 2008 | 10       | 5000  |
| 2        | 100        | 2009 | 12       | 5000  |
| 7        | 200        | 2011 | 15       | 9000  |

#### Product

| product_id | product_name |
|------------|--------------|
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |

---

### Output

| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 5000  |
| Nokia        | 2009 | 5000  |
| Apple        | 2011 | 9000  |

Only products with matching `product_id` in both tables appear.

---

## Key Concepts Reinforced

This challenge reinforces important SQL concepts:

* Use of **INNER JOIN**
* Combining data from related tables
* Defining join conditions correctly
* Selecting specific columns from multiple tables

---

## Conclusion

This exercise highlights how relational databases connect transactional data (sales) with descriptive data (product details).

Understanding `INNER JOIN` is fundamental for real-world analytics, reporting, and data engineering tasks where only matching records should be returned.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***