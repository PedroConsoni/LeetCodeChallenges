# LeetCode SQL – 620. Not Boring Movies (Português-BR)

## Descrição do Desafio

O problema **"Not Boring Movies"** do LeetCode trabalha conceitos de:

- Filtro com `WHERE`
- Uso de operadores aritméticos
- Ordenação com `ORDER BY`
- Combinação de múltiplas condições

O desafio fornece uma única tabela:

### `Cinema` Table

| Coluna       | Tipo |
|-------------|------|
| id          | int  |
| movie       | varchar |
| description | varchar |
| rating      | float |

Cada linha representa um filme.

---

## Objetivo

Retornar todos os filmes que:

- Possuem `id` **ímpar**
- Possuem `description` diferente de `'boring'`

O resultado deve:

- Ser ordenado por `rating` em **ordem decrescente**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT *
FROM cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;
```

---

## Explicação da Query

### Passo 1 – Filtrando IDs Ímpares

```sql
id % 2 = 1
```

O operador módulo `%` calcula o resto da divisão.

Se:

- `id % 2 = 1` → número ímpar
- `id % 2 = 0` → número par

Isso garante que apenas filmes com **ID ímpar** sejam selecionados.

---

### Passo 2 – Excluindo Filmes "boring"

```sql
description != 'boring'
```

Remove do resultado todos os filmes cuja descrição seja exatamente `'boring'`.

---

### Passo 3 – Ordenação por Avaliação

```sql
ORDER BY rating DESC
```

Ordena os resultados por:

- Maior nota primeiro
- Menor nota por último

---

## Conclusão

Esse desafio reforça:

- Uso correto do `WHERE`
- Operadores aritméticos
- Combinação de condições com `AND`
- Ordenação com `ORDER BY`

É um exercício simples, mas essencial para dominar lógica de filtragem em SQL.