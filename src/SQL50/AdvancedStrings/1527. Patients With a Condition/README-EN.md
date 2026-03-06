# LeetCode SQL – 1527. Patients With a Condition

## Challenge Description

The **"Patients With a Condition"** problem on LeetCode focuses on:

- Filtering text using **LIKE**
- Working with **string patterns**
- Handling **multiple conditions in a single column**
- Using logical operators such as **OR**

The problem provides a single table:

### `Patients` Table

| Column        | Type |
|---------------|------|
| patient_id    | int  |
| patient_name  | varchar |
| conditions    | varchar |

Each row represents a **patient** and the medical conditions associated with them.

The `conditions` column may contain **multiple condition codes separated by spaces**.

Example:

```
DIAB100 MYOP
```

This means the patient has **two conditions**.

---

## Objective

Return all patients who have **Type I Diabetes**.

A patient is considered to have this condition if **any of their condition codes starts with `DIAB1`**.

The result must include:

- `patient_id`
- `patient_name`
- `conditions`

---

## SQL Solution (Based on My Implementation)

```sql
SELECT 
    patient_id, 
    patient_name, 
    conditions
FROM 
    Patients
WHERE 
    conditions LIKE 'DIAB1%' 
    OR conditions LIKE '% DIAB1%';
```

---

## Query Explanation

### Step 1 – Selecting the Required Columns

```sql
SELECT 
    patient_id, 
    patient_name, 
    conditions
```

This retrieves the relevant information about each patient:

- Their unique ID
- Their name
- Their list of medical conditions

---

### Step 2 – Checking Conditions That Start with `DIAB1`

```sql
conditions LIKE 'DIAB1%'
```

This pattern matches any string that **starts with `DIAB1`**.

Examples that match:

| conditions |
|-----------|
| DIAB100 |
| DIAB199 ASTHMA |

These cases work because the condition code appears **at the beginning of the string**.

---

### Step 3 – Checking Conditions That Appear Later in the String

```sql
conditions LIKE '% DIAB1%'
```

Some patients may have **multiple conditions**, and the diabetes code may appear **after another condition**.

Example:

| conditions |
|-----------|
| ASTHMA DIAB100 |
| FLU DIAB120 |

The pattern works as follows:

- `%` → matches any characters before
- `' DIAB1'` → ensures the code appears **after a space**, meaning it is a separate condition
- `%` → allows any characters after

This prevents matching incorrect patterns such as:

```
XDIAB100
```

---

### Step 4 – Combining Both Conditions

```sql
OR
```

We use `OR` because the diabetes code may appear:

- **At the beginning of the string**
- **After another condition**

By combining both checks, we capture **all valid cases**.

---

## Why This Works

This solution works because:

- `LIKE` allows flexible **pattern matching**
- Checking both positions ensures the condition is detected **anywhere in the string**
- Using a space before `DIAB1` ensures we match **complete condition codes**

This avoids false matches while still capturing all relevant patients.

---

## Example

If the table contains:

| patient_id | patient_name | conditions |
|------------|--------------|-----------|
| 1 | Daniel | YFEV COUGH |
| 2 | Alice | DIAB100 MYOP |
| 3 | Bob | ASTHMA DIAB100 |
| 4 | George | FLU |

The result will be:

| patient_id | patient_name | conditions |
|------------|--------------|-----------|
| 2 | Alice | DIAB100 MYOP |
| 3 | Bob | ASTHMA DIAB100 |

Because both patients have a condition code that **starts with `DIAB1`**.

---

## Conclusion

This challenge reinforces several important SQL concepts:

- **Pattern matching with LIKE**
- **String filtering**
- **Handling multiple values inside a single column**
- **Combining logical conditions with OR**

It is a great exercise for practicing **text-based filtering in SQL queries**.