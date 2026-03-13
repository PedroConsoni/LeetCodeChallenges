# LeetCode SQL – 1789. Departamento Primário de Cada Funcionário

## Descrição do Desafio

O problema **"Primary Department for Each Employee"** do LeetCode foca nos seguintes conceitos de SQL:

- Filtragem com `WHERE`
- Agregação utilizando `GROUP BY`
- Uso de `HAVING` com funções de agregação
- Combinação de resultados com `UNION`
- Compreensão de lógica condicional em SQL

O problema fornece uma única tabela:

### Tabela `Employee`

| Coluna | Tipo |
|------|------|
| employee_id | int |
| department_id | int |
| primary_flag | varchar |

Cada linha representa um funcionário associado a um departamento.

- `employee_id` identifica o funcionário
- `department_id` identifica o departamento
- `primary_flag` indica se aquele departamento é o **departamento primário** do funcionário

Valores possíveis para `primary_flag`:

- `'Y'` → Departamento primário  
- `'N'` → Não é o departamento primário

Um funcionário pode pertencer a **múltiplos departamentos**, mas apenas um deles pode ser o **departamento primário**.

---

# Objetivo

Retornar o **departamento primário de cada funcionário**.

Regras:

1. Se um funcionário pertence a **apenas um departamento**, então esse departamento é automaticamente o seu departamento primário.
2. Se um funcionário pertence a **múltiplos departamentos**, deve ser retornada a linha onde `primary_flag = 'Y'`.

O resultado final deve conter:

- `employee_id`
- `department_id`

---

# Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    employee_id, 
    department_id
FROM 
    Employee
WHERE 
    employee_id IN (
        SELECT employee_id 
        FROM Employee 
        GROUP BY employee_id 
        HAVING COUNT(*) = 1
    )

UNION

SELECT 
    employee_id, 
    department_id
FROM 
    Employee
WHERE 
    primary_flag = 'Y';
```

---

# Explicação da Query

## Passo 1 – Encontrar Funcionários com Apenas Um Departamento

```sql
SELECT employee_id 
FROM Employee 
GROUP BY employee_id 
HAVING COUNT(*) = 1
```

Essa subconsulta agrupa a tabela pelo `employee_id`.

```sql
GROUP BY employee_id
```

Isso significa que todas as linhas pertencentes ao mesmo funcionário são agrupadas.

Depois contamos quantos registros de departamentos cada funcionário possui:

```sql
COUNT(*)
```

A condição:

```sql
HAVING COUNT(*) = 1
```

Filtra apenas os funcionários que pertencem a **exatamente um departamento**.

Se um funcionário aparece apenas uma vez na tabela, então esse departamento necessariamente é o seu **departamento primário**.

---

## Passo 2 – Retornar Esses Funcionários

```sql
WHERE employee_id IN (...)
```

Essa condição filtra a tabela `Employee` e retorna as linhas dos funcionários que aparecem no resultado da subconsulta.

Esses funcionários possuem **apenas um departamento**, então esse departamento é retornado.

---

## Passo 3 – Selecionar Funcionários com Departamento Primário Definido

```sql
WHERE primary_flag = 'Y'
```

Para funcionários que pertencem a **múltiplos departamentos**, a tabela possui uma coluna que indica qual deles é o **departamento primário**.

Essa condição seleciona apenas a linha onde o valor da flag é `'Y'`.

---

## Passo 4 – Combinar os Resultados

```sql
UNION
```

O operador `UNION` combina os resultados das duas consultas.

Ele garante que o resultado final contenha:

1. Funcionários com **apenas um departamento**
2. Funcionários com **múltiplos departamentos**, mas apenas o **departamento primário**

O `UNION` também remove duplicatas automaticamente.

---

# Por Que Isso Funciona

Essa solução trata os dois possíveis cenários existentes no conjunto de dados.

### Caso 1 — Funcionário possui apenas um departamento

- O `GROUP BY` com `HAVING COUNT(*) = 1` identifica esses funcionários.
- Como existe apenas um departamento, ele automaticamente é o departamento primário.

### Caso 2 — Funcionário possui múltiplos departamentos

- A coluna `primary_flag` identifica qual departamento é o principal.
- Filtrando com `primary_flag = 'Y'` retornamos o departamento correto.

Utilizando `UNION`, combinamos os dois cenários e garantimos que **cada funcionário terá exatamente um departamento retornado**.

---

# Exemplo

Se a tabela contiver:

| employee_id | department_id | primary_flag |
|--------------|--------------|--------------|
| 1 | 1 | N |
| 2 | 1 | Y |
| 2 | 2 | N |
| 3 | 3 | N |
| 4 | 2 | N |
| 4 | 3 | Y |

Explicação:

- Funcionário **1** pertence a apenas um departamento → departamento **1**
- Funcionário **2** pertence a múltiplos departamentos → o primário é **1**
- Funcionário **3** pertence a apenas um departamento → departamento **3**
- Funcionário **4** pertence a múltiplos departamentos → o primário é **3**

Resultado:

| employee_id | department_id |
|--------------|--------------|
| 1 | 1 |
| 2 | 1 |
| 3 | 3 |
| 4 | 3 |

---

# Conclusão

Este desafio reforça vários conceitos importantes de SQL:

- Agregação utilizando `GROUP BY`
- Filtragem de resultados agrupados com `HAVING`
- Uso de subconsultas dentro do `WHERE`
- Combinação de conjuntos de dados com `UNION`
- Tratamento de diferentes cenários lógicos dentro do mesmo conjunto de dados

É um excelente exercício para entender como resolver **problemas condicionais de dados utilizando lógica SQL e operações de conjunto**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***