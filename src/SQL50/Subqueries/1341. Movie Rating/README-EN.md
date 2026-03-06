# LeetCode SQL – 1341. Movie Rating

## Challenge Description

The **"Movie Rating"** problem on LeetCode focuses on practicing:

- Common Table Expressions (`WITH`)
- Aggregations using `COUNT` and `AVG`
- Table joins with `INNER JOIN`
- Sorting with multiple conditions
- Combining results using `UNION ALL`

The problem provides three tables:

### `Users` Table

| Column | Type |
|------|------|
| user_id | int |
| name | varchar |

Each row represents a user who can rate movies.

---

### `Movies` Table

| Column | Type |
|------|------|
| movie_id | int |
| title | varchar |

Each row represents a movie.

---

### `MovieRating` Table

| Column | Type |
|------|------|
| movie_id | int |
| user_id | int |
| rating | int |
| created_at | date |

Each row represents a rating given by a user to a movie.

---

## Objective

Return **two results**:

1. The **name of the user who rated the greatest number of movies**.
2. The **title of the movie with the highest average rating in February 2020**.

Rules:

- If multiple users have the same number of ratings, return the **lexicographically smallest name**.
- If multiple movies have the same average rating, return the **lexicographically smallest title**.

The final output should contain:

| results |

With exactly **two rows**.

---

## SQL Solution (Based on My Implementation)

```sql
WITH TopUser AS ( 
    SELECT TOP 1 name AS results
    FROM Users 
    INNER JOIN MovieRating ON Users.user_id = MovieRating.user_id
    GROUP BY Users.user_id, name
    ORDER BY COUNT(movie_id) DESC, name ASC
),
TopMovie AS (
    SELECT TOP 1 title AS results
    FROM Movies
    INNER JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
    WHERE created_at >= '2020-02-01' AND created_at <= '2020-02-29'
    GROUP BY Movies.movie_id, title
    ORDER BY AVG(CAST(rating AS FLOAT)) DESC, title ASC
)

SELECT results FROM TopUser
UNION ALL
SELECT results FROM TopMovie;
```

---

## Query Explanation

### Step 1 – Finding the User Who Rated the Most Movies

```sql
WITH TopUser AS (
```

A **Common Table Expression (CTE)** is created to determine the user who rated the largest number of movies.

```sql
SELECT TOP 1 name AS results
```

`TOP 1` ensures that only **one result** is returned.

The column is renamed to `results` to match the final output format.

---

### Step 2 – Joining Users and Movie Ratings

```sql
FROM Users 
INNER JOIN MovieRating ON Users.user_id = MovieRating.user_id
```

This join connects:

- The **Users table**
- The **MovieRating table**

This allows us to see **which user rated which movie**.

---

### Step 3 – Counting Ratings Per User

```sql
GROUP BY Users.user_id, name
```

The query groups rows by each user.

Then the ordering logic determines which user appears first.

```sql
ORDER BY COUNT(movie_id) DESC, name ASC
```

Sorting rules:

1. Highest number of ratings first
2. If there is a tie, the **alphabetically smallest name wins**

---

### Step 4 – Finding the Movie With the Highest Average Rating

```sql
TopMovie AS (
```

A second CTE is created to determine the **highest-rated movie in February 2020**.

```sql
SELECT TOP 1 title AS results
```

Again, only **one result** is returned.

---

### Step 5 – Joining Movies With Ratings

```sql
FROM Movies
INNER JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
```

This join connects:

- The **Movies table**
- The **MovieRating table**

Allowing us to analyze movie ratings.

---

### Step 6 – Filtering Ratings From February 2020

```sql
WHERE created_at >= '2020-02-01' AND created_at <= '2020-02-29'
```

This condition ensures that **only ratings created during February 2020** are considered.

---

### Step 7 – Calculating the Average Rating

```sql
GROUP BY Movies.movie_id, title
```

Ratings are grouped by movie.

Then the sorting logic is applied:

```sql
ORDER BY AVG(CAST(rating AS FLOAT)) DESC, title ASC
```

Sorting rules:

1. Highest **average rating** first
2. If tied, the **alphabetically smallest title wins**

The `CAST` ensures the average calculation is treated as a floating-point number.

---

### Step 8 – Combining the Results

```sql
SELECT results FROM TopUser
UNION ALL
SELECT results FROM TopMovie;
```

The final step combines the two results:

1. The top user
2. The top movie

`UNION ALL` keeps **both rows without removing duplicates**.

---

## Why This Works

This solution works because:

- `WITH` allows splitting the logic into clear steps
- `INNER JOIN` connects related data across tables
- `COUNT` identifies the most active user
- `AVG` determines the best-rated movie
- Sorting rules resolve ties correctly
- `UNION ALL` merges the two final results

Together, these techniques efficiently extract the required insights from the dataset.

---

## Example

If the tables contain data like:

### Users

| user_id | name |
|---|---|
| 1 | Daniel |
| 2 | Monica |
| 3 | Maria |

### Movies

| movie_id | title |
|---|---|
| 1 | Avengers |
| 2 | Frozen |
| 3 | Joker |

### MovieRating

| movie_id | user_id | rating | created_at |
|---|---|---|---|
| 1 | 1 | 5 | 2020-02-10 |
| 2 | 1 | 3 | 2020-02-12 |
| 3 | 2 | 4 | 2020-02-20 |
| 1 | 3 | 4 | 2020-01-15 |

Possible final result:

| results |
|---|
| Daniel |
| Avengers |

---

## Conclusion

This challenge reinforces several important SQL concepts:

- Using CTEs for structured query design
- Joining multiple tables
- Performing aggregations (`COUNT`, `AVG`)
- Handling tie-breaking with ordered conditions
- Combining result sets with `UNION ALL`

It demonstrates how SQL can extract **multiple analytical insights from relational datasets in a single query**.