# LeetCode SQL – 180. Números Consecutivos

## Descrição do Desafio

O problema **"Consecutive Numbers"** do LeetCode foca nos seguintes conceitos de SQL:

- Self join (auto junção)
- Comparação de múltiplas linhas da mesma tabela
- Filtragem lógica com `WHERE`
- Remoção de duplicatas utilizando `DISTINCT`

O problema fornece uma única tabela:

### Tabela `Logs`

| Coluna | Tipo |
|------|------|
| id | int |
| num | int |

Cada linha representa um registro contendo um número.

A coluna `id` é **auto incremental**, o que significa que as linhas seguem uma ordem sequencial.

---

# Objetivo

Encontrar todos os números que aparecem **pelo menos três vezes consecutivas**.

O resultado deve conter:

- Uma única coluna chamada **`ConsecutiveNums`**

Cada número deve aparecer **apenas uma vez no resultado**, mesmo que apareça mais de três vezes consecutivas.

---

# Solução SQL (Baseada na Minha Implementação)

```sql
SELECT DISTINCT
    l1.num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.id = l2.id - 1
    AND l2.id = l3.id - 1
    AND l1.num = l2.num
    AND l2.num = l3.num;
```

---

# Explicação da Query

## Passo 1 – Criar Múltiplas Referências da Mesma Tabela

```sql
FROM Logs l1, Logs l2, Logs l3
```

A query referencia a **mesma tabela três vezes**.

Cada alias representa uma posição diferente de linha:

- `l1` → primeira linha
- `l2` → segunda linha
- `l3` → terceira linha

Essa técnica é chamada de **self join**.

Ela permite comparar linhas dentro da mesma tabela.

---

## Passo 2 – Garantir que as Linhas Sejam Consecutivas

```sql
l1.id = l2.id - 1
AND l2.id = l3.id - 1
```

Essas condições garantem que as linhas sejam **sequenciais**.

Exemplo:

| id |
|---|
| 1 |
| 2 |
| 3 |

As condições garantem que:

```
l1.id = 1
l2.id = 2
l3.id = 3
```

Assim estamos verificando **três linhas consecutivas**.

---

## Passo 3 – Verificar se os Números São Iguais

```sql
l1.num = l2.num
AND l2.num = l3.num
```

Essas condições verificam se **o mesmo número aparece nas três linhas**.

Se os valores forem iguais, então esse número aparece **três vezes consecutivas**.

---

## Passo 4 – Remover Resultados Duplicados

```sql
SELECT DISTINCT
```

Se um número aparecer mais de três vezes consecutivas, a query pode identificar múltiplas sequências.

Exemplo:

```
1,1,1,1
```

Isso gera duas sequências válidas:

```
1,1,1
1,1,1
```

O `DISTINCT` garante que o número apareça **apenas uma vez no resultado final**.

---

# Por Que Isso Funciona

Essa solução funciona porque:

- Compara **três linhas consecutivas**
- Verifica se os números são iguais
- Utiliza **self join** para analisar sequências
- Utiliza `DISTINCT` para evitar duplicatas

Assim conseguimos identificar números que aparecem **três vezes seguidas**.

---

# Exemplo

Se a tabela contiver:

| id | num |
|---|---|
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |
| 4 | 2 |
| 5 | 1 |
| 6 | 2 |
| 7 | 2 |
| 8 | 2 |

### Análise

- Linhas **1,2,3** → número **1** aparece três vezes consecutivas
- Linhas **6,7,8** → número **2** aparece três vezes consecutivas

---

### Resultado

| ConsecutiveNums |
|---|
| 1 |
| 2 |

---

# Conclusão

Este desafio reforça conceitos importantes de SQL como:

- Self join
- Comparação de múltiplas linhas da mesma tabela
- Filtragem lógica com `WHERE`
- Remoção de duplicatas com `DISTINCT`

É um excelente exercício para aprender a **identificar padrões e sequências em dados relacionais utilizando SQL**.