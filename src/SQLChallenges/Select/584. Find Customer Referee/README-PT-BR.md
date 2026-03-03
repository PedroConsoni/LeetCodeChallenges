# LeetCode SQL – 584. Find Customer Referee

## Descrição do Desafio

O desafio **"Find Customer Referee"** no LeetCode tem como objetivo praticar o uso de **condições com WHERE**, **operadores de comparação** e o tratamento correto de **valores NULL** em SQL.

O problema fornece uma tabela:

### Tabela `Customer`

| Coluna      | Tipo    |
|------------|---------|
| id         | int     |
| name       | varchar |
| referee_id | int     |

- Cada cliente pode ter sido indicado por outro cliente.
- A coluna `referee_id` armazena o `id` do cliente que fez a indicação.
- Se um cliente **não foi indicado por ninguém**, o valor de `referee_id` será `NULL`.

---

## Objetivo

Retornar os nomes dos clientes que:

- **Não foram indicados pelo cliente com id = 2**
- Ou **não possuem nenhum indicador (referee_id é NULL)**

O resultado deve conter apenas:

* `name`

---

## Solução SQL (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT name
FROM customer
WHERE referee_id != 2 OR referee_id IS NULL;
```

---

## Explicação da Query

### SELECT

```sql
SELECT name
```

Seleciona a coluna que deve ser exibida no resultado final.

O desafio exige apenas o campo `name`.

---

### FROM

```sql
FROM customer
```

Define a tabela da qual os dados serão consultados.

---

### WHERE (Condição)

```sql
WHERE referee_id != 2 OR referee_id IS NULL
```

Essa é a parte mais importante da consulta.

Vamos dividir:

---

### `referee_id != 2`

Filtra os clientes cujo indicador **não é o cliente de id 2**.

Porém, essa condição sozinha **não inclui valores NULL**.

#### Por quê?

No SQL:

- Qualquer comparação com `NULL` resulta em **UNKNOWN**
- E `UNKNOWN` é tratado como **FALSE** dentro do `WHERE`

Ou seja:

```sql
referee_id != 2
```

Não retorna linhas onde `referee_id` é `NULL`.

---

### `OR referee_id IS NULL`

Essa parte garante que também sejam incluídos os clientes que:

- Não possuem indicador
- Têm `referee_id` igual a `NULL`

---

### Resultado Final da Condição

Combinando as duas condições:

- Inclui clientes indicados por qualquer pessoa diferente de 2
- Inclui clientes sem indicador
- Exclui apenas os clientes indicados pelo cliente de id 2

---

## Exemplo

### Entrada

| id | name  | referee_id |
|----|-------|------------|
| 1  | Will  | NULL       |
| 2  | Jane  | NULL       |
| 3  | Alex  | 2          |
| 4  | Bill  | NULL       |
| 5  | Zack  | 1          |
| 6  | Mark  | 2          |

---

### Saída

| name  |
|-------|
| Will  |
| Jane  |
| Bill  |
| Zack  |

`Alex` e `Mark` não aparecem porque possuem `referee_id = 2`.

---

## Conceitos Reforçados

Este desafio reforça fundamentos essenciais de SQL:

* Uso da cláusula **WHERE**
* Operadores lógicos (**OR**)
* Operadores de comparação (`!=`)
* Tratamento correto de **NULL**
* Entendimento da lógica ternária do SQL (TRUE, FALSE, UNKNOWN)

---

## Conclusão

Apesar de simples, este exercício ensina um ponto extremamente importante:

> Comparações com `NULL` usando `=` ou `!=` não funcionam como muitos iniciantes esperam.

Compreender o comportamento do `NULL` é fundamental para escrever filtros corretos em bancos de dados reais, especialmente em cenários de **engenharia de dados** e **desenvolvimento back-end**.

---