# Single Number — Desafio LeetCode

## Descrição do Problema

Dado um array de números inteiros `nums`, onde **cada elemento aparece exatamente duas vezes**, exceto por **um único número**, retorne **esse número único**.

**Exemplos:**

```
Entrada: nums = [2,2,1]
Saída: 1

Entrada: nums = [4,1,2,1,2]
Saída: 4

Entrada: nums = [1]
Saída: 1
```

---

## Lógica da Solução

O objetivo é encontrar o **número que aparece apenas uma vez** em um array onde todos os outros aparecem duas vezes.

Esta implementação utiliza o operador **XOR (^)**, que possui propriedades úteis:

* `a ^ a = 0`  (qualquer número XOR com ele mesmo é 0)
* `a ^ 0 = a`  (qualquer número XOR com 0 é ele mesmo)
* XOR é **comutativo** e **associativo**.

### Passo a passo:

1. Inicialize uma variável `result = 0`.
2. Percorra cada número `num` do array `nums`.
3. Atualize `result` com `result ^= num`.
4. Ao final, `result` conterá o número que aparece apenas uma vez.

---

## Complexidade

* **Tempo:** O(n) — percorre o array apenas uma vez.
* **Espaço:** O(1) — uso constante de memória.

> Esta solução é eficiente e elegante graças às propriedades do operador XOR.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
