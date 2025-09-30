--Qual é o produto mais transacionado?
SELECT IdProduto,
        SUM(QtdeProduto) AS QtdeProdutoSum
        
FROM transacao_produto

GROUP BY IdProduto

ORDER BY COUNT(*) DESC 
