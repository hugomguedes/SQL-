-- SELECT IdTransacao,
--     DtCriacao,
--    strftime('%w',datetime(substr(DtCriacao,1,19))) 
-- FROM transacoes

-- WHERE strftime('%w',datetime(substr(DtCriacao,1,19))) IN ('6','0')



-- SELECT IdCliente,
--         QtdePontos	
-- FROM clientes

-- WHERE QtdePontos >= 100 AND QtdePontos <= 200;


-- SELECT *
-- FROM produtos

-- WHERE DescProduto LIKE 'Venda de%'


-- Listar todas as transações adicionando uma coluna nova sinalizando
--"alto", "médio" e "baixo para o valor dos pontos [<10; <500; <=500]"

-- SELECT IdTransacao,
--         QtdePontos,
--         CASE 
--             WHEN QtdePontos <10 THEN 'BAIXO'
--             WHEN QtdePontos <500 THEN 'MÉDIO'
--             ELSE 'ALTO'
--         END AS FlQtdePontos
-- FROM transacoes

-- ORDER BY QtdePontos DESC



--Quantos clientes tem email cadastrado?
-- SELECT sum(FlEmail) 
-- FROM clientes


--Qual cliente juntou mais pontos positivos em 2025-05?
-- SELECT IdCliente,
--         SUM(QtdePontos) AS totalPontos
-- FROM transacoes

-- WHERE DtCriacao >= '2025-05-01'
-- AND DtCriacao < '2025-06-01'
-- AND QtdePontos > 0

-- GROUP BY IdCliente
-- ORDER BY SUM(QtdePontos) DESC

-- LIMIT 1


--Qual cliente fez mais transaçoes no ano de 2024?
-- SELECT IdCliente,
--         COUNT(IdTransacao),
--         count(DISTINCT IdTransacao)
-- FROM transacoes

-- WHERE DtCriacao >= '2024-01-01'
-- AND DtCriacao < '2025-01-01'

-- GROUP BY IdCliente
-- ORDER BY COUNT(IdTransacao) DESC

--Quantos produtos são de RPG?
-- SELECT COUNT(*)
-- FROM produtos

-- WHERE DescCateogriaProduto = 'rpg';

-- SELECT DescCateogriaProduto,
--         count(*)

-- FROM produtos
-- GROUP BY DescCateogriaProduto;

--Qual o valor médio de pontos positivos por dia?
-- SELECT  sum(QtdePontos) AS totalPontos, 
--         count(substr(DtCriacao, 1, 10)) AS qtdDiasRepetidos,-- slice no intervalo de 1 a 10 caracteres
--         count(DISTINCT substr(DtCriacao, 1, 10)) AS qtdDiasUnicos,
--         sum(QtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) AS avgPontosDia

-- FROM transacoes

-- WHERE QtdePontos > 0

--Qual dia da semana tem mais pedidos em 2025?
-- SELECT
--         strftime('%w',substr(DtCriacao,1,10)) AS diaSemana,
--         count(DISTINCT IdTransacao) AS qtdTransacao
-- FROM transacoes

-- WHERE substr(DtCriacao,1,4) = '2025'

-- GROUP BY 1  -- primeira coluna do select

--Qual o produto mais transacionado?
-- SELECT IdProduto,
--         count(IdProduto) -- OU COUNT(*)
-- FROM transacao_produto

-- GROUP BY IdProduto
-- ORDER BY count(IdProduto) DESC

--Qual o produto com mais pontos transacionados?
-- SELECT IdProduto,
--         sum(VlProduto) AS totalPontos,
--         sum(QtdeProduto) AS qtdVendas
-- FROM transacao_produto

-- GROUP BY IdProduto
-- ORDER BY sum(VlProduto) DESC

--Quais clientes mais perderam pontos por 'lover'?
-- SELECT t1.IdCliente,
--         sum(t1.QtdePontos) AS totalPontos
--        -- t2.IdProduto,
--         --t3.DescProduto,
--        -- t3.DescCateogriaProduto
        
-- FROM transacoes AS t1

-- LEFT JOIN transacao_produto AS t2
-- ON t1.IdTransacao = t2.IdTransacao

-- LEFT JOIN produtos AS t3
-- ON t2.IdProduto = t3.IdProduto

-- WHERE t3.DescCateogriaProduto = 'lovers'

-- GROUP BY t1.IdCliente
-- ORDER BY sum(t1.QtdePontos) ASC

--Quais clientes assinaram a lista de presença no dia 2025-08-25?
-- SELECT t1.IdCliente,
--         count(*)
-- FROM transacoes AS t1

-- LEFT JOIN transacao_produto AS t2
-- ON t1.IdTransacao = t2.IdTransacao

-- LEFT JOIN produtos AS t3
-- ON t2.IdProduto = t3.IdProduto

-- WHERE t1.DtCriacao >= '2025-08-25'
-- AND t1.DtCriacao < '2025-08-26'
-- AND t3.DescProduto = 'Lista de presença'

-- GROUP BY t1.IdCliente