--Lista de transações com o produto "Resgatar Ponei"

-- SELECT *
-- FROM transacao_produto AS t1

-- WHERE t1.IdProduto IN (
--     SELECT IdProduto
--     FROM produtos
--     WHERE DescProduto = 'Resgatar Ponei'
-- )

--Dos clientes que começaram SQL no primeiro dia,quantos chegaram no 5° dia?

SELECT count(DISTINCT t1.IdCliente)
FROM transacoes AS t1

WHERE t1.IdCliente IN (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
)

AND substr(DtCriacao,1,10) = '2025-08-29'

