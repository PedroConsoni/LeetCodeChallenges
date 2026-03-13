# LeetCode SQL – 1517. Find Users With Valid E-Mails

## Challenge Description

The **"Find Users With Valid E-Mails"** problem on LeetCode focuses on:

- Pattern matching using `LIKE`
- String validation rules
- String manipulation with functions like `LEFT` and `LEN`
- Using collations to enforce case-sensitive pattern matching

The problem provides a single table.

---

## `Users` Table

| Column | Type |
|------|------|
| user_id | int |
| name | varchar |
| mail | varchar |

Each row represents a user and their email address.

However, not all email addresses follow the **valid format required by the problem**.

---

## Objective

Return the users whose email addresses are **valid according to the following rules**:

1. The email must end with **`@leetcode.com`**
2. The part before `@leetcode.com` must:
   - Start with a **letter**
   - Contain only:
     - letters (`a-z`, `A-Z`)
     - digits (`0-9`)
     - underscore (`_`)
     - period (`.`)
     - dash (`-`)

The result must return:

- `user_id`
- `name`
- `mail`

---

## SQL Solution (Based on My Implementation)

```sql
SELECT user_id, name, mail
FROM Users
WHERE mail LIKE '[a-zA-Z]%@leetcode.com' COLLATE Latin1_General_BIN
  AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^a-zA-Z0-9_.-]%' COLLATE Latin1_General_BIN;
```

---

## Query Explanation

### Step 1 – Ensuring the Email Starts With a Letter

```sql
mail LIKE '[a-zA-Z]%@leetcode.com'
```

This pattern ensures that:

- The email **starts with a letter (`a-z` or `A-Z`)**
- The email **ends with `@leetcode.com`**

Example of valid patterns:

```
alice@leetcode.com
bob123@leetcode.com
john.doe@leetcode.com
```

Example of invalid patterns:

```
1alice@leetcode.com
_john@leetcode.com
```

---

### Step 2 – Enforcing Case-Sensitive Pattern Matching

```sql
COLLATE Latin1_General_BIN
```

This collation enforces **binary comparison**, which ensures strict pattern matching.

Without this, SQL Server might treat some characters differently depending on the default collation.

---

### Step 3 – Extracting the Username Part of the Email

```sql
LEFT(mail, LEN(mail) - 13)
```

This expression extracts the part **before `@leetcode.com`**.

Why `13`?

Because:

```
@leetcode.com
```

contains **13 characters**.

Example:

```
mail = alice123@leetcode.com
```

Result:

```
alice123
```

---

### Step 4 – Checking for Invalid Characters

```sql
NOT LIKE '%[^a-zA-Z0-9_.-]%'
```

This condition ensures that the username part **does not contain invalid characters**.

Allowed characters:

```
letters
numbers
_
.
-
```

Invalid examples:

```
alice!@leetcode.com
john#@leetcode.com
mark$@leetcode.com
```

These would be filtered out.

---

## Example

### Users Table

| user_id | name | mail |
|-------|------|------|
| 1 | Alice | alice@leetcode.com |
| 2 | Bob | bob123@leetcode.com |
| 3 | Alex | 1alex@leetcode.com |
| 4 | Eve | eve!@leetcode.com |

---

## Result

| user_id | name | mail |
|-------|------|------|
| 1 | Alice | alice@leetcode.com |
| 2 | Bob | bob123@leetcode.com |

Explanation:

- `alice@leetcode.com` → valid
- `bob123@leetcode.com` → valid
- `1alex@leetcode.com` → invalid (does not start with a letter)
- `eve!@leetcode.com` → invalid (contains invalid character)

---

## Why This Works

This solution works because:

- `LIKE` ensures the email structure matches the required pattern
- `LEFT` extracts the username portion
- `LEN` calculates the email length dynamically
- `NOT LIKE` prevents invalid characters
- `COLLATE Latin1_General_BIN` guarantees strict character comparison

---

## Key SQL Concepts Practiced

This challenge reinforces several SQL concepts:

- Pattern matching with `LIKE`
- String manipulation with `LEFT` and `LEN`
- Character validation
- Using collations for strict comparisons
- Data validation using SQL queries

---

## Conclusion

The **Find Users With Valid E-Mails** challenge is a great exercise in **string validation using SQL**.

It demonstrates how SQL can be used not only for querying data but also for **validating input formats and enforcing data quality rules**, which are essential in real-world database systems.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***