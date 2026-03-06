# LeetCode SQL – 196. Delete Duplicate Emails

## Descrição do Desafio

O problema **"Delete Duplicate Emails"** do LeetCode trabalha conceitos importantes de SQL, como:

- Identificação de **registros duplicados**
- Uso de **window functions**
- Utilização de **ROW_NUMBER**
- Particionamento de dados com **PARTITION BY**
- Remoção de registros com **DELETE**

O problema fornece uma única tabela:

### `Person` Table

| Column | Type |
|------|------|
| Id   | int  |
| Email | varchar |

Cada linha representa **uma pessoa e seu endereço de email**.

No entanto, a tabela pode conter **emails duplicados**, ou seja, múltiplas linhas podem possuir o mesmo valor na coluna `Email`.

---

## Objetivo

Remover todos os emails duplicados mantendo **apenas a linha com o menor `Id`** para cada email.

Ou seja:

- Se várias linhas possuem o mesmo email
- Devemos manter apenas a que possui **o menor Id**
- As demais devem ser removidas

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY Id ASC
           ) AS NumeroLinha
    FROM Person
)
DELETE FROM CTE 
WHERE NumeroLinha > 1;
```

---

## Explicação da Query

### Passo 1 – Criando um Número de Linha para Cada Email

```sql
ROW_NUMBER() OVER (
    PARTITION BY Email 
    ORDER BY Id ASC
)
```

A função `ROW_NUMBER()` gera um **número sequencial para cada linha**.

Pontos importantes:

- `PARTITION BY Email` agrupa as linhas pelo email
- `ORDER BY Id ASC` garante que o **menor Id venha primeiro**

Exemplo:

| Id | Email | NumeroLinha |
|----|------|-------------|
| 1 | a@b.com | 1 |
| 2 | a@b.com | 2 |
| 3 | c@d.com | 1 |

Isso significa que:

- A primeira ocorrência do email recebe `NumeroLinha = 1`
- As duplicatas recebem números maiores

---

### Passo 2 – Armazenando o Resultado em uma CTE

```sql
WITH CTE AS (...)
```

Uma **CTE (Common Table Expression)** é utilizada para armazenar o resultado intermediário.

Essa CTE contém:

- Todas as colunas originais
- O número de linha gerado (`NumeroLinha`)

Isso facilita a identificação das duplicatas.

---

### Passo 3 – Removendo as Linhas Duplicadas

```sql
DELETE FROM CTE 
WHERE NumeroLinha > 1;
```

Essa instrução remove todas as linhas onde:

```
NumeroLinha > 1
```

Ou seja:

- Mantemos as linhas com `NumeroLinha = 1`
- Removemos todas as outras linhas que possuem o mesmo email

---

## Por Que Isso Funciona

Essa solução funciona bem porque:

- `ROW_NUMBER()` identifica de forma única as duplicatas
- `PARTITION BY` agrupa as linhas por email
- `ORDER BY Id ASC` garante que o **menor Id seja preservado**
- A CTE permite realizar o **DELETE diretamente no resultado ranqueado**

Esse é um método muito comum para **remoção de duplicatas em tabelas SQL**.

---

## Exemplo

Se a tabela contiver:

| Id | Email |
|----|------|
| 1 | john@example.com |
| 2 | bob@example.com |
| 3 | john@example.com |

Após aplicar `ROW_NUMBER()`:

| Id | Email | NumeroLinha |
|----|------|-------------|
| 1 | john@example.com | 1 |
| 3 | john@example.com | 2 |
| 2 | bob@example.com | 1 |

Após executar o `DELETE`:

| Id | Email |
|----|------|
| 1 | john@example.com |
| 2 | bob@example.com |

A linha duplicada foi removida com sucesso.

---

## Conclusão

Esse desafio reforça vários conceitos importantes de SQL, como:

- **Window functions**
- **ROW_NUMBER**
- **Particionamento de dados**
- **Identificação de duplicatas**
- **Remoção de registros com DELETE**

Esse tipo de operação é muito comum em **processos de limpeza de dados e manutenção de bancos de dados**.