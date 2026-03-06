# LeetCode SQL – 570. Managers with at Least 5 Direct Reports (Português-BR)

## Descrição do Desafio

O problema **"Managers with at Least 5 Direct Reports"** do LeetCode trabalha conceitos de:

- Subqueries
- `GROUP BY`
- `HAVING`
- `COUNT`
- Relacionamentos hierárquicos na mesma tabela

O desafio fornece uma única tabela:

### `Employee` Table

| Coluna     | Tipo |
|------------|------|
| id         | int  |
| name       | varchar |
| department | varchar |
| managerId  | int  |

Cada funcionário pode ter:

- Um `managerId` que referencia outro funcionário
- Ou `NULL`, caso não tenha gerente

Isso cria uma estrutura hierárquica dentro da própria tabela.

---

## Objetivo

Retornar os nomes dos gerentes que possuem **pelo menos 5 subordinados diretos**.

Importante:

- Apenas subordinados diretos contam
- Devemos retornar o `name`, não o `id`

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT name
FROM employee
WHERE id IN (
    SELECT managerId
    FROM employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);
```

---

## Explicação da Query

### Passo 1 – Subconsulta

```sql
SELECT managerId
FROM employee
GROUP BY managerId
HAVING COUNT(*) >= 5
```

Essa subconsulta:

1. Agrupa os funcionários por `managerId`
2. Conta quantos funcionários reportam para cada gerente
3. Filtra apenas aqueles com **5 ou mais subordinados**

---

### Passo 2 – Filtrando os Gerentes

```sql
WHERE id IN (...)
```

A query principal:

- Seleciona os funcionários cujo `id` aparece na subconsulta
- Esses são os gerentes com pelo menos 5 subordinados

Como estamos selecionando `name`, o resultado final retorna os nomes dos gerentes.

---

## Por Que Funciona?

- Cada linha da tabela representa um subordinado
- Agrupar por `managerId` conta quantos subordinados cada gerente possui
- `HAVING COUNT(*) >= 5` filtra os gerentes desejados
- `IN` conecta os IDs encontrados aos nomes correspondentes

---

## Conclusão

Esse desafio reforça:

- Uso de subqueries
- Uso de `GROUP BY`
- Filtragem com `HAVING`
- Contagem de registros relacionados
- Entendimento de hierarquia em banco de dados

É um exercício fundamental para dominar estruturas relacionais em SQL.