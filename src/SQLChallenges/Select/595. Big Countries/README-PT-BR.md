# LeetCode SQL – Big Countries

## Descrição do Desafio

O desafio **"Big Countries"** do LeetCode tem como objetivo praticar a **filtragem de dados em SQL** utilizando a cláusula **WHERE** combinada com operadores lógicos.

O problema fornece uma tabela chamada `World`, que armazena informações sobre diferentes países.

### Tabela `World`

| Coluna     | Tipo    |
| ---------- | ------- |
| name       | varchar |
| continent  | varchar |
| area       | int     |
| population | int     |
| gdp        | bigint  |

---

## Objetivo

Retornar informações dos países que atendem **pelo menos um** dos critérios abaixo:

* `area` maior ou igual a **3.000.000**
* `population` maior ou igual a **25.000.000**

### Colunas exigidas:

* `name`
* `population`
* `area`

---

## Solução em SQL

```sql
SELECT w.name, w.population, w.area
FROM world w
WHERE area >= 3000000 OR population >= 25000000;
```

---

## Explicação da Query

### SELECT

```sql
SELECT w.name, w.population, w.area
```

Seleciona as colunas necessárias da tabela `World`:

* Nome do país
* População
* Área territorial

---

### FROM

```sql
FROM world w
```

Define a tabela de origem da consulta e utiliza um **alias (`w`)** para facilitar a leitura do código.

---

### WHERE com OR

```sql
WHERE area >= 3000000 OR population >= 25000000
```

Aplica as condições de filtro utilizando o operador lógico **OR**:

* O país será retornado se a **área for grande o suficiente**
* **OU** se a **população for grande o suficiente**

Basta **uma das condições ser verdadeira** para que o registro apareça no resultado.

---

## Resultado Esperado

| name          | population | area     |
| ------------- | ---------- | -------- |
| Russia        | 144000000  | 17098246 |
| United States | 331000000  | 9833517  |
| China         | 1400000000 | 9596961  |

> Países que atendem a pelo menos um dos critérios são considerados **"países grandes"**.

---

## Conclusão

Este desafio reforça conceitos fundamentais de SQL:

* Filtragem de dados com a cláusula **WHERE**
* Uso de **operadores lógicos (OR)**
* Seleção de colunas específicas

É um exercício essencial para quem está iniciando em **SQL e análise de dados**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
