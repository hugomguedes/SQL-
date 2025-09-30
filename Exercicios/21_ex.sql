--Qual o produto com mais pontos transacionados?
SELECT IdProduto, 
        SUM(VlProduto * QtdeProduto) AS totalPontos,
        SUM(QtdeProduto) AS qtdeVenda
FROM transacao_produto

GROUP BY IdProduto

ORDER BY SUM(VlProduto) DESC