SELECT IdCliente,
        sum(QtdePontos),
        count(IdTransacao)
FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

GROUP BY IdCliente
HAVING sum(QtdePontos) >=4000 --having é um filtro do GROUP BY

ORDER BY sum(QtdePontos) DESC
