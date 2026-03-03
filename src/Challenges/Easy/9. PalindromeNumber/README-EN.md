# Palindrome Number — LeetCode Challenge

## Problem Description

Given an integer `x`, determine whether it is a **palindrome**.  
A number is considered a **palindrome** if it reads the same backward as forward.

**Examples:**
```
Input: x = 121
Output: true
Explanation: 121 read backward is still 121.

Input: x = -121
Output: false
Explanation: Read backward, it becomes 121-, which is not the same as the original number.

Input: x = 10
Output: false
Explanation: Read backward, it becomes 01, which is not the same.
```

---

## Solution Logic

The main idea is to **reverse the digits of the number** and compare the result with the original value.

1. Store the original value of `x` in an auxiliary variable (`comparator`) to avoid losing it during the process.  
2. Create a variable `reverse` that will store the reversed number.  
3. While `comparator` is greater than zero:
   - Get the **last digit** using the modulo operator `% 10`;
   - Add this digit to the end of `reverse` (by multiplying `reverse` by 10 first);
   - Remove the last digit from `comparator` using **integer division** `/ 10`.
4. After the loop, compare whether the reversed number (`reverse`) is equal to the original number (`x`).

If they are equal, the number is a **palindrome**.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
