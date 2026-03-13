# LeetCode SQL – 1661. Average Time of Process per Machine

## Challenge Description

The **"Average Time of Process per Machine"** problem on LeetCode focuses on practicing **self joins**, aggregation functions, and grouping logic.

The problem provides a table:

### `Activity` Table

| Column        | Type    |
|--------------|---------|
| machine_id   | int     |
| process_id   | int     |
| activity_type| enum    |
| timestamp    | float   |

Each process has exactly:

- One `start`
- One `end`

Each process belongs to a specific machine.

---

## Objective

For each `machine_id`, calculate the **average processing time**.

Processing time is defined as:

```
end.timestamp - start.timestamp
```

The result must:

- Be grouped by `machine_id`
- Be rounded to **3 decimal places**

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    s.machine_id,
    ROUND(AVG(e.timestamp - s.timestamp)::numeric, 3) AS processing_time
FROM Activity s
JOIN Activity e
  ON s.machine_id = e.machine_id
 AND s.process_id = e.process_id
 AND s.activity_type = 'start'
 AND e.activity_type = 'end'
GROUP BY s.machine_id;
```

---

## Query Explanation

### Step 1 – Self Join

```sql
FROM Activity s
JOIN Activity e
```

We join the `Activity` table with itself:

- `s` → represents the **start** record
- `e` → represents the **end** record

---

### Step 2 – Join Conditions

```sql
ON s.machine_id = e.machine_id
AND s.process_id = e.process_id
```

Ensures that:

- We are matching the same machine
- We are matching the same process

```sql
AND s.activity_type = 'start'
AND e.activity_type = 'end'
```

Ensures we are subtracting:

```
end.timestamp - start.timestamp
```

---

### Step 3 – Calculating Processing Time

```sql
e.timestamp - s.timestamp
```

Calculates the execution time for each process.

---

### Step 4 – Average per Machine

```sql
AVG(e.timestamp - s.timestamp)
```

Computes the average processing time per machine.

---

### Step 5 – Rounding

```sql
ROUND(..., 3)
```

Rounds the result to **3 decimal places**, as required.

The cast to `numeric` ensures proper rounding precision.

---

## Example

If machine `1` has two processes:

| process_id | start | end |
|------------|-------|-----|
| 1          | 0.0   | 3.0 |
| 2          | 2.0   | 5.0 |

Processing times:

- 3.0
- 3.0

Average:

```
(3.0 + 3.0) / 2 = 3.000
```

---

## Conclusion

This challenge reinforces:

- Self joins
- Row pairing logic
- Aggregation with `AVG`
- Proper grouping
- Rounding numeric results

It is an essential SQL exercise for anyone studying Data Engineering or Analytics.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***