# LeetCode SQL – 1934. Confirmation Rate (Português-BR)

## Descrição do Desafio

O problema **"Confirmation Rate"** do LeetCode trabalha conceitos de:

- `LEFT JOIN`
- Agregação condicional com `CASE`
- Uso de `AVG`
- Tratamento de `NULL`
- Arredondamento numérico

O desafio fornece duas tabelas:

---

### `Signups` Table

| Coluna    | Tipo |
|-----------|------|
| user_id   | int  |
| time_stamp| datetime |

Cada linha representa um usuário que se cadastrou.

---

### `Confirmations` Table

| Coluna    | Tipo |
|-----------|------|
| user_id   | int  |
| time_stamp| datetime |
| action    | enum ('confirmed', 'timeout') |

Cada linha representa uma tentativa de confirmação.

---

## Objetivo

Para cada usuário, calcular a **taxa de confirmação**, definida como:

```
quantidade de confirmações / total de tentativas
```

Requisitos:

- Todos os usuários devem aparecer
- Se não houver tentativas, o valor deve ser `0`
- O resultado deve ter **2 casas decimais**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    s.user_id, 
    ROUND(
        ISNULL(
            AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END), 
            0
        ), 2
    ) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c ON s.user_id = c.user_id
GROUP BY 
    s.user_id;
```

---

## Explicação da Query

### Passo 1 – LEFT JOIN

```sql
FROM Signups s
LEFT JOIN Confirmations c 
    ON s.user_id = c.user_id
```

O `LEFT JOIN` garante que:

- Todos os usuários apareçam
- Usuários sem confirmação também apareçam
- Valores ausentes resultem em `NULL`

---

### Passo 2 – Lógica Condicional com CASE

```sql
CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0.0 END
```

Converte:

- `'confirmed'` → `1.0`
- `'timeout'` → `0.0`

Isso permite calcular a taxa usando média.

---

### Passo 3 – Uso do AVG()

```sql
AVG(...)
```

Como transformamos:

- Confirmado → 1
- Não confirmado → 0

A média se torna:

```
soma dos confirmados / total de tentativas
```

---

### Passo 4 – Tratamento de NULL

```sql
ISNULL(AVG(...), 0)
```

Se o usuário não tiver tentativas:

- `AVG` retorna `NULL`
- `ISNULL` converte para `0`

---

### Passo 5 – Arredondamento

```sql
ROUND(..., 2)
```

Arredonda o resultado para **2 casas decimais**.

---

## Conclusão

Esse desafio reforça:

- Uso correto de `LEFT JOIN`
- Agregação condicional
- Transformação de categorias em valores numéricos
- Tratamento adequado de `NULL`
- Cálculo de métricas percentuais

É um exercício essencial para desenvolver lógica analítica em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***