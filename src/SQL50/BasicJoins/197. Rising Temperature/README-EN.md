# LeetCode SQL – Rising Temperature

## Challenge Description

The **"Rising Temperature"** problem on LeetCode focuses on practicing **window functions**, especially the use of `LAG()`.

The problem provides a table:

### `Weather` Table

| Column      | Type |
|------------|------|
| id         | int  |
| recordDate | date |
| temperature| int  |

Each row represents the temperature recorded on a specific date.

---

## Objective

Return the `id` of all records where:

- The temperature is **higher than the previous day**
- The previous day is **exactly one calendar day before**

Important:

- We must compare consecutive calendar days
- If dates are not exactly one day apart, they must be ignored

---

## SQL Solution (Based on My Implementation)

```sql
SELECT id
FROM (
    SELECT
        id,
        temperature,
        recordDate,
        LAG(temperature) OVER(ORDER BY recordDate) as prev_temp,
        LAG(recordDate) OVER(ORDER BY recordDate) as prev_date
    FROM weather
) as temp_comparison
WHERE temperature > prev_temp
    AND DATEDIFF(day, prev_date, recordDate) = 1;
```

---

## Query Explanation

### Step 1 – Subquery

The subquery creates two new columns:

- `prev_temp` → Temperature from the previous row
- `prev_date` → Date from the previous row

This is done using the `LAG()` window function.

---

### Step 2 – Using LAG()

```sql
LAG(temperature) OVER(ORDER BY recordDate)
```

Returns the temperature from the previous row ordered by `recordDate`.

```sql
LAG(recordDate) OVER(ORDER BY recordDate)
```

Returns the previous date.

> `ORDER BY recordDate` guarantees chronological comparison.

---

### Step 3 – Filtering Conditions

```sql
WHERE temperature > prev_temp
```

Ensures the current temperature is higher than the previous one.

```sql
AND DATEDIFF(day, prev_date, recordDate) = 1
```

Ensures the two dates are exactly one day apart.

This is necessary because:

- The table may contain missing dates
- We must only compare consecutive calendar days

---

## Example

If the table contains:

| id | recordDate  | temperature |
|----|------------|------------|
| 1  | 2015-01-01 | 10         |
| 2  | 2015-01-02 | 25         |
| 3  | 2015-01-03 | 20         |
| 4  | 2015-01-04 | 30         |

The result will be:

| id |
|----|
| 2  |
| 4  |

Because:

- Day 2 > Day 1
- Day 4 > Day 3

---

## Conclusion

This challenge reinforces:

- Window functions
- Practical use of `LAG()`
- Proper date comparison
- Handling time-series gaps

It is a very important exercise for anyone studying SQL for Data Engineering or Analytics.

---