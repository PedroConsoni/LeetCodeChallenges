# LeetCode SQL – 185. Department Top Three Salaries

## Descrição do Desafio

O problema **"Department Top Three Salaries"** do LeetCode trabalha diversos conceitos importantes de SQL, incluindo:

- Uso de **window functions**
- Ranqueamento com **DENSE_RANK**
- Particionamento de dados com **PARTITION BY**
- Junção de tabelas com **JOIN**
- Filtragem de resultados ranqueados

O problema fornece duas tabelas.

---

### `Employee` Table

| Column       | Type |
|--------------|------|
| Id           | int  |
| Name         | varchar |
| Salary       | int  |
| DepartmentId | int  |

Cada linha representa **um funcionário**, contendo seu salário e o departamento ao qual pertence.

---

### `Department` Table

| Column | Type |
|------|------|
| Id   | int  |
| Name | varchar |

Cada linha representa **um departamento da empresa**.

---

## Objetivo

Retornar **os três maiores salários de cada departamento**.

O resultado deve incluir:

- `Department` → Nome do departamento
- `Employee` → Nome do funcionário
- `Salary` → Salário do funcionário

Caso existam funcionários com **o mesmo salário**, eles devem **compartilhar o mesmo ranking**.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH SalariosRankeados AS (
    SELECT 
        d.Name AS Department,
        e.Name AS Employee,
        e.Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.DepartmentId 
            ORDER BY e.Salary DESC
        ) AS rnk
    FROM Employee e
    JOIN Department d ON e.DepartmentId = d.Id
)
SELECT 
    Department, 
    Employee, 
    Salary
FROM SalariosRankeados
WHERE rnk <= 3;
```

---

## Explicação da Query

### Passo 1 – Realizando o JOIN entre as Tabelas

```sql
JOIN Department d ON e.DepartmentId = d.Id
```

A tabela `Employee` possui apenas o **ID do departamento**, mas não o nome.

Por isso realizamos um **JOIN** com a tabela `Department` para obter o nome do departamento.

Assim conseguimos retornar:

- Nome do funcionário
- Salário
- Nome do departamento

---

### Passo 2 – Utilizando Window Function para Ranqueamento

```sql
DENSE_RANK() OVER (
    PARTITION BY e.DepartmentId 
    ORDER BY e.Salary DESC
)
```

A função `DENSE_RANK()` atribui uma **posição no ranking baseada no salário**.

Detalhes importantes:

- `PARTITION BY e.DepartmentId` reinicia o ranking **para cada departamento**
- `ORDER BY e.Salary DESC` garante que **os maiores salários venham primeiro**

Exemplo de ranking:

| Employee | Salary | Rank |
|--------|--------|------|
| A | 90000 | 1 |
| B | 85000 | 2 |
| C | 85000 | 2 |
| D | 80000 | 3 |

Observe que funcionários com o mesmo salário **compartilham o mesmo ranking**.

---

### Passo 3 – Armazenando os Resultados em uma CTE

```sql
WITH SalariosRankeados AS (...)
```

Uma **CTE (Common Table Expression)** é usada para armazenar os resultados intermediários.

A CTE contém:

- Departamento
- Funcionário
- Salário
- Ranking (`rnk`)

Isso facilita muito o passo final da query.

---

### Passo 4 – Filtrando os Três Maiores Salários

```sql
WHERE rnk <= 3
```

Essa condição garante que retornaremos apenas funcionários cujo ranking seja:

- 1
- 2
- 3

Como utilizamos `DENSE_RANK`, empates de salário **não pulam posições no ranking**.

Assim, podem aparecer mais de três funcionários se houver salários empatados.

---

## Por Que Isso Funciona

Essa solução funciona bem porque:

- `DENSE_RANK` trata corretamente **empates de salário**
- `PARTITION BY` garante que o ranking seja calculado **dentro de cada departamento**
- A **CTE melhora a legibilidade da query**
- O filtro final fica **simples e claro**

Esse é o padrão mais comum para resolver problemas de **Top N por grupo em SQL**.

---

## Conclusão

Esse desafio reforça conceitos importantes de SQL, como:

- **Window functions**
- **DENSE_RANK**
- **PARTITION BY**
- **JOIN entre tabelas**
- **Consultas Top-N por grupo**

É um problema clássico utilizado para praticar **consultas analíticas e ranqueamento em SQL**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***