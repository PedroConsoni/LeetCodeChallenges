# LeetCode SQL – Rising Temperature (Português-BR)

## Descrição do Desafio

O problema **"Rising Temperature"** do LeetCode tem como foco o uso de **funções de janela**, especialmente `LAG()`.

A tabela fornecida é:

### `Weather` Table

| Coluna      | Tipo |
|------------|------|
| id         | int  |
| recordDate | date |
| temperature| int  |

Cada linha representa a temperatura registrada em uma determinada data.

---

## Objetivo

Retornar o `id` de todos os registros onde:

- A temperatura é **maior que a do dia anterior**
- A data anterior é **exatamente um dia antes**

Ou seja:

- Devemos comparar dias consecutivos
- Datas com intervalo maior que 1 dia devem ser ignoradas

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT id
FROM (
    SELECT
        id,
        temperature,
        recordDate,
        LAG(temperature) OVER(ORDER BY recordDate) as prev_temp,
        LAG(recordDate) OVER(ORDER BY recordDate) as prev_date
    FROM weather
) as temp_comparison
WHERE temperature > prev_temp
    AND DATEDIFF(day, prev_date, recordDate) = 1;
```

---

## Explicação da Query

### Passo 1 – Subconsulta

A subconsulta adiciona duas colunas:

- `prev_temp` → Temperatura anterior
- `prev_date` → Data anterior

Isso é feito utilizando a função de janela `LAG()`.

---

### Passo 2 – Uso do LAG()

```sql
LAG(temperature) OVER(ORDER BY recordDate)
```

Busca a temperatura da linha anterior ordenada por data.

```sql
LAG(recordDate) OVER(ORDER BY recordDate)
```

Busca a data da linha anterior.

> O `ORDER BY recordDate` garante a ordem cronológica correta.

---

### Passo 3 – Condições do WHERE

```sql
WHERE temperature > prev_temp
```

Garante que a temperatura atual seja maior que a anterior.

```sql
AND DATEDIFF(day, prev_date, recordDate) = 1
```

Garante que as datas tenham exatamente 1 dia de diferença.

Isso é importante porque:

- A tabela pode ter datas faltando
- Precisamos comparar apenas dias consecutivos

---

## Conclusão

Esse desafio reforça:

- Uso de funções de janela
- Aplicação prática do `LAG()`
- Comparação correta de datas
- Tratamento de séries temporais

É um exercício essencial para quem estuda SQL voltado para Engenharia de Dados ou Análise de Dados.