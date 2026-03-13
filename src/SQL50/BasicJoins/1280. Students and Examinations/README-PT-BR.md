# LeetCode SQL – 1280. Students and Examinations (Português-BR)

## Descrição do Desafio

O problema **"Students and Examinations"** do LeetCode trabalha conceitos de:

- `CROSS JOIN`
- `LEFT JOIN`
- Agregação com `COUNT`
- `GROUP BY`
- Tratamento de registros ausentes

O desafio fornece três tabelas:

### `Students` Table

| Coluna        | Tipo |
|--------------|------|
| student_id   | int  |
| student_name | varchar |

---

### `Subjects` Table

| Coluna        | Tipo |
|--------------|------|
| subject_name | varchar |

---

### `Examinations` Table

| Coluna        | Tipo |
|--------------|------|
| student_id   | int  |
| subject_name | varchar |

A tabela `Examinations` registra cada vez que um aluno realiza uma prova.

---

## Objetivo

Para cada aluno e cada disciplina, retornar:

- `student_id`
- `student_name`
- `subject_name`
- Quantidade de exames realizados naquela disciplina

Importante:

- Todo aluno deve aparecer com todas as disciplinas
- Se ele não realizou nenhuma prova, o valor deve ser `0`

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    s.student_id, 
    s.student_name, 
    sub.subject_name, 
    COUNT(e.student_id) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
```

---

## Explicação da Query

### Passo 1 – CROSS JOIN

```sql
CROSS JOIN Subjects sub
```

O `CROSS JOIN` cria todas as combinações possíveis entre:

- Cada aluno
- Cada disciplina

Isso garante que todos os alunos apareçam com todas as matérias.

---

### Passo 2 – LEFT JOIN

```sql
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
```

O `LEFT JOIN` adiciona os registros de exames quando existirem.

Se o aluno não tiver feito a prova:

- Os valores de `Examinations` serão `NULL`
- A linha ainda aparecerá no resultado

---

### Passo 3 – Contagem de Exames

```sql
COUNT(e.student_id)
```

Conta quantas vezes o aluno realizou aquela prova.

Importante:

- `COUNT(coluna)` ignora `NULL`
- Se não houver prova, o resultado será automaticamente `0`

---

### Passo 4 – GROUP BY

```sql
GROUP BY s.student_id, s.student_name, sub.subject_name
```

Agrupa os resultados por:

- Aluno
- Disciplina

---

### Passo 5 – ORDER BY

```sql
ORDER BY s.student_id, sub.subject_name
```

Ordena o resultado por:

1. ID do aluno
2. Nome da disciplina

---

## Conclusão

Esse desafio reforça:

- Uso de `CROSS JOIN` para gerar combinações
- Uso de `LEFT JOIN` para preservar dados ausentes
- Uso de `COUNT`
- Agrupamento correto
- Tratamento adequado de valores `NULL`

É um exercício essencial para dominar lógica relacional em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***