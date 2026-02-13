--Em 2024 quantas transacoes de Lovers tivemos?
 SELECT 
        t3.DescCateogriaProduto,
        COUNT(DISTINCT t1.IdTransacao) AS QtdLovers
        --t1.IdTransacao,
--         t1.IdCliente,
--         t2.IdProduto,
--         t3.DescCateogriaProduto

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
on t2.IdProduto = t3.IdProduto

WHERE t1.DtCriacao >= '2024-01-01'
AND t1.DtCriacao < '2025-01-01'
-- AND DescCateogriaProduto = 'lovers'
GROUP BY t3.DescCateogriaProduto
