# LeetCode SQL – 1581. Customer Who Visited but Did Not Make Any Transactions

## Descrição do Desafio

O desafio **"Customer Who Visited but Did Not Make Any Transactions"** no LeetCode tem como objetivo praticar **LEFT JOIN**, filtragem com **NULL** e agregação com **GROUP BY**.

O problema fornece duas tabelas:

### Tabela `Visits`

| Coluna       | Tipo |
|--------------|------|
| visit_id     | int  |
| customer_id  | int  |

### Tabela `Transactions`

| Coluna         | Tipo |
|----------------|------|
| transaction_id | int  |
| visit_id       | int  |
| amount         | int  |

- Cada linha em `Visits` representa uma visita de um cliente.
- Cada linha em `Transactions` representa uma transação realizada durante uma visita.
- Algumas visitas podem não ter nenhuma transação associada.

---

## Objetivo

Retornar:

* `customer_id`
* `count_no_trans`

Onde:

- `count_no_trans` representa a quantidade de visitas feitas por um cliente **sem realizar nenhuma transação**.

---

## Solução SQL

```sql
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans 
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;
```

---

## Explicação da Query

### SELECT

```sql
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
```

- `v.customer_id` identifica o cliente.
- `COUNT(v.visit_id)` conta quantas visitas não tiveram transação.
- `AS count_no_trans` renomeia a coluna conforme solicitado.

---

### FROM

```sql
FROM Visits v
```

Define `Visits` como tabela base.

Como precisamos considerar todas as visitas (inclusive as que não tiveram transação), ela deve ser a tabela principal.

---

### LEFT JOIN

```sql
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
```

O `LEFT JOIN` garante que:

- Todas as visitas sejam retornadas.
- As transações correspondentes sejam incluídas quando existirem.
- Se não houver transação, as colunas de `Transactions` serão `NULL`.

---

### WHERE

```sql
WHERE t.transaction_id IS NULL
```

Filtra apenas as visitas que:

- Não possuem transação correspondente.

Se `transaction_id` for `NULL`, significa que a visita não teve transação.

---

### GROUP BY

```sql
GROUP BY v.customer_id
```

Agrupa os resultados filtrados por cliente.

Isso permite contar quantas visitas sem transação cada cliente teve.

---

## Exemplo

### Entrada

#### Visits

| visit_id | customer_id |
|----------|------------|
| 1        | 23         |
| 2        | 9          |
| 4        | 30         |
| 5        | 54         |
| 6        | 96         |
| 7        | 54         |
| 8        | 54         |

#### Transactions

| transaction_id | visit_id | amount |
|----------------|----------|--------|
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |

---

### Saída

| customer_id | count_no_trans |
|-------------|---------------|
| 30          | 1             |
| 54          | 2             |
| 96          | 1             |

Esses clientes visitaram, mas não realizaram transações nessas visitas.

---

## Conceitos Reforçados

Este desafio reforça conceitos importantes de SQL:

* Uso de **LEFT JOIN**
* Filtro de registros não correspondentes com `IS NULL`
* Agregação com **COUNT()**
* Agrupamento com **GROUP BY**
* Combinação de junção com agregação

---

## Conclusão

Este exercício representa um cenário muito comum no mundo real:

Identificar registros que existem em uma tabela, mas não possuem correspondência em outra.

Entender como combinar **LEFT JOIN**, filtro por `NULL` e agregação é fundamental para análise de dados, relatórios e tarefas de engenharia de dados.

---