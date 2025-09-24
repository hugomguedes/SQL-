-- SELECIONE PRODUTOS QUE CONTÉM 'churn' NO NOME
SELECT *

FROM produtos

/*
WHERE DescProduto IN ('Churn_10pp','Churn_2pp','Churn_5pp')
WHERE DescProduto LIKE '%churn%' 
*/

WHERE DescCateogriaProduto = 'churn_model'