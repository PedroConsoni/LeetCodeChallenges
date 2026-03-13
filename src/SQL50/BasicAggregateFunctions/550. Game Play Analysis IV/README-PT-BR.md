# LeetCode SQL – 550. Game Play Analysis IV

## Descrição do Desafio

O problema **"Game Play Analysis IV"** do LeetCode trabalha os seguintes conceitos:

- CTE (Common Table Expression)
- Funções de agregação (`MIN`, `COUNT`)
- Manipulação de datas
- `LEFT JOIN`
- Contagem distinta
- Conversão e formatação decimal

O exercício fornece uma única tabela:

---

### Tabela `Activity`

| Coluna       | Tipo |
|--------------|------|
| player_id    | int  |
| device_id    | int  |
| event_date   | date |
| games_played | int  |

Cada linha representa um login de um jogador em uma determinada data.

---

## Objetivo

Retornar a fração de jogadores que:

- Fizeram login no dia **imediatamente após** seu primeiro login.

O resultado deve:

- Ser retornado como `fraction`
- Estar formatado com **2 casas decimais**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH FirstLogins AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login
    FROM 
        Activity
    GROUP BY 
        player_id
)
SELECT 
    CAST(
        COUNT(a.player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity) 
        AS DECIMAL(5,2)
    ) AS fraction
FROM 
    FirstLogins fl
LEFT JOIN 
    Activity a 
    ON fl.player_id = a.player_id 
    AND a.event_date = DATEADD(day, 1, fl.first_login);
```

---

## Explicação da Query

### Passo 1 – Identificando o Primeiro Login de Cada Jogador (CTE)

```sql
WITH FirstLogins AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login
    FROM 
        Activity
    GROUP BY 
        player_id
)
```

Essa CTE:

- Agrupa os registros por `player_id`
- Usa `MIN(event_date)` para encontrar a primeira data de login

Resultado:

- Uma linha por jogador
- Contendo sua primeira data de login

---

### Passo 2 – Verificando Login no Dia Seguinte

```sql
LEFT JOIN Activity a 
ON fl.player_id = a.player_id 
AND a.event_date = DATEADD(day, 1, fl.first_login)
```

Explicação:

- `DATEADD(day, 1, fl.first_login)` calcula o dia seguinte ao primeiro login
- O `JOIN` verifica se existe um login exatamente nessa data

Se existir correspondência:

- O jogador retornou no dia seguinte

Se não existir:

- O jogador não retornou

---

### Passo 3 – Contando Jogadores que Retornaram

```sql
COUNT(a.player_id)
```

Conta apenas os jogadores que tiveram correspondência no `JOIN`, ou seja:

- Jogadores que retornaram no dia seguinte

---

### Passo 4 – Contando o Total de Jogadores

```sql
(SELECT COUNT(DISTINCT player_id) FROM Activity)
```

Retorna:

- O número total de jogadores únicos

Necessário para calcular a fração:

```
(jogadores que retornaram) / (total de jogadores)
```

---

### Passo 5 – Garantindo Divisão Decimal

```sql
COUNT(a.player_id) * 1.0
```

Multiplicar por `1.0` força divisão decimal e evita divisão inteira.

---

### Passo 6 – Formatando o Resultado

```sql
CAST(... AS DECIMAL(5,2))
```

Garante:

- Resultado com exatamente **2 casas decimais**
- Formatação conforme exigido

---

## Por Que Essa Solução Funciona?

- A CTE isola o primeiro login
- O `LEFT JOIN` verifica retorno no dia seguinte
- `COUNT` mede quem retornou
- `COUNT(DISTINCT)` mede o total
- `1.0` evita erro de divisão inteira
- `CAST` formata corretamente o número

Cada parte da query atende diretamente aos requisitos do problema.

---

## Exemplo

### Tabela Activity

| player_id | event_date |
|------------|------------|
| 1          | 2023-01-01 |
| 1          | 2023-01-02 |
| 2          | 2023-01-05 |
| 3          | 2023-01-07 |
| 3          | 2023-01-08 |

---

### Primeiros Logins

- Jogador 1 → 2023-01-01  
- Jogador 2 → 2023-01-05  
- Jogador 3 → 2023-01-07  

---

### Retorno no Dia Seguinte

- Jogador 1 → Retornou em 2023-01-02 ✅  
- Jogador 2 → Não retornou ❌  
- Jogador 3 → Retornou em 2023-01-08 ✅  

Jogadores que retornaram = 2  
Total de jogadores = 3  

Fração:

```
2 / 3 = 0.67
```

---

## Conclusão

Esse desafio reforça:

- Análise de primeiro evento com `MIN`
- Manipulação de datas com `DATEADD`
- Uso de `LEFT JOIN` para verificação condicional
- Cálculo correto de frações
- Prevenção de divisão inteira
- Formatação numérica em SQL

É um excelente exercício para dominar análise de retenção de usuários (retention analysis) em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***