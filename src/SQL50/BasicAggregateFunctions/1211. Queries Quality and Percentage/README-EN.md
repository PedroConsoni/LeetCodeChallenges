# LeetCode SQL – 1211. Queries Quality and Percentage

## Challenge Description

The **"Queries Quality and Percentage"** problem on LeetCode focuses on:

- Aggregate functions (`AVG`)
- Conditional logic with `CASE WHEN`
- Arithmetic calculations
- Percentage calculations
- Rounding values with `ROUND`
- Grouping results with `GROUP BY`

The problem provides a single table:

---

### `Queries` Table

| Column     | Type |
|------------|------|
| query_name | varchar |
| result     | varchar |
| position   | int  |
| rating     | int  |

Each row represents a result returned for a specific query, along with its position and rating.

---

## Objective

For each `query_name`, return:

- `quality`: the average of `rating / position`
- `poor_query_percentage`: the percentage of queries with `rating < 3`

Both values must be rounded to **2 decimal places**.

Additionally:

- Rows where `query_name` is `NULL` must be excluded.

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    query_name,                
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,                
    ROUND(AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100, 2) AS poor_query_percentage
FROM 
    Queries                
WHERE 
    query_name IS NOT NULL
GROUP BY 
    query_name;
```

---

## Query Explanation

### Step 1 – Filtering NULL Query Names

```sql
WHERE query_name IS NOT NULL
```

This ensures:

- Only valid queries are considered
- Rows with `NULL` query names are excluded from calculations

---

### Step 2 – Calculating Query Quality

```sql
AVG(rating * 1.0 / position)
```

The formula for quality is:

```
rating / position
```

Important detail:

- `rating * 1.0` forces decimal division.
- Without `1.0`, SQL could perform integer division and lose precision.

The `AVG()` function calculates the average of this value for each `query_name`.

---

### Step 3 – Calculating Poor Query Percentage

```sql
AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100
```

This part works as follows:

1. `CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END`
   - Returns `1.0` if the rating is less than 3
   - Returns `0.0` otherwise

2. Taking the `AVG()` of this expression gives:
   - The fraction of rows where `rating < 3`

3. Multiplying by `100` converts it into a percentage.

Example:

If 2 out of 5 ratings are below 3:

```
AVG = 0.4
0.4 × 100 = 40.00%
```

---

### Step 4 – Rounding the Results

```sql
ROUND(..., 2)
```

Both calculated values are rounded to:

- Exactly **2 decimal places**
- Matching the problem requirement

---

### Step 5 – Grouping by Query Name

```sql
GROUP BY query_name
```

This ensures:

- One row per query
- Calculations are performed separately for each `query_name`

Without `GROUP BY`, the result would be a single overall calculation.

---

## Why This Works

- `WHERE` removes invalid data
- `AVG` calculates both mean quality and poor rate
- `CASE WHEN` transforms a condition into numeric values
- `1.0` ensures decimal precision
- `ROUND` formats output correctly
- `GROUP BY` separates calculations per query

Each part directly satisfies a requirement of the problem.

---

## Example

### Queries Table

| query_name | result | position | rating |
|------------|--------|----------|--------|
| Dog        | A      | 1        | 5      |
| Dog        | B      | 2        | 3      |
| Dog        | C      | 3        | 1      |
| Cat        | D      | 1        | 2      |
| Cat        | E      | 2        | 4      |

---

### Calculation

For **Dog**:

- Quality:
  - (5/1 + 3/2 + 1/3) / 3
- Poor percentage:
  - Only rating 1 is < 3 → 1 out of 3 → 33.33%

For **Cat**:

- Quality:
  - (2/1 + 4/2) / 2
- Poor percentage:
  - One rating < 3 out of 2 → 50.00%

---

## Conclusion

This challenge reinforces:

- Advanced use of `AVG`
- Conditional aggregation with `CASE`
- Percentage calculation techniques
- Avoiding integer division issues
- Proper data filtering
- Group-based reporting logic

It is an excellent exercise for mastering analytical SQL patterns.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***