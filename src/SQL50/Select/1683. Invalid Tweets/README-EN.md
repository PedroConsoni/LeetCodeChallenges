# LeetCode SQL – 1683. Invalid Tweets

## Challenge Description

The **"Invalid Tweets"** challenge on LeetCode focuses on practicing the use of the **WHERE clause** and **string functions**, specifically the `LENGTH()` function in PostgreSQL.

The problem provides one table:

### `Tweets` Table

| Column    | Type    |
|-----------|---------|
| tweet_id  | int     |
| content   | varchar |

- Each row represents a tweet.
- The `content` column stores the text of the tweet.

According to the problem, a tweet is considered **invalid** if its content length is **strictly greater than 15 characters**.

---

## Objective

Return the IDs of tweets that are **invalid**.

The result should contain:

* `tweet_id`

---

## SQL Solution (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 15;
```

---

## Query Explanation

### SELECT

```sql
SELECT tweet_id
```

Selects the column required in the final result.

The challenge only asks for the `tweet_id`.

---

### FROM

```sql
FROM tweets
```

Defines the table from which the data will be retrieved.

---

### WHERE

```sql
WHERE LENGTH(content) > 15
```

This condition filters tweets based on the length of their content.

- `LENGTH(content)` calculates the number of characters in the tweet.
- `> 15` ensures that only tweets with more than 15 characters are returned.

If the content has 15 characters or fewer, the tweet is considered valid and will not appear in the result.

---

## Example

### Input

| tweet_id | content               |
|-----------|----------------------|
| 1         | Vote for Biden       |
| 2         | Let us make America great again! |

---

### Output

| tweet_id |
|----------|
| 2        |

Tweet 2 is invalid because its content contains more than 15 characters.

---

## Key Concepts Reinforced

This challenge reinforces important SQL fundamentals:

* Use of the **WHERE** clause
* String functions such as **LENGTH()**
* Filtering data based on computed values
* Understanding conditional expressions

---

## Conclusion

Although simple, this challenge highlights how SQL can filter data using built-in functions.

Understanding how to work with string functions is essential in real-world scenarios involving text processing, data validation, and data quality checks.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***