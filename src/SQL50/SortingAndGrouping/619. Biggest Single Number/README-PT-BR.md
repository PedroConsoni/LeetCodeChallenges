# LeetCode SQL – 619. Biggest Single Number

## Descrição do Desafio

O problema **"Biggest Single Number"** do LeetCode trabalha os seguintes conceitos:

- Agregação com `COUNT`
- Filtragem de grupos com `HAVING`
- Uso de subqueries
- Busca de valores máximos com `MAX`

O desafio fornece uma única tabela:

### Tabela `MyNumbers`

| Coluna | Tipo |
|--------|------|
| num    | int  |

Cada linha contém um número inteiro.

O mesmo número pode aparecer várias vezes na tabela.

---

## Objetivo

Retornar o **maior número** que aparece **exatamente uma vez** na tabela.

Se nenhum número atender a essa condição, deve-se retornar `NULL`.

Formato esperado:

| num |
|-----|

Onde:

- `num` = Maior número que aparece apenas uma vez  

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT MAX(num) as num
FROM (
    SELECT num
    FROM mynumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS singlenumber;
```

---

## Explicação da Query

### Passo 1 – Agrupando os Números

```sql
GROUP BY num
```

A cláusula `GROUP BY` agrupa números iguais.

Isso permite contar quantas vezes cada número aparece na tabela.

---

### Passo 2 – Filtrando Apenas Ocorrências Únicas

```sql
HAVING COUNT(num) = 1
```

A cláusula `HAVING` filtra os grupos após a agregação.

- `COUNT(num) = 1` garante que apenas números que aparecem exatamente uma vez sejam mantidos
- Números repetidos são descartados

Neste ponto, temos apenas números únicos.

---

### Passo 3 – Utilizando uma Subquery

```sql
FROM (
    ...
) AS singlenumber
```

A subquery isola os números que aparecem apenas uma vez.

Tratamos esse resultado como uma tabela temporária chamada `singlenumber`.

A lógica fica organizada em duas etapas:

- Query interna → encontra números únicos  
- Query externa → encontra o maior deles  

---

### Passo 4 – Encontrando o Maior Valor

```sql
MAX(num)
```

A função `MAX()` retorna o maior valor entre os números restantes.

Se nenhum número aparecer exatamente uma vez:

- A subquery retorna vazio
- `MAX()` retorna `NULL`

---

## Por Que Essa Solução Funciona?

- `GROUP BY` agrupa números iguais
- `HAVING COUNT(num) = 1` filtra apenas valores únicos
- A subquery separa a lógica em etapas claras
- `MAX()` retorna o maior número válido

É uma solução limpa, organizada e eficiente.

---

## Exemplo

Se a tabela contiver:

| num |
|-----|
| 8   |
| 8   |
| 3   |
| 1   |
| 2   |
| 2   |

### Raciocínio passo a passo

Resultados agrupados:

- 8 → aparece 2 vezes ❌  
- 3 → aparece 1 vez ✅  
- 1 → aparece 1 vez ✅  
- 2 → aparece 2 vezes ❌  

Números únicos: 3, 1  

Maior número entre eles: **3**

---

## Resultado Final

| num |
|-----|
| 3   |

---

## Conclusão

Este desafio reforça conceitos importantes de SQL:

- Agrupamento com `GROUP BY`
- Filtragem de agregações com `HAVING`
- Uso de subqueries para organizar a lógica
- Aplicação de funções agregadas como `MAX`

Apesar de simples, é um excelente exercício para compreender filtragem em nível de grupo e construção de queries em camadas.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***