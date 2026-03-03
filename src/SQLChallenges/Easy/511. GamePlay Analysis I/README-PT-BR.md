# LeetCode SQL – Last Login (Primeiro Login por Jogador)

## Descrição do Desafio

O desafio **"Last Login"** (também conhecido como *First Login by Player*) do LeetCode tem como objetivo praticar o uso de **GROUP BY**, **funções agregadas** e **ordenação de resultados** em SQL.

O objetivo é determinar a **primeira data de login** de cada jogador com base nos registros de atividade.

---

## Estrutura da Tabela

### Tabela `Activity`

| Coluna       | Tipo |
| ------------ | ---- |
| player_id    | int  |
| device_id    | int  |
| event_date   | date |
| games_played | int  |

Cada linha representa uma atividade de login de um jogador em uma data específica.

---

## Objetivo

Para cada `player_id`, retornar:

* O identificador do jogador
* A **primeira data de login** (menor `event_date`)

O resultado deve estar ordenado por `player_id` em ordem crescente.

### Colunas esperadas:

* `player_id`
* `first_login`

---

## Solução em SQL

```sql
SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id
ORDER BY player_id ASC;
```

---

## Explicação da Query

### MIN (Função Agregada)

```sql
MIN(event_date)
```

Retorna a **data mais antiga** para cada jogador, que corresponde ao seu primeiro login.

---

### GROUP BY

```sql
GROUP BY player_id
```

Agrupa todos os registros de atividade por `player_id`, permitindo aplicar funções agregadas para cada jogador.

---

### SELECT

```sql
SELECT player_id, MIN(event_date) AS first_login
```

Seleciona:

* O identificador do jogador
* A data do primeiro login, renomeada como `first_login`

---

### ORDER BY

```sql
ORDER BY player_id ASC
```

Ordena o resultado pelo `player_id` em ordem crescente, conforme solicitado no desafio.

---

## Exemplo

### Tabela Activity

| player_id | event_date |
| --------- | ---------- |
| 1         | 2016-03-01 |
| 1         | 2016-05-02 |
| 2         | 2017-06-25 |
| 3         | 2018-07-03 |
| 3         | 2018-07-04 |

### Resultado

| player_id | first_login |
| --------- | ----------- |
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2018-07-03  |

---

## Conclusão

Este desafio reforça conceitos importantes de SQL:

* Uso de **funções agregadas (MIN)**
* Agrupamento de dados com **GROUP BY**
* Ordenação de resultados com **ORDER BY**

É um exercício fundamental para trabalhar com **dados temporais e lógica de agregação** em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
