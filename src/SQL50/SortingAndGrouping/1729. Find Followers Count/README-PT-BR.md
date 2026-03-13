# LeetCode SQL – 1729. Find Followers Count

## Descrição do Desafio

O problema **"Find Followers Count"** do LeetCode trabalha os seguintes conceitos:

- Agregação com `COUNT`
- Agrupamento com `GROUP BY`
- Entendimento de relacionamentos um-para-muitos

O desafio fornece uma única tabela:

### Tabela `Followers`

| Coluna      | Tipo |
|-------------|------|
| user_id     | int  |
| follower_id | int  |

Cada linha representa uma relação onde:

- `follower_id` segue `user_id`

Um usuário pode aparecer várias vezes porque:
- Pode ter vários seguidores

---

## Objetivo

Para cada `user_id`, retornar:

- O total de seguidores que ele possui

Formato esperado:

| user_id | followers_count |
|---------|------------------|

Onde:

- `user_id` = Usuário que está sendo seguido  
- `followers_count` = Quantidade de seguidores desse usuário  

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT user_id, COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id;
```

---

## Explicação da Query

### Passo 1 – Agrupando por Usuário

```sql
GROUP BY user_id
```

A cláusula `GROUP BY` agrupa todas as linhas que possuem o mesmo `user_id`.

Isso significa que:

- Todas as relações de seguidores de um mesmo usuário são tratadas como um único grupo
- As funções de agregação operam dentro de cada grupo

Sem o `GROUP BY`, teríamos apenas um total geral da tabela.

---

### Passo 2 – Contando os Seguidores

```sql
COUNT(follower_id)
```

`COUNT()` conta a quantidade de valores não nulos na coluna especificada.

Como cada linha representa um seguidor:

- Cada `follower_id` corresponde a um seguidor
- A contagem retorna o total de seguidores por usuário

---

### Passo 3 – Renomeando a Coluna

```sql
AS followers_count
```

O `AS` cria um alias (apelido) para a coluna agregada.

Em vez de retornar:

```
COUNT(follower_id)
```

Renomeamos para:

```
followers_count
```

Isso melhora a legibilidade e segue o formato esperado pelo problema.

---

## Por Que Essa Solução Funciona?

- Cada linha representa uma relação de seguidor
- `GROUP BY user_id` separa os dados por usuário
- `COUNT(follower_id)` contabiliza corretamente os seguidores
- A query realiza a agregação de forma simples e eficiente

É a forma mais direta e otimizada de resolver o problema.

---

## Exemplo

Se a tabela contiver:

| user_id | follower_id |
|---------|-------------|
| 1       | 2           |
| 1       | 3           |
| 1       | 4           |
| 2       | 1           |
| 2       | 3           |

### Raciocínio passo a passo

### Usuário 1:
Seguidores: 2, 3, 4  
Total de seguidores = 3  

### Usuário 2:
Seguidores: 1, 3  
Total de seguidores = 2  

---

## Resultado Final

| user_id | followers_count |
|---------|------------------|
| 1       | 3                |
| 2       | 2                |

---

## Conclusão

Este desafio reforça conceitos fundamentais de SQL:

- Agregação de dados
- Agrupamento de registros
- Contagem em relacionamentos um-para-muitos
- Uso de alias para melhor organização

Apesar de simples, é um exercício essencial para entender modelagem relacional e consultas agregadas.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***