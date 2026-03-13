# LeetCode SQL – 602. Friend Requests II: Who Has the Most Friends

## Descrição do Desafio

O problema **"Friend Requests II: Who Has the Most Friends"** do LeetCode foca nos seguintes conceitos de SQL:

- Uso de **Common Table Expressions (CTE)**
- Combinação de resultados com **UNION ALL**
- Agregação de dados utilizando **COUNT**
- Agrupamento de registros com **GROUP BY**
- Ordenação e limitação de resultados com **ORDER BY** e **TOP**

O problema fornece uma única tabela:

### `RequestAccepted` Table

| Column        | Type |
|---------------|------|
| requester_id  | int  |
| accepter_id   | int  |
| accept_date   | date |

Cada linha representa **um pedido de amizade que foi aceito** entre dois usuários.

Isso significa que:

- `requester_id` enviou o pedido de amizade
- `accepter_id` aceitou o pedido de amizade

Após a aceitação, **ambos se tornam amigos**.

---

## Objetivo

Encontrar **o usuário que possui o maior número de amigos**.

O resultado deve retornar:

- `id` → o ID do usuário
- `num` → a quantidade total de amigos desse usuário

Caso existam vários usuários, devemos retornar **apenas aquele com a maior quantidade de amigos**.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH AllFriends AS (
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
)

SELECT TOP 1 
    id, 
    COUNT(id) AS num
FROM AllFriends
GROUP BY id
ORDER BY num DESC;
```

---

## Explicação da Query

### Passo 1 – Criando uma Lista Unificada de Amigos

```sql
WITH AllFriends AS (
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
)
```

Essa **CTE (Common Table Expression)** cria um conjunto de resultados temporário chamado `AllFriends`.

A ideia é **tratar os dois participantes da amizade de forma igual**.

Na tabela original:

- `requester_id` é um dos amigos
- `accepter_id` é o outro amigo

Utilizando `UNION ALL`, juntamos essas duas colunas em **uma única coluna chamada `id`**.

Exemplo de transformação:

Tabela original:

| requester_id | accepter_id |
|--------------|-------------|
| 1            | 2           |
| 1            | 3           |
| 2            | 3           |

Depois da CTE:

| id |
|----|
| 1  |
| 1  |
| 2  |
| 2  |
| 3  |
| 3  |

Cada ocorrência representa **uma conexão de amizade**.

---

### Passo 2 – Contando Amigos por Usuário

```sql
COUNT(id) AS num
```

Após transformar todas as amizades em uma única coluna, contamos quantas vezes cada usuário aparece.

Cada ocorrência representa **uma relação de amizade**.

Portanto:

- Mais ocorrências → mais amigos.

---

### Passo 3 – Agrupando por Usuário

```sql
GROUP BY id
```

Essa cláusula agrupa todas as linhas pelo ID do usuário para que possamos contar as amizades **de cada usuário individualmente**.

Exemplo de resultado agrupado:

| id | num |
|----|-----|
| 1  | 2   |
| 2  | 2   |
| 3  | 2   |

---

### Passo 4 – Ordenando pela Quantidade de Amigos

```sql
ORDER BY num DESC
```

Isso ordena os usuários pela **maior quantidade de amigos primeiro**.

---

### Passo 5 – Retornando Apenas o Usuário com Mais Amigos

```sql
TOP 1
```

`TOP 1` garante que retornaremos **apenas o usuário com o maior número de amigos**.

Formato final do resultado:

| id | num |
|----|-----|
| 3  | 5   |

---

## Por Que Isso Funciona

Essa abordagem funciona de forma eficiente porque:

- `UNION ALL` combina os dois lados da relação de amizade
- A CTE simplifica o conjunto de dados para uma única coluna
- `COUNT` calcula o total de amizades
- `GROUP BY` agrega os resultados por usuário
- `ORDER BY DESC` identifica quem possui mais amigos
- `TOP 1` retorna apenas o maior resultado

Isso evita joins complexos e mantém a query **simples, clara e escalável**.

---

## Exemplo

Se a tabela contiver:

| requester_id | accepter_id |
|--------------|-------------|
| 1            | 2           |
| 1            | 3           |
| 2            | 3           |
| 3            | 4           |

Após o processamento, as contagens seriam:

| id | num |
|----|-----|
| 1  | 2   |
| 2  | 2   |
| 3  | 3   |
| 4  | 1   |

Resultado final:

| id | num |
|----|-----|
| 3  | 3   |

Porque **o usuário 3 possui o maior número de amigos**.

---

## Conclusão

Esse desafio reforça vários conceitos importantes de SQL:

- Transformação de dados com **CTEs**
- Combinação de resultados usando **UNION ALL**
- Agregação de dados com **COUNT**
- Agrupamento de registros com **GROUP BY**
- Ranqueamento de resultados com **ORDER BY**

É um excelente exercício para entender como **normalizar dados de relacionamento e realizar agregações de forma eficiente**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***