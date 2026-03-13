# LeetCode SQL – 585. Investments in 2016

## Descrição do Desafio

O problema **"Investments in 2016"** do LeetCode trabalha diversos conceitos importantes de SQL, incluindo:

- Uso de **window functions**
- Particionamento de dados com **PARTITION BY**
- Agregação de dados utilizando **SUM**
- Aplicação de **condições de filtragem**
- Formatação de valores numéricos

O problema fornece uma única tabela:

### `Insurance` Table

| Column   | Type |
|----------|------|
| pid      | int  |
| tiv_2015 | float |
| tiv_2016 | float |
| lat      | float |
| lon      | float |

Cada linha representa **uma apólice de seguro**.

Onde:

- `tiv_2015` → Valor total investido em **2015**
- `tiv_2016` → Valor total investido em **2016**
- `lat` e `lon` → Coordenadas geográficas da apólice

---

## Objetivo

Calcular a **soma de `tiv_2016`** das apólices que atendem **duas condições**:

1. O valor de **`tiv_2015` deve aparecer mais de uma vez** na tabela.
2. A **localização (`lat`, `lon`) deve ser única** (nenhuma outra apólice possui as mesmas coordenadas).

O resultado final deve:

- Retornar a **soma de `tiv_2016`**
- Estar formatado com **duas casas decimais**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
WITH CTE AS (
    SELECT 
        tiv_2016,
        COUNT(*) OVER(PARTITION BY tiv_2015) as cnt_tiv_2015,
        COUNT(*) OVER(PARTITION BY lat, lon) as cnt_lat_lon
    FROM Insurance
)
SELECT 
    CAST(SUM(tiv_2016) AS DECIMAL(18, 2)) AS tiv_2016
FROM CTE
WHERE 
    cnt_tiv_2015 > 1
    AND cnt_lat_lon = 1;
```

---

## Explicação da Query

### Passo 1 – Criando uma CTE com Window Functions

```sql
WITH CTE AS (
```

Criamos uma **CTE (Common Table Expression)** para facilitar a organização da query.

Em vez de usar várias subqueries, utilizamos **window functions** para calcular informações auxiliares.

---

### Passo 2 – Contando Apólices com o Mesmo `tiv_2015`

```sql
COUNT(*) OVER(PARTITION BY tiv_2015) as cnt_tiv_2015
```

Essa função conta quantas apólices possuem **o mesmo valor de `tiv_2015`**.

Exemplo:

| tiv_2015 | count |
|----------|-------|
| 10       | 2     |
| 10       | 2     |
| 20       | 1     |

Somente valores cuja contagem é **maior que 1** satisfazem a condição do problema.

---

### Passo 3 – Contando Apólices com a Mesma Localização

```sql
COUNT(*) OVER(PARTITION BY lat, lon) as cnt_lat_lon
```

Aqui contamos quantas apólices possuem **a mesma localização geográfica**.

Exemplo:

| lat | lon | count |
|-----|-----|-------|
| 10  | 20  | 2     |
| 10  | 20  | 2     |
| 15  | 30  | 1     |

O problema exige **localizações únicas**, ou seja, a contagem deve ser **igual a 1**.

---

### Passo 4 – Filtrando as Apólices Válidas

```sql
WHERE 
    cnt_tiv_2015 > 1
    AND cnt_lat_lon = 1
```

Esse filtro garante que:

- O valor de `tiv_2015` aparece **mais de uma vez**
- A localização `(lat, lon)` é **única**

Somente registros que atendem **ambas as condições** são considerados.

---

### Passo 5 – Somando os Investimentos de 2016

```sql
SUM(tiv_2016)
```

Calcula a soma total dos valores de **investimento em 2016** das apólices válidas.

---

### Passo 6 – Formatando o Resultado

```sql
CAST(SUM(tiv_2016) AS DECIMAL(18, 2))
```

Converte o resultado para um número decimal com **duas casas decimais**, conforme exigido pelo problema.

---

## Por Que Isso Funciona

Essa solução é eficiente porque:

- **Window functions** permitem contar valores sem colapsar as linhas
- `PARTITION BY` organiza os dados logicamente
- A **CTE melhora a legibilidade da query**
- Os filtros são aplicados apenas após o cálculo das contagens

Isso torna a solução **simples, clara e eficiente**.

---

## Conclusão

Esse desafio reforça conceitos importantes de SQL, como:

- **Window functions**
- **PARTITION BY**
- **Agregações com SUM**
- **Filtragem baseada em condições**
- **Formatação de números**

É um excelente exercício para aprender a trabalhar com **consultas analíticas e funções de janela em SQL**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***