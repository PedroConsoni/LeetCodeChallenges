# LeetCode SQL – 1527. Patients With a Condition

## Descrição do Desafio

O problema **"Patients With a Condition"** do LeetCode trabalha alguns conceitos importantes de SQL, como:

- Filtragem de texto utilizando **LIKE**
- Trabalhar com **padrões em strings**
- Lidar com **múltiplas condições dentro de uma mesma coluna**
- Utilizar operadores lógicos como **OR**

O problema fornece uma única tabela:

### `Patients` Table

| Column        | Type |
|---------------|------|
| patient_id    | int  |
| patient_name  | varchar |
| conditions    | varchar |

Cada linha representa **um paciente** e as condições médicas associadas a ele.

A coluna `conditions` pode conter **múltiplos códigos de condição separados por espaço**.

Exemplo:

```
DIAB100 MYOP
```

Isso significa que o paciente possui **duas condições médicas**.

---

## Objetivo

Retornar todos os pacientes que possuem **Diabetes Tipo I**.

Um paciente é considerado como tendo essa condição se **qualquer um dos seus códigos de condição começar com `DIAB1`**.

O resultado deve incluir:

- `patient_id`
- `patient_name`
- `conditions`

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    patient_id, 
    patient_name, 
    conditions
FROM 
    Patients
WHERE 
    conditions LIKE 'DIAB1%' 
    OR conditions LIKE '% DIAB1%';
```

---

## Explicação da Query

### Passo 1 – Selecionando as Colunas Necessárias

```sql
SELECT 
    patient_id, 
    patient_name, 
    conditions
```

Aqui selecionamos as informações relevantes de cada paciente:

- ID do paciente
- Nome do paciente
- Lista de condições médicas

---

### Passo 2 – Verificando Condições que Começam com `DIAB1`

```sql
conditions LIKE 'DIAB1%'
```

Esse padrão encontra qualquer string que **comece com `DIAB1`**.

Exemplos que correspondem:

| conditions |
|-----------|
| DIAB100 |
| DIAB199 ASTHMA |

Esses casos funcionam porque o código da condição aparece **no início da string**.

---

### Passo 3 – Verificando Condições que Aparecem Depois

```sql
conditions LIKE '% DIAB1%'
```

Alguns pacientes podem ter **várias condições**, e o código de diabetes pode aparecer **depois de outra condição**.

Exemplo:

| conditions |
|-----------|
| ASTHMA DIAB100 |
| FLU DIAB120 |

O padrão funciona assim:

- `%` → corresponde a qualquer sequência de caracteres antes
- `' DIAB1'` → garante que o código aparece **após um espaço**
- `%` → permite qualquer sequência de caracteres depois

Isso evita correspondências incorretas como:

```
XDIAB100
```

---

### Passo 4 – Combinando as Condições

```sql
OR
```

Usamos `OR` porque o código de diabetes pode aparecer:

- **No início da string**
- **Após outra condição**

Assim conseguimos capturar **todos os casos válidos**.

---

## Por Que Isso Funciona

Essa solução funciona bem porque:

- `LIKE` permite fazer **busca por padrões em texto**
- Verificamos tanto o início quanto o meio da string
- O espaço antes de `DIAB1` garante que estamos verificando **um código completo de condição**

Isso evita falsos positivos e captura todos os pacientes relevantes.

---

## Exemplo

Se a tabela contiver:

| patient_id | patient_name | conditions |
|------------|--------------|-----------|
| 1 | Daniel | YFEV COUGH |
| 2 | Alice | DIAB100 MYOP |
| 3 | Bob | ASTHMA DIAB100 |
| 4 | George | FLU |

O resultado será:

| patient_id | patient_name | conditions |
|------------|--------------|-----------|
| 2 | Alice | DIAB100 MYOP |
| 3 | Bob | ASTHMA DIAB100 |

Porque ambos possuem uma condição que **começa com `DIAB1`**.

---

## Conclusão

Esse desafio reforça conceitos importantes de SQL, como:

- **Busca por padrões com LIKE**
- **Filtragem de strings**
- **Tratamento de múltiplos valores em uma coluna**
- **Combinação de condições com OR**

É um ótimo exercício para praticar **consultas SQL que envolvem filtragem textual**.