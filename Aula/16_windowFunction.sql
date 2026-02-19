-- quantidade de interações total do curso acumulada (frequência acumulada)

WITH tb_sumario_dias AS (
    SELECT substr(DtCriacao,1,10) AS Dia,
            count(DISTINCT IdTransacao) AS qtTransacao
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY substr(DtCriacao,1,10)
)

SELECT *,
        sum(qtTransacao) OVER (PARTITION BY 1 ORDER BY Dia) AS qtTransacaoAcum
FROM tb_sumario_dias 
