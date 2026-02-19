-- de quanto em quanto tempo as pessoas assistem o canal?
WITH tb_cliente_dia AS (
    SELECT IdCliente,
            substr(DtCriacao,1,10) AS Dia
    FROM transacoes

    WHERE substr (DtCriacao,1,4) = '2025'

    GROUP BY IdCliente, Dia
),

tb_lag AS (
    SELECT *,
            lag(Dia) OVER (PARTITION BY IdCliente ORDER BY Dia) AS lagDia
    FROM tb_cliente_dia
),

tb_diff_Dt AS (
    SELECT *,
            julianday(Dia) - julianday(lagDia) AS DtDiff
    FROM tb_lag
),

tb_avg_cliente AS (
    SELECT IdCliente,
     AVG(DtDiff) AS avgDia
    FROM tb_diff_Dt

    GROUP BY IdCliente
)

SELECT AVG(avgDia)
FROM tb_avg_cliente



