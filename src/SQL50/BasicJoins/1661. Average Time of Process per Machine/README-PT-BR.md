# LeetCode SQL – 1661. Tempo Médio de Processamento por Máquina

## Descrição do Desafio

O problema **"Average Time of Process per Machine"** do LeetCode trabalha conceitos de **self join**, agregação e agrupamento.

A tabela fornecida é:

### `Activity` Table

| Coluna        | Tipo  |
|--------------|-------|
| machine_id   | int   |
| process_id   | int   |
| activity_type| enum  |
| timestamp    | float |

Cada processo possui exatamente:

- Um registro `start`
- Um registro `end`

Cada processo pertence a uma máquina específica.

---

## Objetivo

Para cada `machine_id`, calcular o **tempo médio de processamento**.

O tempo de processamento é definido como:

```
end.timestamp - start.timestamp
```

O resultado deve:

- Ser agrupado por `machine_id`
- Ser arredondado para **3 casas decimais**

---

## Solução SQL (Baseada na Minha Implementação)

```sql
SELECT 
    s.machine_id,
    ROUND(AVG(e.timestamp - s.timestamp)::numeric, 3) AS processing_time
FROM Activity s
JOIN Activity e
  ON s.machine_id = e.machine_id
 AND s.process_id = e.process_id
 AND s.activity_type = 'start'
 AND e.activity_type = 'end'
GROUP BY s.machine_id;
```

---

## Explicação da Query

### Passo 1 – Self Join

```sql
FROM Activity s
JOIN Activity e
```

Fazemos um join da tabela com ela mesma:

- `s` → representa o registro de **start**
- `e` → representa o registro de **end**

---

### Passo 2 – Condições do Join

```sql
ON s.machine_id = e.machine_id
AND s.process_id = e.process_id
```

Garante que estamos combinando:

- A mesma máquina
- O mesmo processo

```sql
AND s.activity_type = 'start'
AND e.activity_type = 'end'
```

Garante que estamos calculando:

```
end.timestamp - start.timestamp
```

---

### Passo 3 – Cálculo do Tempo

```sql
e.timestamp - s.timestamp
```

Calcula o tempo de execução de cada processo.

---

### Passo 4 – Média por Máquina

```sql
AVG(e.timestamp - s.timestamp)
```

Calcula a média dos tempos de processamento por máquina.

---

### Passo 5 – Arredondamento

```sql
ROUND(..., 3)
```

Arredonda o resultado para **3 casas decimais**, conforme exigido.

O cast para `numeric` garante precisão correta no arredondamento.

---

## Conclusão

Esse desafio reforça:

- Uso de self join
- Associação correta de registros start e end
- Uso de `AVG`
- Agrupamento com `GROUP BY`
- Arredondamento de valores numéricos

É um exercício essencial para quem estuda SQL voltado para Engenharia de Dados ou Análise de Dados.

---

***The explication you are accessing is in Portuguese-BR, if you prefer to access the explication in English, [click here](README-EN.md)***