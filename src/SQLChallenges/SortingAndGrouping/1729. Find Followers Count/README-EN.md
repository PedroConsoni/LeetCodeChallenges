# LeetCode SQL – 1729. Find Followers Count

## Challenge Description

The **"Find Followers Count"** problem on LeetCode focuses on:

- Aggregation with `COUNT`
- Grouping data with `GROUP BY`
- Understanding one-to-many relationships

The problem provides a single table:

### `Followers` Table

| Column       | Type |
|-------------|------|
| user_id     | int  |
| follower_id | int  |

Each row represents a relationship where:

- `follower_id` follows `user_id`

A user may appear multiple times because:
- They can have multiple followers

---

## Objective

For each `user_id`, return:

- The total number of followers they have

The output format:

| user_id | followers_count |
|---------|------------------|

Where:

- `user_id` = The user being followed  
- `followers_count` = Number of followers that user has  

---

## SQL Solution (Based on My Implementation)

```sql
SELECT user_id, COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id;
```

---

## Query Explanation

### Step 1 – Grouping by User

```sql
GROUP BY user_id
```

The `GROUP BY` clause groups all rows that share the same `user_id`.

This means:

- All follower relationships for the same user are treated as a single group
- Aggregation functions operate inside each user group

Without `GROUP BY`, we would get one total for the entire table.

---

### Step 2 – Counting Followers

```sql
COUNT(follower_id)
```

`COUNT()` counts the number of non-null values in the specified column.

Since each row represents one follower relationship:

- Each `follower_id` corresponds to one follower
- Counting them gives the total number of followers per user

---

### Step 3 – Renaming the Column

```sql
AS followers_count
```

The `AS` keyword creates an alias for the aggregated column.

Instead of returning:

```
COUNT(follower_id)
```

We rename it to:

```
followers_count
```

This improves readability and matches the expected output format.

---

## Why This Works

- Each row represents one follower relationship
- `GROUP BY user_id` isolates each user
- `COUNT(follower_id)` counts how many followers belong to each user
- The query performs aggregation efficiently in a single step

This is the simplest and most optimized solution.

---

## Example

If the table contains:

| user_id | follower_id |
|---------|-------------|
| 1       | 2           |
| 1       | 3           |
| 1       | 4           |
| 2       | 1           |
| 2       | 3           |

### Step-by-step reasoning

### User 1:
Followers: 2, 3, 4  
Total followers = 3  

### User 2:
Followers: 1, 3  
Total followers = 2  

---

## Final Output

| user_id | followers_count |
|---------|------------------|
| 1       | 3                |
| 2       | 2                |

---

## Conclusion

This challenge reinforces fundamental SQL concepts:

- Data aggregation
- Grouping records
- Counting related rows in one-to-many relationships
- Using aliases for clearer output

Although simple, it is an essential exercise for understanding relational data modeling and aggregation queries.