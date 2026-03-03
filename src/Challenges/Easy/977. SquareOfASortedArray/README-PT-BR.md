# Squares of a Sorted Array — Desafio LeetCode

## Descrição do Problema

Dado um array de inteiros **`nums`** ordenado em **ordem não decrescente**, retorne um novo array com **os quadrados de cada número**, também **ordenado em ordem crescente**.

**Exemplos:**
```
Entrada: nums = [-4, -1, 0, 3, 10]
Saída: [0, 1, 9, 16, 100]
Explicação: Quadrados = [16, 1, 0, 9, 100], Ordenado = [0, 1, 9, 16, 100]

Entrada: nums = [-7, -3, 2, 3, 11]
Saída: [4, 9, 9, 49, 121]
Explicação: Quadrados = [49, 9, 4, 9, 121], Ordenado = [4, 9, 9, 49, 121]
```

---

## Lógica da Solução

O desafio pede para **elevar ao quadrado todos os números do array** e depois **retornar o resultado ordenado**.

A solução implementada segue uma abordagem **simples e direta**, utilizando o método `Arrays.sort()` da biblioteca padrão do Java para ordenar os resultados.

### Passo a passo:

1. Crie um novo array `resultado` com o mesmo tamanho de `nums`.  
2. Percorra todos os elementos de `nums`.  
3. Para cada número, calcule o quadrado (`nums[i] * nums[i]`) e armazene em `resultado[i]`.  
4. Após calcular todos os quadrados, ordene o array com `Arrays.sort(resultado)`.  
5. Retorne o array `resultado` já ordenado.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
