# LeetCode SQL – 1070. Product Sales Analysis III

## Descrição do Desafio

O problema **"Product Sales Analysis III"** do LeetCode trabalha os seguintes conceitos:

- Common Table Expressions (`WITH`)
- Funções de janela (Window Functions)
- Ranqueamento com `RANK()`
- Particionamento com `PARTITION BY`
- Ordenação com `ORDER BY`

O desafio fornece uma única tabela:

### Tabela `Sales`

| Coluna     | Tipo |
|------------|------|
| product_id | int  |
| year       | int  |
| quantity   | int  |
| price      | int  |

Cada linha representa as vendas de um produto em um determinado ano.

Um produto pode aparecer várias vezes porque:
- Pode ter registros de vendas em vários anos

---

## Objetivo

Para cada `product_id`, retornar:

- O **primeiro ano** em que o produto foi vendido
- A `quantity` vendida nesse ano
- O `price` nesse ano

Formato esperado:

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH RankedSales AS ( 
    SELECT 
        product_id, 
        year AS first_year, 
        quantity, 
        price,
        RANK() OVER(PARTITION BY product_id ORDER BY year ASC) as rn
    FROM Sales
)
SELECT 
    product_id, 
    first_year, 
    quantity, 
    price
FROM RankedSales
WHERE rn = 1;
```

---

## Explicação da Query

### Passo 1 – Criando uma CTE

```sql
WITH RankedSales AS ( ... )
```

A cláusula `WITH` cria um conjunto de resultados temporário chamado `RankedSales`.

Isso melhora:

- A legibilidade
- A separação lógica entre ranqueamento e filtragem

---

### Passo 2 – Aplicando a Função de Janela

```sql
RANK() OVER(PARTITION BY product_id ORDER BY year ASC)
```

Este é o núcleo da solução.

- `PARTITION BY product_id` separa os dados por produto
- `ORDER BY year ASC` ordena do ano mais antigo para o mais recente
- `RANK()` atribui uma posição dentro de cada grupo

O ano mais antigo recebe `rn = 1`.

---

### Passo 3 – Renomeando a Coluna

```sql
year AS first_year
```

Renomeamos `year` para `first_year` para deixar o resultado mais claro e no formato exigido.

---

### Passo 4 – Filtrando Apenas o Primeiro Ano

```sql
WHERE rn = 1
```

Essa condição garante que:

- Apenas o primeiro registro de venda de cada produto seja retornado
- Os demais anos sejam descartados

---

## Por Que Essa Solução Funciona?

- `PARTITION BY` isola cada produto
- `ORDER BY year ASC` garante ordem cronológica
- `RANK()` identifica corretamente o primeiro ano
- A CTE organiza a lógica de forma clara e eficiente

É uma solução escalável e adequada para grandes volumes de dados.

---

## Exemplo

Se a tabela contiver:

| product_id | year | quantity | price |
|------------|------|----------|-------|
| 1          | 2018 | 10       | 100   |
| 1          | 2019 | 15       | 120   |
| 2          | 2017 | 5        | 200   |
| 2          | 2018 | 8        | 210   |

### Raciocínio passo a passo

### Produto 1:
Anos: 2018, 2019  
Primeiro ano: 2018  
Quantidade: 10  
Preço: 100  

### Produto 2:
Anos: 2017, 2018  
Primeiro ano: 2017  
Quantidade: 5  
Preço: 200  

---

## Resultado Final

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|
| 1          | 2018       | 10       | 100   |
| 2          | 2017       | 5        | 200   |

---

## Conclusão

Este desafio reforça conceitos importantes de SQL:

- Funções de janela
- Ranqueamento com `RANK()`
- Particionamento de dados
- Uso de CTE para organização
- Filtragem baseada em resultados analíticos

É um exercício essencial para dominar consultas analíticas em SQL.