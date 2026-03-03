# LeetCode SQL – 1148. Article Views I

## Descrição do Desafio

O desafio **"Article Views I"** no LeetCode tem como objetivo praticar o uso da cláusula **WHERE**, comparação entre colunas e remoção de duplicidades utilizando **DISTINCT**.

O problema fornece uma tabela:

### Tabela `Views`

| Coluna     | Tipo |
|------------|------|
| article_id | int  |
| author_id  | int  |
| viewer_id  | int  |
| view_date  | date |

- Cada linha representa uma visualização de um artigo.
- `author_id` identifica o autor do artigo.
- `viewer_id` identifica quem visualizou o artigo.

---

## Objetivo

Retornar os IDs dos autores que visualizaram **pelo menos um de seus próprios artigos**.

O resultado deve conter:

* `id` (author_id renomeado como id)

O resultado deve estar em ordem crescente.

---

## Solução SQL (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY id;
```

---

## Explicação da Query

### SELECT

```sql
SELECT DISTINCT author_id AS id
```

- `author_id` é selecionado porque precisamos retornar o ID do autor.
- `AS id` renomeia a coluna conforme exigido pelo problema.
- `DISTINCT` garante que cada autor apareça apenas uma vez no resultado.

Sem o `DISTINCT`, o mesmo autor poderia aparecer várias vezes caso visualizasse seu próprio artigo mais de uma vez.

---

### FROM

```sql
FROM views
```

Define a tabela da qual os dados serão consultados.

---

### WHERE

```sql
WHERE author_id = viewer_id
```

Essa condição filtra os registros onde:

- O autor do artigo é a mesma pessoa que o visualizou.

Ou seja:

- O autor visualizou o próprio artigo.

---

### ORDER BY

```sql
ORDER BY id
```

Garante que o resultado esteja ordenado de forma crescente pelo ID do autor, conforme exigido pelo desafio.

---

## Exemplo

### Entrada

| article_id | author_id | viewer_id | view_date  |
|------------|----------|-----------|------------|
| 1          | 3        | 5         | 2019-08-01 |
| 1          | 3        | 6         | 2019-08-02 |
| 2          | 7        | 7         | 2019-08-01 |
| 2          | 7        | 6         | 2019-08-02 |
| 4          | 7        | 1         | 2019-07-22 |
| 3          | 4        | 4         | 2019-07-21 |

---

### Saída

| id |
|----|
| 4  |
| 7  |

Os autores 4 e 7 visualizaram pelo menos um de seus próprios artigos.

---

## Conceitos Reforçados

Este desafio reforça fundamentos essenciais de SQL:

* Comparação entre colunas dentro do `WHERE`
* Uso de **DISTINCT** para remover duplicidades
* Uso de alias com **AS**
* Ordenação com **ORDER BY**

---

## Conclusão

Apesar de ser um exercício simples, ele fortalece conceitos centrais de filtragem em SQL.

Entender como comparar colunas dentro da mesma tabela e eliminar duplicidades é essencial para consultas reais em análise de dados, engenharia de dados e desenvolvimento back-end.

---