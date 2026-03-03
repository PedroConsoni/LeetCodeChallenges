# Squares of a Sorted Array — LeetCode Challenge

## Problem Description

Given an integer array **`nums`** sorted in **non-decreasing order**, return a new array consisting of **the squares of each number**, also sorted in **non-decreasing order**.

**Examples:**
```
Input: nums = [-4, -1, 0, 3, 10]
Output: [0, 1, 9, 16, 100]
Explanation: Squares = [16, 1, 0, 9, 100], Sorted = [0, 1, 9, 16, 100]

Input: nums = [-7, -3, 2, 3, 11]
Output: [4, 9, 9, 49, 121]
Explanation: Squares = [49, 9, 4, 9, 121], Sorted = [4, 9, 9, 49, 121]
```

---

## Solution Logic

The challenge requires **squaring all the numbers** in the given array and then **returning the results in sorted order**.

The implemented solution follows a **simple and straightforward approach**, using the `Arrays.sort()` method from the Java standard library to handle the sorting.

### Step-by-step:

1. Create a new array `resultado` with the same length as `nums`.  
2. Iterate through all the elements in `nums`.  
3. For each number, compute its square (`nums[i] * nums[i]`) and store it in `resultado[i]`.  
4. After all squares are computed, sort the array using `Arrays.sort(resultado)`.  
5. Return the sorted array `resultado`.

---

***A explicação que você está acessando está em inglês, caso prefira acessar a explicação em Português-BR, [clique aqui](README-PT-BR.md)***
