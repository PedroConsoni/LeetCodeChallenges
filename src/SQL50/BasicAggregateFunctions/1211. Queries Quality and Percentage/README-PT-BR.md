# LeetCode SQL – 1211. Queries Quality and Percentage

## Descrição do Desafio

O problema **"Queries Quality and Percentage"** do LeetCode trabalha os seguintes conceitos:

- Funções de agregação (`AVG`)
- Lógica condicional com `CASE WHEN`
- Cálculos aritméticos
- Cálculo de porcentagens
- Arredondamento com `ROUND`
- Agrupamento com `GROUP BY`

O exercício fornece uma única tabela:

---

### Tabela `Queries`

| Coluna     | Tipo |
|------------|------|
| query_name | varchar |
| result     | varchar |
| position   | int  |
| rating     | int  |

Cada linha representa um resultado retornado por uma consulta, incluindo sua posição e avaliação.

---

## Objetivo

Para cada `query_name`, devemos retornar:

- `quality`: a média de `rating / position`
- `poor_query_percentage`: a porcentagem de registros onde `rating < 3`

Ambos os valores devem estar arredondados para **2 casas decimais**.

Além disso:

- Registros onde `query_name` é `NULL` devem ser ignorados.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    query_name,                
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,                
    ROUND(AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100, 2) AS poor_query_percentage
FROM 
    Queries                
WHERE 
    query_name IS NOT NULL
GROUP BY 
    query_name;
```

---

## Explicação da Query

### Passo 1 – Filtrando Valores NULL

```sql
WHERE query_name IS NOT NULL
```

Isso garante que:

- Apenas consultas válidas sejam consideradas
- Registros com `query_name` nulo sejam excluídos dos cálculos

---

### Passo 2 – Calculando a Qualidade da Query

```sql
AVG(rating * 1.0 / position)
```

A fórmula da qualidade é:

```
rating / position
```

Detalhe importante:

- `rating * 1.0` força divisão decimal.
- Sem isso, poderia ocorrer divisão inteira, causando perda de precisão.

O `AVG()` calcula a média desse valor para cada `query_name`.

---

### Passo 3 – Calculando a Porcentagem de Queries Ruins

```sql
AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END) * 100
```

Funciona da seguinte forma:

1. `CASE WHEN rating < 3 THEN 1.0 ELSE 0.0 END`
   - Retorna `1.0` se a avaliação for menor que 3
   - Retorna `0.0` caso contrário

2. O `AVG()` dessa expressão calcula:
   - A fração de registros onde `rating < 3`

3. Multiplicando por `100`, transformamos em porcentagem.

Exemplo:

Se 2 de 5 avaliações forem menores que 3:

```
AVG = 0.4
0.4 × 100 = 40.00%
```

---

### Passo 4 – Arredondando os Valores

```sql
ROUND(..., 2)
```

Garante que:

- Os resultados tenham exatamente **2 casas decimais**
- O formato esteja conforme exigido pelo problema

---

### Passo 5 – Agrupando por Query

```sql
GROUP BY query_name
```

Isso garante:

- Uma linha por consulta
- Cálculos feitos separadamente para cada `query_name`

Sem o `GROUP BY`, teríamos apenas um cálculo geral.

---

## Por Que Essa Solução Funciona?

- O `WHERE` remove dados inválidos
- O `AVG` calcula tanto média quanto proporção
- O `CASE WHEN` transforma condição lógica em valor numérico
- O `1.0` evita divisão inteira
- O `ROUND` formata corretamente os números
- O `GROUP BY` organiza os cálculos por consulta

Cada parte da query atende diretamente aos requisitos do problema.

---

## Exemplo

### Tabela Queries

| query_name | result | position | rating |
|------------|--------|----------|--------|
| Dog        | A      | 1        | 5      |
| Dog        | B      | 2        | 3      |
| Dog        | C      | 3        | 1      |
| Cat        | D      | 1        | 2      |
| Cat        | E      | 2        | 4      |

---

### Cálculo

Para **Dog**:

- Quality:
  - (5/1 + 3/2 + 1/3) / 3
- Poor percentage:
  - Apenas 1 avaliação < 3 → 1 de 3 → 33.33%

Para **Cat**:

- Quality:
  - (2/1 + 4/2) / 2
- Poor percentage:
  - 1 avaliação < 3 de 2 → 50.00%

---

## Conclusão

Esse desafio reforça:

- Uso avançado de `AVG`
- Agregação condicional com `CASE`
- Técnicas de cálculo de porcentagem
- Prevenção de erros de divisão inteira
- Filtragem correta de dados
- Lógica analítica em SQL

É um excelente exercício para dominar padrões analíticos em consultas SQL.