# LeetCode SQL – 1251. Average Selling Price

## 📌 Challenge Description

The **"Average Selling Price"** challenge on LeetCode tests your understanding of:

- `LEFT JOIN`
- Date range conditions in joins
- `SUM()` aggregation
- Weighted average calculation
- `COALESCE()`
- `ROUND()`
- `GROUP BY`

The problem provides two tables:

### `Prices`
| Column       | Type |
|--------------|------|
| product_id   | int  |
| start_date   | date |
| end_date     | date |
| price        | int  |

Each product can have different prices over different time periods.

### `UnitsSold`
| Column        | Type |
|--------------|------|
| product_id   | int  |
| purchase_date| date |
| units        | int  |

Each row represents how many units were sold on a specific date.

---

## 🎯 Objective

For each `product_id`, calculate the **average selling price**, rounded to 2 decimal places.

### Important Rules:

- Only consider sales that happened within the price validity period.
- If a product has no sales, the average price should be `0`.

---

## 🧠 Strategy

To solve this problem:

1. Use a `LEFT JOIN` to ensure all products appear, even if they have no sales.
2. Join on:
   - Same `product_id`
   - `purchase_date` between `start_date` and `end_date`
3. Compute the **weighted average**:

   Weighted Average Formula:
