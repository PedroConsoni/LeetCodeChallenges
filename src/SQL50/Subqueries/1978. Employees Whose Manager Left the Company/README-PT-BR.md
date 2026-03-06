# LeetCode SQL – 1978. Employees Whose Manager Left the Company (Português-BR)

## Descrição do Desafio

O problema **"Employees Whose Manager Left the Company"** do LeetCode foca na prática de:

- Filtragem de dados com `WHERE`
- Verificação de valores `NULL`
- Subqueries utilizando `NOT IN`
- Ordenação de resultados com `ORDER BY`

O problema fornece uma única tabela:

### `Employees` Table

| Column | Type |
|------|------|
| employee_id | int |
| name | varchar |
| manager_id | int |
| salary | int |

Cada linha representa um funcionário de uma empresa.

- `employee_id` é o identificador único do funcionário
- `manager_id` representa o gerente desse funcionário
- Se um gerente sair da empresa, seu `employee_id` não aparecerá mais na tabela

---

## Objetivo

Encontrar todos os funcionários que:

- Possuem **salário menor que 30000**
- **Possuem um gerente**
- Mas o **gerente não existe mais na tabela Employees**

O resultado deve retornar:

| employee_id |

E deve estar ordenado por `employee_id` em **ordem crescente**.

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT employee_id
FROM Employees
WHERE salary < 30000
  AND manager_id IS NOT NULL
  AND manager_id NOT IN (
      SELECT employee_id FROM Employees
  )
ORDER BY employee_id;
```

---

## Explicação da Query

### Passo 1 – Filtrar funcionários com salário menor que 30000

```sql
salary < 30000
```

Essa condição seleciona apenas funcionários cujo salário é **menor que 30000**.

Somente esses funcionários serão considerados no resultado final.

---

### Passo 2 – Garantir que o funcionário possui gerente

```sql
manager_id IS NOT NULL
```

Essa condição garante que o funcionário **possui um gerente definido**.

Se `manager_id` fosse `NULL`, significaria que:

- O funcionário não possui gerente
- Ou está no topo da hierarquia da empresa

Esses casos são ignorados no resultado.

---

### Passo 3 – Verificar se o gerente saiu da empresa

```sql
manager_id NOT IN (
    SELECT employee_id FROM Employees
)
```

Essa subquery obtém **todos os IDs de funcionários atualmente na empresa**.

```sql
SELECT employee_id FROM Employees
```

Em seguida, a condição verifica se o `manager_id` **não está presente nessa lista**.

Se o ID do gerente não existir na tabela, significa que:

- O gerente **não faz mais parte da empresa**

Portanto, esse funcionário deve aparecer no resultado.

---

### Passo 4 – Ordenar o resultado

```sql
ORDER BY employee_id
```

Isso ordena o resultado final por **employee_id em ordem crescente**.

Assim, o resultado segue exatamente o formato solicitado pelo problema.

---

## Por que essa solução funciona

Essa solução funciona porque:

- `salary < 30000` filtra funcionários com salários menores
- `manager_id IS NOT NULL` garante que o funcionário tem gerente
- `NOT IN` verifica se o gerente ainda existe na tabela
- A subquery retorna a lista de funcionários atuais
- `ORDER BY` garante que o resultado esteja ordenado corretamente

Essas condições juntas permitem identificar funcionários cujo **gerente não está mais na empresa**.

---

## Exemplo

Se a tabela `Employees` contiver:

| employee_id | name | manager_id | salary |
|-------------|------|-----------|-------|
| 1 | Alice | NULL | 60000 |
| 2 | Bob | 1 | 25000 |
| 3 | Charlie | 5 | 20000 |
| 4 | David | 1 | 40000 |

O funcionário **Charlie** possui:

- salário = 20000 (< 30000)
- manager_id = 5
- gerente **5 não existe na tabela**

Resultado final:

| employee_id |
|-------------|
| 3 |

---

## Conclusão

Esse desafio reforça diversos conceitos importantes de SQL:

- Filtragem com múltiplas condições
- Tratamento de valores `NULL`
- Uso de subqueries para validar relacionamentos
- Uso de `NOT IN` para lógica de exclusão
- Ordenação de resultados com `ORDER BY`

É um exercício útil para entender como o SQL pode identificar **relações ausentes em dados relacionais**.