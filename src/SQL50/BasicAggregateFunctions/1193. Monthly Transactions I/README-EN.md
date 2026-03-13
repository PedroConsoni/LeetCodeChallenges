# LeetCode SQL – 1193. Monthly Transactions I

## Challenge Description

The **"Monthly Transactions I"** problem on LeetCode focuses on:

- Date formatting
- Aggregate functions (`COUNT`, `SUM`)
- Conditional aggregation with `CASE WHEN`
- Grouping by multiple columns
- Generating monthly reports

The problem provides a single table:

---

### `Transactions` Table

| Column     | Type |
|------------|------|
| id         | int  |
| country    | varchar |
| state      | varchar |
| amount     | int  |
| trans_date | date |

Each row represents a financial transaction with:

- The country where it occurred
- The transaction state (`approved` or other)
- The transaction amount
- The transaction date

---

## Objective

For each **month and country**, return:

- `month` (formatted as `YYYY-MM`)
- `country`
- Total number of transactions (`trans_count`)
- Number of approved transactions (`approved_count`)
- Total transaction amount (`trans_total_amount`)
- Total approved transaction amount (`approved_total_amount`)

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    LEFT(CONVERT(VARCHAR, trans_date, 120), 7) AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    LEFT(CONVERT(VARCHAR, trans_date, 120), 7), country;
```

---

## Query Explanation

### Step 1 – Extracting the Month

```sql
LEFT(CONVERT(VARCHAR, trans_date, 120), 7)
```

This part formats the date:

1. `CONVERT(VARCHAR, trans_date, 120)`
   - Converts the date to string format `YYYY-MM-DD`

2. `LEFT(..., 7)`
   - Extracts only the first 7 characters
   - Result: `YYYY-MM`

This creates a monthly grouping key.

---

### Step 2 – Counting Total Transactions

```sql
COUNT(*) AS trans_count
```

Counts all transactions per:

- Month
- Country

Because we use `GROUP BY`, this count is calculated for each combination.

---

### Step 3 – Counting Approved Transactions

```sql
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)
```

How it works:

- Returns `1` if the transaction is approved
- Returns `0` otherwise
- Summing these values gives the total number of approved transactions

---

### Step 4 – Calculating Total Transaction Amount

```sql
SUM(amount) AS trans_total_amount
```

Adds up all transaction amounts per month and country.

---

### Step 5 – Calculating Approved Transaction Amount

```sql
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)
```

How it works:

- If approved → add the amount
- Otherwise → add 0
- The sum gives the total approved amount

---

### Step 6 – Grouping the Results

```sql
GROUP BY LEFT(CONVERT(VARCHAR, trans_date, 120), 7), country
```

This ensures:

- One row per month per country
- All calculations are separated accordingly

Without grouping by both fields, the results would be incorrect.

---

## Why This Works

- Date conversion creates a monthly reporting format
- `COUNT` provides total volume
- `SUM` calculates monetary totals
- `CASE WHEN` enables conditional aggregation
- `GROUP BY` ensures correct data segmentation

Each column in the SELECT corresponds to a specific reporting requirement.

---

## Example

### Transactions Table

| id | country | state     | amount | trans_date |
|----|---------|----------|--------|------------|
| 1  | US      | approved | 100    | 2023-01-10 |
| 2  | US      | declined | 200    | 2023-01-15 |
| 3  | US      | approved | 150    | 2023-02-05 |
| 4  | BR      | approved | 300    | 2023-01-20 |

---

### Result

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|---------|---------|------------|----------------|-------------------|-----------------------|
| 2023-01 | US      | 2          | 1              | 300               | 100                   |
| 2023-02 | US      | 1          | 1              | 150               | 150                   |
| 2023-01 | BR      | 1          | 1              | 300               | 300                   |

---

## Conclusion

This challenge reinforces:

- Monthly aggregation logic
- Date manipulation techniques
- Conditional counting
- Financial aggregation
- Multi-column grouping

It is an excellent real-world reporting exercise using SQL.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***