# LeetCode SQL – Second Highest Salary

## Descrição do Desafio

O desafio **"Second Highest Salary"** do LeetCode tem como objetivo praticar o uso de **subqueries** e **funções agregadas** em SQL.

O objetivo é encontrar o **segundo maior salário** presente na tabela `Employee`.

---

## Estrutura da Tabela

### Tabela `Employee`

| Coluna | Tipo |
| ------ | ---- |
| id     | int  |
| salary | int  |

A tabela pode conter vários funcionários com o mesmo salário.

---

## Objetivo

Retornar o **segundo maior salário** entre todos os funcionários.

* Caso não exista um segundo maior salário, a consulta deve retornar `NULL`.

### Coluna esperada:

* `secondhighestsalary`

---

## Solução em SQL

```sql
SELECT MAX(salary) AS secondhighestsalary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);
```

---

## Explicação da Query

### Subquery – Maior Salário

```sql
(SELECT MAX(salary) FROM employee)
```

Essa subquery retorna o **maior salário** da tabela `Employee`.

---

### WHERE (Exclusão do Maior Salário)

```sql
WHERE salary < (SELECT MAX(salary) FROM employee)
```

Remove da seleção todos os registros que possuem o **maior salário**, mantendo apenas salários **menores que o máximo**.

---

### MAX sobre o Resultado Filtrado

```sql
SELECT MAX(salary) AS secondhighestsalary
```

Entre os salários restantes, o `MAX(salary)` retorna o **maior valor**, que corresponde ao **segundo maior salário**.

---

## Exemplo

### Tabela Employee

| id | salary |
| -- | ------ |
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

### Resultado

| secondhighestsalary |
| ------------------- |
| 200                 |

---

## Caso Especial (Edge Case)

Se todos os funcionários tiverem o **mesmo salário**, a subquery eliminará todos os registros, e o resultado será:

| secondhighestsalary |
| ------------------- |
| NULL                |

Esse comportamento está de acordo com os requisitos do desafio.

---

## Conclusão

Este desafio reforça conceitos fundamentais de SQL:

* Uso de **subqueries**
* Aplicação de **funções agregadas (MAX)**
* Tratamento de **casos especiais** com retorno `NULL`

É um exercício essencial para consolidar a **lógica de consultas SQL e resolução de problemas**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
