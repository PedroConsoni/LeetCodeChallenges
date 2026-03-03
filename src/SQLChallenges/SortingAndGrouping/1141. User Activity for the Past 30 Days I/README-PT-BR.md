# LeetCode SQL – 1141. User Activity for the Past 30 Days I

## Descrição do Desafio

O problema **"User Activity for the Past 30 Days I"** do LeetCode trabalha os seguintes conceitos:

- Filtragem com `WHERE`
- Filtro por intervalo de datas com `BETWEEN`
- Agregação com `COUNT`
- Remoção de duplicatas com `DISTINCT`
- Agrupamento com `GROUP BY`

O desafio fornece uma única tabela:

### Tabela `Activity`

| Coluna        | Tipo |
|--------------|------|
| user_id      | int  |
| session_id   | int  |
| activity_date| date |
| activity_type| enum |

Cada linha representa uma atividade realizada por um usuário em uma data específica.

Um usuário pode aparecer várias vezes no mesmo dia porque:
- Pode ter múltiplas sessões
- Pode realizar várias atividades

---

## Objetivo

Retornar o número de **usuários ativos por dia** durante o período de 30 dias que termina em **2019-07-27**.

Formato esperado:

| day | active_users |
|-----|--------------|

Onde:

- `day` = Data da atividade  
- `active_users` = Quantidade de usuários distintos ativos naquele dia  

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;
```

---

## Explicação da Query

### Passo 1 – Filtrando o Período de 30 Dias

```sql
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
```

O operador `BETWEEN` filtra registros dentro de um intervalo de datas.

Importante:

- `BETWEEN` é inclusivo
- Inclui tanto a data inicial quanto a final

Isso garante que apenas as atividades dentro do período solicitado sejam analisadas.

---

### Passo 2 – Agrupando por Data

```sql
GROUP BY activity_date
```

O `GROUP BY` agrupa todas as linhas que possuem a mesma `activity_date`.

Isso permite calcular o número de usuários ativos **por dia**, em vez de um total geral do período.

---

### Passo 3 – Contando Usuários Distintos

```sql
COUNT(DISTINCT user_id)
```

- `COUNT()` conta registros
- `DISTINCT` remove duplicatas antes da contagem

Isso garante que:

- Se um usuário tiver várias sessões no mesmo dia, ele será contado apenas uma vez
- O número de usuários ativos diários seja calculado corretamente

---

### Passo 4 – Renomeando Colunas

```sql
activity_date AS day
COUNT(DISTINCT user_id) AS active_users
```

Os aliases tornam o resultado mais legível e seguem o formato exigido:

- `activity_date` → `day`
- Contagem agregada → `active_users`

---

## Por Que Essa Solução Funciona?

- `BETWEEN` filtra corretamente o intervalo de datas
- `GROUP BY` separa os dados por dia
- `COUNT(DISTINCT ...)` garante a contagem correta de usuários únicos
- A query realiza filtragem e agregação de forma eficiente

Essa é a forma mais clara e otimizada de resolver o problema.

---

## Exemplo

Se a tabela contiver:

| user_id | session_id | activity_date | activity_type |
|----------|------------|--------------|--------------|
| 1        | 1          | 2019-07-20   | open_session |
| 1        | 2          | 2019-07-20   | scroll_down  |
| 2        | 1          | 2019-07-20   | open_session |
| 1        | 3          | 2019-07-21   | send_message |

### Raciocínio passo a passo

### 2019-07-20:
Usuários: 1, 1, 2  
Usuários distintos: 1, 2  
Total de usuários ativos = 2  

### 2019-07-21:
Usuários: 1  
Total de usuários ativos = 1  

---

## Resultado Final

| day        | active_users |
|------------|--------------|
| 2019-07-20 | 2            |
| 2019-07-21 | 1            |

---

## Conclusão

Este desafio reforça conceitos essenciais de SQL:

- Filtragem por datas
- Agregação
- Remoção de duplicatas com `DISTINCT`
- Agrupamento por tempo
- Uso de alias para melhor legibilidade

É um exercício fundamental para entender como calcular usuários ativos diários (DAU) em cenários reais de análise de dados.