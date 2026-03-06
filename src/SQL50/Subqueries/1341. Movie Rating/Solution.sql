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