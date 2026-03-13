# LeetCode SQL – 1667. Fix Names in a Table

## Descrição do Desafio

O desafio **"Fix Names in a Table"** no LeetCode tem como objetivo praticar **manipulação de strings** e padronização de texto em SQL.

O problema fornece uma tabela:

### Tabela `Users`

| Coluna  | Tipo    |
|---------|---------|
| user_id | int     |
| name    | varchar |

A coluna `name` pode conter capitalização inconsistente, como:

- `aLice`
- `bOB`
- `CHARLIE`

O objetivo é padronizar os nomes para que:

- A primeira letra seja maiúscula
- As demais letras sejam minúsculas

---

## Objetivo

Retornar:

* `user_id`
* `name` (formatado corretamente)

O resultado deve estar ordenado por `user_id` em ordem crescente.

---

## Solução SQL (SQL Server / T-SQL)

```sql
SELECT user_id, 
       UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS name
FROM users
ORDER BY user_id;
```

---

## Explicação da Query

### SELECT

```sql
SELECT user_id, 
       UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS name
```

- `user_id` é retornado normalmente.
- A coluna `name` é transformada e renomeada como `name`.

Vamos entender a lógica:

---

### `LEFT(name, 1)`

Extrai o primeiro caractere do nome.

Exemplo:
- `aLice` → `a`

---

### `UPPER(LEFT(name, 1))`

Converte o primeiro caractere para maiúsculo.

Exemplo:
- `a` → `A`

---

### `SUBSTRING(name, 2, LEN(name))`

Extrai o restante do nome a partir da segunda posição.

Exemplo:
- `aLice` → `Lice`

---

### `LOWER(SUBSTRING(...))`

Converte o restante das letras para minúsculas.

Exemplo:
- `Lice` → `lice`

---

### Concatenação (`+`)

```sql
UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name)))
```

Une:

- Primeira letra maiúscula
- Restante em minúsculo

Resultado final:
- `aLice` → `Alice`
- `bOB` → `Bob`
- `CHARLIE` → `Charlie`

---

### FROM

```sql
FROM users
```

Define a tabela consultada.

---

### ORDER BY

```sql
ORDER BY user_id
```

Garante que os resultados estejam ordenados pelo `user_id` em ordem crescente.

---

## Exemplo

### Entrada

| user_id | name     |
|----------|----------|
| 1        | aLice    |
| 2        | bOB      |
| 3        | CHARLIE  |

---

### Saída

| user_id | name     |
|----------|----------|
| 1        | Alice    |
| 2        | Bob      |
| 3        | Charlie  |

---

## Conceitos Reforçados

Este desafio reforça conceitos importantes de SQL:

* Funções de manipulação de string (`UPPER`, `LOWER`, `LEFT`, `SUBSTRING`, `LEN`)
* Concatenação de strings
* Uso de alias com `AS`
* Ordenação com `ORDER BY`

---

## Conclusão

Este exercício demonstra como SQL pode ser utilizado para **limpeza e padronização de dados**.

A formatação correta de texto é essencial em cenários reais de normalização de entrada de usuários, padronização de dados e melhoria da qualidade das informações.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***