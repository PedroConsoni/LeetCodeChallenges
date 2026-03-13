# LeetCode SQL – 1378. Replace Employee ID With The Unique Identifier

## Descrição do Desafio

O desafio **"Replace Employee ID With The Unique Identifier"** no LeetCode tem como objetivo praticar **operações de JOIN**, especialmente o **LEFT JOIN**, para combinar dados de tabelas relacionadas.

O problema fornece duas tabelas:

### Tabela `Employees`

| Coluna | Tipo |
|--------|------|
| id     | int  |
| name   | varchar |

### Tabela `EmployeeUNI`

| Coluna    | Tipo |
|-----------|------|
| id        | int  |
| unique_id | int  |

- Cada funcionário possui um `id` e um `name`.
- Alguns funcionários possuem um `unique_id` correspondente na tabela `EmployeeUNI`.
- Nem todos os funcionários possuem um registro correspondente em `EmployeeUNI`.

---

## Objetivo

Retornar uma lista contendo:

* `unique_id`
* `name`

Garantindo que **todos os funcionários apareçam no resultado**, mesmo que não possuam `unique_id`.

---

## Solução SQL

```sql
SELECT u.unique_id, e.name
FROM employees e
LEFT JOIN employeeuni u
    ON e.id = u.id;
```

---

## Explicação da Query

### SELECT

```sql
SELECT u.unique_id, e.name
```

Seleciona:

- `unique_id` da tabela `EmployeeUNI`
- `name` da tabela `Employees`

Se o funcionário não tiver um `unique_id` correspondente, o valor retornado será `NULL`.

---

### FROM

```sql
FROM employees e
```

Define a **tabela base** da consulta.

Como precisamos garantir que todos os funcionários apareçam, `Employees` deve ser a tabela principal.

---

### LEFT JOIN

```sql
LEFT JOIN employeeuni u
```

O `LEFT JOIN` garante que:

- Todas as linhas da tabela `Employees` sejam retornadas.
- Os dados da tabela `EmployeeUNI` sejam incluídos quando houver correspondência.
- Caso não exista correspondência, `unique_id` será `NULL`.

---

### ON (Condição de Junção)

```sql
ON e.id = u.id
```

Define como as tabelas se relacionam:

- A junção ocorre quando o `id` da tabela `Employees` é igual ao `id` da tabela `EmployeeUNI`.

---

## Exemplo

### Entrada

#### Employees

| id | name     |
|----|----------|
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |

#### EmployeeUNI

| id | unique_id |
|----|-----------|
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |

---

### Saída

| unique_id | name     |
|------------|----------|
| NULL       | Alice    |
| NULL       | Bob      |
| 2          | Meir     |
| 3          | Winston  |
| 1          | Jonathan |

Funcionários sem `unique_id` correspondente ainda aparecem no resultado.

---

## Conceitos Reforçados

Este desafio reforça conceitos importantes de SQL:

* Uso de **LEFT JOIN**
* Combinação de dados de múltiplas tabelas
* Tratamento de valores `NULL`
* Definição correta de condições de junção

---

## Conclusão

Este exercício demonstra como bancos de dados relacionais conectam dados entre tabelas.

Entender o funcionamento do **LEFT JOIN** é fundamental em cenários reais de engenharia de dados, análise de dados e desenvolvimento back-end, onde preservar registros não correspondentes é essencial.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***