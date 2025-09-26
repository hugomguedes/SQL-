SELECT round(AVG(QtdePontos),2) AS mediaCarteira, --média (average)
        1. *sum(QtdePontos)/count(IdCliente) AS mediaCarteiraRoots,
        min(QtdePontos) AS minCarteira,
        max(QtdePontos) AS maxCarteira,
        sum(FlTwitch),
        sum(FlEmail)
FROM clientes