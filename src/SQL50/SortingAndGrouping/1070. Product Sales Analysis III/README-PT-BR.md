# LeetCode SQL – 1070. Product Sales Analysis III

## Descrição do Desafio

O problema **"Product Sales Analysis III"** no LeetCode foca em conceitos importantes de SQL, como:

- Common Table Expressions (`WITH`)
- Funções de janela (Window Functions)
- Classificação com `RANK()`
- Particionamento de dados com `PARTITION BY`
- Ordenação com `ORDER BY`

O problema fornece uma única tabela:

### Tabela `Sales`

| Coluna     | Tipo |
|------------|------|
| product_id | int  |
| year       | int  |
| quantity   | int  |
| price      | int  |

Cada linha representa as informações de venda de um produto em um ano específico.

Um produto pode aparecer múltiplas vezes porque:

- Ele pode ter registros de venda em vários anos.

---

## Objetivo

Para cada `product_id`, retornar:

- O **primeiro ano** em que o produto foi vendido
- A `quantity` vendida nesse ano
- O `price` nesse ano

Formato da saída:

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

### Passo 1 – Criando uma Common Table Expression (CTE)

```sql
WITH RankedSales AS ( ... )
```

A cláusula `WITH` cria um conjunto de resultados temporário chamado `RankedSales`.

Isso melhora:

- A legibilidade da query
- A separação lógica entre a etapa de classificação e a etapa de filtragem

---

### Passo 2 – Aplicando a Função de Janela

```sql
RANK() OVER(PARTITION BY product_id ORDER BY year ASC)
```

Este é o núcleo da solução.

- `PARTITION BY product_id` separa os dados por produto
- `ORDER BY year ASC` ordena os registros de cada produto do mais antigo para o mais recente
- `RANK()` atribui um número de classificação dentro de cada grupo de produto

O ano mais antigo para cada produto recebe `rn = 1`.

---

### Passo 3 – Renomeando a Coluna Year

```sql
year AS first_year
```

Renomeamos `year` para `first_year` para:

- Corresponder ao formato de saída exigido
- Tornar o significado da coluna mais claro

---

### Passo 4 – Filtrando Apenas o Primeiro Ano

```sql
WHERE rn = 1
```

Essa condição garante que:

- Apenas o primeiro registro de venda de cada produto seja retornado
- Todas as outras linhas classificadas sejam ignoradas

---

## Por Que Isso Funciona

- `PARTITION BY` isola cada produto
- `ORDER BY year ASC` garante a classificação cronológica
- `RANK()` identifica corretamente o primeiro ano de venda
- A CTE separa a lógica de classificação da filtragem final

Essa abordagem é eficiente e escalável para grandes conjuntos de dados.

---

## Exemplo

Se a tabela contiver:

| product_id | year | quantity | price |
|------------|------|----------|-------|
| 1          | 2018 | 10       | 100   |
| 1          | 2019 | 15       | 120   |
| 2          | 2017 | 5        | 200   |
| 2          | 2018 | 8        | 210   |

### Explicação passo a passo

### Produto 1

Anos: 2018, 2019  
Primeiro ano: 2018  
Quantidade: 10  
Preço: 100  

### Produto 2

Anos: 2017, 2018  
Primeiro ano: 2017  
Quantidade: 5  
Preço: 200  

---

## Saída Final

| product_id | first_year | quantity | price |
|------------|------------|----------|-------|
| 1          | 2018       | 10       | 100   |
| 2          | 2017       | 5        | 200   |

---

## Conclusão

Este desafio reforça conceitos importantes de SQL:

- Funções de janela
- Classificação com `RANK()`
- Particionamento de dados
- Uso de CTEs para consultas mais limpas
- Filtragem baseada em resultados de funções de janela

É um exercício fundamental para dominar **consultas analíticas em SQL**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***