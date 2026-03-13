# LeetCode SQL – 1075. Project Employees I

## Descrição do Desafio

O problema **"Project Employees I"** do LeetCode trabalha os seguintes conceitos:

- `JOIN` entre tabelas
- Funções de agregação (`AVG`)
- Conversão de tipos com `CAST`
- Arredondamento com `ROUND`
- Agrupamento com `GROUP BY`

O exercício fornece duas tabelas:

---

### Tabela `Project`

| Coluna       | Tipo |
|-------------|------|
| project_id  | int  |
| employee_id | int  |

Cada linha indica que um funcionário está alocado em um determinado projeto.

---

### Tabela `Employee`

| Coluna            | Tipo |
|-------------------|------|
| employee_id       | int  |
| name              | varchar |
| experience_years  | int  |

Cada linha representa um funcionário e seus anos de experiência.

---

## Objetivo

Para cada `project_id`, devemos retornar:

- A **média dos anos de experiência** dos funcionários que trabalham naquele projeto
- O valor deve estar arredondado para **2 casas decimais**

O resultado final deve conter:

- `project_id`
- `average_years`

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    project_id, 
    ROUND(AVG(CAST(experience_years AS DECIMAL(10,2))), 2) average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY project_id;
```

---

## Explicação da Query

### Passo 1 – Fazendo o JOIN das Tabelas

```sql
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
```

O `JOIN` conecta as duas tabelas através da coluna `employee_id`.

Por quê?

- A tabela `Project` informa **quais funcionários estão em cada projeto**
- A tabela `Employee` informa **quantos anos de experiência cada funcionário possui**

Ao unir as duas tabelas, conseguimos acessar:

- `project_id`
- `experience_years`

na mesma consulta.

---

### Passo 2 – Convertendo para Decimal

```sql
CAST(experience_years AS DECIMAL(10,2))
```

Mesmo sendo um número inteiro (`int`), convertemos para `DECIMAL(10,2)` para:

- Garantir precisão decimal durante o cálculo da média
- Evitar comportamentos inesperados de arredondamento
- Preparar o valor para o `ROUND`

---

### Passo 3 – Calculando a Média

```sql
AVG(...)
```

A função `AVG()` calcula a média dos anos de experiência dos funcionários.

Mas isso só funciona corretamente porque utilizamos:

```sql
GROUP BY project_id
```

O `GROUP BY` agrupa os funcionários por projeto antes de calcular a média.

---

### Passo 4 – Arredondando o Resultado

```sql
ROUND(AVG(...), 2)
```

O `ROUND` garante que:

- O resultado tenha exatamente **2 casas decimais**
- O formato esteja de acordo com o enunciado

Exemplos:

- 3.666666 → 3.67  
- 5 → 5.00  

---

### Passo 5 – Agrupando por Projeto

```sql
GROUP BY project_id
```

Isso garante:

- Uma linha por projeto
- A média calculada separadamente para cada `project_id`

Sem o `GROUP BY`, a consulta retornaria apenas uma média geral para todos os projetos.

---

## Por Que Essa Solução Funciona?

- O `JOIN` conecta os projetos aos funcionários
- O `GROUP BY` separa os cálculos por projeto
- O `AVG` calcula a média corretamente
- O `CAST` garante precisão decimal
- O `ROUND` ajusta o formato final

Cada parte da query atende diretamente a um requisito do problema.

---

## Exemplo

### Tabela Project

| project_id | employee_id |
|------------|------------|
| 1          | 1          |
| 1          | 2          |
| 2          | 3          |

### Tabela Employee

| employee_id | name   | experience_years |
|------------|--------|------------------|
| 1          | Alice  | 3                |
| 2          | Bob    | 5                |
| 3          | Carol  | 4                |

---

### Cálculo

- Projeto 1 → Funcionários 1 e 2 → (3 + 5) / 2 = 4.00  
- Projeto 2 → Funcionário 3 → 4 / 1 = 4.00  

---

### Resultado Final

| project_id | average_years |
|------------|--------------|
| 1          | 4.00         |
| 2          | 4.00         |

---

## Conclusão

Esse desafio reforça:

- Entendimento de relacionamentos entre tabelas
- Uso correto de `JOIN`
- Aplicação de funções de agregação
- Importância do `GROUP BY`
- Formatação de números com `ROUND`

É um exercício essencial para dominar agregações com múltiplas tabelas — algo extremamente comum em cenários reais de análise de dados.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***