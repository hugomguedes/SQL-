-- como foi a curva de churn do curso de SQL? (cancelamentos)

WITH tb_cliente_dia1 AS (
    SELECT DISTINCT IdCliente
    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-26'
)

SELECT substr(DtCriacao,1,10) AS QtDia,
        count(DISTINCT t1.IdCliente) AS QtClientes,
        1. * count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_cliente_dia1) AS pctRetencao --proporçao
FROM tb_cliente_dia1 AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

GROUP BY substr(DtCriacao,1,10)

