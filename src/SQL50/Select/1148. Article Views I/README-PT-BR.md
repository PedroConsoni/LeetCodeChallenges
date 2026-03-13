# LeetCode SQL – 1148. Article Views I

## Descrição do Desafio

O problema **"Article Views I"** no LeetCode foca nos seguintes conceitos de SQL:

- Filtragem de linhas utilizando `WHERE`
- Comparação de valores dentro da mesma linha
- Remoção de duplicatas utilizando `DISTINCT`
- Ordenação de resultados com `ORDER BY`

O problema fornece uma única tabela.

### Tabela `Views`

| Coluna     | Tipo |
|------------|------|
| article_id | int  |
| author_id  | int  |
| viewer_id  | int  |
| view_date  | date |

Cada linha representa uma **visualização de um artigo**.

- `author_id` representa o **autor do artigo**
- `viewer_id` representa o **usuário que visualizou o artigo**

---

## Objetivo

Retornar os **IDs dos autores que visualizaram seus próprios artigos**.

O resultado deve:

- Mostrar a coluna com o nome **`id`**
- Conter **apenas valores únicos**
- Estar **ordenado em ordem crescente**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT DISTINCT author_id as id
FROM views
WHERE author_id = viewer_id
ORDER BY author_id ASC;
```

---

## Explicação da Query

### Passo 1 – Comparando Autor e Visualizador

```sql
WHERE author_id = viewer_id
```

Essa condição verifica se **o autor do artigo é a mesma pessoa que o visualizou**.

Se:

- `author_id = viewer_id` → o autor visualizou o próprio artigo
- `author_id ≠ viewer_id` → o visualizador é outra pessoa

Esse filtro mantém apenas as linhas onde **o autor acessou o próprio artigo**.

---

### Passo 2 – Selecionando o ID do Autor

```sql
SELECT author_id AS id
```

O problema exige que a coluna de saída se chame **`id`**.

Como o nome da coluna original é `author_id`, nós a renomeamos utilizando:

```sql
AS id
```

Isso cria o formato de saída esperado pelo LeetCode.

---

### Passo 3 – Removendo Autores Duplicados

```sql
DISTINCT
```

Um autor pode visualizar seu próprio artigo **várias vezes**.

Por exemplo:

| author_id | viewer_id |
|-----------|-----------|
| 7         | 7         |
| 7         | 7         |
| 7         | 7         |

Sem o `DISTINCT`, o resultado teria linhas repetidas.

O `DISTINCT` garante que **cada autor apareça apenas uma vez no resultado**.

---

### Passo 4 – Ordenando os Resultados

```sql
ORDER BY author_id ASC
```

Isso ordena o resultado final pelo **ID do autor em ordem crescente**.

Exemplo de ordenação:

```
1
3
7
9
```

Isso atende ao requisito do problema de que os resultados devem estar **do menor para o maior ID**.

---

## Por Que Essa Solução Funciona

Essa query funciona de forma eficiente porque:

- `WHERE author_id = viewer_id` identifica quando autores visualizam seus próprios artigos
- `DISTINCT` remove IDs de autores duplicados
- `AS id` garante que o nome da coluna de saída esteja correto
- `ORDER BY` organiza o resultado corretamente

Juntas, essas cláusulas SQL produzem exatamente o resultado esperado pelo problema.

---

## Exemplo

Se a tabela contiver os seguintes dados:

| article_id | author_id | viewer_id | view_date |
|------------|-----------|-----------|-----------|
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 3         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |

### Passo 1 – Filtrar linhas onde o autor visualizou o próprio artigo

| article_id | author_id | viewer_id | view_date |
|------------|-----------|-----------|-----------|
| 1          | 3         | 3         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |

### Passo 2 – Selecionar `author_id` como `id`

| id |
|----|
| 3  |
| 7  |

### Passo 3 – Aplicar `DISTINCT`

Não existem duplicatas, então a tabela permanece igual.

### Passo 4 – Ordenar em ordem crescente

Resultado final:

| id |
|----|
| 3  |
| 7  |

---

## Conclusão

Este desafio reforça vários conceitos fundamentais de SQL:

- Filtragem de linhas com `WHERE`
- Comparação de valores na mesma linha
- Remoção de duplicatas usando `DISTINCT`
- Renomeação de colunas com `AS`
- Ordenação de resultados com `ORDER BY`

Embora seja um exercício simples, ele é excelente para praticar **lógica de filtragem em SQL e formatação de resultados**, habilidades essenciais ao trabalhar com bancos de dados relacionais.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***