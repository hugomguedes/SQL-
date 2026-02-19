--Quantidades de transações acumuladas ao longo do tempo (diario)

WITH tb_transacao_dia AS (
    SELECT 
            substr(DtCriacao,1,10)  AS dtDia,
            COUNT(DISTINCT IdTransacao) AS qtTransacao
    FROM transacoes

    GROUP BY dtDia
    ORDER BY dtDia
)

SELECT *,
    SUM(qtTransacao) OVER (PARTITION BY 1 ORDER BY dtDia ASC) AS qtTransacaoAcumDia
FROM tb_transacao_dia
