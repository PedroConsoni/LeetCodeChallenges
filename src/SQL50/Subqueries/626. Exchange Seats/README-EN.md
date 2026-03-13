# LeetCode SQL – 626. Exchange Seats

## Challenge Description

The **"Exchange Seats"** problem on LeetCode focuses on practicing:

- Conditional logic using `CASE`
- Arithmetic operations
- Subqueries
- Sorting results with `ORDER BY`

The problem provides a single table:

### `Seat` Table

| Column | Type |
|------|------|
| id | int |
| student | varchar |

Each row represents a seat in a classroom and the student sitting in that seat.

- `id` represents the seat number
- `student` represents the student assigned to that seat

---

## Objective

Swap the seat IDs of every **two consecutive students**.

Rules:

- Student in seat **1 swaps with seat 2**
- Student in seat **3 swaps with seat 4**
- Student in seat **5 swaps with seat 6**, and so on

However:

- If the number of students is **odd**, the **last student keeps their seat**

The result must return:

| id | student |

And must be ordered by `id`.

---

## SQL Solution (Based on My Implementation)

```sql
SELECT
    CASE
        WHEN id % 2 != 0 AND id < (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id % 2 != 0 AND id = (SELECT MAX(id) FROM Seat) THEN id
        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;
```

---

## Query Explanation

### Step 1 – Using CASE to Control Seat Swapping

```sql
CASE
```

The `CASE` statement allows us to apply **conditional logic** inside the `SELECT` statement.

This makes it possible to dynamically change the `id` values depending on the situation.

---

### Step 2 – Swapping Odd Seats With the Next Seat

```sql
WHEN id % 2 != 0 AND id < (SELECT MAX(id) FROM Seat) THEN id + 1
```

This condition checks two things:

1. If the seat ID is **odd**

```sql
id % 2 != 0
```

The modulo operator `%` calculates the remainder of a division.

- If `id % 2 = 1` → the number is odd
- If `id % 2 = 0` → the number is even

2. If the seat is **not the last seat**

```sql
id < (SELECT MAX(id) FROM Seat)
```

This ensures that the current seat is not the last one.

If both conditions are true:

- The seat ID becomes **id + 1**

This effectively swaps the seat with the next student.

Example:

| Original ID | New ID |
|---|---|
| 1 | 2 |
| 3 | 4 |
| 5 | 6 |

---

### Step 3 – Handling the Last Seat When the Number of Students Is Odd

```sql
WHEN id % 2 != 0 AND id = (SELECT MAX(id) FROM Seat) THEN id
```

This condition handles the **special case** where:

- The seat ID is **odd**
- It is also the **last seat in the table**

This means there is **no student to swap with**.

Therefore, the seat ID **remains the same**.

---

### Step 4 – Handling Even Seats

```sql
ELSE id - 1
```

If none of the previous conditions apply, the seat must be **even**.

In this case:

- The seat swaps with the **previous seat**

Example:

| Original ID | New ID |
|---|---|
| 2 | 1 |
| 4 | 3 |
| 6 | 5 |

---

### Step 5 – Ordering the Final Result

```sql
ORDER BY id
```

After the swap logic is applied, the result is sorted by the **new seat IDs**.

This ensures the seats appear in the correct order.

---

## Why This Works

This solution works because:

- The modulo operator `%` identifies odd and even seat numbers
- The `CASE` statement allows conditional seat swapping
- The subquery `SELECT MAX(id)` detects the last seat
- The logic prevents swapping when the last seat has no pair
- `ORDER BY` ensures the final output is correctly sorted

Together, these conditions implement the seat exchange rule precisely.

---

## Example

If the `Seat` table contains:

| id | student |
|---|---|
| 1 | Alice |
| 2 | Bob |
| 3 | Charlie |
| 4 | David |
| 5 | Eve |

Seat swapping occurs as follows:

- 1 ↔ 2
- 3 ↔ 4
- 5 remains unchanged

Final result:

| id | student |
|---|---|
| 1 | Bob |
| 2 | Alice |
| 3 | David |
| 4 | Charlie |
| 5 | Eve |

---

## Conclusion

This challenge reinforces several important SQL concepts:

- Conditional logic using `CASE`
- Arithmetic operations with seat numbers
- Using subqueries to detect edge cases
- Sorting results with `ORDER BY`

It demonstrates how SQL can be used to **rearrange structured data using logical rules**, which is a common requirement in data transformation tasks.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***