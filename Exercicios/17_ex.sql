--Quantos produtos são de RPG
SELECT IdProduto,
        COUNT(IdProduto)
FROM produtos

WHERE DescCateogriaProduto = 'rpg';


SELECT DescCateogriaProduto,
        COUNT(*)

FROM produtos

GROUP BY DescCateogriaProduto;