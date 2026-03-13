# LeetCode SQL – 1174. Immediate Food Delivery II

## Descrição do Desafio

O problema **"Immediate Food Delivery II"** do LeetCode trabalha os seguintes conceitos:

- CTE (Common Table Expression)
- Funções de agregação (`MIN`, `COUNT`, `SUM`)
- Lógica condicional com `CASE WHEN`
- Cálculo de porcentagem
- Arredondamento com `ROUND`
- Identificação do primeiro registro por grupo

O exercício fornece uma única tabela:

---

### Tabela `Delivery`

| Coluna                      | Tipo |
|-----------------------------|------|
| delivery_id                 | int  |
| customer_id                 | int  |
| order_date                  | date |
| customer_pref_delivery_date | date |

Cada linha representa um pedido de entrega contendo:

- O cliente que realizou o pedido
- A data do pedido
- A data preferida de entrega pelo cliente

---

## Objetivo

Calcular a porcentagem de clientes cujo **primeiro pedido** foi entregue na **data preferida**.

O resultado deve:

- Ser retornado como `immediate_percentage`
- Estar arredondado para **2 casas decimais**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH primeiroPedidos AS (
    SELECT customer_id,
    MIN(order_date) as primeira_data
    FROM Delivery
    GROUP BY customer_id
)

SELECT
    ROUND(
        SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS immediate_percentage
FROM Delivery d
INNER JOIN primeiroPedidos p
ON d.customer_id = p.customer_id
AND d.order_date = p.primeira_data;
```

---

## Explicação da Query

### Passo 1 – Identificando o Primeiro Pedido de Cada Cliente (CTE)

```sql
WITH primeiroPedidos AS (
    SELECT customer_id,
    MIN(order_date) as primeira_data
    FROM Delivery
    GROUP BY customer_id
)
```

Essa CTE:

- Agrupa os pedidos por `customer_id`
- Utiliza `MIN(order_date)` para encontrar a primeira data de pedido de cada cliente

Resultado:

- Uma linha por cliente
- Contendo a data do primeiro pedido

---

### Passo 2 – Fazendo o JOIN com a Tabela Original

```sql
INNER JOIN primeiroPedidos p
ON d.customer_id = p.customer_id
AND d.order_date = p.primeira_data
```

Isso garante que:

- Apenas o primeiro pedido de cada cliente seja considerado
- Pedidos posteriores sejam ignorados

Agora temos exatamente um registro por cliente (seu primeiro pedido).

---

### Passo 3 – Verificando se a Entrega Foi Imediata

```sql
CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END
```

Lógica:

- Se a data do pedido for igual à data preferida → retorna 1
- Caso contrário → retorna 0

---

### Passo 4 – Calculando a Porcentagem

```sql
SUM(...) * 100.0 / COUNT(*)
```

Explicação:

- `SUM(...)` conta quantos primeiros pedidos foram imediatos
- `COUNT(*)` conta o total de primeiros pedidos
- `100.0` força divisão decimal
- O resultado é convertido em porcentagem

---

### Passo 5 – Arredondando o Resultado

```sql
ROUND(..., 2)
```

Garante:

- Resultado com exatamente **2 casas decimais**
- Formato conforme exigido pelo problema

---

## Por Que Essa Solução Funciona?

- A CTE isola o primeiro pedido de cada cliente
- O `JOIN` filtra corretamente esses pedidos
- O `CASE WHEN` transforma condição lógica em valor numérico
- `SUM / COUNT` calcula a proporção
- `100.0` evita divisão inteira
- `ROUND` formata corretamente o resultado

Cada parte da query atende diretamente aos requisitos do problema.

---

## Exemplo

### Tabela Delivery

| delivery_id | customer_id | order_date  | customer_pref_delivery_date |
|------------|------------|------------|-----------------------------|
| 1          | 1          | 2023-01-01 | 2023-01-01                  |
| 2          | 1          | 2023-01-02 | 2023-01-02                  |
| 3          | 2          | 2023-01-05 | 2023-01-06                  |
| 4          | 3          | 2023-01-07 | 2023-01-07                  |

---

### Considerando Apenas o Primeiro Pedido

- Cliente 1 → 2023-01-01 → Imediato
- Cliente 2 → 2023-01-05 → Não imediato
- Cliente 3 → 2023-01-07 → Imediato

Imediatos = 2  
Total de clientes = 3  

Porcentagem:

```
(2 / 3) × 100 = 66.67%
```

---

## Conclusão

Esse desafio reforça:

- Uso de CTE para análise de primeiro evento
- Aplicação de `MIN` para identificar registros iniciais
- Agregação condicional com `CASE`
- Cálculo correto de porcentagens
- Prevenção de divisão inteira
- Construção de métricas analíticas em SQL

É um excelente exercício para dominar análises baseadas em primeiro evento (first-event analysis).

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***