--Qual mês tivemos mais lista de presença assinada
SELECT COUNT(DISTINCT t1.IdTransacao) AS qtdTransacao,
        substr(t1.DtCriacao,1,7) AS anoMes --substr faz um slice pegando caracteres de 1 até 7
FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DescProduto = 'Lista de presença'

GROUP BY substr(t1.DtCriacao,1,7)
ORDER BY qtdTransacao DESC