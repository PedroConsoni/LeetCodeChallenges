# LeetCode SQL – 1484. Agrupar Produtos Vendidos por Data

## Descrição do Desafio

O problema **"Group Sold Products By The Date"** do LeetCode foca em conceitos importantes de SQL, como:

- Agrupar dados com `GROUP BY`
- Remover duplicatas com `DISTINCT`
- Utilizar funções de agregação como `COUNT`
- Concatenar valores com `STRING_AGG`
- Ordenar resultados com `ORDER BY`

O desafio fornece apenas **uma tabela**.

---

## Tabela `Activities`

| Coluna | Tipo |
|------|------|
| sell_date | date |
| product | varchar |

Cada linha representa **um produto que foi vendido em uma determinada data**.

Entretanto, o mesmo produto pode aparecer **várias vezes na mesma data**, o que significa que podem existir **registros duplicados**.

---

## Objetivo

Para **cada `sell_date`**, devemos retornar:

- O número de **produtos distintos vendidos** (`num_sold`)
- Uma **lista de produtos separados por vírgula** vendidos naquela data (`products`)

Requisitos adicionais:

- Os produtos devem ser **únicos**
- Os produtos devem estar **ordenados alfabeticamente**
- O resultado final deve estar **ordenado pela data (`sell_date`)**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STRING_AGG(product, ',') WITHIN GROUP (ORDER BY product ASC) AS products
FROM (
    SELECT DISTINCT sell_date, product
    FROM Activities
) AS DistinctActivities
GROUP BY 
    sell_date
ORDER BY 
    sell_date;
```

---

## Explicação da Query

### Passo 1 – Removendo Produtos Duplicados por Data

```sql
SELECT DISTINCT sell_date, product
FROM Activities
```

A palavra-chave `DISTINCT` garante que **cada produto apareça apenas uma vez por data**.

Exemplo de dados com duplicatas:

| sell_date | product |
|----------|--------|
| 2020-05-30 | Headphone |
| 2020-05-30 | Headphone |

Sem o `DISTINCT`, essas duplicatas continuariam no conjunto de dados e poderiam afetar o resultado final.

---

### Passo 2 – Criando uma Subconsulta

```sql
FROM (
    SELECT DISTINCT sell_date, product
    FROM Activities
) AS DistinctActivities
```

Essa subconsulta cria um **resultado temporário** onde as duplicatas já foram removidas.

Dessa forma, a agregação da consulta principal trabalha com **dados limpos**.

---

### Passo 3 – Contando Produtos Únicos

```sql
COUNT(DISTINCT product) AS num_sold
```

Essa função conta quantos **produtos diferentes foram vendidos em cada data**.

Exemplo:

Produtos vendidos em um dia:

```
Headphone
Keyboard
Mouse
```

Resultado:

```
num_sold = 3
```

---

### Passo 4 – Agrupando Produtos em uma String

```sql
STRING_AGG(product, ',')
```

A função `STRING_AGG` combina várias linhas em **uma única string separada por vírgulas**.

Exemplo:

Linhas:

| product |
|------|
| Headphone |
| Keyboard |
| Mouse |

Resultado:

```
Headphone,Keyboard,Mouse
```

---

### Passo 5 – Ordenando os Produtos Alfabeticamente

```sql
WITHIN GROUP (ORDER BY product ASC)
```

Isso garante que os produtos dentro da string agregada estejam **em ordem alfabética**.

Ordem correta:

```
Headphone,Keyboard,Mouse
```

Em vez de:

```
Mouse,Headphone,Keyboard
```

---

### Passo 6 – Agrupando por Data

```sql
GROUP BY sell_date
```

Esse comando agrupa todas as linhas que possuem a mesma `sell_date`.

Cada data se torna **uma única linha no resultado final**.

---

### Passo 7 – Ordenando o Resultado Final

```sql
ORDER BY sell_date
```

Isso ordena o resultado **cronologicamente**, da data mais antiga para a mais recente.

---

## Exemplo

Se a tabela contiver:

| sell_date | product |
|----------|--------|
| 2020-05-30 | Headphone |
| 2020-05-30 | Keyboard |
| 2020-05-30 | Headphone |
| 2020-06-01 | Pencil |
| 2020-06-01 | Pencil |
| 2020-06-01 | Eraser |

---

## Após Remover Duplicatas

| sell_date | product |
|----------|--------|
| 2020-05-30 | Headphone |
| 2020-05-30 | Keyboard |
| 2020-06-01 | Pencil |
| 2020-06-01 | Eraser |

---

## Resultado Final

| sell_date | num_sold | products |
|----------|----------|----------|
| 2020-05-30 | 2 | Headphone,Keyboard |
| 2020-06-01 | 2 | Eraser,Pencil |

Explicação:

- **2020-05-30**
  - Produtos vendidos: Headphone, Keyboard
  - Total de produtos únicos: **2**

- **2020-06-01**
  - Produtos vendidos: Eraser, Pencil
  - Total de produtos únicos: **2**

---

## Por Que Essa Solução Funciona

Essa solução funciona porque:

- `DISTINCT` remove pares duplicados de `(sell_date, product)`
- `COUNT(DISTINCT product)` calcula quantos produtos únicos foram vendidos
- `STRING_AGG` concatena várias linhas em uma única string
- `WITHIN GROUP (ORDER BY ...)` garante a ordem alfabética
- `GROUP BY sell_date` agrupa os registros por data

---

## Conceitos de SQL Praticados

Este desafio reforça vários conceitos importantes de SQL:

- Remoção de duplicatas com `DISTINCT`
- Uso de funções de agregação como `COUNT`
- Concatenação de valores com `STRING_AGG`
- Agrupamento de dados com `GROUP BY`
- Ordenação de resultados com `ORDER BY`

---

## Conclusão

O desafio **Group Sold Products By The Date** é um excelente exercício para praticar **agregações e agrupamentos em SQL**.

Ele demonstra como:

- Limpar conjuntos de dados com duplicatas
- Agrupar informações por uma coluna específica
- Criar saídas formatadas utilizando agregação de strings

Essas técnicas são muito utilizadas em **análise de dados, relatórios e consultas analíticas**, tornando esse problema bastante relevante em cenários reais de SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***