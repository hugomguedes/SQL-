--Quantidade de usuários cadastrados  (absoluto e acumulado) ao longo do tempo?
WITH tb_clientes_dia AS (
    SELECT substr(DtCriacao,1,10) AS dtDia,
            COUNT(DISTINCT IdCliente) AS qtClienteAbsoluto
    FROM clientes

    GROUP BY dtDia
)

SELECT *,
    SUM(qtClienteAbsoluto) OVER (PARTITION BY 1 ORDER BY dtDia) AS qtClienteAcum
FROM tb_clientes_dia
