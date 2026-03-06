# LeetCode SQL – 1193. Monthly Transactions I

## Descrição do Desafio

O problema **"Monthly Transactions I"** do LeetCode trabalha os seguintes conceitos:

- Manipulação e formatação de datas
- Funções de agregação (`COUNT`, `SUM`)
- Agregação condicional com `CASE WHEN`
- Agrupamento por múltiplas colunas
- Construção de relatórios mensais

O exercício fornece uma única tabela:

---

### Tabela `Transactions`

| Coluna     | Tipo |
|------------|------|
| id         | int  |
| country    | varchar |
| state      | varchar |
| amount     | int  |
| trans_date | date |

Cada linha representa uma transação financeira contendo:

- País da transação
- Estado da transação (`approved` ou outro)
- Valor da transação
- Data da transação

---

## Objetivo

Para cada **mês e país**, devemos retornar:

- `month` (no formato `YYYY-MM`)
- `country`
- Total de transações (`trans_count`)
- Total de transações aprovadas (`approved_count`)
- Valor total das transações (`trans_total_amount`)
- Valor total das transações aprovadas (`approved_total_amount`)

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    LEFT(CONVERT(VARCHAR, trans_date, 120), 7) AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    LEFT(CONVERT(VARCHAR, trans_date, 120), 7), country;
```

---

## Explicação da Query

### Passo 1 – Extraindo o Mês

```sql
LEFT(CONVERT(VARCHAR, trans_date, 120), 7)
```

Esse trecho faz o seguinte:

1. `CONVERT(VARCHAR, trans_date, 120)`
   - Converte a data para o formato `YYYY-MM-DD`

2. `LEFT(..., 7)`
   - Pega apenas os primeiros 7 caracteres
   - Resultado final: `YYYY-MM`

Isso permite agrupar as transações por mês.

---

### Passo 2 – Contando Todas as Transações

```sql
COUNT(*) AS trans_count
```

Conta todas as transações para cada combinação de:

- Mês
- País

---

### Passo 3 – Contando Transações Aprovadas

```sql
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END)
```

Funciona assim:

- Retorna `1` se a transação estiver aprovada
- Retorna `0` caso contrário
- A soma total indica quantas transações foram aprovadas

---

### Passo 4 – Somando o Valor Total das Transações

```sql
SUM(amount) AS trans_total_amount
```

Soma todos os valores das transações por mês e país.

---

### Passo 5 – Somando o Valor das Transações Aprovadas

```sql
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)
```

Funciona assim:

- Se aprovada → soma o valor
- Caso contrário → soma 0
- Resultado: valor total apenas das transações aprovadas

---

### Passo 6 – Agrupando os Resultados

```sql
GROUP BY LEFT(CONVERT(VARCHAR, trans_date, 120), 7), country
```

Garante:

- Uma linha para cada mês e país
- Cálculos separados corretamente

Sem esse agrupamento, os resultados seriam incorretos.

---

## Por Que Essa Solução Funciona?

- A conversão da data cria a chave mensal
- `COUNT` mede volume
- `SUM` calcula valores monetários
- `CASE WHEN` permite agregação condicional
- `GROUP BY` organiza os dados corretamente

Cada coluna retornada atende diretamente a um requisito do relatório.

---

## Exemplo

### Tabela Transactions

| id | country | state     | amount | trans_date |
|----|---------|----------|--------|------------|
| 1  | US      | approved | 100    | 2023-01-10 |
| 2  | US      | declined | 200    | 2023-01-15 |
| 3  | US      | approved | 150    | 2023-02-05 |
| 4  | BR      | approved | 300    | 2023-01-20 |

---

### Resultado

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|---------|---------|------------|----------------|-------------------|-----------------------|
| 2023-01 | US      | 2          | 1              | 300               | 100                   |
| 2023-02 | US      | 1          | 1              | 150               | 150                   |
| 2023-01 | BR      | 1          | 1              | 300               | 300                   |

---

## Conclusão

Esse desafio reforça:

- Lógica de agregação mensal
- Manipulação de datas
- Contagem condicional
- Cálculo de totais financeiros
- Agrupamento por múltiplas dimensões

É um excelente exercício para desenvolver relatórios analíticos reais em SQL.