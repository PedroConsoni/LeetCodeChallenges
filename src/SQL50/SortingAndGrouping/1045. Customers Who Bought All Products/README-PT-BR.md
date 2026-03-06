# LeetCode SQL – 1045. Customers Who Bought All Products

## Descrição do Desafio

O problema **"Customers Who Bought All Products"** do LeetCode trabalha os seguintes conceitos:

- Agregação com `COUNT`
- Remoção de duplicatas com `DISTINCT`
- Filtragem de grupos com `HAVING`
- Uso de subqueries
- Comparação de resultados agregados

O desafio fornece duas tabelas:

### Tabela `Customer`

| Coluna      | Tipo |
|-------------|------|
| customer_id | int  |
| product_key | int  |

Cada linha representa um produto comprado por um cliente.

Um cliente pode aparecer várias vezes porque:
- Pode comprar vários produtos
- Pode comprar o mesmo produto mais de uma vez

---

### Tabela `Product`

| Coluna      | Tipo |
|-------------|------|
| product_key | int  |

Cada linha representa um produto único disponível.

---

## Objetivo

Retornar o `customer_id` dos clientes que compraram **todos os produtos** listados na tabela `Product`.

Formato esperado:

| customer_id |
|-------------|

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    customer_id
FROM 
    Customer
GROUP BY 
    customer_id
HAVING 
    COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
```

---

## Explicação da Query

### Passo 1 – Agrupando por Cliente

```sql
GROUP BY customer_id
```

A cláusula `GROUP BY` agrupa todas as compras por cliente.

Isso permite calcular quantos produtos únicos cada cliente comprou.

---

### Passo 2 – Contando Produtos Distintos por Cliente

```sql
COUNT(DISTINCT product_key)
```

- `COUNT()` conta registros
- `DISTINCT` remove duplicatas

Isso garante que:

- Se o cliente comprou o mesmo produto várias vezes, ele será contado apenas uma vez
- A contagem represente produtos únicos adquiridos

---

### Passo 3 – Contando o Total de Produtos

```sql
(SELECT COUNT(*) FROM Product)
```

A subquery calcula o total de produtos disponíveis.

Como a tabela `Product` contém produtos únicos:

- `COUNT(*)` retorna a quantidade total de produtos diferentes

---

### Passo 4 – Comparando as Quantidades

```sql
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)
```

A cláusula `HAVING` filtra os grupos após a agregação.

Comparamos:

- Quantidade de produtos únicos comprados pelo cliente
- Quantidade total de produtos disponíveis

Se os valores forem iguais:

- O cliente comprou todos os produtos

---

## Por Que Essa Solução Funciona?

- `GROUP BY` separa os dados por cliente
- `COUNT(DISTINCT ...)` calcula compras únicas
- A subquery retorna o total de produtos
- `HAVING` garante que apenas clientes completos sejam retornados

É uma solução clara, lógica e eficiente.

---

## Exemplo

### Tabela Product

| product_key |
|-------------|
| 1           |
| 2           |
| 3           |

Total de produtos = 3

### Tabela Customer

| customer_id | product_key |
|-------------|-------------|
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 2           |

### Raciocínio passo a passo

Cliente 1:
Produtos únicos: 1, 2, 3  
Total = 3 → Igual ao total de produtos → ✅ Incluído  

Cliente 2:
Produtos únicos: 1, 2  
Total = 2 → Diferente do total de produtos → ❌ Excluído  

---

## Resultado Final

| customer_id |
|-------------|
| 1           |

---

## Conclusão

Este desafio reforça conceitos importantes de SQL:

- Agregações agrupadas
- Uso de `DISTINCT`
- Subqueries para comparação
- Filtragem com `HAVING`

É um excelente exercício para entender lógica de divisão relacional em SQL.