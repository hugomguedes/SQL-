-- quantidade total de transacoes acumulada de clientes por dia desde o inicio do curso

WITH tb_cliente_dias AS (
    SELECT  IdCliente,
            substr(DtCriacao,1,10) AS Dia,
            COUNT(DISTINCT IdTransacao) AS qtTransacoes

    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY IdCliente, Dia
),

tb_lag AS (
    SELECT *,
            sum(qtTransacoes) OVER (PARTITION BY IdCliente ORDER BY Dia) AS acum,
            lag(qtTransacoes) OVER (PARTITION BY IdCliente ORDER BY Dia) AS lagTransacao
    FROM tb_cliente_dias
)

SELECT *,
        1. * qtTransacoes / lagTransacao AS vezesEngajamento -- medindo tendencia
FROM tb_lag


