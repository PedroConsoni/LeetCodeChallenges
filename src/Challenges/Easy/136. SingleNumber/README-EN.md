# Single Number — LeetCode Challenge

## Problem Description

Given an array of integers `nums`, where **every element appears exactly twice** except for **one single number**, return **that single number**.

**Examples:**

```
Input: nums = [2,2,1]
Output: 1

Input: nums = [4,1,2,1,2]
Output: 4

Input: nums = [1]
Output: 1
```

---

## Solution Logic

The goal is to find the **number that appears only once** in an array where all other numbers appear twice.

This implementation uses the **XOR (^) operator**, which has useful properties:

* `a ^ a = 0`  (any number XOR with itself is 0)
* `a ^ 0 = a`  (any number XOR with 0 is the number itself)
* XOR is **commutative** and **associative**.

### Step by step:

1. Initialize a variable `result = 0`.
2. Iterate through each number `num` in the array `nums`.
3. Update `result` with `result ^= num`.
4. At the end, `result` will contain the number that appears only once.

---

## Complexity

* **Time:** O(n) — iterates through the array only once.
* **Space:** O(1) — uses constant extra memory.

> This solution is efficient and elegant thanks to the properties of the XOR operator.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
