# LeetCode SQL – 1204. Última Pessoa que Cabe no Ônibus

## Descrição do Desafio

O problema **"Last Person to Fit in the Bus"** do LeetCode foca nos seguintes conceitos de SQL:

- Window functions
- Cálculo de soma acumulada com `SUM() OVER`
- Ordenação de registros
- Filtragem baseada em valores acumulados
- Limitação de resultados com `TOP`

O problema fornece uma única tabela:

### Tabela `Queue`

| Coluna | Tipo |
|------|------|
| person_id | int |
| person_name | varchar |
| weight | int |
| turn | int |

Cada linha representa uma pessoa esperando em uma fila para entrar em um ônibus.

- `person_id` identifica a pessoa
- `person_name` contém o nome da pessoa
- `weight` representa o peso da pessoa
- `turn` indica a ordem em que as pessoas entram no ônibus

O ônibus possui **capacidade máxima de peso de 1000**.

---

# Objetivo

Determinar **o nome da última pessoa que consegue entrar no ônibus sem ultrapassar o limite de peso**.

As pessoas devem entrar **na ordem definida pela coluna `turn`**.

---

# Solução SQL (Baseada na Minha Implementação)

```sql
WITH WeightSum AS (
    SELECT 
        person_name, 
        SUM(weight) OVER (ORDER BY turn) AS cumulative_weight
    FROM Queue
)
SELECT TOP 1 person_name
FROM WeightSum
WHERE cumulative_weight <= 1000
ORDER BY cumulative_weight DESC;
```

---

# Explicação da Query

## Passo 1 – Criar uma Common Table Expression (CTE)

```sql
WITH WeightSum AS (...)
```

Isso cria uma **Common Table Expression (CTE)**.

A CTE é usada para calcular o **peso acumulado das pessoas que entram no ônibus**, respeitando a ordem da fila.

---

## Passo 2 – Calcular a Soma Acumulada

```sql
SUM(weight) OVER (ORDER BY turn)
```

Essa é uma **window function** que calcula uma soma acumulada.

Explicação:

- `ORDER BY turn` garante que o cálculo siga a ordem da fila
- Cada linha soma o peso das pessoas anteriores mais o peso da pessoa atual

Exemplo:

| turn | weight | cumulative_weight |
|----|----|----|
| 1 | 200 | 200 |
| 2 | 300 | 500 |
| 3 | 400 | 900 |
| 4 | 200 | 1100 |

Assim conseguimos ver como o peso total aumenta conforme mais pessoas entram no ônibus.

---

## Passo 3 – Filtrar Passageiros Válidos

```sql
WHERE cumulative_weight <= 1000
```

Essa condição mantém apenas as linhas onde o peso total **não ultrapassa o limite do ônibus**.

Qualquer pessoa que faça o peso total ultrapassar **1000** é descartada.

---

## Passo 4 – Encontrar o Último Passageiro Válido

```sql
ORDER BY cumulative_weight DESC
```

Os resultados são ordenados do **maior peso acumulado para o menor**.

Assim a pessoa que deixa o ônibus **mais próximo do limite máximo** aparece primeiro.

---

## Passo 5 – Retornar Apenas Um Resultado

```sql
SELECT TOP 1
```

Esse comando retorna **apenas a primeira linha do resultado ordenado**.

Essa linha corresponde **à última pessoa que consegue entrar no ônibus sem ultrapassar o limite de peso**.

---

# Por Que Isso Funciona

Essa solução funciona porque:

- Calcula o **peso acumulado dos passageiros**
- Mantém a ordem correta de entrada usando `turn`
- Remove passageiros que ultrapassam o limite de peso
- Seleciona o passageiro cujo peso acumulado fica **mais próximo do limite máximo**

Assim garantimos que o resultado seja **a última pessoa que consegue embarcar no ônibus**.

---

# Exemplo

Se a tabela contiver:

| person_id | person_name | weight | turn |
|---|---|---|---|
| 1 | Alice | 250 | 1 |
| 2 | Bob | 175 | 2 |
| 3 | Alex | 350 | 3 |
| 4 | John | 400 | 4 |
| 5 | Marie | 200 | 5 |

### Soma Acumulada

| person_name | cumulative_weight |
|---|---|
| Alice | 250 |
| Bob | 425 |
| Alex | 775 |
| John | 1175 |
| Marie | 1375 |

O limite do ônibus é **1000**.

John ultrapassaria o limite.

---

### Resultado

| person_name |
|---|
| Alex |

Alex é **a última pessoa que consegue entrar no ônibus sem ultrapassar o limite de peso**.

---

# Conclusão

Este desafio reforça conceitos importantes de SQL como:

- Window functions
- Soma acumulada com `SUM() OVER`
- Ordenação de dados
- Filtragem baseada em valores acumulados
- Limitação de resultados com `TOP`

É um excelente exercício para entender como **analisar dados sequenciais e restrições acumuladas utilizando SQL**.