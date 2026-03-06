# LeetCode SQL – 1321. Restaurant Growth (Português-BR)

## Descrição do Desafio

O problema **"Restaurant Growth"** do LeetCode foca na prática de:

- Common Table Expressions (`WITH`)
- Agregação utilizando `SUM`
- Window functions
- Médias móveis (rolling average)
- Ordenação de resultados com `ORDER BY`

O problema fornece uma única tabela:

### `Customer` Table

| Column | Type |
|------|------|
| customer_id | int |
| name | varchar |
| visited_on | date |
| amount | int |

Cada linha representa **uma visita de um cliente ao restaurante**, contendo a data da visita e o valor gasto.

---

## Objetivo

Calcular o **valor total e a média de faturamento para um período móvel de 7 dias**.

Regras:

- O cálculo deve incluir **o dia atual e os 6 dias anteriores**
- Apenas dias com **7 dias completos de histórico** devem aparecer no resultado
- O resultado final deve conter:

| visited_on | amount | average_amount |

Onde:

- `visited_on` → o último dia da janela de 7 dias
- `amount` → faturamento total nesses 7 dias
- `average_amount` → média diária de faturamento no mesmo período

O resultado deve estar **ordenado por data**.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH DailySales AS (
    SELECT 
        visited_on, 
        SUM(amount) AS day_amount
    FROM Customer
    GROUP BY visited_on
),
CalculatedStats AS (

    SELECT 
        visited_on,
        SUM(day_amount) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        AVG(CAST(day_amount AS FLOAT)) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
    FROM DailySales
)

SELECT 
    visited_on, 
    amount, 
    ROUND(average_amount, 2) AS average_amount
FROM CalculatedStats
WHERE row_num >= 7
ORDER BY visited_on;
```

---

## Explicação da Query

### Passo 1 – Calculando o faturamento diário

```sql
WITH DailySales AS (
```

A primeira **Common Table Expression (CTE)** calcula o **total gasto por dia**.

```sql
SELECT 
    visited_on, 
    SUM(amount) AS day_amount
FROM Customer
GROUP BY visited_on
```

Aqui os registros são agrupados pela data `visited_on`.

Se vários clientes visitaram o restaurante no mesmo dia, seus valores são **somados para gerar o faturamento diário**.

Exemplo:

| visited_on | day_amount |
|---|---|
| 2020-01-01 | 100 |
| 2020-01-02 | 150 |
| 2020-01-03 | 200 |

---

### Passo 2 – Calculando o total móvel de 7 dias

```sql
SUM(day_amount) OVER (
    ORDER BY visited_on 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
) AS amount
```

Essa **window function** calcula a **soma móvel de 7 dias**.

Explicação:

- `ORDER BY visited_on` garante a ordem cronológica
- `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` inclui:
  - o dia atual
  - os **6 dias anteriores**

Assim, cada linha representa o **faturamento total dos últimos 7 dias**.

---

### Passo 3 – Calculando a média de 7 dias

```sql
AVG(CAST(day_amount AS FLOAT)) OVER (
    ORDER BY visited_on 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
)
```

Essa função calcula a **média diária de faturamento dentro da mesma janela de 7 dias**.

O `CAST` garante que o cálculo seja feito como **número decimal**, permitindo valores fracionários.

---

### Passo 4 – Criando um número de linha

```sql
ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
```

Essa função gera um **número sequencial para cada linha** baseado na ordem das datas.

Isso permite identificar **quando uma janela completa de 7 dias começa a existir**.

Exemplo:

| visited_on | row_num |
|---|---|
| Dia 1 | 1 |
| Dia 2 | 2 |
| Dia 3 | 3 |

O primeiro cálculo válido aparece quando `row_num = 7`.

---

### Passo 5 – Filtrando apenas janelas completas

```sql
WHERE row_num >= 7
```

Essa condição remove as primeiras seis linhas, pois **não possuem histórico suficiente para calcular 7 dias completos**.

Assim, apenas períodos completos permanecem no resultado.

---

### Passo 6 – Arredondando a média

```sql
ROUND(average_amount, 2)
```

A média é arredondada para **duas casas decimais**, conforme solicitado no problema.

---

### Passo 7 – Ordenando o resultado final

```sql
ORDER BY visited_on
```

O resultado final é ordenado cronologicamente pelas datas.

---

## Por que essa solução funciona

Essa solução funciona porque:

- A primeira CTE calcula o **faturamento diário**
- As window functions calculam **somas e médias móveis**
- `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` define a janela de **7 dias**
- `ROW_NUMBER` remove janelas incompletas
- `ROUND` formata corretamente a média

Essas técnicas permitem realizar **análises temporais diretamente no SQL**.

---

## Conclusão

Esse desafio reforça vários conceitos importantes de SQL:

- Uso de **CTEs** para estruturar consultas complexas
- Agregação de dados por dia
- Uso de **window functions**
- Cálculo de **médias móveis**
- Filtragem de janelas incompletas
- Formatação de resultados

Ele demonstra como o SQL pode ser usado para realizar **análises temporais e métricas de crescimento**, algo muito comum em análise de dados e inteligência de negócios.