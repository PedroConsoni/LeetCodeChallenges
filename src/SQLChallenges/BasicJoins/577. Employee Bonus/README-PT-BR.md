# LeetCode SQL – Employee Bonus

## Descrição do Desafio

O desafio **"Employee Bonus"** do LeetCode tem como objetivo praticar o uso de **LEFT OUTER JOIN** combinado com **filtros utilizando WHERE**, incluindo o tratamento de valores **NULL**.

O problema fornece duas tabelas relacionadas a funcionários e seus respectivos bônus.

---

## Estrutura das Tabelas

### Tabela `Employee`

| Coluna     | Tipo    |
| ---------- | ------- |
| empId      | int     |
| name       | varchar |
| supervisor | int     |
| salary     | int     |

### Tabela `Bonus`

| Coluna | Tipo |
| ------ | ---- |
| empId  | int  |
| bonus  | int  |

Nem todo funcionário possui um bônus cadastrado.

---

## Objetivo

Retornar uma lista contendo:

* `name` (nome do funcionário)
* `bonus` (valor do bônus)

A consulta deve incluir:

* Funcionários com **bônus menor que 1000**
* Funcionários **sem bônus registrado** (`NULL`)

---

## Solução em SQL

```sql
SELECT e.name, b.bonus
FROM employee e
LEFT OUTER JOIN bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;
```

---

## Explicação da Query

### SELECT

```sql
SELECT e.name, b.bonus
```

Seleciona:

* O nome do funcionário da tabela `Employee`
* O valor do bônus da tabela `Bonus`

---

### FROM

```sql
FROM employee e
```

Define a tabela principal da consulta.

> A tabela `Employee` é a base para garantir que todos os funcionários sejam considerados.

---

### LEFT OUTER JOIN

```sql
LEFT OUTER JOIN bonus b
ON e.empId = b.empId
```

O `LEFT OUTER JOIN` garante que:

* Todos os funcionários apareçam no resultado
* O bônus será retornado apenas quando existir correspondência

Quando não houver bônus, o valor será `NULL`.

---

### WHERE com OR e IS NULL

```sql
WHERE b.bonus < 1000 OR b.bonus IS NULL
```

Aplica os critérios de filtragem:

* Funcionários com bônus **menor que 1000**
* Funcionários **sem bônus cadastrado**

O operador **OR** garante que qualquer uma das condições seja suficiente.

---

## Resultado Esperado

| name | bonus |
| ---- | ----- |
| Brad | NULL  |
| John | 500   |
| Dan  | NULL  |

> Funcionários sem bônus ou com bônus abaixo de 1000 aparecem no resultado.

---

## Conclusão

Este desafio reforça conceitos importantes de SQL:

* Uso de **LEFT OUTER JOIN**
* Tratamento de valores **NULL**
* Aplicação de filtros com **WHERE** e **OR**

É um excelente exercício para consolidar conhecimentos de **joins e filtragem de dados** em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
