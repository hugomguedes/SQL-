SELECT *
FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto




-- SELECT *
-- FROM transacao_produto
-- INNER JOIN produtos
-- ON transacao_produto.IdProduto = produtos.IdProduto

-- LIMIT