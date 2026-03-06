# LeetCode SQL – Duplicate Emails

## Descrição do Desafio

O desafio **"Duplicate Emails"** do LeetCode tem como objetivo praticar o uso de **GROUP BY** e **HAVING** em SQL para identificar **valores duplicados** em uma tabela.

Neste problema, precisamos encontrar endereços de e-mail que aparecem **mais de uma vez** na tabela `Person`.

---

## Estrutura da Tabela

### Tabela `Person`

| Coluna | Tipo    |
| ------ | ------- |
| id     | int     |
| email  | varchar |

Cada registro representa uma pessoa, e múltiplas pessoas podem compartilhar o mesmo e-mail.

---

## Objetivo

Retornar todos os **e-mails duplicados**, ou seja, aqueles que aparecem **mais de uma vez** na tabela.

### Coluna esperada:

* `email`

---

## Solução em SQL

```sql
SELECT email
FROM person
GROUP BY email
HAVING COUNT(email) > 1;
```

---

## Explicação da Query

### GROUP BY

```sql
GROUP BY email
```

Agrupa os registros pelo campo `email`, permitindo contar quantas vezes cada e-mail aparece na tabela.

---

### COUNT

```sql
COUNT(email)
```

Conta o número de ocorrências de cada e-mail dentro de cada grupo.

---

### HAVING

```sql
HAVING COUNT(email) > 1
```

O `HAVING` é usado para **filtrar grupos**, diferente do `WHERE`, que filtra linhas.

Neste caso, ele mantém apenas os grupos em que o e-mail aparece **mais de uma vez**, ou seja, e-mails duplicados.

---

## Exemplo

### Tabela Person

| id | email                     |
| -- | ------------------------- |
| 1  | [a@b.com](mailto:a@b.com) |
| 2  | [c@d.com](mailto:c@d.com) |
| 3  | [a@b.com](mailto:a@b.com) |

### Resultado

| email                     |
| ------------------------- |
| [a@b.com](mailto:a@b.com) |

---

## Conclusão

Este desafio reforça conceitos essenciais de SQL:

* Uso de **GROUP BY** para agregação
* Aplicação da função **COUNT**
* Filtragem de grupos com **HAVING**

É um exercício fundamental para identificar **duplicidades em bancos de dados**.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***
