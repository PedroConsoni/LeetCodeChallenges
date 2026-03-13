# LeetCode SQL – 1633. Percentage of Users Attended a Contest

## Descrição do Desafio

O problema **"Percentage of Users Attended a Contest"** do LeetCode trabalha os seguintes conceitos:

- Funções de agregação (`COUNT`)
- Subqueries
- Cálculos aritméticos
- Arredondamento com `ROUND`
- Ordenação com múltiplos critérios

O exercício fornece duas tabelas:

---

### Tabela `Users`

| Coluna    | Tipo |
|-----------|------|
| user_id   | int  |
| user_name | varchar |

Cada linha representa um usuário do sistema.

---

### Tabela `Register`

| Coluna     | Tipo |
|------------|------|
| contest_id | int  |
| user_id    | int  |

Cada linha indica que um usuário se registrou em um concurso.

---

## Objetivo

Para cada `contest_id`, devemos retornar:

- A porcentagem de usuários que participaram do concurso
- O valor deve estar arredondado para **2 casas decimais**

O resultado deve ser:

- Ordenado pela `percentage` em **ordem decrescente**
- Em caso de empate, ordenar pelo `contest_id` em **ordem crescente**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT
    contest_id,
    ROUND(
        COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users),
        2
    ) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
```

---

## Explicação da Query

### Passo 1 – Contando Usuários por Concurso

```sql
COUNT(user_id)
```

Conta quantos usuários se registraram em cada concurso.

Isso funciona corretamente porque usamos:

```sql
GROUP BY contest_id
```

Assim, a contagem é feita separadamente para cada concurso.

---

### Passo 2 – Obtendo o Total de Usuários

```sql
(SELECT COUNT(*) FROM Users)
```

Essa subquery retorna o número total de usuários cadastrados no sistema.

Ela é necessária porque a fórmula da porcentagem é:

```
(usuários do concurso / total de usuários) × 100
```

---

### Passo 3 – Calculando a Porcentagem

```sql
COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users)
```

Detalhe importante:

- Utilizamos `100.0` em vez de `100` para forçar divisão decimal.
- Isso evita divisão inteira e garante precisão no cálculo.

---

### Passo 4 – Arredondando o Resultado

```sql
ROUND(..., 2)
```

Garante que:

- O resultado tenha exatamente **2 casas decimais**
- O formato esteja de acordo com o enunciado

Exemplos:

- 33.333333 → 33.33  
- 50 → 50.00  

---

### Passo 5 – Ordenando o Resultado

```sql
ORDER BY percentage DESC, contest_id ASC
```

Isso significa:

1. Maior porcentagem primeiro  
2. Em caso de empate, menor `contest_id` primeiro  

---

## Por Que Essa Solução Funciona?

- O `GROUP BY` separa os cálculos por concurso
- O `COUNT` calcula o número de participantes
- A subquery retorna o total de usuários
- O `100.0` garante cálculo decimal correto
- O `ROUND` formata o resultado
- O `ORDER BY` aplica as regras de ordenação exigidas

Cada parte da query atende diretamente a um requisito do problema.

---

## Exemplo

### Tabela Users

| user_id | user_name |
|---------|-----------|
| 1       | Alice     |
| 2       | Bob       |
| 3       | Carol     |
| 4       | David     |

### Tabela Register

| contest_id | user_id |
|------------|---------|
| 10         | 1       |
| 10         | 2       |
| 20         | 2       |
| 20         | 3       |

---

### Cálculo

Total de usuários = 4

- Concurso 10 → 2 usuários → (2 / 4) × 100 = 50.00  
- Concurso 20 → 2 usuários → (2 / 4) × 100 = 50.00  

---

### Resultado Final

| contest_id | percentage |
|------------|------------|
| 10         | 50.00      |
| 20         | 50.00      |

Ordenado por porcentagem decrescente e `contest_id` crescente.

---

## Conclusão

Esse desafio reforça:

- Uso de `COUNT` com `GROUP BY`
- Aplicação de subqueries
- Cálculo de porcentagens
- Prevenção de erros de divisão inteira
- Ordenação com múltiplos critérios

É um excelente exercício para dominar lógica de relatórios e métricas em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***