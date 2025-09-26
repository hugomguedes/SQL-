SELECT 
        SUM(QtdePontos),

       SUM (CASE 
        WHEN QtdePontos > 0 THEN QtdePontos
        END) AS QtdePontosPos,

        SUM (CASE 
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS QtdePontosNeg,

        COUNT(CASE 
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS QtdeTransacaoNegativas
FROM transacoes

WHERE DtCriacao >='2025-07-01'
AND DtCriacao <'2025-08-01'