# LeetCode SQL – 1341. Movie Rating (Português-BR)

## Descrição do Desafio

O problema **"Movie Rating"** do LeetCode foca na prática de:

- Common Table Expressions (`WITH`)
- Agregações utilizando `COUNT` e `AVG`
- Junções de tabelas com `INNER JOIN`
- Ordenação com múltiplas condições
- Combinação de resultados com `UNION ALL`

O problema fornece três tabelas:

### `Users` Table

| Column | Type |
|------|------|
| user_id | int |
| name | varchar |

Cada linha representa um usuário que pode avaliar filmes.

---

### `Movies` Table

| Column | Type |
|------|------|
| movie_id | int |
| title | varchar |

Cada linha representa um filme.

---

### `MovieRating` Table

| Column | Type |
|------|------|
| movie_id | int |
| user_id | int |
| rating | int |
| created_at | date |

Cada linha representa uma avaliação feita por um usuário para um filme.

---

## Objetivo

Retornar **dois resultados**:

1. O **nome do usuário que avaliou o maior número de filmes**.
2. O **título do filme com a maior média de avaliações em fevereiro de 2020**.

Regras:

- Se vários usuários tiverem o mesmo número de avaliações, deve-se retornar o **nome lexicograficamente menor**.
- Se vários filmes tiverem a mesma média de avaliação, deve-se retornar o **título lexicograficamente menor**.

O resultado final deve conter:

| results |

Com exatamente **duas linhas**.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH TopUser AS ( 
    SELECT TOP 1 name AS results
    FROM Users 
    INNER JOIN MovieRating ON Users.user_id = MovieRating.user_id
    GROUP BY Users.user_id, name
    ORDER BY COUNT(movie_id) DESC, name ASC
),
TopMovie AS (
    SELECT TOP 1 title AS results
    FROM Movies
    INNER JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
    WHERE created_at >= '2020-02-01' AND created_at <= '2020-02-29'
    GROUP BY Movies.movie_id, title
    ORDER BY AVG(CAST(rating AS FLOAT)) DESC, title ASC
)

SELECT results FROM TopUser
UNION ALL
SELECT results FROM TopMovie;
```

---

## Explicação da Query

### Passo 1 – Encontrar o usuário que mais avaliou filmes

```sql
WITH TopUser AS (
```

Uma **Common Table Expression (CTE)** é criada para encontrar o usuário que avaliou o maior número de filmes.

```sql
SELECT TOP 1 name AS results
```

`TOP 1` garante que apenas **um resultado** será retornado.

A coluna é renomeada para `results` para padronizar o formato da saída final.

---

### Passo 2 – Juntando usuários com avaliações

```sql
FROM Users 
INNER JOIN MovieRating ON Users.user_id = MovieRating.user_id
```

Essa junção conecta:

- A tabela **Users**
- A tabela **MovieRating**

Assim é possível identificar **qual usuário avaliou qual filme**.

---

### Passo 3 – Contando avaliações por usuário

```sql
GROUP BY Users.user_id, name
```

Os registros são agrupados por usuário.

Em seguida, a ordenação define qual usuário ficará em primeiro lugar.

```sql
ORDER BY COUNT(movie_id) DESC, name ASC
```

Regras de ordenação:

1. Maior número de avaliações primeiro
2. Em caso de empate, vence o **nome em ordem alfabética**

---

### Passo 4 – Encontrar o filme com maior média de avaliação

```sql
TopMovie AS (
```

Uma segunda CTE é criada para encontrar o **filme com maior média de avaliação em fevereiro de 2020**.

```sql
SELECT TOP 1 title AS results
```

Novamente, apenas **um resultado** será retornado.

---

### Passo 5 – Juntando filmes com avaliações

```sql
FROM Movies
INNER JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
```

Essa junção conecta:

- A tabela **Movies**
- A tabela **MovieRating**

Permitindo analisar as avaliações de cada filme.

---

### Passo 6 – Filtrando avaliações de fevereiro de 2020

```sql
WHERE created_at >= '2020-02-01' AND created_at <= '2020-02-29'
```

Essa condição garante que **apenas avaliações feitas em fevereiro de 2020** sejam consideradas.

---

### Passo 7 – Calculando a média das avaliações

```sql
GROUP BY Movies.movie_id, title
```

As avaliações são agrupadas por filme.

Em seguida é aplicada a lógica de ordenação:

```sql
ORDER BY AVG(CAST(rating AS FLOAT)) DESC, title ASC
```

Regras de ordenação:

1. Maior **média de avaliação** primeiro
2. Em caso de empate, vence o **título em ordem alfabética**

O `CAST` garante que o cálculo da média seja tratado como número decimal.

---

### Passo 8 – Combinando os resultados

```sql
SELECT results FROM TopUser
UNION ALL
SELECT results FROM TopMovie;
```

A etapa final combina os dois resultados:

1. O usuário que mais avaliou filmes
2. O filme com maior média de avaliação

`UNION ALL` mantém **as duas linhas sem remover duplicatas**.

---

## Por que essa solução funciona

Essa solução funciona porque:

- `WITH` organiza a lógica da consulta em etapas claras
- `INNER JOIN` conecta dados relacionados entre tabelas
- `COUNT` identifica o usuário mais ativo
- `AVG` calcula a média de avaliações dos filmes
- A ordenação resolve corretamente casos de empate
- `UNION ALL` combina os dois resultados finais

Essas técnicas permitem extrair **múltiplas análises em uma única consulta SQL**.

---

## Conclusão

Esse desafio reforça vários conceitos importantes de SQL:

- Uso de CTEs para organizar consultas complexas
- Junção de múltiplas tabelas
- Uso de agregações (`COUNT`, `AVG`)
- Aplicação de regras de desempate com `ORDER BY`
- Combinação de resultados com `UNION ALL`

Ele demonstra como o SQL pode ser utilizado para **realizar análises de dados mais avançadas a partir de múltiplas tabelas relacionais**.