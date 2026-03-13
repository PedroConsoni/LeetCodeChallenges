# LeetCode SQL – 1327. Listar Produtos Pedidos em um Período

## Descrição do Desafio

O problema **"List the Products Ordered in a Period"** do LeetCode trabalha conceitos importantes de SQL, como:

- Junção de tabelas com `INNER JOIN`
- Filtragem de dados com `WHERE`
- Funções de agregação como `SUM`
- Agrupamento de resultados com `GROUP BY`
- Filtragem de agregações com `HAVING`

O desafio fornece duas tabelas.

---

## Tabela `Products`

| Coluna | Tipo |
|------|------|
| product_id | int |
| product_name | varchar |

Cada linha representa um produto disponível.

---

## Tabela `Orders`

| Coluna | Tipo |
|------|------|
| product_id | int |
| order_date | date |
| unit | int |

Cada linha representa um pedido de um produto em uma data específica.

A coluna `unit` representa **quantas unidades do produto foram compradas**.

---

## Objetivo

Retornar os produtos que:

- Foram pedidos durante **fevereiro de 2020**
- Possuem **total de unidades vendidas maior ou igual a 100**

O resultado deve incluir:

- `product_name`
- O **total de unidades vendidas** (`unit`)

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    p.product_name, 
    SUM(o.unit) AS unit
FROM 
    Products p
INNER JOIN 
    Orders o ON p.product_id = o.product_id
WHERE 
    o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;
```

---

## Explicação da Query

### Passo 1 – Fazendo a Junção das Tabelas

```sql
INNER JOIN Orders o ON p.product_id = o.product_id
```

O `INNER JOIN` conecta as tabelas `Products` e `Orders` usando `product_id`.

Isso permite acessar:

- o **nome do produto**
- os **dados do pedido**

---

### Passo 2 – Filtrando os Pedidos por Data

```sql
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
```

Essa condição seleciona apenas pedidos feitos em **fevereiro de 2020**.

O operador `BETWEEN` inclui ambas as datas limite.

---

### Passo 3 – Agrupando por Produto

```sql
GROUP BY p.product_name
```

Esse comando agrupa todos os pedidos que pertencem ao mesmo produto.

Cada produto gera **uma única linha no resultado final**.

---

### Passo 4 – Somando as Unidades Vendidas

```sql
SUM(o.unit)
```

A função `SUM` calcula o **total de unidades vendidas de cada produto** no período selecionado.

Exemplo:

| product_name | unit |
|--------------|------|
| Keyboard | 40 |
| Keyboard | 70 |

Resultado:

```
110
```

---

### Passo 5 – Filtrando os Resultados Agregados

```sql
HAVING SUM(o.unit) >= 100
```

A cláusula `HAVING` filtra os resultados após o agrupamento.

Somente produtos com **100 ou mais unidades vendidas** aparecem no resultado final.

---

## Exemplo

### Products

| product_id | product_name |
|------------|-------------|
| 1 | Keyboard |
| 2 | Mouse |
| 3 | Monitor |

### Orders

| product_id | order_date | unit |
|-----------|------------|------|
| 1 | 2020-02-05 | 40 |
| 1 | 2020-02-10 | 70 |
| 2 | 2020-02-15 | 20 |
| 3 | 2020-02-20 | 90 |

---

## Resultado

| product_name | unit |
|--------------|------|
| Keyboard | 110 |

Explicação:

- Keyboard total em fevereiro = **110**
- Mouse total = **20**
- Monitor total = **90**

Apenas **Keyboard** atende à condição `>= 100`.

---

## Por Que Essa Solução Funciona

Essa solução funciona porque:

- `INNER JOIN` conecta produtos com seus pedidos
- `WHERE` filtra os pedidos no intervalo de datas correto
- `GROUP BY` agrupa os pedidos por produto
- `SUM` calcula o total de unidades vendidas
- `HAVING` filtra os resultados agregados

---

## Conceitos de SQL Praticados

Este desafio reforça:

- Junções entre tabelas
- Filtragem por datas
- Funções de agregação
- Filtragem de agregações com `HAVING`
- Estruturação de consultas analíticas

---

## Conclusão

O desafio **List the Products Ordered in a Period** demonstra como combinar **junções, agregações e filtros** para analisar dados de vendas.

Essas técnicas são amplamente usadas em:

- análises de vendas
- dashboards
- consultas de business intelligence

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***