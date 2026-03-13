# LeetCode SQL – 1251. Average Selling Price

## 📌 Descrição do Desafio

O desafio **"Average Selling Price"** no LeetCode testa seu entendimento sobre:

- `LEFT JOIN`
- Condições de intervalo de datas em `JOIN`
- Agregação com `SUM()`
- Cálculo de média ponderada
- `COALESCE()`
- `ROUND()`
- `GROUP BY`

O problema fornece duas tabelas:

### `Prices`
| Coluna       | Tipo |
|--------------|------|
| product_id   | int  |
| start_date   | date |
| end_date     | date |
| price        | int  |

Cada produto pode ter preços diferentes em diferentes períodos de tempo.

### `UnitsSold`
| Coluna        | Tipo |
|--------------|------|
| product_id   | int  |
| purchase_date| date |
| units        | int  |

Cada linha representa quantas unidades foram vendidas em uma data específica.

---

## 🎯 Objetivo

Para cada `product_id`, calcular o **preço médio de venda**, arredondado para **2 casas decimais**.

### Regras Importantes

- Considerar apenas vendas que ocorreram **dentro do período de validade do preço**.
- Se um produto **não tiver vendas**, o preço médio deve ser `0`.

---

## 🧠 Estratégia

Para resolver esse problema:

1. Utilizar um `LEFT JOIN` para garantir que **todos os produtos apareçam**, mesmo aqueles que **não possuem vendas**.
2. Fazer o `JOIN` utilizando:
   - O mesmo `product_id`
   - `purchase_date` entre `start_date` e `end_date`
3. Calcular a **média ponderada**.

### Fórmula da Média Ponderada

A média ponderada é calculada da seguinte forma:

```
SUM(price * units) / SUM(units)
```

Isso garante que vendas com maior quantidade de unidades tenham maior peso no cálculo da média.

---

## 💻 Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    p.product_id,
    ROUND(
        COALESCE(SUM(p.price * u.units) / SUM(u.units), 0),
        2
    ) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

---

## 🔍 Explicação da Query

### Passo 1 – Utilizando `LEFT JOIN`

```sql
LEFT JOIN UnitsSold u
```

O `LEFT JOIN` garante que **todos os produtos da tabela `Prices` apareçam no resultado**, mesmo que não existam vendas registradas na tabela `UnitsSold`.

---

### Passo 2 – Condição de Período de Preço

```sql
u.purchase_date BETWEEN p.start_date AND p.end_date
```

Essa condição garante que apenas vendas realizadas **durante o período em que aquele preço estava válido** sejam consideradas.

---

### Passo 3 – Cálculo da Média Ponderada

```sql
SUM(p.price * u.units) / SUM(u.units)
```

Multiplicamos o preço pela quantidade vendida para calcular o **valor total vendido**, e depois dividimos pelo **total de unidades vendidas**.

Isso produz a média ponderada do preço de venda.

---

### Passo 4 – Lidando com Produtos Sem Venda

```sql
COALESCE(..., 0)
```

Se um produto **não tiver vendas**, o cálculo da média retornaria `NULL`.

O `COALESCE()` substitui esse valor por `0`, conforme exigido pelo problema.

---

### Passo 5 – Arredondamento

```sql
ROUND(..., 2)
```

O resultado final é arredondado para **2 casas decimais**, conforme solicitado.

---

## 📊 Exemplo

### Tabela `Prices`

| product_id | start_date | end_date   | price |
|------------|------------|------------|-------|
| 1 | 2019-02-17 | 2019-02-28 | 5 |
| 1 | 2019-03-01 | 2019-03-22 | 20 |
| 2 | 2019-02-01 | 2019-02-20 | 15 |
| 2 | 2019-02-21 | 2019-03-31 | 30 |

### Tabela `UnitsSold`

| product_id | purchase_date | units |
|------------|--------------|------|
| 1 | 2019-02-25 | 100 |
| 1 | 2019-03-01 | 15 |
| 2 | 2019-02-10 | 200 |
| 2 | 2019-03-22 | 30 |

---

## 📈 Saída Esperada

| product_id | average_price |
|------------|---------------|
| 1 | 6.96 |
| 2 | 16.96 |

---

## 🧾 Conclusão

Este desafio reforça conceitos importantes de SQL analítico:

- Uso correto de `LEFT JOIN`
- Condições de intervalo de datas em `JOIN`
- Cálculo de **média ponderada**
- Uso de `COALESCE()` para tratar valores `NULL`
- Uso de `ROUND()` para formatação de resultados
- Agrupamento com `GROUP BY`

É um excelente exercício para praticar **consultas analíticas envolvendo múltiplas tabelas e agregações**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***