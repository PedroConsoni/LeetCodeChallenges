# LeetCode SQL – 1517. Encontrar Usuários com E-mails Válidos

## Descrição do Desafio

O problema **"Find Users With Valid E-Mails"** do LeetCode trabalha conceitos importantes de SQL, como:

- Correspondência de padrões com `LIKE`
- Validação de strings
- Manipulação de strings com funções como `LEFT` e `LEN`
- Uso de collation para garantir correspondência de padrões sensível a caracteres

O desafio fornece apenas **uma tabela**.

---

## Tabela `Users`

| Coluna | Tipo |
|------|------|
| user_id | int |
| name | varchar |
| mail | varchar |

Cada linha representa um usuário e seu endereço de e-mail.

Entretanto, nem todos os e-mails seguem o **formato válido exigido pelo problema**.

---

## Objetivo

Retornar os usuários cujos e-mails são **válidos de acordo com as seguintes regras**:

1. O e-mail deve terminar com **`@leetcode.com`**
2. A parte antes de `@leetcode.com` deve:
   - Começar com **uma letra**
   - Conter apenas:
     - letras (`a-z`, `A-Z`)
     - números (`0-9`)
     - underscore (`_`)
     - ponto (`.`)
     - hífen (`-`)

O resultado deve retornar:

- `user_id`
- `name`
- `mail`

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT user_id, name, mail
FROM Users
WHERE mail LIKE '[a-zA-Z]%@leetcode.com' COLLATE Latin1_General_BIN
  AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^a-zA-Z0-9_.-]%' COLLATE Latin1_General_BIN;
```

---

## Explicação da Query

### Passo 1 – Garantindo que o E-mail Comece com uma Letra

```sql
mail LIKE '[a-zA-Z]%@leetcode.com'
```

Esse padrão garante que:

- O e-mail **comece com uma letra (`a-z` ou `A-Z`)**
- O e-mail **termine com `@leetcode.com`**

Exemplos válidos:

```
alice@leetcode.com
bob123@leetcode.com
john.doe@leetcode.com
```

Exemplos inválidos:

```
1alice@leetcode.com
_john@leetcode.com
```

---

### Passo 2 – Garantindo Comparação Binária

```sql
COLLATE Latin1_General_BIN
```

Essa collation garante **comparação binária**, tornando a validação de padrões mais rigorosa.

Sem isso, algumas comparações poderiam variar dependendo da collation padrão do banco.

---

### Passo 3 – Extraindo a Parte do Usuário do E-mail

```sql
LEFT(mail, LEN(mail) - 13)
```

Essa expressão extrai a parte **antes de `@leetcode.com`**.

Por que `13`?

Porque:

```
@leetcode.com
```

possui **13 caracteres**.

Exemplo:

```
mail = alice123@leetcode.com
```

Resultado:

```
alice123
```

---

### Passo 4 – Verificando Caracteres Inválidos

```sql
NOT LIKE '%[^a-zA-Z0-9_.-]%'
```

Essa condição garante que o nome do usuário **não contenha caracteres inválidos**.

Caracteres permitidos:

```
letras
números
_
.
-
```

Exemplos inválidos:

```
alice!@leetcode.com
john#@leetcode.com
mark$@leetcode.com
```

Esses e-mails seriam filtrados.

---

## Exemplo

### Users

| user_id | name | mail |
|-------|------|------|
| 1 | Alice | alice@leetcode.com |
| 2 | Bob | bob123@leetcode.com |
| 3 | Alex | 1alex@leetcode.com |
| 4 | Eve | eve!@leetcode.com |

---

## Resultado

| user_id | name | mail |
|-------|------|------|
| 1 | Alice | alice@leetcode.com |
| 2 | Bob | bob123@leetcode.com |

Explicação:

- `alice@leetcode.com` → válido
- `bob123@leetcode.com` → válido
- `1alex@leetcode.com` → inválido (não começa com letra)
- `eve!@leetcode.com` → inválido (possui caractere inválido)

---

## Por Que Essa Solução Funciona

Essa solução funciona porque:

- `LIKE` garante que o e-mail siga o padrão esperado
- `LEFT` extrai a parte do usuário
- `LEN` calcula dinamicamente o tamanho do e-mail
- `NOT LIKE` impede caracteres inválidos
- `COLLATE Latin1_General_BIN` garante comparação de caracteres rigorosa

---

## Conceitos de SQL Praticados

Este desafio reforça vários conceitos importantes:

- Correspondência de padrões com `LIKE`
- Manipulação de strings com `LEFT` e `LEN`
- Validação de caracteres
- Uso de collation para comparação precisa
- Validação de dados diretamente no SQL

---

## Conclusão

O desafio **Find Users With Valid E-Mails** é um ótimo exercício para praticar **validação de strings em SQL**.

Ele demonstra como SQL pode ser usado não apenas para consultar dados, mas também para **validar formatos e garantir qualidade dos dados**, algo extremamente importante em sistemas reais de banco de dados.