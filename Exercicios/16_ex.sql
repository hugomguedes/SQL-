--Qual cliente fez mais transações em 2024?

SELECT IdCliente,
        COUNT(DISTINCT IdTransacao)
FROM transacoes

WHERE DtCriacao >='2024-01-01'
AND DtCriacao < '2025-01-01'

GROUP BY IdCliente

ORDER BY COUNT(DISTINCT IdTransacao) DESC