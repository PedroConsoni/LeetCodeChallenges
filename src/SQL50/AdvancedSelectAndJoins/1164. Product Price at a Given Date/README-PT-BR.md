# LeetCode SQL – 1164. Preço do Produto em uma Data Específica

## Descrição do Desafio

O problema **"Product Price at a Given Date"** do LeetCode foca nos seguintes conceitos de SQL:

- Common Table Expressions (`WITH`)
- Window functions
- Uso de `RANK()` para classificação de linhas
- Filtragem de dados por data
- Combinação de resultados utilizando `UNION`

O problema fornece uma única tabela:

### Tabela `Products`

| Coluna | Tipo |
|------|------|
| product_id | int |
| new_price | int |
| change_date | date |

Cada linha representa um **evento de alteração de preço de um produto**.

- `product_id` identifica o produto
- `new_price` representa o novo preço
- `change_date` indica quando a alteração ocorreu

Se um produto **não tiver preço registrado antes da data informada**, o preço padrão deve ser **10**.

---

# Objetivo

Encontrar o **preço de cada produto na data `2019-08-16`**.

Regras:

1. Se um produto teve várias alterações de preço antes dessa data, devemos selecionar **a alteração mais recente antes ou no dia `2019-08-16`**.
2. Se um produto **não teve nenhuma alteração de preço antes dessa data**, então seu preço deve ser **10**.

O resultado final deve conter:

- `product_id`
- `price`

---

# Solução SQL (Baseada na Minha Implementação)

```sql
WITH PrecosRecentes AS (
    SELECT 
        product_id, 
        new_price,
        RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) as rnk
    FROM Products
    WHERE change_date <= '2019-08-16'
)

SELECT product_id, new_price AS price
FROM PrecosRecentes
WHERE rnk = 1

UNION

SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';
```

---

# Explicação da Query

## Passo 1 – Criar uma Common Table Expression (CTE)

```sql
WITH PrecosRecentes AS (...)
```

Isso cria uma **Common Table Expression (CTE)**.

Uma CTE funciona como um conjunto de resultados temporário que pode ser utilizado posteriormente na query.

Nesse caso, ela é usada para identificar **a alteração de preço mais recente de cada produto antes da data alvo**.

---

## Passo 2 – Filtrar Alterações de Preço Antes da Data Alvo

```sql
WHERE change_date <= '2019-08-16'
```

Essa condição garante que apenas alterações de preço que ocorreram **antes ou na data alvo** sejam consideradas.

Qualquer alteração posterior é ignorada.

---

## Passo 3 – Classificar Alterações de Preço por Produto

```sql
RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC)
```

Essa **window function** atribui uma classificação para as alterações de preço de cada produto.

Explicação:

- `PARTITION BY product_id` → separa os registros por produto
- `ORDER BY change_date DESC` → ordena as alterações da mais recente para a mais antiga

A alteração mais recente recebe **rank 1**.

---

## Passo 4 – Selecionar o Preço Mais Recente

```sql
WHERE rnk = 1
```

Esse filtro retorna apenas **a alteração de preço mais recente de cada produto** antes da data alvo.

A coluna `new_price` é renomeada para `price`.

---

## Passo 5 – Tratar Produtos Sem Alterações Antes da Data

```sql
HAVING MIN(change_date) > '2019-08-16'
```

Alguns produtos podem não ter nenhuma alteração de preço antes da data especificada.

Essa condição identifica esses produtos.

Se a primeira alteração registrada ocorrer **depois da data alvo**, significa que o produto ainda não tinha preço válido.

De acordo com o problema, esses produtos devem receber **o preço padrão de 10**.

---

## Passo 6 – Combinar os Resultados

```sql
UNION
```

O operador `UNION` combina:

1. Produtos com alterações de preço válidas antes da data alvo
2. Produtos que devem receber o **preço padrão**

Assim garantimos que todos os produtos apareçam no resultado final.

---

# Por Que Isso Funciona

Essa solução trata corretamente os dois cenários possíveis do problema.

### Caso 1 — Produto possui alteração de preço antes da data

- A window function identifica **o preço mais recente válido**.
- O filtro `rnk = 1` retorna esse preço.

### Caso 2 — Produto não possui alteração antes da data

- A cláusula `HAVING` identifica esses produtos.
- A query atribui o **preço padrão de 10**.

Combinando os resultados com `UNION`, garantimos que **cada produto receba o preço correto**.

---

# Exemplo

Se a tabela contiver:

| product_id | new_price | change_date |
|---|---|---|
| 1 | 20 | 2019-08-14 |
| 2 | 50 | 2019-08-14 |
| 1 | 30 | 2019-08-15 |
| 1 | 35 | 2019-08-16 |
| 2 | 65 | 2019-08-17 |
| 3 | 20 | 2019-08-18 |

### Análise

- Produto **1** → preço mais recente antes ou em `2019-08-16` = **35**
- Produto **2** → preço mais recente antes de `2019-08-16` = **50**
- Produto **3** → não possui preço antes da data → **preço padrão = 10**

---

### Resultado

| product_id | price |
|---|---|
| 1 | 35 |
| 2 | 50 |
| 3 | 10 |

---

# Conclusão

Este desafio reforça vários conceitos importantes de SQL:

- Uso de **CTEs (`WITH`)**
- Utilização de **window functions**
- Classificação de linhas com `RANK()`
- Filtragem baseada em datas
- Combinação de resultados com `UNION`

É um ótimo exercício para aprender a **recuperar registros históricos mais recentes e lidar com ausência de dados em SQL**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***