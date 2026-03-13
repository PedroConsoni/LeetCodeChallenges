# LeetCode SQL – 1757. Recyclable and Low Fat Products

## Descrição do Desafio

O desafio **"Recyclable and Low Fat Products"** no LeetCode tem como objetivo praticar o uso da cláusula **WHERE** com múltiplas condições utilizando o operador lógico **AND**.

O problema fornece uma tabela:

### Tabela `Products`

| Coluna     | Tipo    |
|------------|---------|
| product_id | int     |
| low_fats   | enum    |
| recyclable | enum    |

- `low_fats` pode ser `'Y'` ou `'N'`
- `recyclable` pode ser `'Y'` ou `'N'`

---

## Objetivo

Retornar os IDs dos produtos que sejam:

- **Baixo teor de gordura (Low Fat)**
- **Recicláveis**

O resultado deve conter apenas:

* `product_id`

---

## Solução SQL (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT product_id
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

---

## Explicação da Query

### SELECT

```sql
SELECT product_id
```

Seleciona a coluna que deve ser exibida no resultado final.

O desafio solicita apenas o `product_id`.

---

### FROM

```sql
FROM products
```

Define a tabela da qual os dados serão consultados.

---

### WHERE (Condição)

```sql
WHERE low_fats = 'Y' AND recyclable = 'Y'
```

Essa condição aplica **duas exigências ao mesmo tempo**:

- `low_fats = 'Y'` → O produto deve ser de baixo teor de gordura.
- `recyclable = 'Y'` → O produto deve ser reciclável.

O operador **AND** garante que ambas as condições precisam ser verdadeiras simultaneamente.

Se uma delas for falsa, o produto não será incluído no resultado.

---

## Exemplo

### Entrada

| product_id | low_fats | recyclable |
|------------|----------|------------|
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |

---

### Saída

| product_id |
|------------|
| 1          |
| 3          |

Apenas os produtos 1 e 3 atendem às duas condições.

---

## Conceitos Reforçados

Este desafio reforça fundamentos essenciais de SQL:

* Uso da cláusula **WHERE**
* Operador lógico **AND**
* Filtro com múltiplas condições
* Uso de valores categóricos ('Y' / 'N') para simular comportamento booleano

---

## Conclusão

Apesar de ser um exercício simples, ele é importante para consolidar a base de filtros condicionais em SQL.

Compreender como operadores lógicos como **AND** funcionam é fundamental para escrever consultas precisas em cenários reais de análise de dados, engenharia de dados e desenvolvimento back-end.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***