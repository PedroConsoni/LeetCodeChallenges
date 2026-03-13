# LeetCode SQL – 626. Exchange Seats (Português-BR)

## Descrição do Desafio

O problema **"Exchange Seats"** do LeetCode foca na prática de:

- Lógica condicional usando `CASE`
- Operações aritméticas
- Subqueries
- Ordenação de resultados com `ORDER BY`

O problema fornece uma única tabela:

### `Seat` Table

| Column | Type |
|------|------|
| id | int |
| student | varchar |

Cada linha representa um assento em uma sala de aula e o estudante sentado naquele assento.

- `id` representa o número do assento
- `student` representa o estudante associado a esse assento

---

## Objetivo

Trocar os assentos de **cada par de estudantes consecutivos**.

Regras:

- O estudante no assento **1 troca com o assento 2**
- O estudante no assento **3 troca com o assento 4**
- O estudante no assento **5 troca com o assento 6**, e assim por diante

Entretanto:

- Se o número de estudantes for **ímpar**, o **último estudante permanece no mesmo assento**

O resultado deve retornar:

| id | student |

E deve estar ordenado por `id`.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT
    CASE
        WHEN id % 2 != 0 AND id < (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id % 2 != 0 AND id = (SELECT MAX(id) FROM Seat) THEN id
        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;
```

---

## Explicação da Query

### Passo 1 – Usando CASE para controlar a troca de assentos

```sql
CASE
```

A instrução `CASE` permite aplicar **lógica condicional** diretamente dentro do `SELECT`.

Isso possibilita alterar dinamicamente os valores de `id` dependendo da situação.

---

### Passo 2 – Trocar assentos ímpares com o próximo assento

```sql
WHEN id % 2 != 0 AND id < (SELECT MAX(id) FROM Seat) THEN id + 1
```

Essa condição verifica duas coisas:

1. Se o ID do assento é **ímpar**

```sql
id % 2 != 0
```

O operador módulo `%` calcula o resto da divisão.

- Se `id % 2 = 1` → o número é ímpar
- Se `id % 2 = 0` → o número é par

2. Se o assento **não é o último da tabela**

```sql
id < (SELECT MAX(id) FROM Seat)
```

Isso garante que ainda exista um próximo assento para realizar a troca.

Se ambas as condições forem verdadeiras:

- O novo ID se torna **id + 1**

Isso efetivamente troca o assento com o próximo estudante.

Exemplo:

| ID Original | Novo ID |
|---|---|
| 1 | 2 |
| 3 | 4 |
| 5 | 6 |

---

### Passo 3 – Tratando o último assento quando o número de estudantes é ímpar

```sql
WHEN id % 2 != 0 AND id = (SELECT MAX(id) FROM Seat) THEN id
```

Essa condição trata o caso especial em que:

- O assento é **ímpar**
- E também é **o último da tabela**

Nesse caso:

- Não existe outro estudante para trocar de lugar

Portanto, o assento **permanece o mesmo**.

---

### Passo 4 – Tratando assentos pares

```sql
ELSE id - 1
```

Se nenhuma das condições anteriores for atendida, significa que o assento é **par**.

Nesse caso:

- O assento troca com o **assento anterior**

Exemplo:

| ID Original | Novo ID |
|---|---|
| 2 | 1 |
| 4 | 3 |
| 6 | 5 |

---

### Passo 5 – Ordenando o resultado final

```sql
ORDER BY id
```

Após aplicar a lógica de troca, o resultado é ordenado pelos **novos IDs de assento**.

Isso garante que os assentos apareçam na ordem correta.

---

## Por que essa solução funciona

Essa solução funciona porque:

- O operador `%` identifica números pares e ímpares
- O `CASE` permite aplicar diferentes regras de troca
- A subquery `SELECT MAX(id)` identifica o último assento
- A lógica evita trocar o último assento quando não existe par
- `ORDER BY` garante que o resultado final esteja ordenado corretamente

Essas condições juntas implementam perfeitamente a regra de troca de assentos.

---

## Exemplo

Se a tabela `Seat` contiver:

| id | student |
|---|---|
| 1 | Alice |
| 2 | Bob |
| 3 | Charlie |
| 4 | David |
| 5 | Eve |

A troca de assentos ocorre da seguinte forma:

- 1 ↔ 2
- 3 ↔ 4
- 5 permanece no mesmo lugar

Resultado final:

| id | student |
|---|---|
| 1 | Bob |
| 2 | Alice |
| 3 | David |
| 4 | Charlie |
| 5 | Eve |

---

## Conclusão

Esse desafio reforça vários conceitos importantes de SQL:

- Uso de lógica condicional com `CASE`
- Operações aritméticas para manipulação de IDs
- Uso de subqueries para identificar casos especiais
- Ordenação de resultados com `ORDER BY`

Ele demonstra como o SQL pode ser utilizado para **reorganizar dados estruturados com base em regras lógicas**, algo muito comum em tarefas de transformação de dados.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***