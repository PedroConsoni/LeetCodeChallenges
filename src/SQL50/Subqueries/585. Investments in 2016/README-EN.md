# LeetCode SQL – 585. Investments in 2016

## Challenge Description

The **"Investments in 2016"** problem on LeetCode focuses on:

- Using **window functions**
- Partitioning data with **PARTITION BY**
- Applying **aggregation with SUM**
- Filtering based on grouped conditions
- Handling **numeric formatting**

The problem provides a single table:

### `Insurance` Table

| Column   | Type |
|----------|------|
| pid      | int  |
| tiv_2015 | float |
| tiv_2016 | float |
| lat      | float |
| lon      | float |

Each row represents an **insurance policy**.

Where:

- `tiv_2015` → Total investment value in **2015**
- `tiv_2016` → Total investment value in **2016**
- `lat` and `lon` → Geographic coordinates of the policy

---

## Objective

Calculate the **sum of `tiv_2016`** for policies that satisfy **two conditions**:

1. The policy must have a **`tiv_2015` value that appears more than once** in the table.
2. The **location (`lat`, `lon`) must be unique** (no other policy shares the same coordinates).

The final result must:

- Return the **sum of `tiv_2016`**
- Be formatted with **two decimal places**

---

## SQL Solution (Based on My Implementation)

```sql
WITH CTE AS (
    SELECT 
        tiv_2016,
        COUNT(*) OVER(PARTITION BY tiv_2015) as cnt_tiv_2015,
        COUNT(*) OVER(PARTITION BY lat, lon) as cnt_lat_lon
    FROM Insurance
)
SELECT 
    CAST(SUM(tiv_2016) AS DECIMAL(18, 2)) AS tiv_2016
FROM CTE
WHERE 
    cnt_tiv_2015 > 1
    AND cnt_lat_lon = 1;
```

---

## Query Explanation

### Step 1 – Creating a CTE with Window Functions

```sql
WITH CTE AS (
```

A **Common Table Expression (CTE)** is created to simplify the logic of the query.

Instead of performing multiple subqueries, we calculate useful metrics using **window functions**.

---

### Step 2 – Counting Policies with the Same `tiv_2015`

```sql
COUNT(*) OVER(PARTITION BY tiv_2015) as cnt_tiv_2015
```

This window function counts how many policies share the **same `tiv_2015` value**.

Example:

| tiv_2015 | count |
|----------|-------|
| 10       | 2     |
| 10       | 2     |
| 20       | 1     |

Only values where the count is **greater than 1** will satisfy the problem condition.

---

### Step 3 – Counting Policies with the Same Location

```sql
COUNT(*) OVER(PARTITION BY lat, lon) as cnt_lat_lon
```

This counts how many policies share the **same geographic location**.

Example:

| lat | lon | count |
|-----|-----|-------|
| 10  | 20  | 2     |
| 10  | 20  | 2     |
| 15  | 30  | 1     |

The challenge requires **unique locations**, meaning the count must equal **1**.

---

### Step 4 – Filtering Valid Policies

```sql
WHERE 
    cnt_tiv_2015 > 1
    AND cnt_lat_lon = 1
```

This ensures that:

- The `tiv_2015` value appears **more than once**
- The `(lat, lon)` location is **unique**

Only policies that satisfy **both conditions** are included.

---

### Step 5 – Summing the Investment Value

```sql
SUM(tiv_2016)
```

This calculates the total **investment value in 2016** for all valid policies.

---

### Step 6 – Formatting the Result

```sql
CAST(SUM(tiv_2016) AS DECIMAL(18, 2))
```

The result is converted to a **decimal number with two decimal places**, as required by the problem.

---

## Why This Works

This solution is efficient because:

- **Window functions** allow counting values without collapsing rows
- `PARTITION BY` groups data logically without using subqueries
- The **CTE improves readability**
- Filtering conditions are applied only after computing the counts

This approach keeps the query **clean, readable, and scalable**.

---

## Example

If the table contains:

| pid | tiv_2015 | tiv_2016 | lat | lon |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 10       | 15       | 20  | 20  |
| 3   | 20       | 20       | 10  | 10  |
| 4   | 30       | 25       | 30  | 30  |

Valid rows must satisfy:

- `tiv_2015` appears more than once
- `(lat, lon)` appears only once

After filtering, only the valid policies remain, and their `tiv_2016` values are summed.

---

## Conclusion

This challenge reinforces important SQL concepts:

- **Window functions**
- **Partitioning data**
- **Conditional filtering**
- **Aggregation with SUM**
- **Numeric formatting**

It is an excellent exercise for mastering **analytical SQL queries and window functions**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***