# LeetCode SQL – 602. Friend Requests II: Who Has the Most Friends

## Challenge Description

The **"Friend Requests II: Who Has the Most Friends"** problem on LeetCode focuses on:

- Working with **Common Table Expressions (CTE)**
- Combining results using **UNION ALL**
- Aggregating data with **COUNT**
- Grouping results with **GROUP BY**
- Sorting and limiting results using **ORDER BY** and **TOP**

The problem provides a single table:

### `RequestAccepted` Table

| Column        | Type |
|---------------|------|
| requester_id  | int  |
| accepter_id   | int  |
| accept_date   | date |

Each row represents a **friend request that was accepted** between two users.

This means:

- `requester_id` sent the friend request
- `accepter_id` accepted the friend request

Once accepted, **both users become friends**.

---

## Objective

Find the **user who has the highest number of friends**.

The result must return:

- `id` → the user ID
- `num` → total number of friends that user has

If multiple users exist, return the **one with the highest friend count**.

---

## SQL Solution (Based on My Implementation)

```sql
WITH AllFriends AS (
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
)

SELECT TOP 1 
    id, 
    COUNT(id) AS num
FROM AllFriends
GROUP BY id
ORDER BY num DESC;
```

---

## Query Explanation

### Step 1 – Creating a Unified Friend List

```sql
WITH AllFriends AS (
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
)
```

This **CTE (Common Table Expression)** creates a temporary result set called `AllFriends`.

The idea is to **treat both participants of a friendship equally**.

From the original table:

- `requester_id` is one friend
- `accepter_id` is the other friend

Using `UNION ALL`, we stack both columns into a **single column called `id`**.

Example transformation:

Original table:

| requester_id | accepter_id |
|--------------|-------------|
| 1            | 2           |
| 1            | 3           |
| 2            | 3           |

After the CTE:

| id |
|----|
| 1  |
| 1  |
| 2  |
| 2  |
| 3  |
| 3  |

Each appearance represents **one friendship connection**.

---

### Step 2 – Counting Friends per User

```sql
COUNT(id) AS num
```

After combining all friendships into a single column, we count how many times each user appears.

Each occurrence represents **one friendship relationship**.

So:

- More occurrences → more friends.

---

### Step 3 – Grouping by User

```sql
GROUP BY id
```

This groups all rows by user ID so that we can count friendships **per user**.

Example grouped result:

| id | num |
|----|-----|
| 1  | 2   |
| 2  | 2   |
| 3  | 2   |

---

### Step 4 – Sorting by Number of Friends

```sql
ORDER BY num DESC
```

This sorts users by **highest friend count first**.

---

### Step 5 – Returning Only the Top User

```sql
TOP 1
```

`TOP 1` ensures that we return **only the user with the highest number of friends**.

Final result format:

| id | num |
|----|-----|
| 3  | 5   |

---

## Why This Works

This approach works efficiently because:

- `UNION ALL` combines both sides of the friendship relationship
- The CTE simplifies the dataset into a single column
- `COUNT` calculates total friendships
- `GROUP BY` aggregates results per user
- `ORDER BY DESC` identifies the user with the most friends
- `TOP 1` returns only the highest result

This avoids complicated joins and keeps the query **clean and scalable**.

---

## Example

If the table contains:

| requester_id | accepter_id |
|--------------|-------------|
| 1            | 2           |
| 1            | 3           |
| 2            | 3           |
| 3            | 4           |

After processing, the counts would be:

| id | num |
|----|-----|
| 1  | 2   |
| 2  | 2   |
| 3  | 3   |
| 4  | 1   |

Final output:

| id | num |
|----|-----|
| 3  | 3   |

Because **user 3 has the highest number of friends**.

---

## Conclusion

This challenge reinforces several important SQL concepts:

- Transforming datasets with **CTEs**
- Combining results using **UNION ALL**
- Aggregating data with **COUNT**
- Grouping records using **GROUP BY**
- Ranking results using **ORDER BY**

It is a great exercise for understanding how to **normalize relationship data and perform aggregations efficiently**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***