# LeetCode SQL – 1141. User Activity for the Past 30 Days I

## Challenge Description

The **"User Activity for the Past 30 Days I"** problem on LeetCode focuses on:

- Filtering with `WHERE`
- Date range filtering using `BETWEEN`
- Aggregation with `COUNT`
- Removing duplicates using `DISTINCT`
- Grouping results with `GROUP BY`

The problem provides a single table:

### `Activity` Table

| Column        | Type |
|--------------|------|
| user_id      | int  |
| session_id   | int  |
| activity_date| date |
| activity_type| enum |

Each row represents a user activity on a specific date.

A user may appear multiple times on the same day because:
- They can have multiple sessions
- They can perform multiple activities

---

## Objective

Return the number of **active users per day** during the 30-day period ending on **2019-07-27**.

The required output format:

| day | active_users |
|-----|--------------|

Where:

- `day` = Activity date  
- `active_users` = Number of distinct users active on that day  

---

## SQL Solution (Based on My Implementation)

```sql
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;
```

---

## Query Explanation

### Step 1 – Filtering the 30-Day Period

```sql
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
```

The `BETWEEN` operator filters rows within a date range.

Important:

- `BETWEEN` is inclusive
- Both start and end dates are included

This ensures we only analyze activity within the required 30-day window.

---

### Step 2 – Grouping by Date

```sql
GROUP BY activity_date
```

The `GROUP BY` clause groups all records that share the same `activity_date`.

This allows us to calculate the number of active users **per day** instead of one total for the entire period.

---

### Step 3 – Counting Unique Users

```sql
COUNT(DISTINCT user_id)
```

- `COUNT()` counts records
- `DISTINCT` removes duplicates before counting

This ensures that:

- If a user had multiple sessions on the same day, they are counted only once
- We measure daily active users correctly

---

### Step 4 – Renaming Columns

```sql
activity_date AS day
COUNT(DISTINCT user_id) AS active_users
```

Aliases improve readability and match the required output format:

- `activity_date` → `day`
- Aggregated count → `active_users`

---

## Why This Works

- `BETWEEN` correctly filters the required date interval
- `GROUP BY` separates data by day
- `COUNT(DISTINCT ...)` guarantees accurate daily active user counting
- The query performs filtering and aggregation efficiently

This is the cleanest and most optimized solution.

---

## Example

If the table contains:

| user_id | session_id | activity_date | activity_type |
|----------|------------|--------------|--------------|
| 1        | 1          | 2019-07-20   | open_session |
| 1        | 2          | 2019-07-20   | scroll_down  |
| 2        | 1          | 2019-07-20   | open_session |
| 1        | 3          | 2019-07-21   | send_message |

### Step-by-step reasoning

### 2019-07-20:
Users: 1, 1, 2  
Distinct users: 1, 2  
Total active users = 2  

### 2019-07-21:
Users: 1  
Total active users = 1  

---

## Final Output

| day        | active_users |
|------------|--------------|
| 2019-07-20 | 2            |
| 2019-07-21 | 1            |

---

## Conclusion

This challenge reinforces essential SQL skills:

- Date filtering
- Aggregation
- Removing duplicates with `DISTINCT`
- Grouping results by time
- Using aliases for cleaner output

It is a fundamental exercise for understanding daily active user calculations in real-world data analysis.