# LeetCode SQL – 1907. Count Salary Categories (Português-BR)

## Descrição do Desafio

O problema **"Count Salary Categories"** do LeetCode foca na prática de:

- Filtragem condicional com `WHERE`
- Agregação utilizando `COUNT`
- Combinação de resultados com `UNION`
- Classificação de valores numéricos em categorias

O problema fornece uma única tabela:

### `Accounts` Table

| Column | Type |
|------|------|
| account_id | int |
| income | int |

Cada linha representa uma conta bancária e a renda associada a essa conta.

---

## Objetivo

Classificar todas as contas em **três categorias de salário** e contar quantas contas pertencem a cada categoria.

As categorias são:

- **Low Salary** → renda **menor que 20000**
- **Average Salary** → renda **entre 20000 e 50000**
- **High Salary** → renda **maior que 50000**

O resultado deve conter duas colunas:

| category | accounts_count |

Cada linha representa uma categoria salarial e a quantidade de contas dentro dessa categoria.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION

SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000

UNION

SELECT 'High Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;
```

---

## Explicação da Query

### Passo 1 – Contando contas com salário baixo

```sql
SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000
```

Essa query realiza três ações:

1. Filtra as linhas onde a renda é **menor que 20000**
2. Utiliza `COUNT(*)` para contar quantas linhas atendem essa condição
3. Define o rótulo `'Low Salary'` para essa categoria usando `AS category`

Exemplo de resultado parcial:

| category | accounts_count |
|--------|---------------|
| Low Salary | 3 |

---

### Passo 2 – Contando contas com salário médio

```sql
SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income >= 20000 AND income <= 50000
```

Essa query seleciona contas onde a renda está **entre 20000 e 50000**, incluindo os dois limites.

A condição:

```sql
income >= 20000 AND income <= 50000
```

Garante que:

- Contas com renda **exatamente 20000** sejam incluídas
- Contas com renda **exatamente 50000** também sejam incluídas

Essas contas são classificadas como **Average Salary**.

---

### Passo 3 – Contando contas com salário alto

```sql
SELECT 'High Salary' AS category, COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000
```

Essa query filtra contas com renda **maior que 50000**.

Todas as contas que atendem essa condição são classificadas como **High Salary**.

---

### Passo 4 – Combinando os resultados com UNION

```sql
UNION
```

O operador `UNION` combina os resultados das três consultas em **um único conjunto de resultados**.

Cada consulta retorna a mesma estrutura:

- Um nome de categoria
- A contagem de contas naquela categoria

Como as colunas são compatíveis, o SQL consegue juntar os resultados em uma única tabela final.

---

## Por que essa solução funciona

Essa solução funciona porque:

- `COUNT(*)` conta eficientemente as linhas que atendem uma condição
- Cada faixa salarial é tratada por uma consulta separada
- `UNION` combina os resultados em uma única tabela
- Os rótulos fixos identificam claramente cada categoria

Isso torna a query **simples, legível e bem organizada logicamente**.

---

## Exemplo

Se a tabela `Accounts` contiver:

| account_id | income |
|------------|--------|
| 1 | 15000 |
| 2 | 22000 |
| 3 | 48000 |
| 4 | 52000 |
| 5 | 80000 |

A classificação será:

- **Low Salary** → 15000
- **Average Salary** → 22000, 48000
- **High Salary** → 52000, 80000

Resultado final:

| category | accounts_count |
|--------|---------------|
| Low Salary | 1 |
| Average Salary | 2 |
| High Salary | 2 |

---

## Conclusão

Esse desafio reforça vários conceitos importantes de SQL:

- Filtragem de intervalos numéricos com `WHERE`
- Contagem de registros utilizando `COUNT`
- Classificação de dados em categorias
- Combinação de múltiplas consultas com `UNION`

Embora seja um problema relativamente simples, ele demonstra como o SQL pode transformar dados numéricos brutos em **resultados agrupados e estruturados**, algo muito comum em análises de dados.