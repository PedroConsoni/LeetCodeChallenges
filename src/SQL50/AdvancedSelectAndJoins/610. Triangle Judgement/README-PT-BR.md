# LeetCode SQL – 610. Julgamento de Triângulo

## Descrição do Desafio

O problema **"Triangle Judgement"** do LeetCode foca nos seguintes conceitos de SQL:

- Lógica condicional utilizando `CASE`
- Condições matemáticas em SQL
- Expressões booleanas com `AND`
- Criação de colunas derivadas

O problema fornece uma única tabela:

### Tabela `Triangle`

| Coluna | Tipo |
|------|------|
| x | int |
| y | int |
| z | int |

Cada linha representa três números que podem representar os **comprimentos dos lados de um triângulo**.

---

# Objetivo

Determinar se os três valores fornecidos **podem formar um triângulo**.

Um triângulo só é válido se a **regra da desigualdade triangular** for satisfeita.

Essa regra afirma que:

- A soma de quaisquer dois lados deve ser **maior que o terceiro lado**.

Portanto:

- `x + y > z`
- `x + z > y`
- `y + z > x`

Se todas as condições forem verdadeiras, o resultado deve ser:

```
Yes
```

Caso contrário:

```
No
```

O resultado deve conter:

- `x`
- `y`
- `z`
- Uma nova coluna chamada `triangle`

---

# Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    x, 
    y, 
    z,
    CASE 
        WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM 
    Triangle;
```

---

# Explicação da Query

## Passo 1 – Selecionar os Lados do Triângulo

```sql
SELECT x, y, z
```

Isso retorna os três valores da tabela que representam os **possíveis lados do triângulo**.

---

## Passo 2 – Utilizar CASE para Aplicar Lógica

```sql
CASE
```

A instrução `CASE` funciona como uma estrutura **IF-ELSE** dentro do SQL.

Ela permite avaliar condições e retornar valores diferentes dependendo do resultado.

---

## Passo 3 – Aplicar a Regra da Desigualdade Triangular

```sql
WHEN x + y > z AND x + z > y AND y + z > x
```

Essa condição verifica a **regra matemática do triângulo**.

As três condições precisam ser verdadeiras:

- A soma de `x` e `y` deve ser maior que `z`
- A soma de `x` e `z` deve ser maior que `y`
- A soma de `y` e `z` deve ser maior que `x`

Se todas forem satisfeitas, então os valores podem formar um triângulo.

---

## Passo 4 – Retornar o Resultado

```sql
THEN 'Yes'
ELSE 'No'
```

Se a condição for verdadeira:

```
Yes
```

Se a condição for falsa:

```
No
```

---

## Passo 5 – Criar uma Nova Coluna

```sql
END AS triangle
```

Isso cria uma nova coluna chamada **`triangle`**, que contém o resultado da verificação.

---

# Por Que Isso Funciona

Essa solução implementa diretamente a **definição matemática de um triângulo**.

Ao verificar as três condições da desigualdade triangular:

- Triângulos inválidos são identificados corretamente
- Triângulos válidos retornam `"Yes"`
- Triângulos inválidos retornam `"No"`

A instrução `CASE` permite calcular o resultado **linha por linha**.

---

# Exemplo

Se a tabela contiver:

| x | y | z |
|---|---|---|
| 13 | 15 | 30 |
| 10 | 20 | 15 |

### Linha 1

```
13 + 15 = 28
28 > 30 → Falso
```

Resultado:

```
No
```

### Linha 2

```
10 + 20 = 30 > 15
10 + 15 = 25 > 20
20 + 15 = 35 > 10
```

Resultado:

```
Yes
```

Resultado Final:

| x | y | z | triangle |
|---|---|---|---|
| 13 | 15 | 30 | No |
| 10 | 20 | 15 | Yes |

---

# Conclusão

Este desafio reforça conceitos importantes de SQL como:

- Lógica condicional com `CASE`
- Expressões booleanas com `AND`
- Validação matemática dentro de queries SQL
- Criação de colunas derivadas

É um exercício simples, porém muito útil para praticar **condições lógicas e colunas calculadas em SQL**.