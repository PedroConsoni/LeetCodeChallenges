# LeetCode SQL – 1683. Invalid Tweets

## Descrição do Desafio

O desafio **"Invalid Tweets"** no LeetCode tem como objetivo praticar o uso da cláusula **WHERE** e de **funções de string**, especificamente a função `LENGTH()` no PostgreSQL.

O problema fornece uma tabela:

### Tabela `Tweets`

| Coluna    | Tipo    |
|-----------|---------|
| tweet_id  | int     |
| content   | varchar |

- Cada linha representa um tweet.
- A coluna `content` armazena o texto do tweet.

De acordo com o problema, um tweet é considerado **inválido** se o tamanho do seu conteúdo for **maior que 15 caracteres**.

---

## Objetivo

Retornar os IDs dos tweets que são **inválidos**.

O resultado deve conter apenas:

* `tweet_id`

---

## Solução SQL (PostgreSQL)

```sql
-- Write your PostgreSQL query statement below
SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 15;
```

---

## Explicação da Query

### SELECT

```sql
SELECT tweet_id
```

Seleciona a coluna que deve ser exibida no resultado final.

O desafio solicita apenas o `tweet_id`.

---

### FROM

```sql
FROM tweets
```

Define a tabela da qual os dados serão consultados.

---

### WHERE

```sql
WHERE LENGTH(content) > 15
```

Essa condição filtra os tweets com base no tamanho do conteúdo.

- `LENGTH(content)` calcula a quantidade de caracteres do tweet.
- `> 15` garante que apenas tweets com mais de 15 caracteres sejam retornados.

Se o conteúdo tiver 15 caracteres ou menos, o tweet é considerado válido e não aparecerá no resultado.

---

## Exemplo

### Entrada

| tweet_id | content                          |
|-----------|----------------------------------|
| 1         | Vote for Biden                  |
| 2         | Let us make America great again! |

---

### Saída

| tweet_id |
|----------|
| 2        |

O tweet 2 é inválido porque possui mais de 15 caracteres.

---

## Conceitos Reforçados

Este desafio reforça fundamentos importantes de SQL:

* Uso da cláusula **WHERE**
* Funções de string como **LENGTH()**
* Filtro baseado em valores calculados
* Validação de dados textuais

---

## Conclusão

Apesar de simples, este exercício demonstra como utilizar funções nativas do SQL para filtrar dados.

Saber trabalhar com funções de string é essencial em cenários reais de processamento de texto, validação de dados e controle de qualidade de informações.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***