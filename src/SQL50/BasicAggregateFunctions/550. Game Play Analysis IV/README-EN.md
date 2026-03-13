# LeetCode SQL – 550. Game Play Analysis IV

## Challenge Description

The **"Game Play Analysis IV"** problem on LeetCode focuses on:

- Common Table Expressions (CTE)
- Aggregate functions (`MIN`, `COUNT`)
- Date manipulation
- `LEFT JOIN`
- Distinct counting
- Decimal conversion and formatting

The problem provides a single table:

---

### `Activity` Table

| Column     | Type |
|------------|------|
| player_id  | int  |
| device_id  | int  |
| event_date | date |
| games_played | int |

Each row represents a player logging into the game on a specific date.

---

## Objective

Return the fraction of players who:

- Logged in on the day **immediately after** their first login.

The result must:

- Be returned as `fraction`
- Rounded to **2 decimal places**

---

## SQL Solution (Based on My Implementation)

```sql
WITH FirstLogins AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login
    FROM 
        Activity
    GROUP BY 
        player_id
)
SELECT 
    CAST(
        COUNT(a.player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity) 
        AS DECIMAL(5,2)
    ) AS fraction
FROM 
    FirstLogins fl
LEFT JOIN 
    Activity a 
    ON fl.player_id = a.player_id 
    AND a.event_date = DATEADD(day, 1, fl.first_login);
```

---

## Query Explanation

### Step 1 – Identifying Each Player’s First Login (CTE)

```sql
WITH FirstLogins AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login
    FROM 
        Activity
    GROUP BY 
        player_id
)
```

This CTE:

- Groups records by `player_id`
- Uses `MIN(event_date)` to find each player’s first login date

Result:

- One row per player
- Their earliest login date

---

### Step 2 – Joining to Check Next-Day Login

```sql
LEFT JOIN Activity a 
ON fl.player_id = a.player_id 
AND a.event_date = DATEADD(day, 1, fl.first_login)
```

Explanation:

- `DATEADD(day, 1, fl.first_login)` calculates the next day after first login
- The join checks whether the player logged in exactly one day later

If a match exists:

- That player returned the next day

If no match exists:

- The player did not return the next day

---

### Step 3 – Counting Returning Players

```sql
COUNT(a.player_id)
```

This counts how many players:

- Had a login on the day after their first login

Because it counts values from the joined table (`a`), only successful matches are counted.

---

### Step 4 – Counting Total Players

```sql
(SELECT COUNT(DISTINCT player_id) FROM Activity)
```

This subquery returns:

- The total number of unique players in the system

This is necessary to compute the fraction:

```
(players who returned next day) / (total players)
```

---

### Step 5 – Forcing Decimal Division

```sql
COUNT(a.player_id) * 1.0
```

Multiplying by `1.0` ensures:

- The division is decimal
- Avoids integer division issues

---

### Step 6 – Formatting the Result

```sql
CAST(... AS DECIMAL(5,2))
```

This ensures:

- The final result has exactly 2 decimal places
- Matches the problem requirement

---

## Why This Works

- The CTE isolates each player’s first login
- The `LEFT JOIN` checks for next-day activity
- `COUNT` measures returning players
- `COUNT(DISTINCT)` measures total players
- `1.0` ensures decimal precision
- `CAST` formats the result correctly

Each component directly satisfies a requirement of the problem.

---

## Example

### Activity Table

| player_id | event_date |
|------------|------------|
| 1          | 2023-01-01 |
| 1          | 2023-01-02 |
| 2          | 2023-01-05 |
| 3          | 2023-01-07 |
| 3          | 2023-01-08 |

---

### First Logins

- Player 1 → 2023-01-01  
- Player 2 → 2023-01-05  
- Player 3 → 2023-01-07  

---

### Next-Day Returns

- Player 1 → Returned on 2023-01-02 ✅  
- Player 2 → Did not return next day ❌  
- Player 3 → Returned on 2023-01-08 ✅  

Returning players = 2  
Total players = 3  

Fraction:

```
2 / 3 = 0.67
```

---

## Conclusion

This challenge reinforces:

- First-event analysis using `MIN`
- Date manipulation with `DATEADD`
- Using `LEFT JOIN` for conditional matching
- Calculating fractions properly
- Preventing integer division errors
- Formatting numeric output correctly

It is an excellent problem for mastering retention analysis in SQL.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***