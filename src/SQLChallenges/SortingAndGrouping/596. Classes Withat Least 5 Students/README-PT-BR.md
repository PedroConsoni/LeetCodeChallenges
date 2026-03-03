# LeetCode SQL – Classes More Than 5 Students

## Descrição do Desafio

O desafio **"Classes More Than 5 Students"** do LeetCode tem como objetivo praticar o uso de **GROUP BY** e **HAVING** em SQL para filtrar grupos com base em funções de agregação.

Neste problema, precisamos identificar as **turmas (classes)** que possuem **cinco ou mais alunos** matriculados.

---

## Estrutura da Tabela

### Tabela `Courses`

| Coluna  | Tipo    |
| ------- | ------- |
| student | varchar |
| class   | varchar |

Cada registro representa um aluno matriculado em uma determinada turma.

---

## Objetivo

Retornar o nome das **turmas** que possuem **pelo menos 5 alunos**.

### Coluna esperada:

* `class`

---

## Solução em SQL

```sql
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;
```

---

## Explicação da Query

### GROUP BY

```sql
GROUP BY class
```

Agrupa os registros pela coluna `class`, permitindo analisar cada turma separadamente.

---

### COUNT

```sql
COUNT(student)
```

Conta quantos alunos (`student`) existem em cada turma.

---

### HAVING

```sql
HAVING COUNT(student) >= 5
```

O `HAVING` é utilizado para **filtrar grupos**, diferente do `WHERE`, que filtra linhas individuais.

Nesse caso, apenas as turmas com **5 ou mais alunos** são retornadas.

---

## Exemplo

### Tabela Courses

| student | class   |
| ------- | ------- |
| A       | Math    |
| B       | Math    |
| C       | Math    |
| D       | Math    |
| E       | Math    |
| F       | English |

### Resultado

| class |
| ----- |
| Math  |

---

## Conclusão

Este desafio reforça conceitos fundamentais de SQL:

* Agrupamento de dados com **GROUP BY**
* Uso da função de agregação **COUNT**
* Filtragem de grupos com **HAVING**

É um exercício essencial para compreender **análise de dados agregados** em SQL.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
