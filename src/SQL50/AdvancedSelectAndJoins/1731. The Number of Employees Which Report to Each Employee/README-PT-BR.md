# LeetCode SQL – 1731. The Number of Employees Which Report to Each Employee

## Descrição do Desafio

O problema **"The Number of Employees Which Report to Each Employee"** do LeetCode trabalha os seguintes conceitos:

- Self join (auto junção)
- Agregação com `COUNT` e `AVG`
- Agrupamento com `GROUP BY`
- Conversão de tipos (`CAST`)
- Ordenação de resultados

O desafio fornece uma única tabela:

### Tabela `Employees`

| Coluna       | Tipo |
|-------------|------|
| employee_id | int  |
| name        | varchar |
| age         | int  |
| reports_to  | int  |

Cada linha representa um funcionário.

- `reports_to` referencia o `employee_id` de outro funcionário
- Se `reports_to` for `NULL`, o funcionário não se reporta a ninguém

Isso cria uma estrutura hierárquica dentro da própria tabela.

---

## Objetivo

Para cada gerente (funcionário que possui pelo menos um subordinado direto), retornar:

- `employee_id`
- `name`
- Quantidade de subordinados diretos (`reports_count`)
- Idade média dos subordinados (`average_age`, arredondada para o inteiro mais próximo)

O resultado deve ser ordenado por `employee_id`.

Formato esperado:

| employee_id | name | reports_count | average_age |
|-------------|------|---------------|-------------|

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    m.employee_id, 
    m.name, 
    COUNT(e.employee_id) AS reports_count, 
    CAST(ROUND(AVG(CAST(e.age AS FLOAT)), 0) AS INT) AS average_age
FROM Employees e
INNER JOIN Employees m ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;
```

---

## Explicação da Query

### Passo 1 – Self Join

```sql
FROM Employees e
INNER JOIN Employees m ON e.reports_to = m.employee_id
```

É uma auto junção porque estamos conectando a tabela `Employees` com ela mesma.

- `e` representa os subordinados
- `m` representa os gerentes

A condição:

```sql
e.reports_to = m.employee_id
```

Relaciona cada funcionário ao seu gerente.

O `INNER JOIN` garante que apenas gerentes com subordinados apareçam no resultado.

---

### Passo 2 – Contando Subordinados

```sql
COUNT(e.employee_id) AS reports_count
```

Cada linha do join representa um subordinado.

Ao contar `e.employee_id`, obtemos o número de subordinados diretos de cada gerente.

---

### Passo 3 – Calculando a Idade Média

```sql
CAST(ROUND(AVG(CAST(e.age AS FLOAT)), 0) AS INT) AS average_age
```

Detalhamento:

1. `CAST(e.age AS FLOAT)` permite cálculo decimal
2. `AVG(...)` calcula a média das idades
3. `ROUND(..., 0)` arredonda para o inteiro mais próximo
4. `CAST(... AS INT)` converte o resultado final para inteiro

Isso garante que o formato final esteja correto.

---

### Passo 4 – Agrupando por Gerente

```sql
GROUP BY m.employee_id, m.name
```

Agrupa todos os subordinados sob cada gerente.

Sem o `GROUP BY`, as funções de agregação não funcionariam corretamente.

---

### Passo 5 – Ordenando o Resultado

```sql
ORDER BY m.employee_id
```

Ordena o resultado final pelo ID do gerente em ordem crescente.

---

## Por Que Essa Solução Funciona?

- O self join conecta subordinados aos gerentes
- `COUNT()` calcula o número de subordinados
- `AVG()` calcula a idade média
- `ROUND()` garante o formato correto
- `GROUP BY` organiza a agregação por gerente

É uma solução clara, eficiente e adequada para dados hierárquicos.

---

## Exemplo

Se a tabela contiver:

| employee_id | name   | age | reports_to |
|-------------|--------|-----|------------|
| 1           | Alice  | 45  | NULL       |
| 2           | Bob    | 30  | 1          |
| 3           | Carol  | 25  | 1          |
| 4           | David  | 40  | NULL       |

### Raciocínio passo a passo

Gerente 1 (Alice):

Subordinados:
- Bob (30)
- Carol (25)

Quantidade = 2  
Média = (30 + 25) / 2 = 27,5 → Arredondado = 28  

Funcionário 4 não possui subordinados → Não aparece no resultado.

---

## Resultado Final

| employee_id | name  | reports_count | average_age |
|-------------|-------|---------------|-------------|
| 1           | Alice | 2             | 28          |

---

## Conclusão

Este desafio reforça conceitos avançados de SQL:

- Self join
- Estruturas hierárquicas
- Múltiplas funções de agregação
- Conversão e arredondamento de tipos
- Relatórios agrupados

É um exercício essencial para trabalhar com estruturas organizacionais e análises hierárquicas em bancos de dados.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***