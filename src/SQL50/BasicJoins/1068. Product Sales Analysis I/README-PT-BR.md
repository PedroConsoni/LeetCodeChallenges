# LeetCode SQL – 1068. Product Sales Analysis I

## Descrição do Desafio

O desafio **"Product Sales Analysis I"** no LeetCode tem como objetivo praticar o uso de **INNER JOIN** para combinar dados relacionados de múltiplas tabelas.

O problema fornece duas tabelas:

### Tabela `Sales`

| Coluna     | Tipo |
|------------|------|
| sale_id    | int  |
| product_id | int  |
| year       | int  |
| quantity   | int  |
| price      | int  |

### Tabela `Product`

| Coluna       | Tipo    |
|--------------|---------|
| product_id   | int     |
| product_name | varchar |

- A tabela `Sales` contém informações de vendas.
- A tabela `Product` contém os detalhes dos produtos.
- As duas tabelas se relacionam pela coluna `product_id`.

---

## Objetivo

Retornar uma lista contendo:

* `product_name`
* `year`
* `price`

O resultado deve incluir apenas registros onde exista correspondência de `product_id` nas duas tabelas.

---

## Solução SQL

```sql
SELECT p.product_name, s.year, s.price
FROM sales s
INNER JOIN product p
    ON s.product_id = p.product_id;
```

---

## Explicação da Query

### SELECT

```sql
SELECT p.product_name, s.year, s.price
```

Seleciona:

- `product_name` da tabela `Product`
- `year` da tabela `Sales`
- `price` da tabela `Sales`

---

### FROM

```sql
FROM sales s
```

Define a tabela base da consulta como `Sales`.

---

### INNER JOIN

```sql
INNER JOIN product p
```

O `INNER JOIN` garante que:

- Apenas linhas com `product_id` correspondente nas duas tabelas sejam retornadas.
- Se um produto não existir na tabela `Product`, sua venda não aparecerá no resultado.

---

### ON (Condição de Junção)

```sql
ON s.product_id = p.product_id
```

Define como as tabelas se relacionam:

- A junção ocorre quando o `product_id` da tabela `Sales` é igual ao `product_id` da tabela `Product`.

---

## Exemplo

### Entrada

#### Sales

| sale_id | product_id | year | quantity | price |
|----------|------------|------|----------|-------|
| 1        | 100        | 2008 | 10       | 5000  |
| 2        | 100        | 2009 | 12       | 5000  |
| 7        | 200        | 2011 | 15       | 9000  |

#### Product

| product_id | product_name |
|------------|--------------|
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |

---

### Saída

| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 5000  |
| Nokia        | 2009 | 5000  |
| Apple        | 2011 | 9000  |

Apenas produtos com `product_id` correspondente nas duas tabelas aparecem no resultado.

---

## Conceitos Reforçados

Este desafio reforça conceitos importantes de SQL:

* Uso de **INNER JOIN**
* Combinação de dados de tabelas relacionadas
* Definição correta de condições de junção
* Seleção de colunas específicas de múltiplas tabelas

---

## Conclusão

Este exercício demonstra como bancos de dados relacionais conectam dados transacionais (vendas) com dados descritivos (produtos).

Entender o funcionamento do **INNER JOIN** é fundamental para tarefas reais de análise, relatórios e engenharia de dados, onde apenas registros correspondentes devem ser retornados.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***