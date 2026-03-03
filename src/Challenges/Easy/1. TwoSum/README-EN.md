# Two Sum — LeetCode Challenge

## Problem Description

Given an array of integers `nums` and an integer `target`, return **the indices of two numbers** such that they add up exactly to `target`.

You may assume that **each input has exactly one solution** and **you may not use the same element twice**.  
The answer can be returned in **any order**.

**Examples:**
```
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: nums[0] + nums[1] = 2 + 7 = 9

Input: nums = [3,2,4], target = 6
Output: [1,2]

Input: nums = [3,3], target = 6
Output: [0,1]
```

---

## Solution Logic

The goal is to find **two different elements** in the array whose sum equals the `target`.

This implementation uses a **brute-force approach**, checking all possible pairs in the array until the correct one is found.

### Step-by-step:

1. Loop through each element in the array using index `i`.  
2. For each element `nums[i]`, loop again through the elements **ahead of it** using index `j = i + 1`.  
3. For each pair `(nums[i], nums[j])`, check if their sum equals `target`.  
4. If the condition is true, return the indices `[i, j]`.  
5. If no pair is found (although the problem guarantees one), return `[0, 0]`.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
