--Qual categoria tem produtos mais vendidos?
SELECT
        t2.DescCateogriaProduto,
        COUNT(DISTINCT t1.IdTransacao)

FROM transacao_produto AS t1
LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

GROUP BY t2.DescCateogriaProduto
ORDER BY COUNT(DISTINCT t1.IdTransacao) DESC 