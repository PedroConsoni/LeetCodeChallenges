# Two Sum — Desafio LeetCode

## Descrição do Problema

Dado um array de números inteiros `nums` e um inteiro `target`, retorne **os índices de dois números** tais que eles somem exatamente `target`.

Você pode assumir que **cada entrada possui exatamente uma solução** e **não pode usar o mesmo elemento duas vezes**.  
A resposta pode ser retornada em **qualquer ordem**.

**Exemplos:**
```
Entrada: nums = [2,7,11,15], target = 9
Saída: [0,1]
Explicação: nums[0] + nums[1] = 2 + 7 = 9

Entrada: nums = [3,2,4], target = 6
Saída: [1,2]

Entrada: nums = [3,3], target = 6
Saída: [0,1]
```

---

## Lógica da Solução

O objetivo é encontrar **dois elementos diferentes** no array cuja soma seja igual ao valor `target`.

Esta implementação utiliza uma abordagem **força bruta**, verificando todos os pares possíveis no array até encontrar o correto.

### Passo a passo:

1. Percorra cada elemento do array usando o índice `i`.  
2. Para cada elemento `nums[i]`, percorra novamente os elementos **à frente dele** usando o índice `j = i + 1`.  
3. Para cada par `(nums[i], nums[j])`, verifique se a soma é igual ao `target`.  
4. Se a condição for verdadeira, retorne os índices `[i, j]`.  
5. Caso nenhum par seja encontrado (apesar do problema garantir que haja), retorne `[0, 0]`.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
