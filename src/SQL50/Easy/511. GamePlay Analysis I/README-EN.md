# LeetCode SQL – Last Login (First Login by Player)

## Challenge Description

The **"Last Login"** (also known as *First Login by Player*) challenge on LeetCode focuses on practicing **GROUP BY**, **aggregate functions**, and **ordering results** in SQL.

The goal is to determine the **first login date** for each player based on their activity records.

---

## Table Structure

### `Activity` Table

| Column       | Type |
| ------------ | ---- |
| player_id    | int  |
| device_id    | int  |
| event_date   | date |
| games_played | int  |

Each row represents a login activity of a player on a specific date.

---

## Objective

For each `player_id`, return:

* The player's ID
* The **first login date** (earliest `event_date`)

The result must be ordered by `player_id` in ascending order.

### Expected columns:

* `player_id`
* `first_login`

---

## SQL Solution

```sql
SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id
ORDER BY player_id ASC;
```

---

## Query Explanation

### MIN (Aggregate Function)

```sql
MIN(event_date)
```

Returns the **earliest date** for each player, which corresponds to their first login.

---

### GROUP BY

```sql
GROUP BY player_id
```

Groups all activity records by `player_id`, allowing aggregate functions to be applied per player.

---

### SELECT

```sql
SELECT player_id, MIN(event_date) AS first_login
```

Selects:

* The player identifier
* The earliest login date, renamed as `first_login`

---

### ORDER BY

```sql
ORDER BY player_id ASC
```

Sorts the result set by `player_id` in ascending order, as required by the challenge.

---

## Example

### Activity Table

| player_id | event_date |
| --------- | ---------- |
| 1         | 2016-03-01 |
| 1         | 2016-05-02 |
| 2         | 2017-06-25 |
| 3         | 2018-07-03 |
| 3         | 2018-07-04 |

### Result

| player_id | first_login |
| --------- | ----------- |
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2018-07-03  |

---

## Conclusion

This challenge reinforces key SQL concepts:

* Use of **aggregate functions (MIN)**
* Grouping data with **GROUP BY**
* Sorting results with **ORDER BY**

It is a fundamental exercise for working with **time-based data and aggregation logic** in SQL.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
