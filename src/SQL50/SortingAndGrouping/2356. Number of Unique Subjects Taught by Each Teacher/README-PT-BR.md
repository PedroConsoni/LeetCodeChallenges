# LeetCode SQL – 2356. Number of Unique Subjects Taught by Each Teacher

## Descrição do Desafio

O problema **"Number of Unique Subjects Taught by Each Teacher"** do LeetCode trabalha os seguintes conceitos:

- Agregação com `COUNT`
- Remoção de duplicatas com `DISTINCT`
- Agrupamento de dados com `GROUP BY`

O desafio fornece uma única tabela:

### Tabela `Teacher`

| Coluna      | Tipo |
|------------|------|
| teacher_id | int  |
| subject_id | int  |
| dept_id    | int  |

Cada linha representa uma disciplina ministrada por um professor.

Um professor pode aparecer várias vezes porque:

- Pode lecionar várias disciplinas
- A mesma disciplina pode aparecer repetida na tabela

---

## Objetivo

Para cada `teacher_id`, devemos retornar:

- O total de **disciplinas únicas** que ele ministra

O resultado deve conter:

| teacher_id | cnt |
|------------|-----|

Onde:

- `teacher_id` = Identificador do professor  
- `cnt` = Quantidade de disciplinas distintas ensinadas por esse professor  

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id;
```

---

## Explicação da Query

### Passo 1 – Agrupando por Professor

```sql
GROUP BY teacher_id
```

A cláusula `GROUP BY` agrupa todas as linhas que possuem o mesmo `teacher_id`.

Isso significa que:

- Todos os registros do mesmo professor são tratados como um único grupo
- As funções de agregação operam dentro de cada grupo

Sem o `GROUP BY`, teríamos apenas um total geral da tabela inteira, e não um resultado por professor.

---

### Passo 2 – Contando Disciplinas Únicas

```sql
COUNT(DISTINCT subject_id)
```

- `COUNT()` conta registros
- `DISTINCT` remove valores duplicados antes da contagem

Isso garante que:

- Se um professor aparecer várias vezes com a mesma `subject_id`, ela será contada apenas uma vez
- Apenas disciplinas únicas entram no cálculo

Sem o `DISTINCT`, disciplinas repetidas aumentariam incorretamente o resultado.

---

### Passo 3 – Renomeando a Coluna

```sql
AS cnt
```

`AS` cria um alias (apelido) para a coluna calculada.

Em vez de retornar:

```
COUNT(DISTINCT subject_id)
```

Nós renomeamos para:

```
cnt
```

Isso deixa o resultado mais limpo e no formato esperado pelo problema.

---

## Por Que Essa Solução Funciona?

- `GROUP BY` separa os dados por professor
- `COUNT(DISTINCT ...)` garante que cada disciplina seja contada apenas uma vez
- A query realiza agrupamento e agregação de forma eficiente em um único comando

Essa é a forma mais clara e otimizada de resolver o problema.

---

## Exemplo

Se a tabela contiver:

| teacher_id | subject_id | dept_id |
|------------|------------|---------|
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 2          | 1       |

### Raciocínio passo a passo

### Professor 1:
Disciplinas: 2, 2, 3  
Disciplinas únicas: 2, 3  
Total = 2  

### Professor 2:
Disciplinas: 1, 2, 2  
Disciplinas únicas: 1, 2  
Total = 2  

---

## Resultado Final

| teacher_id | cnt |
|------------|-----|
| 1          | 2   |
| 2          | 2   |

---

## Conclusão

Este desafio reforça conceitos fundamentais de SQL:

- Agregação de dados
- Eliminação de duplicatas com `DISTINCT`
- Agrupamento de registros com `GROUP BY`
- Uso de alias para melhorar a legibilidade

Apesar de ser um problema simples, ele é essencial para dominar agregações agrupadas e aprender a contar corretamente valores únicos em bancos de dados relacionais.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***